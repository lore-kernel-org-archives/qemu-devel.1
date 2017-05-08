Received: from eggs.gnu.org ([2001:4830:134:3::10]:52477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d7mS7-0007DV-SI
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d7mS4-0002BT-LU
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:28:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d7mS4-0002B2-Bq
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:28:04 -0400
Date: Mon, 8 May 2017 18:27:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170508172757.GI2120@work-vm>
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
	<20170505173507.74077-10-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170505173507.74077-10-pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 09/10] s390x/css: turn on channel subsystem
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> Turn on migration for the channel subsystem and the new scheme for
> migrating virtio-ccw proxy devices (instead of letting the transport
> independent child device migrate it's proxy, use the usual
> DeviceClass.vmsd mechanism) for future machine versions.
> 
> The vmstate based migration of the channel subsystem is not migration
> stream compatible with the method for handling migration of legacy
> machines.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
> ---
>  hw/s390x/ccw-device.c      |  1 +
>  hw/s390x/css.c             |  5 +++++
>  hw/s390x/s390-virtio-ccw.c |  9 ++++-----
>  hw/s390x/virtio-ccw.c      | 14 ++++++++++++++
>  include/hw/s390x/css.h     |  4 ++++
>  5 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
> index f9bfa15..3b5df03 100644
> --- a/hw/s390x/ccw-device.c
> +++ b/hw/s390x/ccw-device.c
> @@ -48,6 +48,7 @@ static void ccw_device_class_init(ObjectClass *klass, void *data)
>      k->realize = ccw_device_realize;
>      k->refill_ids = ccw_device_refill_ids;
>      dc->props = ccw_device_properties;
> +    dc->vmsd = &vmstate_ccw_dev;
>  }
>  
>  const VMStateDescription vmstate_ccw_dev = {
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index d9a0fb9..b58832a 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -385,6 +385,11 @@ static int subch_dev_post_load(void *opaque, int version_id)
>      return 0;
>  }
>  
> +void css_register_vmstate(void)
> +{
> +    vmstate_register(NULL, 0, &vmstate_css, &channel_subsys);
> +}
> +

Why isn't that attached to a device vmsd? 

>  IndAddr *get_indicator(hwaddr ind_addr, int len)
>  {
>      IndAddr *indicator;
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 698e8fc..5307f59 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -196,7 +196,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>  
>      s390mc->ri_allowed = true;
>      s390mc->cpu_model_allowed = true;
> -    s390mc->css_migration_enabled = false; /* TODO: set to true */
> +    s390mc->css_migration_enabled = true;
>      mc->init = ccw_init;
>      mc->reset = s390_machine_reset;
>      mc->hot_add_cpu = s390_hot_add_cpu;
> @@ -414,10 +414,9 @@ bool css_migration_enabled(void)
>  
>  static void ccw_machine_2_10_instance_options(MachineState *machine)
>  {
> -    /*
> -     * TODO Once preparations are done register vmstate for the css if
> -     * css_migration_enabled().
> -     */
> +    if (css_migration_enabled()) {
> +        css_register_vmstate();
> +    }
>  }
>  
>  static void ccw_machine_2_10_class_options(MachineClass *mc)
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 8ab655c..c611b6f 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -1307,6 +1307,10 @@ static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
>  {
>      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
>  
> +    if (css_migration_enabled()) {
> +        /* we migrate via DeviceClass.vmsd */
> +        return;
> +    }
>      /*
>       * We save in legacy mode. The components take care of their own
>       * compat. representation (based on css_migration_enabled).
> @@ -1318,6 +1322,10 @@ static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
>  {
>      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
>  
> +    if (css_migration_enabled()) {
> +        /* we migrate via DeviceClass.vmsd */
> +        return 0;
> +    }
>      /*
>       * We load in legacy mode. The components take take care to read
>       * only stuff which is actually there (based on css_migration_enabled).
> @@ -1365,6 +1373,11 @@ static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
>      sch->id.cu_model = virtio_bus_get_vdev_id(&dev->bus);
>  
>  
> +    /* Avoid generating unknown section for legacy migration target. */
> +    if (!css_migration_enabled()) {
> +        DEVICE_GET_CLASS(ccw_dev)->vmsd = NULL;
> +    }
> +

That's a very odd thing to do; can't you use a .needed at the
top level of the vmstate_virtio_ccw_dev to avoid having to
set it to NULL like this?


>      css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
>                            d->hotplugged, 1);
>  }
> @@ -1657,6 +1670,7 @@ static void virtio_ccw_device_class_init(ObjectClass *klass, void *data)
>      dc->realize = virtio_ccw_busdev_realize;
>      dc->exit = virtio_ccw_busdev_exit;
>      dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
> +    dc->vmsd = &vmstate_virtio_ccw_dev;
>  }
>  
>  static const TypeInfo virtio_ccw_device_info = {
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index dbe093e..be5eb81 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -207,4 +207,8 @@ extern PropertyInfo css_devid_ro_propinfo;
>   * is responsible for unregistering and freeing it.
>   */
>  SubchDev *css_create_virtual_sch(CssDevId bus_id, Error **errp);
> +
> +/** Turn on css migration */
> +void css_register_vmstate(void);
> +
>  #endif
> -- 
> 2.10.2

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
