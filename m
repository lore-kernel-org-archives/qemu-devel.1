Received: from eggs.gnu.org ([2001:4830:134:3::10]:53348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cEIYy-0003XH-2R
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cEIYu-0002Ge-Ve
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:25:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cEIYu-0002G9-Mx
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:25:48 -0500
Date: Tue, 6 Dec 2016 14:25:45 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161206162545.GA4027@thinpad.lan.raisama.net>
References: <148103887228.22326.478406873609299999.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148103887228.22326.478406873609299999.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] qdev: fix the order compat and global
 properties are applied
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Dec 06, 2016 at 04:41:12PM +0100, Greg Kurz wrote:
> The current code recursively applies global properties from child up to
> parent types. This can cause properties passed with the -global option to
> be silently overridden by internal compat properties.
> 
> This is exactly what happens with virtio-*-pci drivers since commit:
> 
> "9a4c0e220d8a hw/virtio-pci: fix virtio behaviour"
> 
> Passing -device virtio-blk-pci.disable-modern=off has no effect on 2.6
> machine types because the internal virtio-pci.disable-modern=on compat
> property always prevail.
> 
> This patch fixes the issue by reversing the logic: we now go through the
> global property list and, for each property, we check if it is applicable
> to the device.
> 
> This result in compat properties being applied first, in the order they
> appear in the HW_COMPAT_* macros, followed by global properties, in they
> order appear on the command line.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

FWIW, this is the behavior I would like to see. But:

I think it's too late to change the rules on 2.8. I would like to
change behavior only on 2.9, so we have time to discuss and test
it. I believe the 2.8 fix should be just changing the HW_COMPAT_*
macros to touch only the device subclasses, so we fix the
regression introduced by commit 9a4c0e220d8a without changing any
rules on how -global is handled.

> ---
>  hw/core/qdev-properties.c |   15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 5972108b2699..93a4dfeb0836 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1089,8 +1089,7 @@ int qdev_prop_check_globals(void)
>      return ret;
>  }
>  
> -static void qdev_prop_set_globals_for_type(DeviceState *dev,
> -                                           const char *typename)
> +void qdev_prop_set_globals(DeviceState *dev)
>  {
>      GList *l;
>  
> @@ -1098,7 +1097,7 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
>          GlobalProperty *prop = l->data;
>          Error *err = NULL;
>  
> -        if (strcmp(typename, prop->driver) != 0) {
> +        if (object_dynamic_cast(OBJECT(dev), prop->driver) == NULL) {
>              continue;
>          }
>          prop->used = true;
> @@ -1120,16 +1119,6 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
>      }
>  }
>  
> -void qdev_prop_set_globals(DeviceState *dev)
> -{
> -    ObjectClass *class = object_get_class(OBJECT(dev));
> -
> -    do {
> -        qdev_prop_set_globals_for_type(dev, object_class_get_name(class));
> -        class = object_class_get_parent(class);
> -    } while (class);
> -}
> -
>  /* --- 64bit unsigned int 'size' type --- */
>  
>  static void get_size(Object *obj, Visitor *v, const char *name, void *opaque,
> 

-- 
Eduardo
