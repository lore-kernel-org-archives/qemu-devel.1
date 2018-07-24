Received: from eggs.gnu.org ([2001:4830:134:3::10]:35888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fhv7g-0004Ln-C4
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fhv7b-00040W-QQ
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:04:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fhv7b-0003zV-Hi
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:04:51 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6OB4ahB040099
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 07:04:50 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kdyeu2c37-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 07:04:41 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 24 Jul 2018 12:03:43 +0100
References: <20180724092413.5770-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 24 Jul 2018 13:03:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180724092413.5770-1-cohuck@redhat.com>
Content-Language: en-US
Message-Id: <d4269a11-98c7-0b07-039c-715940daf83d@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] s390x: remove 's390-squash-mcss'
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Xiao Feng Ren <renxiaof@linux.ibm.com>, qemu-devel@nongnu.org, libvir-list@redhat.com

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>


On 07/24/2018 11:24 AM, Cornelia Huck wrote:
> This option has been deprecated for two releases; remove it.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/3270-ccw.c                |  2 +-
>  hw/s390x/css-bridge.c              |  1 -
>  hw/s390x/css.c                     |  6 ++----
>  hw/s390x/s390-ccw.c                |  2 +-
>  hw/s390x/s390-virtio-ccw.c         | 37 ++-----------------------------------
>  hw/s390x/virtio-ccw.c              |  2 +-
>  include/hw/s390x/css-bridge.h      |  1 -
>  include/hw/s390x/css.h             |  9 +++------
>  include/hw/s390x/s390-virtio-ccw.h |  1 -
>  qemu-deprecated.texi               |  8 --------
>  qemu-options.hx                    | 10 ----------
>  target/s390x/cpu.c                 | 10 ----------
>  target/s390x/cpu.h                 |  1 -
>  13 files changed, 10 insertions(+), 80 deletions(-)
> 
> diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
> index 3af13ea027..cf58b81fc0 100644
> --- a/hw/s390x/3270-ccw.c
> +++ b/hw/s390x/3270-ccw.c
> @@ -104,7 +104,7 @@ static void emulated_ccw_3270_realize(DeviceState *ds, Error **errp)
>      SubchDev *sch;
>      Error *err = NULL;
>  
> -    sch = css_create_sch(cdev->devno, cbus->squash_mcss, errp);
> +    sch = css_create_sch(cdev->devno, errp);
>      if (!sch) {
>          return;
>      }
> diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
> index a02d708239..1bd6c8b458 100644
> --- a/hw/s390x/css-bridge.c
> +++ b/hw/s390x/css-bridge.c
> @@ -106,7 +106,6 @@ VirtualCssBus *virtual_css_bus_init(void)
>      /* Create bus on bridge device */
>      bus = qbus_create(TYPE_VIRTUAL_CSS_BUS, dev, "virtual-css");
>      cbus = VIRTUAL_CSS_BUS(bus);
> -    cbus->squash_mcss = s390_get_squash_mcss();
>  
>      /* Enable hotplugging */
>      qbus_set_hotplug_handler(bus, dev, &error_abort);
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 5424ea4562..5a9fe45ce8 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -2359,15 +2359,13 @@ const PropertyInfo css_devid_ro_propinfo = {
>      .get = get_css_devid,
>  };
>  
> -SubchDev *css_create_sch(CssDevId bus_id, bool squash_mcss, Error **errp)
> +SubchDev *css_create_sch(CssDevId bus_id, Error **errp)
>  {
>      uint16_t schid = 0;
>      SubchDev *sch;
>  
>      if (bus_id.valid) {
> -        if (squash_mcss) {
> -            bus_id.cssid = channel_subsys.default_cssid;
> -        } else if (!channel_subsys.css[bus_id.cssid]) {
> +        if (!channel_subsys.css[bus_id.cssid]) {
>              css_create_css_image(bus_id.cssid, false);
>          }
>  
> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
> index 214c940593..d1280bf631 100644
> --- a/hw/s390x/s390-ccw.c
> +++ b/hw/s390x/s390-ccw.c
> @@ -78,7 +78,7 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
>          goto out_err_propagate;
>      }
>  
> -    sch = css_create_sch(ccw_dev->devno, cbus->squash_mcss, &err);
> +    sch = css_create_sch(ccw_dev->devno, &err);
>      if (!sch) {
>          goto out_mdevid_free;
>      }
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 7983185d04..380a41d806 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -282,19 +282,8 @@ static void ccw_init(MachineState *machine)
>      virtio_ccw_register_hcalls();
>  
>      s390_enable_css_support(s390_cpu_addr2state(0));
> -    /*
> -     * Non mcss-e enabled guests only see the devices from the default
> -     * css, which is determined by the value of the squash_mcss property.
> -     */
> -    if (css_bus->squash_mcss) {
> -        ret = css_create_css_image(0, true);
> -    } else {
> -        ret = css_create_css_image(VIRTUAL_CSSID, true);
> -    }
> -    if (qemu_opt_get(qemu_get_machine_opts(), "s390-squash-mcss")) {
> -        warn_report("The machine property 's390-squash-mcss' is deprecated"
> -                    " (obsoleted by lifting the cssid restrictions).");
> -    }
> +
> +    ret = css_create_css_image(VIRTUAL_CSSID, true);
>  
>      assert(ret == 0);
>      if (css_migration_enabled()) {
> @@ -575,21 +564,6 @@ static void machine_set_loadparm(Object *obj, const char *val, Error **errp)
>          ms->loadparm[i] = ' '; /* pad right with spaces */
>      }
>  }
> -static inline bool machine_get_squash_mcss(Object *obj, Error **errp)
> -{
> -    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> -
> -    return ms->s390_squash_mcss;
> -}
> -
> -static inline void machine_set_squash_mcss(Object *obj, bool value,
> -                                           Error **errp)
> -{
> -    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> -
> -    ms->s390_squash_mcss = value;
> -}
> -
>  static inline void s390_machine_initfn(Object *obj)
>  {
>      object_property_add_bool(obj, "aes-key-wrap",
> @@ -614,13 +588,6 @@ static inline void s390_machine_initfn(Object *obj)
>              " to upper case) to pass to machine loader, boot manager,"
>              " and guest kernel",
>              NULL);
> -    object_property_add_bool(obj, "s390-squash-mcss",
> -                             machine_get_squash_mcss,
> -                             machine_set_squash_mcss, NULL);
> -    object_property_set_description(obj, "s390-squash-mcss", "(deprecated) "
> -            "enable/disable squashing subchannels into the default css",
> -            NULL);
> -    object_property_set_bool(obj, false, "s390-squash-mcss", NULL);
>  }
>  
>  static const TypeInfo ccw_machine_info = {
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 7ddb378d52..3156e8d6e1 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -700,7 +700,7 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
>      SubchDev *sch;
>      Error *err = NULL;
>  
> -    sch = css_create_sch(ccw_dev->devno, cbus->squash_mcss, errp);
> +    sch = css_create_sch(ccw_dev->devno, errp);
>      if (!sch) {
>          return;
>      }
> diff --git a/include/hw/s390x/css-bridge.h b/include/hw/s390x/css-bridge.h
> index cf0860432a..5a0203be5f 100644
> --- a/include/hw/s390x/css-bridge.h
> +++ b/include/hw/s390x/css-bridge.h
> @@ -28,7 +28,6 @@ typedef struct VirtualCssBridge {
>  /* virtual css bus type */
>  typedef struct VirtualCssBus {
>      BusState parent_obj;
> -    bool squash_mcss;
>  } VirtualCssBus;
>  
>  #define TYPE_VIRTUAL_CSS_BUS "virtual-css-bus"
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 35facb47d2..9da5912921 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -266,11 +266,8 @@ extern const PropertyInfo css_devid_ro_propinfo;
>  /**
>   * Create a subchannel for the given bus id.
>   *
> - * If @p bus_id is valid, and @p squash_mcss is true, verify that it is
> - * not already in use in the default css, and find a free devno from the
> - * default css image for it.
> - * If @p bus_id is valid, and @p squash_mcss is false, verify that it is
> - * not already in use, and find a free devno for it.
> + * If @p bus_id is valid, verify that it is not already in use, and find a
> + * free devno for it.
>   * If @p bus_id is not valid find a free subchannel id and device number
>   * across all subchannel sets and all css images starting from the default
>   * css image.
> @@ -282,7 +279,7 @@ extern const PropertyInfo css_devid_ro_propinfo;
>   * The caller becomes owner of the returned subchannel structure and
>   * is responsible for unregistering and freeing it.
>   */
> -SubchDev *css_create_sch(CssDevId bus_id, bool squash_mcss, Error **errp);
> +SubchDev *css_create_sch(CssDevId bus_id, Error **errp);
>  
>  /** Turn on css migration */
>  void css_register_vmstate(void);
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
> index ab88d49d10..e9c4f4182b 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -29,7 +29,6 @@ typedef struct S390CcwMachineState {
>      bool aes_key_wrap;
>      bool dea_key_wrap;
>      uint8_t loadparm[8];
> -    bool s390_squash_mcss;
>  } S390CcwMachineState;
>  
>  typedef struct S390CcwMachineClass {
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 9920a85adc..09f7b22fb1 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -126,14 +126,6 @@ The ``-nodefconfig`` argument is a synonym for ``-no-user-config``.
>  The @option{--balloon virtio} argument has been superseded by
>  @option{--device virtio-balloon}.
>  
> -@subsection -machine s390-squash-mcss=on|off (since 2.12.0)
> -
> -The ``s390-squash-mcss=on`` property has been obsoleted by allowing the
> -cssid to be chosen freely. Instead of squashing subchannels into the
> -default channel subsystem image for guests that do not support multiple
> -channel subsystems, all devices can be put into the default channel
> -subsystem image.
> -
>  @subsection -fsdev handle (since 2.12.0)
>  
>  The ``handle'' fsdev backend does not support symlinks and causes the 9p
> diff --git a/qemu-options.hx b/qemu-options.hx
> index b1bf0f485f..e57cec96a5 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -43,7 +43,6 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
>      "                nvdimm=on|off controls NVDIMM support (default=off)\n"
>      "                enforce-config-section=on|off enforce configuration section migration (default=off)\n"
> -    "                s390-squash-mcss=on|off (deprecated) controls support for squashing into default css (default=off)\n"
>      "                memory-encryption=@var{} memory encryption object to use (default=none)\n",
>      QEMU_ARCH_ALL)
>  STEXI
> @@ -96,15 +95,6 @@ controls whether DEA wrapping keys will be created to allow
>  execution of DEA cryptographic functions.  The default is on.
>  @item nvdimm=on|off
>  Enables or disables NVDIMM support. The default is off.
> -@item s390-squash-mcss=on|off
> -Enables or disables squashing subchannels into the default css.
> -The default is off.
> -NOTE: This property is deprecated and will be removed in future releases.
> -The ``s390-squash-mcss=on`` property has been obsoleted by allowing the
> -cssid to be chosen freely. Instead of squashing subchannels into the
> -default channel subsystem image for guests that do not support multiple
> -channel subsystems, all devices can be put into the default channel
> -subsystem image.
>  @item enforce-config-section=on|off
>  If @option{enforce-config-section} is set to @var{on}, force migration
>  code to send configuration section even if the machine-type sets the
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 271c5ce652..8ed4823d6e 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -421,16 +421,6 @@ void s390_crypto_reset(void)
>      }
>  }
>  
> -bool s390_get_squash_mcss(void)
> -{
> -    if (object_property_get_bool(OBJECT(qdev_get_machine()), "s390-squash-mcss",
> -                                 NULL)) {
> -        return true;
> -    }
> -
> -    return false;
> -}
> -
>  void s390_enable_css_support(S390CPU *cpu)
>  {
>      if (kvm_enabled()) {
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 2c3dd2d189..86b66dfeac 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -713,7 +713,6 @@ static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data arg)
>  
>  /* cpu.c */
>  void s390_crypto_reset(void);
> -bool s390_get_squash_mcss(void);
>  int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit);
>  void s390_cmma_reset(void);
>  void s390_enable_css_support(S390CPU *cpu);
> 
