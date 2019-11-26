Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92584C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 08:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F519206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 08:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtC5YKPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F519206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZWZ7-00062H-HA
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 03:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iZWTO-0000cq-M2
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iZWO2-00005I-Aa
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:39:56 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iZWO1-00004u-Um
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:39:54 -0500
Received: by mail-wm1-x343.google.com with SMTP id b11so2166825wmb.5
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 00:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TmJcrgdi3SbV4ykYkwZhUy5Yo7sWJXnVMg7xcJ1Dzq8=;
 b=ZtC5YKPvqIjKxwXb5OxErTOCOem8jHh3eX2XG5y8stIjQHu+i6uwzofkZCUz6ZumYN
 2jiccvCZiWEYsP0MxHkHVSyjC5v5xky8Z4mSI4TI/fucewvpfuYCkWkynHXZ8L6y68Tv
 xnb1UFPPxZeeNmkDOFzOLUoB6T2K/McQsVRQt/p1lJGSPMuh75g8WDInHdvSbhlbmjPc
 4K9sar3AgGl0ZKGBoi98ZRwR+1sMjP95hYX0eVxqujY3Ev2Cb56kqsFhTRdXM3H1yX88
 QELG08Uwnpwkme0kSwzwuXFQM5qM0K8wwLQf/VZS+5Ax+/cscS7uD7QMMZiQWoxBETdy
 aMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TmJcrgdi3SbV4ykYkwZhUy5Yo7sWJXnVMg7xcJ1Dzq8=;
 b=DhU5TgrpefsI9qLY5XkiU+l6Es15bpabCQFNS5PAx4PvKaY4F5ucu1br2BDOdjzKBK
 qh2N5dgaBJSlfIBilsaiFEUuT1BGmiwe8VVw9VVy7qfGM9+25uXn8goJXuqVC/dlzjnV
 lomXXv6PKHbxmu1WaF8FtuogeLKHIuN0CGTnuXK2w2HnOFmnav+sY8ZjO1cVC9vRZF5l
 gLIEy8VJy9IDUoz9Lr5ltoISTo/qYQNoybfSN4EBjYkvxRFyT57ClKS35ZiSb3qpAA2F
 iJCXGJkDLkYz32/dB//HmbwgFlJAXVga+SnR1w/d/LJ7pBkY36bpbvjg7P0cEKH5Vd7i
 xzTw==
X-Gm-Message-State: APjAAAXq2/y4rPBtVKOYum1hlerG3RMnaDW5Ew+frXVyeHdTKssokkZL
 WTyGaXHZBhH8FP9OsyGqyQDiTPoYdIB6wvYFsoY=
X-Google-Smtp-Source: APXvYqyPsZmc7RD7jUD4m8yk8dy88XewlJtRpTOEx6dvdghEh+VzACGDVy/nnD9RSFkPVCE4TLOf6ECmGWiCB3xy+Yg=
X-Received: by 2002:a1c:9e10:: with SMTP id h16mr2972316wme.91.1574757592630; 
 Tue, 26 Nov 2019 00:39:52 -0800 (PST)
MIME-Version: 1.0
References: <20191125153619.39893-1-felipe@nutanix.com>
 <20191125153619.39893-5-felipe@nutanix.com>
In-Reply-To: <20191125153619.39893-5-felipe@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 26 Nov 2019 12:39:38 +0400
Message-ID: <CAJ+F1CJT5pe6NYKHVk1OF70RkBK-d9uW4Q93J1yg+jTpL0FhOQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] qom/object: Use common get/set uint helpers
To: Felipe Franciosi <felipe@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Nov 25, 2019 at 7:37 PM Felipe Franciosi <felipe@nutanix.com> wrote=
:
>
> Several objects implemented their own uint property getters and setters,
> despite them being straightforward (without any checks/validations on
> the values themselves) and identical across objects. This makes use of
> an enhanced API for object_property_add_uintXX_ptr() which offers
> default setters.
>
> Some of these setters used to update the value even if the type visit
> failed (eg. because the value being set overflowed over the given type).
> The new setter introduces a check for these errors, not updating the
> value if an error occurred. The error is propagated.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>


Some comments below, otherwise:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/acpi/ich9.c       |  93 +++------------------------------------
>  hw/isa/lpc_ich9.c    |  14 +-----
>  hw/misc/edu.c        |  12 +----
>  hw/pci-host/q35.c    |  14 ++----
>  hw/ppc/spapr.c       |  17 ++------
>  hw/vfio/pci-quirks.c |  18 ++------
>  memory.c             |  15 +------
>  target/arm/cpu.c     |  21 +--------
>  target/i386/sev.c    | 102 +++----------------------------------------
>  9 files changed, 29 insertions(+), 277 deletions(-)
>
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 94dc5147ce..aa3c7a59ab 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -357,81 +357,6 @@ static void ich9_pm_set_cpu_hotplug_legacy(Object *o=
bj, bool value,
>      s->pm.cpu_hotplug_legacy =3D value;
>  }
>
> -static void ich9_pm_get_disable_s3(Object *obj, Visitor *v, const char *=
name,
> -                                   void *opaque, Error **errp)
> -{
> -    ICH9LPCPMRegs *pm =3D opaque;
> -    uint8_t value =3D pm->disable_s3;
> -
> -    visit_type_uint8(v, name, &value, errp);
> -}
> -
> -static void ich9_pm_set_disable_s3(Object *obj, Visitor *v, const char *=
name,
> -                                   void *opaque, Error **errp)
> -{
> -    ICH9LPCPMRegs *pm =3D opaque;
> -    Error *local_err =3D NULL;
> -    uint8_t value;
> -
> -    visit_type_uint8(v, name, &value, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -    pm->disable_s3 =3D value;
> -out:
> -    error_propagate(errp, local_err);
> -}
> -
> -static void ich9_pm_get_disable_s4(Object *obj, Visitor *v, const char *=
name,
> -                                   void *opaque, Error **errp)
> -{
> -    ICH9LPCPMRegs *pm =3D opaque;
> -    uint8_t value =3D pm->disable_s4;
> -
> -    visit_type_uint8(v, name, &value, errp);
> -}
> -
> -static void ich9_pm_set_disable_s4(Object *obj, Visitor *v, const char *=
name,
> -                                   void *opaque, Error **errp)
> -{
> -    ICH9LPCPMRegs *pm =3D opaque;
> -    Error *local_err =3D NULL;
> -    uint8_t value;
> -
> -    visit_type_uint8(v, name, &value, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -    pm->disable_s4 =3D value;
> -out:
> -    error_propagate(errp, local_err);
> -}
> -
> -static void ich9_pm_get_s4_val(Object *obj, Visitor *v, const char *name=
,
> -                               void *opaque, Error **errp)
> -{
> -    ICH9LPCPMRegs *pm =3D opaque;
> -    uint8_t value =3D pm->s4_val;
> -
> -    visit_type_uint8(v, name, &value, errp);
> -}
> -
> -static void ich9_pm_set_s4_val(Object *obj, Visitor *v, const char *name=
,
> -                               void *opaque, Error **errp)
> -{
> -    ICH9LPCPMRegs *pm =3D opaque;
> -    Error *local_err =3D NULL;
> -    uint8_t value;
> -
> -    visit_type_uint8(v, name, &value, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -    pm->s4_val =3D value;
> -out:
> -    error_propagate(errp, local_err);
> -}
> -
>  static bool ich9_pm_get_enable_tco(Object *obj, Error **errp)
>  {
>      ICH9LPCState *s =3D ICH9_LPC_DEVICE(obj);
> @@ -468,18 +393,12 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMR=
egs *pm, Error **errp)
>                               ich9_pm_get_cpu_hotplug_legacy,
>                               ich9_pm_set_cpu_hotplug_legacy,
>                               NULL);
> -    object_property_add(obj, ACPI_PM_PROP_S3_DISABLED, "uint8",
> -                        ich9_pm_get_disable_s3,
> -                        ich9_pm_set_disable_s3,
> -                        NULL, pm, NULL);
> -    object_property_add(obj, ACPI_PM_PROP_S4_DISABLED, "uint8",
> -                        ich9_pm_get_disable_s4,
> -                        ich9_pm_set_disable_s4,
> -                        NULL, pm, NULL);
> -    object_property_add(obj, ACPI_PM_PROP_S4_VAL, "uint8",
> -                        ich9_pm_get_s4_val,
> -                        ich9_pm_set_s4_val,
> -                        NULL, pm, NULL);
> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
> +                                  &pm->disable_s3, false, errp);
> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
> +                                  &pm->disable_s4, false, errp);
> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_VAL,
> +                                  &pm->s4_val, false, errp);

Sometime object properties are registered with error_abort, sometime
with errp, sometime with NULL.

Here you changed the argument. Not a big deal, but I think you should
leave it as is for now. And we can address the error handling
inconsisteny another day.

>      object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
>                               ich9_pm_get_enable_tco,
>                               ich9_pm_set_enable_tco,
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 232c7916f3..9abe07247e 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -627,15 +627,6 @@ static const MemoryRegionOps ich9_rst_cnt_ops =3D {
>      .endianness =3D DEVICE_LITTLE_ENDIAN
>  };
>
> -static void ich9_lpc_get_sci_int(Object *obj, Visitor *v, const char *na=
me,
> -                                 void *opaque, Error **errp)
> -{
> -    ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(obj);
> -    uint8_t value =3D lpc->sci_gsi;
> -
> -    visit_type_uint8(v, name, &value, errp);
> -}
> -
>  static void ich9_lpc_initfn(Object *obj)
>  {
>      ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(obj);
> @@ -643,9 +634,8 @@ static void ich9_lpc_initfn(Object *obj)
>      static const uint8_t acpi_enable_cmd =3D ICH9_APM_ACPI_ENABLE;
>      static const uint8_t acpi_disable_cmd =3D ICH9_APM_ACPI_DISABLE;
>
> -    object_property_add(obj, ACPI_PM_PROP_SCI_INT, "uint8",
> -                        ich9_lpc_get_sci_int,
> -                        NULL, NULL, NULL, NULL);
> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
> +                                  &lpc->sci_gsi, true, NULL);
>      object_property_add_uint8_ptr(obj, ACPI_PM_PROP_ACPI_ENABLE_CMD,
>                                    &acpi_enable_cmd, true, NULL);
>      object_property_add_uint8_ptr(obj, ACPI_PM_PROP_ACPI_DISABLE_CMD,
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index d5e2bdbb57..200503ecfd 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -396,21 +396,13 @@ static void pci_edu_uninit(PCIDevice *pdev)
>      msi_uninit(pdev);
>  }
>
> -static void edu_obj_uint64(Object *obj, Visitor *v, const char *name,
> -                           void *opaque, Error **errp)
> -{
> -    uint64_t *val =3D opaque;
> -
> -    visit_type_uint64(v, name, val, errp);
> -}
> -
>  static void edu_instance_init(Object *obj)
>  {
>      EduState *edu =3D EDU(obj);
>
>      edu->dma_mask =3D (1UL << 28) - 1;
> -    object_property_add(obj, "dma_mask", "uint64", edu_obj_uint64,
> -                    edu_obj_uint64, NULL, &edu->dma_mask, NULL);
> +    object_property_add_uint64_ptr(obj, "dma_mask",
> +                                   &edu->dma_mask, false, NULL);
>  }
>
>  static void edu_class_init(ObjectClass *class, void *data)
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 158d270b9f..61fbe04fe9 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -165,14 +165,6 @@ static void q35_host_get_pci_hole64_end(Object *obj,=
 Visitor *v,
>      visit_type_uint64(v, name, &value, errp);
>  }
>
> -static void q35_host_get_mmcfg_size(Object *obj, Visitor *v, const char =
*name,
> -                                    void *opaque, Error **errp)
> -{
> -    PCIExpressHost *e =3D PCIE_HOST_BRIDGE(obj);
> -
> -    visit_type_uint64(v, name, &e->size, errp);
> -}
> -
>  /*
>   * NOTE: setting defaults for the mch.* fields in this table
>   * doesn't work, because mch is a separate QOM object that is
> @@ -213,6 +205,7 @@ static void q35_host_initfn(Object *obj)
>  {
>      Q35PCIHost *s =3D Q35_HOST_DEVICE(obj);
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(obj);
> +    PCIExpressHost *pehb =3D PCIE_HOST_BRIDGE(obj);
>
>      memory_region_init_io(&phb->conf_mem, obj, &pci_host_conf_le_ops, ph=
b,
>                            "pci-conf-idx", 4);
> @@ -242,9 +235,8 @@ static void q35_host_initfn(Object *obj)
>                          q35_host_get_pci_hole64_end,
>                          NULL, NULL, NULL, NULL);
>
> -    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "uint64",
> -                        q35_host_get_mmcfg_size,
> -                        NULL, NULL, NULL, NULL);
> +    object_property_add_uint64_ptr(obj, PCIE_HOST_MCFG_SIZE,
> +                                   &pehb->size, true, NULL);
>
>      object_property_add_link(obj, MCH_HOST_PROP_RAM_MEM, TYPE_MEMORY_REG=
ION,
>                               (Object **) &s->mch.ram_memory,
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e076f6023c..1b9400526f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3227,18 +3227,6 @@ static void spapr_set_resize_hpt(Object *obj, cons=
t char *value, Error **errp)
>      }
>  }
>
> -static void spapr_get_vsmt(Object *obj, Visitor *v, const char *name,
> -                                   void *opaque, Error **errp)
> -{
> -    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
> -}
> -
> -static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
> -                                   void *opaque, Error **errp)
> -{
> -    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
> -}
> -
>  static char *spapr_get_ic_mode(Object *obj, Error **errp)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> @@ -3336,8 +3324,9 @@ static void spapr_instance_init(Object *obj)
>      object_property_set_description(obj, "resize-hpt",
>                                      "Resizing of the Hash Page Table (en=
abled, disabled, required)",
>                                      NULL);
> -    object_property_add(obj, "vsmt", "uint32", spapr_get_vsmt,
> -                        spapr_set_vsmt, NULL, &spapr->vsmt, &error_abort=
);
> +    object_property_add_uint32_ptr(obj, "vsmt",
> +                                   &spapr->vsmt, false, &error_abort);
> +
>      object_property_set_description(obj, "vsmt",
>                                      "Virtual SMT: KVM behaves as if this=
 were"
>                                      " the host's SMT mode", &error_abort=
);
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 136f3a9ad6..34335e071e 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -2187,14 +2187,6 @@ int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error =
**errp)
>      return 0;
>  }
>
> -static void vfio_pci_nvlink2_get_tgt(Object *obj, Visitor *v,
> -                                     const char *name,
> -                                     void *opaque, Error **errp)
> -{
> -    uint64_t tgt =3D (uintptr_t) opaque;
> -    visit_type_uint64(v, name, &tgt, errp);
> -}
> -
>  static void vfio_pci_nvlink2_get_link_speed(Object *obj, Visitor *v,
>                                                   const char *name,
>                                                   void *opaque, Error **e=
rrp)
> @@ -2240,9 +2232,8 @@ int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vd=
ev, Error **errp)
>                                 nv2reg->size, p);
>      QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
>
> -    object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
> -                        vfio_pci_nvlink2_get_tgt, NULL, NULL,
> -                        (void *) (uintptr_t) cap->tgt, NULL);
> +    object_property_add_uint64_ptr(OBJECT(vdev), "nvlink2-tgt",
> +                                   (void *)(uintptr_t)cap->tgt, true, NU=
LL);

nit: (void *) is enough, no?

>      trace_vfio_pci_nvidia_gpu_setup_quirk(vdev->vbasedev.name, cap->tgt,
>                                            nv2reg->size);
>  free_exit:
> @@ -2301,9 +2292,8 @@ int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Erro=
r **errp)
>          QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
>      }
>
> -    object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
> -                        vfio_pci_nvlink2_get_tgt, NULL, NULL,
> -                        (void *) (uintptr_t) captgt->tgt, NULL);
> +    object_property_add_uint64_ptr(OBJECT(vdev), "nvlink2-tgt",
> +                                   (void *)(uintptr_t)captgt->tgt, true,=
 NULL);

same

>      trace_vfio_pci_nvlink2_setup_quirk_ssatgt(vdev->vbasedev.name, captg=
t->tgt,
>                                                atsdreg->size);
>
> diff --git a/memory.c b/memory.c
> index 06484c2bff..0a34ee3c86 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1158,15 +1158,6 @@ void memory_region_init(MemoryRegion *mr,
>      memory_region_do_init(mr, owner, name, size);
>  }
>
> -static void memory_region_get_addr(Object *obj, Visitor *v, const char *=
name,
> -                                   void *opaque, Error **errp)
> -{
> -    MemoryRegion *mr =3D MEMORY_REGION(obj);
> -    uint64_t value =3D mr->addr;
> -
> -    visit_type_uint64(v, name, &value, errp);
> -}
> -
>  static void memory_region_get_container(Object *obj, Visitor *v,
>                                          const char *name, void *opaque,
>                                          Error **errp)
> @@ -1230,10 +1221,8 @@ static void memory_region_initfn(Object *obj)
>                               NULL, NULL, &error_abort);
>      op->resolve =3D memory_region_resolve_container;
>
> -    object_property_add(OBJECT(mr), "addr", "uint64",
> -                        memory_region_get_addr,
> -                        NULL, /* memory_region_set_addr */
> -                        NULL, NULL, &error_abort);
> +    object_property_add_uint64_ptr(OBJECT(mr), "addr",
> +                                   &mr->addr, true, &error_abort);
>      object_property_add(OBJECT(mr), "priority", "uint32",
>                          memory_region_get_priority,
>                          NULL, /* memory_region_set_priority */
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 7a4ac9339b..aa7278e540 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1039,22 +1039,6 @@ static void arm_set_pmu(Object *obj, bool value, E=
rror **errp)
>      cpu->has_pmu =3D value;
>  }
>
> -static void arm_get_init_svtor(Object *obj, Visitor *v, const char *name=
,
> -                               void *opaque, Error **errp)
> -{
> -    ARMCPU *cpu =3D ARM_CPU(obj);
> -
> -    visit_type_uint32(v, name, &cpu->init_svtor, errp);
> -}
> -
> -static void arm_set_init_svtor(Object *obj, Visitor *v, const char *name=
,
> -                               void *opaque, Error **errp)
> -{
> -    ARMCPU *cpu =3D ARM_CPU(obj);
> -
> -    visit_type_uint32(v, name, &cpu->init_svtor, errp);
> -}
> -
>  void arm_cpu_post_init(Object *obj)
>  {
>      ARMCPU *cpu =3D ARM_CPU(obj);
> @@ -1165,9 +1149,8 @@ void arm_cpu_post_init(Object *obj)
>           * a simple DEFINE_PROP_UINT32 for this because we want to permi=
t
>           * the property to be set after realize.
>           */
> -        object_property_add(obj, "init-svtor", "uint32",
> -                            arm_get_init_svtor, arm_set_init_svtor,
> -                            NULL, NULL, &error_abort);
> +        object_property_add_uint32_ptr(obj, "init-svtor",
> +                                       &cpu->init_svtor, false, &error_a=
bort);
>      }
>
>      qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 024bb24e51..23d7ab8b72 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -266,94 +266,6 @@ qsev_guest_class_init(ObjectClass *oc, void *data)
>              "guest owners session parameters (encoded with base64)", NUL=
L);
>  }
>
> -static void
> -qsev_guest_set_handle(Object *obj, Visitor *v, const char *name,
> -                      void *opaque, Error **errp)
> -{
> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
> -    uint32_t value;
> -
> -    visit_type_uint32(v, name, &value, errp);
> -    sev->handle =3D value;
> -}
> -
> -static void
> -qsev_guest_set_policy(Object *obj, Visitor *v, const char *name,
> -                      void *opaque, Error **errp)
> -{
> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
> -    uint32_t value;
> -
> -    visit_type_uint32(v, name, &value, errp);
> -    sev->policy =3D value;
> -}
> -
> -static void
> -qsev_guest_set_cbitpos(Object *obj, Visitor *v, const char *name,
> -                       void *opaque, Error **errp)
> -{
> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
> -    uint32_t value;
> -
> -    visit_type_uint32(v, name, &value, errp);
> -    sev->cbitpos =3D value;
> -}
> -
> -static void
> -qsev_guest_set_reduced_phys_bits(Object *obj, Visitor *v, const char *na=
me,
> -                                   void *opaque, Error **errp)
> -{
> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
> -    uint32_t value;
> -
> -    visit_type_uint32(v, name, &value, errp);
> -    sev->reduced_phys_bits =3D value;
> -}
> -
> -static void
> -qsev_guest_get_policy(Object *obj, Visitor *v, const char *name,
> -                      void *opaque, Error **errp)
> -{
> -    uint32_t value;
> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
> -
> -    value =3D sev->policy;
> -    visit_type_uint32(v, name, &value, errp);
> -}
> -
> -static void
> -qsev_guest_get_handle(Object *obj, Visitor *v, const char *name,
> -                      void *opaque, Error **errp)
> -{
> -    uint32_t value;
> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
> -
> -    value =3D sev->handle;
> -    visit_type_uint32(v, name, &value, errp);
> -}
> -
> -static void
> -qsev_guest_get_cbitpos(Object *obj, Visitor *v, const char *name,
> -                       void *opaque, Error **errp)
> -{
> -    uint32_t value;
> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
> -
> -    value =3D sev->cbitpos;
> -    visit_type_uint32(v, name, &value, errp);
> -}
> -
> -static void
> -qsev_guest_get_reduced_phys_bits(Object *obj, Visitor *v, const char *na=
me,
> -                                   void *opaque, Error **errp)
> -{
> -    uint32_t value;
> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
> -
> -    value =3D sev->reduced_phys_bits;
> -    visit_type_uint32(v, name, &value, errp);
> -}
> -
>  static void
>  qsev_guest_init(Object *obj)
>  {
> @@ -361,15 +273,11 @@ qsev_guest_init(Object *obj)
>
>      sev->sev_device =3D g_strdup(DEFAULT_SEV_DEVICE);
>      sev->policy =3D DEFAULT_GUEST_POLICY;
> -    object_property_add(obj, "policy", "uint32", qsev_guest_get_policy,
> -                        qsev_guest_set_policy, NULL, NULL, NULL);
> -    object_property_add(obj, "handle", "uint32", qsev_guest_get_handle,
> -                        qsev_guest_set_handle, NULL, NULL, NULL);
> -    object_property_add(obj, "cbitpos", "uint32", qsev_guest_get_cbitpos=
,
> -                        qsev_guest_set_cbitpos, NULL, NULL, NULL);
> -    object_property_add(obj, "reduced-phys-bits", "uint32",
> -                        qsev_guest_get_reduced_phys_bits,
> -                        qsev_guest_set_reduced_phys_bits, NULL, NULL, NU=
LL);
> +    object_property_add_uint32_ptr(obj, "policy", &sev->policy, false, N=
ULL);
> +    object_property_add_uint32_ptr(obj, "handle", &sev->handle, false, N=
ULL);
> +    object_property_add_uint32_ptr(obj, "cbitpos", &sev->cbitpos, false,=
 NULL);
> +    object_property_add_uint32_ptr(obj, "reduced-phys-bits",
> +                                   &sev->reduced_phys_bits, false, NULL)=
;
>  }
>
>  /* sev guest info */
> --
> 2.20.1
>


--=20
Marc-Andr=C3=A9 Lureau

