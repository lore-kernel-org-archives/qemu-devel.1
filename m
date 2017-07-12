Received: from eggs.gnu.org ([2001:4830:134:3::10]:36182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dVLVw-0002NF-Ds
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dVLVt-000846-8S
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:33:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dVLVs-00083Y-UX
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:33:25 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6CHTQOA076123
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 13:33:22 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bncj5wbjq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 13:33:22 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 12 Jul 2017 18:33:19 +0100
References: <20170711004303.3902-1-ehabkost@redhat.com>
	<20170711004303.3902-2-ehabkost@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 12 Jul 2017 19:33:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170711004303.3902-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <91940c7e-3685-26e0-e8f9-e050afcd28b5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qdev: fix the order compat and global
 properties are applied
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>



On 07/11/2017 02:43 AM, Eduardo Habkost wrote:
> From: Greg Kurz <groug@kaod.org>
> 
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
> Message-Id: <148103887228.22326.478406873609299999.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/core/qdev-properties.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index f11d578..41cca9d 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1148,8 +1148,7 @@ int qdev_prop_check_globals(void)
>      return ret;
>  }
> 
> -static void qdev_prop_set_globals_for_type(DeviceState *dev,
> -                                           const char *typename)
> +void qdev_prop_set_globals(DeviceState *dev)
>  {
>      GList *l;
> 
> @@ -1157,7 +1156,7 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
>          GlobalProperty *prop = l->data;
>          Error *err = NULL;
> 
> -        if (strcmp(typename, prop->driver) != 0) {
> +        if (object_dynamic_cast(OBJECT(dev), prop->driver) == NULL) {
>              continue;
>          }
>          prop->used = true;
> @@ -1175,16 +1174,6 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
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

Code looks good to me. Given that high profile people are happy with the
patch I won't object on the behavior aspect which I don't understand fully.
Thus:

Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>


Now a couple of questions for keeping  my clear conscience:
* What did we test? Since this patch is fixing a problem it
changes behavior. Did we test if there is something that breaks?

* The previous version seems to establish a (somewhat strange)
precedence for the case the same device property (storage object)
is set via multiple super-classes (e.g. set both by parent and
parents parent). This seems to have at least been possible,
and technically it still is I guess. Now instead of most general
(super class) wins we have last added property wins. I assume it
isn't a problem, because we don't have something obscure like that.
Or am I wrong? This obviously connects to the first question.
(By the way, most specialized wins would not have been that
surprising given how inheritance and OO usually works. My assumption
that nobody used this obscure mechanism is largely based on it's
strangeness).
