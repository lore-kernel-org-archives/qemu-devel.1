Received: from eggs.gnu.org ([2001:4830:134:3::10]:54633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dfRih-0001rK-CU
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dfRic-0001s2-AW
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:12:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1dfRic-0001pW-1f
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:12:18 -0400
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1501119055-4060-4-git-send-email-mdroth@linux.vnet.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e916c286-8e4b-32b7-41f2-8114db651a82@redhat.com>
Date: Wed, 9 Aug 2017 16:04:54 +0200
MIME-Version: 1.0
In-Reply-To: <1501119055-4060-4-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/3] qdev: defer DEVICE_DEL event
 until instance_finalize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, groug@kaod.org, armbru@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

Hi Michael,

On 27/07/2017 03:30, Michael Roth wrote:
> DEVICE_DEL is currently emitted when a Device is unparented, as
> opposed to when it is finalized. The main design motivation for this
> seems to be that after unparent()/unrealize(), the Device is no
> longer visible to the guest, and thus the operation is complete
> from the perspective of management.
> 
> However, there are cases where remaining host-side cleanup is also
> pertinent to management. The is generally handled by treating these
> resources as aspects of the "backend", which can be managed via
> separate interfaces/events, such as blockdev_add/del, netdev_add/del,
> object_add/del, etc, but some devices do not have this level of
> compartmentalization, namely vfio-pci, and possibly to lend themselves
> well to it.
> 
> In the case of vfio-pci, the "backend" cleanup happens as part of
> the finalization of the vfio-pci device itself, in particular the
> cleanup of the VFIO group FD. Failing to wait for this cleanup can
> result in tools like libvirt attempting to rebind the device to
> the host while it's still being used by VFIO, which can result in
> host crashes or other misbehavior depending on the host driver.
> 
> Deferring DEVICE_DEL still affords us the ability to manage backends
> explicitly, while also addressing cases like vfio-pci's, so we
> implement that approach here.
> 
> An alternative proposal involving having VFIO emit a separate event
> to denote completion of host-side cleanup was discussed, but the
> prevailing opinion seems to be that it is not worth the added
> complexity, and leaves the issue open for other Device implementations
> solve in the future.
> 
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  hw/core/qdev.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 08c4061..d14acba 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -1067,7 +1067,6 @@ static void device_finalize(Object *obj)
>      NamedGPIOList *ngl, *next;
>  
>      DeviceState *dev = DEVICE(obj);
> -    qemu_opts_del(dev->opts);
>  
>      QLIST_FOREACH_SAFE(ngl, &dev->gpios, node, next) {
>          QLIST_REMOVE(ngl, node);
> @@ -1078,6 +1077,18 @@ static void device_finalize(Object *obj)
>           * here
>           */
>      }
> +
> +    /* Only send event if the device had been completely realized */
> +    if (dev->pending_deleted_event) {
> +        g_assert(dev->canonical_path);
> +
> +        qapi_event_send_device_deleted(!!dev->id, dev->id, dev->canonical_path,
> +                                       &error_abort);
> +        g_free(dev->canonical_path);
> +        dev->canonical_path = NULL;
> +    }
> +
> +    qemu_opts_del(dev->opts);
>  }
>  
>  static void device_class_base_init(ObjectClass *class, void *data)
> @@ -1107,16 +1118,6 @@ static void device_unparent(Object *obj)
>          object_unref(OBJECT(dev->parent_bus));
>          dev->parent_bus = NULL;
>      }
> -
> -    /* Only send event if the device had been completely realized */
> -    if (dev->pending_deleted_event) {
> -        g_assert(dev->canonical_path);
> -
> -        qapi_event_send_device_deleted(!!dev->id, dev->id, dev->canonical_path,
> -                                       &error_abort);
> -        g_free(dev->canonical_path);
> -        dev->canonical_path = NULL;
> -    }
is the code below, introduced in patch 1/device_set_realized() still
relevant?
        /* always re-initialize since we clean up in device_unparent()
instead
         * of unrealize()
         */
        g_free(dev->canonical_path);

Thanks

Eric
>  }
>  
>  static void device_class_init(ObjectClass *class, void *data)
> 
