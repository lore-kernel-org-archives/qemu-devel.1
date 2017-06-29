Received: from eggs.gnu.org ([2001:4830:134:3::10]:55342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dQZkw-0004Af-Df
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dQZkq-0003Kt-7m
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:45:14 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dQZkp-0003Iv-Ul
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:45:08 -0400
Received: by mail-wr0-f180.google.com with SMTP id r103so189927097wrb.0
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 06:45:07 -0700 (PDT)
References: <1498734863-164338-1-git-send-email-imammedo@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b6193c2f-a358-b871-34f7-7f8d6784f4b8@redhat.com>
Date: Thu, 29 Jun 2017 15:45:04 +0200
MIME-Version: 1.0
In-Reply-To: <1498734863-164338-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qom: enforce readonly nature of link's
 check callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, mst@redhat.com, alistair.francis@xilinx.com, qemu-arm@nongnu.org, edgar.iglesias@gmail.com, afaerber@suse.de

On 29/06/2017 13:14, Igor Mammedov wrote:
> link's check callback is supposed to verify/permit setting it,
> however currently nothing restricts it from misusing it
> and modifying target object from within.
> Make sure that readonly semantics are checked by compiler
> to prevent callback's misuse.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> Fam,
>  it probably conflicts with yours DEFINE_PROP_LINK series,
>  feel free to include this patch if you'll have to respin
> 
> ---
>  include/hw/qdev-properties.h | 3 ++-
>  include/qom/object.h         | 6 +++---
>  hw/core/qdev-properties.c    | 3 ++-
>  hw/display/xlnx_dp.c         | 2 +-
>  hw/ipmi/ipmi.c               | 2 +-
>  hw/mem/pc-dimm.c             | 2 +-
>  hw/misc/ivshmem.c            | 2 +-
>  qom/object.c                 | 8 ++++----
>  8 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 306bbab..6dfe16e 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -234,7 +234,8 @@ void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
>   * This function should be used as the check() argument to
>   * object_property_add_link().
>   */
> -void qdev_prop_allow_set_link_before_realize(Object *obj, const char *name,
> +void qdev_prop_allow_set_link_before_realize(const Object *obj,
> +                                             const char *name,
>                                               Object *val, Error **errp);
>  
>  #endif
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 5ecc2d1..5223692 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -788,7 +788,7 @@ ObjectClass *object_get_class(Object *obj);
>   *
>   * Returns: The QOM typename of @obj.
>   */
> -const char *object_get_typename(Object *obj);
> +const char *object_get_typename(const Object *obj);
>  
>  /**
>   * type_register_static:
> @@ -1320,7 +1320,7 @@ typedef enum {
>   * callback function.  It allows the link property to be set and never returns
>   * an error.
>   */
> -void object_property_allow_set_link(Object *, const char *,
> +void object_property_allow_set_link(const Object *, const char *,
>                                      Object *, Error **);
>  
>  /**
> @@ -1353,7 +1353,7 @@ void object_property_allow_set_link(Object *, const char *,
>   */
>  void object_property_add_link(Object *obj, const char *name,
>                                const char *type, Object **child,
> -                              void (*check)(Object *obj, const char *name,
> +                              void (*check)(const Object *obj, const char *name,
>                                              Object *val, Error **errp),
>                                ObjectPropertyLinkFlags flags,
>                                Error **errp);
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 2a82768..95e5fdb 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -25,7 +25,8 @@ void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
>      }
>  }
>  
> -void qdev_prop_allow_set_link_before_realize(Object *obj, const char *name,
> +void qdev_prop_allow_set_link_before_realize(const Object *obj,
> +                                             const char *name,
>                                               Object *val, Error **errp)
>  {
>      DeviceState *dev = DEVICE(obj);
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index f43eb09..3ed81ff 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -515,7 +515,7 @@ static void xlnx_dp_aux_set_command(XlnxDPState *s, uint32_t value)
>      s->core_registers[DP_INTERRUPT_SIGNAL_STATE] |= 0x04;
>  }
>  
> -static void xlnx_dp_set_dpdma(Object *obj, const char *name, Object *val,
> +static void xlnx_dp_set_dpdma(const Object *obj, const char *name, Object *val,
>                                Error **errp)
>  {
>      XlnxDPState *s = XLNX_DP(obj);
> diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
> index 5cf1caa..a2fd1eb 100644
> --- a/hw/ipmi/ipmi.c
> +++ b/hw/ipmi/ipmi.c
> @@ -90,7 +90,7 @@ static TypeInfo ipmi_interface_type_info = {
>      .class_init = ipmi_interface_class_init,
>  };
>  
> -static void isa_ipmi_bmc_check(Object *obj, const char *name,
> +static void isa_ipmi_bmc_check(const Object *obj, const char *name,
>                                 Object *val, Error **errp)
>  {
>      IPMIBmc *bmc = IPMI_BMC(val);
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 9e8dab0..380cb30 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -366,7 +366,7 @@ static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
>      visit_type_int(v, name, &value, errp);
>  }
>  
> -static void pc_dimm_check_memdev_is_busy(Object *obj, const char *name,
> +static void pc_dimm_check_memdev_is_busy(const Object *obj, const char *name,
>                                        Object *val, Error **errp)
>  {
>      Error *local_err = NULL;
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index abeaf3d..e25016c 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -1005,7 +1005,7 @@ static const TypeInfo ivshmem_common_info = {
>      .class_init    = ivshmem_common_class_init,
>  };
>  
> -static void ivshmem_check_memdev_is_busy(Object *obj, const char *name,
> +static void ivshmem_check_memdev_is_busy(const Object *obj, const char *name,
>                                           Object *val, Error **errp)
>  {
>      if (host_memory_backend_is_mapped(MEMORY_BACKEND(val))) {
> diff --git a/qom/object.c b/qom/object.c
> index 7a05e35..a429e64 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -735,7 +735,7 @@ out:
>      return ret;
>  }
>  
> -const char *object_get_typename(Object *obj)
> +const char *object_get_typename(const Object *obj)
>  {
>      return obj->class->type->name;
>  }
> @@ -1395,7 +1395,7 @@ out:
>      g_free(type);
>  }
>  
> -void object_property_allow_set_link(Object *obj, const char *name,
> +void object_property_allow_set_link(const Object *obj, const char *name,
>                                      Object *val, Error **errp)
>  {
>      /* Allow the link to be set, always */
> @@ -1403,7 +1403,7 @@ void object_property_allow_set_link(Object *obj, const char *name,
>  
>  typedef struct {
>      Object **child;
> -    void (*check)(Object *, const char *, Object *, Error **);
> +    void (*check)(const Object *, const char *, Object *, Error **);
>      ObjectPropertyLinkFlags flags;
>  } LinkProperty;
>  
> @@ -1519,7 +1519,7 @@ static void object_release_link_property(Object *obj, const char *name,
>  
>  void object_property_add_link(Object *obj, const char *name,
>                                const char *type, Object **child,
> -                              void (*check)(Object *, const char *,
> +                              void (*check)(const Object *, const char *,
>                                              Object *, Error **),
>                                ObjectPropertyLinkFlags flags,
>                                Error **errp)
> 


Good idea.  I think it's okay to wait for Fam's series.

Paolo
