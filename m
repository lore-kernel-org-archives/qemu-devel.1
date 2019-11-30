Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16D3C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 07:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB1D2084D
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 07:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmBF7BuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB1D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaxXF-0000ET-Gq
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 02:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iaxWI-0008CQ-VZ
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 02:50:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iaxWG-0008Fy-A2
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 02:50:22 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iaxWF-0008F4-Vv
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 02:50:20 -0500
Received: by mail-wr1-x442.google.com with SMTP id t2so37643657wrr.1
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 23:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9uZqTYpYdn1yJ5WuATZx4k3XpAisF+un8NcrcGK8uy4=;
 b=dmBF7BuJK7hsbGP8/bJkWOA45Ej82MhDM6Cg+DL4CMxejwjeCDp6wCiDloL3xxt+Su
 HBypouOwfjDFZ/Gc2Od/ld0hIHej/HQTUKaINxfa9HTAVLUjfpyxFGZ3BUlFmhNEswfh
 zmqNFrbXUdIABudyODQDS53mo3KYUw/EujgwjI06jiVSWTlkBMVBXfhDoo+pN3Fr7r9K
 cXAD70o3Rf4iSC0eYQCbJWcmC5mJzOn0ZpqVk+Ex3THNnU1pO1KIQXy8W7GunLJ0dBbO
 yJgdl+hh5l7ZW4MugAYeUiWmh/kQHwwzkIOH3pUTiGBRrfHcauKhvzN51/k0QCjr6hRi
 sRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9uZqTYpYdn1yJ5WuATZx4k3XpAisF+un8NcrcGK8uy4=;
 b=JVbZzHKiGAlC+qDSVmyA4wwbES/0Cjs/wRkh5rS0Pn7HY1LAeEmhwlOTTTZiqMl5zF
 pe1A9WrFDu9B6qId9A8pigmXaIH9vdfngbq60wR0knVzevBZCIWorfL7pjm32NAyakBS
 RBxf4BCq59uY8SA38adwFOw/gfSjk8+8+NrVLXCmTIT8EzimFRTf7eVv7isUnWiLSJ5I
 ojMMjTj/NMikRjtgzK/e5UNATuS4XX/YnPUgTT/QRpRQ9xQtoi/mu9Vt53/bSB+8YB6l
 yMRojcgj9F7nOqZBIe9hSpxjVhY1Ub1RbroB9m4+xzM4FpR6xcAggUHfPhEcbKkhXX8M
 X5CA==
X-Gm-Message-State: APjAAAV2dt7mYb+VEFZLSNyTmzCOS1BqyT7vb3g2UljKfussHp/j9/rJ
 3++iiXN5UZ8iWwLHlGzlCAmg+2BQG/uCuVc7/wk=
X-Google-Smtp-Source: APXvYqxEQMEH4TkrOSxsOty7OxS+MHak/WQ/pHNYE+sTzjzZvvilpKHCsIY96fxalQwm4xkPQK4/ldZuNoCf54os8UU=
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr3579917wrr.312.1575100218093; 
 Fri, 29 Nov 2019 23:50:18 -0800 (PST)
MIME-Version: 1.0
References: <20191129174630.6922-1-felipe@nutanix.com>
 <20191129174630.6922-2-felipe@nutanix.com>
In-Reply-To: <20191129174630.6922-2-felipe@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 30 Nov 2019 11:50:04 +0400
Message-ID: <CAJ+F1CLraSrG634zNXZGZ=k0aCVxoWXggnTo_WiSY-zW_rMLBg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] qom/object: enable setter for uint types
To: Felipe Franciosi <felipe@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Nov 29, 2019 at 9:46 PM Felipe Franciosi <felipe@nutanix.com> wrote=
:
>
> Traditionally, the uint-specific property helpers only offer getters.
> When adding object (or class) uint types, one must therefore use the
> generic property helper if a setter is needed (and probably duplicate
> some code writing their own getters/setters).
>
> This enhances the uint-specific property helper APIs by adding a
> bitwise-or'd 'flags' field and modifying all clients of that API to set
> this paramater to OBJ_PROP_FLAG_READ. This maintains the current
> behaviour whilst allowing others to also set OBJ_PROP_FLAG_WRITE (or use
> the more convenient OBJ_PROP_FLAG_READWRITE) in the future (which will
> automatically install a setter). Other flags may be added later.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> ---
>  hw/acpi/ich9.c       |   4 +-
>  hw/acpi/pcihp.c      |   7 +-
>  hw/acpi/piix4.c      |  12 +--
>  hw/isa/lpc_ich9.c    |   4 +-
>  hw/ppc/spapr_drc.c   |   3 +-
>  include/qom/object.h |  44 +++++++--
>  qom/object.c         | 216 ++++++++++++++++++++++++++++++++++++++-----
>  ui/console.c         |   4 +-
>  8 files changed, 246 insertions(+), 48 deletions(-)
>
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 2034dd749e..742fb78226 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -454,12 +454,12 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMR=
egs *pm, Error **errp)
>      pm->s4_val =3D 2;
>
>      object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
> -                                   &pm->pm_io_base, errp);
> +                                   &pm->pm_io_base, OBJ_PROP_FLAG_READ, =
errp);
>      object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
>                          ich9_pm_get_gpe0_blk,
>                          NULL, NULL, pm, NULL);
>      object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
> -                                   &gpe0_len, errp);
> +                                   &gpe0_len, OBJ_PROP_FLAG_READ, errp);
>      object_property_add_bool(obj, "memory-hotplug-support",
>                               ich9_pm_get_memory_hotplug_support,
>                               ich9_pm_set_memory_hotplug_support,
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 8413348a33..4dcef372bf 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -80,7 +80,8 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
>
>          *bus_bsel =3D (*bsel_alloc)++;
>          object_property_add_uint32_ptr(OBJECT(bus), ACPI_PCIHP_PROP_BSEL=
,
> -                                       bus_bsel, &error_abort);
> +                                       bus_bsel, OBJ_PROP_FLAG_READ,
> +                                       &error_abort);
>      }
>
>      return bsel_alloc;
> @@ -373,9 +374,9 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *s=
, PCIBus *root_bus,
>      memory_region_add_subregion(address_space_io, s->io_base, &s->io);
>
>      object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_BASE_PROP, &s->i=
o_base,
> -                                   &error_abort);
> +                                   OBJ_PROP_FLAG_READ, &error_abort);
>      object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_LEN_PROP, &s->io=
_len,
> -                                   &error_abort);
> +                                   OBJ_PROP_FLAG_READ, &error_abort);
>  }
>
>  const VMStateDescription vmstate_acpi_pcihp_pci_status =3D {
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 93aec2dd2c..fe05a3ce46 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -443,17 +443,17 @@ static void piix4_pm_add_propeties(PIIX4PMState *s)
>      static const uint16_t sci_int =3D 9;
>
>      object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_ENABLE_CM=
D,
> -                                  &acpi_enable_cmd, NULL);
> +                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ, =
NULL);
>      object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_DISABLE_C=
MD,
> -                                  &acpi_disable_cmd, NULL);
> +                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ,=
 NULL);
>      object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK,
> -                                  &gpe0_blk, NULL);
> +                                  &gpe0_blk, OBJ_PROP_FLAG_READ, NULL);
>      object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK_LEN,
> -                                  &gpe0_blk_len, NULL);
> +                                  &gpe0_blk_len, OBJ_PROP_FLAG_READ, NUL=
L);
>      object_property_add_uint16_ptr(OBJECT(s), ACPI_PM_PROP_SCI_INT,
> -                                  &sci_int, NULL);
> +                                  &sci_int, OBJ_PROP_FLAG_READ, NULL);
>      object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
> -                                  &s->io_base, NULL);
> +                                  &s->io_base, OBJ_PROP_FLAG_READ, NULL)=
;
>  }
>
>  static void piix4_pm_realize(PCIDevice *dev, Error **errp)
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 17c292e306..99517c3946 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -645,9 +645,9 @@ static void ich9_lpc_add_properties(ICH9LPCState *lpc=
)
>                          ich9_lpc_get_sci_int,
>                          NULL, NULL, NULL, NULL);
>      object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_=
CMD,
> -                                  &acpi_enable_cmd, NULL);
> +                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ, =
NULL);
>      object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE=
_CMD,
> -                                  &acpi_disable_cmd, NULL);
> +                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ,=
 NULL);
>
>      ich9_pm_add_properties(OBJECT(lpc), &lpc->pm, NULL);
>  }
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 62f1a42592..bbd4bf35c7 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -553,7 +553,8 @@ static void spapr_dr_connector_instance_init(Object *=
obj)
>      SpaprDrc *drc =3D SPAPR_DR_CONNECTOR(obj);
>      SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>
> -    object_property_add_uint32_ptr(obj, "id", &drc->id, NULL);
> +    object_property_add_uint32_ptr(obj, "id", &drc->id, OBJ_PROP_FLAG_RE=
AD,
> +                                   NULL);
>      object_property_add(obj, "index", "uint32", prop_get_index,
>                          NULL, NULL, NULL, NULL);
>      object_property_add(obj, "fdt", "struct", prop_get_fdt,
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 128d00c77f..d2bfd76741 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1579,65 +1579,93 @@ void object_class_property_add_tm(ObjectClass *kl=
ass, const char *name,
>                                    void (*get)(Object *, struct tm *, Err=
or **),
>                                    Error **errp);
>
> +typedef enum {
> +    /* Automatically add a getter to the property */
> +    OBJ_PROP_FLAG_READ =3D 1 << 0,
> +    /* Automatically add a setter to the property */
> +    OBJ_PROP_FLAG_WRITE =3D 1 << 1,
> +    /* Automatically add a getter and a setter to the property */
> +    OBJ_PROP_FLAG_READWRITE =3D (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRIT=
E),
> +} ObjectPropertyFlags;
> +
>  /**
>   * object_property_add_uint8_ptr:
>   * @obj: the object to add a property to
>   * @name: the name of the property
>   * @v: pointer to value
> + * @flags: bitwise-or'd ObjectPropertyFlags
>   * @errp: if an error occurs, a pointer to an area to store the error
>   *
>   * Add an integer property in memory.  This function will add a
>   * property of type 'uint8'.
>   */
>  void object_property_add_uint8_ptr(Object *obj, const char *name,
> -                                   const uint8_t *v, Error **errp);
> +                                   const uint8_t *v, ObjectPropertyFlags=
 flags,
> +                                   Error **errp);
>  void object_class_property_add_uint8_ptr(ObjectClass *klass, const char =
*name,
> -                                         const uint8_t *v, Error **errp)=
;
> +                                         const uint8_t *v,
> +                                         ObjectPropertyFlags flags,
> +                                         Error **errp);
>
>  /**
>   * object_property_add_uint16_ptr:
>   * @obj: the object to add a property to
>   * @name: the name of the property
>   * @v: pointer to value
> + * @flags: bitwise-or'd ObjectPropertyFlags
>   * @errp: if an error occurs, a pointer to an area to store the error
>   *
>   * Add an integer property in memory.  This function will add a
>   * property of type 'uint16'.
>   */
>  void object_property_add_uint16_ptr(Object *obj, const char *name,
> -                                    const uint16_t *v, Error **errp);
> +                                    const uint16_t *v,
> +                                    ObjectPropertyFlags flags,
> +                                    Error **errp);
>  void object_class_property_add_uint16_ptr(ObjectClass *klass, const char=
 *name,
> -                                          const uint16_t *v, Error **err=
p);
> +                                          const uint16_t *v,
> +                                          ObjectPropertyFlags flags,
> +                                          Error **errp);
>
>  /**
>   * object_property_add_uint32_ptr:
>   * @obj: the object to add a property to
>   * @name: the name of the property
>   * @v: pointer to value
> + * @flags: bitwise-or'd ObjectPropertyFlags
>   * @errp: if an error occurs, a pointer to an area to store the error
>   *
>   * Add an integer property in memory.  This function will add a
>   * property of type 'uint32'.
>   */
>  void object_property_add_uint32_ptr(Object *obj, const char *name,
> -                                    const uint32_t *v, Error **errp);
> +                                    const uint32_t *v,
> +                                    ObjectPropertyFlags flags,
> +                                    Error **errp);
>  void object_class_property_add_uint32_ptr(ObjectClass *klass, const char=
 *name,
> -                                          const uint32_t *v, Error **err=
p);
> +                                          const uint32_t *v,
> +                                          ObjectPropertyFlags flags,
> +                                          Error **errp);
>
>  /**
>   * object_property_add_uint64_ptr:
>   * @obj: the object to add a property to
>   * @name: the name of the property
>   * @v: pointer to value
> + * @flags: bitwise-or'd ObjectPropertyFlags
>   * @errp: if an error occurs, a pointer to an area to store the error
>   *
>   * Add an integer property in memory.  This function will add a
>   * property of type 'uint64'.
>   */
>  void object_property_add_uint64_ptr(Object *obj, const char *name,
> -                                    const uint64_t *v, Error **Errp);
> +                                    const uint64_t *v,
> +                                    ObjectPropertyFlags flags,
> +                                    Error **Errp);
>  void object_class_property_add_uint64_ptr(ObjectClass *klass, const char=
 *name,
> -                                          const uint64_t *v, Error **Err=
p);
> +                                          const uint64_t *v,
> +                                          ObjectPropertyFlags flags,
> +                                          Error **Errp);
>
>  /**
>   * object_property_add_alias:
> diff --git a/qom/object.c b/qom/object.c
> index d51b57fba1..77c2682296 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -2326,6 +2326,22 @@ static void property_get_uint8_ptr(Object *obj, Vi=
sitor *v, const char *name,
>      visit_type_uint8(v, name, &value, errp);
>  }
>
> +static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *=
name,
> +                                   void *opaque, Error **errp)
> +{
> +    uint8_t *field =3D opaque;
> +    uint8_t value;
> +    Error *local_err =3D NULL;
> +
> +    visit_type_uint8(v, name, &value, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    *field =3D value;
> +}
> +
>  static void property_get_uint16_ptr(Object *obj, Visitor *v, const char =
*name,
>                                      void *opaque, Error **errp)
>  {
> @@ -2333,6 +2349,22 @@ static void property_get_uint16_ptr(Object *obj, V=
isitor *v, const char *name,
>      visit_type_uint16(v, name, &value, errp);
>  }
>
> +static void property_set_uint16_ptr(Object *obj, Visitor *v, const char =
*name,
> +                                    void *opaque, Error **errp)
> +{
> +    uint16_t *field =3D opaque;
> +    uint16_t value;
> +    Error *local_err =3D NULL;
> +
> +    visit_type_uint16(v, name, &value, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    *field =3D value;
> +}
> +
>  static void property_get_uint32_ptr(Object *obj, Visitor *v, const char =
*name,
>                                      void *opaque, Error **errp)
>  {
> @@ -2340,6 +2372,22 @@ static void property_get_uint32_ptr(Object *obj, V=
isitor *v, const char *name,
>      visit_type_uint32(v, name, &value, errp);
>  }
>
> +static void property_set_uint32_ptr(Object *obj, Visitor *v, const char =
*name,
> +                                    void *opaque, Error **errp)
> +{
> +    uint32_t *field =3D opaque;
> +    uint32_t value;
> +    Error *local_err =3D NULL;
> +
> +    visit_type_uint32(v, name, &value, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    *field =3D value;
> +}
> +
>  static void property_get_uint64_ptr(Object *obj, Visitor *v, const char =
*name,
>                                      void *opaque, Error **errp)
>  {
> @@ -2347,60 +2395,180 @@ static void property_get_uint64_ptr(Object *obj,=
 Visitor *v, const char *name,
>      visit_type_uint64(v, name, &value, errp);
>  }
>
> +static void property_set_uint64_ptr(Object *obj, Visitor *v, const char =
*name,
> +                                    void *opaque, Error **errp)
> +{
> +    uint64_t *field =3D opaque;
> +    uint64_t value;
> +    Error *local_err =3D NULL;
> +
> +    visit_type_uint64(v, name, &value, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    *field =3D value;
> +}
> +
>  void object_property_add_uint8_ptr(Object *obj, const char *name,
> -                                   const uint8_t *v, Error **errp)
> +                                   const uint8_t *v,
> +                                   ObjectPropertyFlags flags,
> +                                   Error **errp)
>  {
> -    object_property_add(obj, name, "uint8", property_get_uint8_ptr,
> -                        NULL, NULL, (void *)v, errp);
> +    ObjectPropertyAccessor *getter =3D NULL;
> +    ObjectPropertyAccessor *setter =3D NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) =3D=3D OBJ_PROP_FLAG_READ) {
> +        getter =3D property_get_uint8_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) =3D=3D OBJ_PROP_FLAG_WRITE) {
> +        setter =3D property_set_uint8_ptr;
> +    }
> +
> +    object_property_add(obj, name, "uint8",
> +                        getter, setter, NULL, (void *)v, errp);

Or just:

    object_property_add(obj, name, "uint8",
        flags & OBJ_PROP_FLAG_READ ? property_get_uint8_ptr : NULL,
        flags & OBJ_PROP_FLAG_WRITE ? property_set_uint8_ptr : NULL,
        NULL, v, errp);

>  }
>
>  void object_class_property_add_uint8_ptr(ObjectClass *klass, const char =
*name,
> -                                         const uint8_t *v, Error **errp)
> +                                         const uint8_t *v,
> +                                         ObjectPropertyFlags flags,
> +                                         Error **errp)
>  {
> -    object_class_property_add(klass, name, "uint8", property_get_uint8_p=
tr,
> -                              NULL, NULL, (void *)v, errp);
> +    ObjectPropertyAccessor *getter =3D NULL;
> +    ObjectPropertyAccessor *setter =3D NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) =3D=3D OBJ_PROP_FLAG_READ) {
> +        getter =3D property_get_uint8_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) =3D=3D OBJ_PROP_FLAG_WRITE) {
> +        setter =3D property_set_uint8_ptr;
> +    }
> +
> +    object_class_property_add(klass, name, "uint8",
> +                              getter, setter, NULL, (void *)v, errp);
>  }
>
>  void object_property_add_uint16_ptr(Object *obj, const char *name,
> -                                    const uint16_t *v, Error **errp)
> +                                    const uint16_t *v,
> +                                    ObjectPropertyFlags flags,
> +                                    Error **errp)
>  {
> -    object_property_add(obj, name, "uint16", property_get_uint16_ptr,
> -                        NULL, NULL, (void *)v, errp);
> +    ObjectPropertyAccessor *getter =3D NULL;
> +    ObjectPropertyAccessor *setter =3D NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) =3D=3D OBJ_PROP_FLAG_READ) {
> +        getter =3D property_get_uint16_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) =3D=3D OBJ_PROP_FLAG_WRITE) {
> +        setter =3D property_set_uint16_ptr;
> +    }
> +
> +    object_property_add(obj, name, "uint16",
> +                        getter, setter, NULL, (void *)v, errp);
>  }
>
>  void object_class_property_add_uint16_ptr(ObjectClass *klass, const char=
 *name,
> -                                          const uint16_t *v, Error **err=
p)
> +                                          const uint16_t *v,
> +                                          ObjectPropertyFlags flags,
> +                                          Error **errp)
>  {
> -    object_class_property_add(klass, name, "uint16", property_get_uint16=
_ptr,
> -                              NULL, NULL, (void *)v, errp);
> +    ObjectPropertyAccessor *getter =3D NULL;
> +    ObjectPropertyAccessor *setter =3D NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) =3D=3D OBJ_PROP_FLAG_READ) {
> +        getter =3D property_get_uint16_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) =3D=3D OBJ_PROP_FLAG_WRITE) {
> +        setter =3D property_set_uint16_ptr;
> +    }
> +
> +    object_class_property_add(klass, name, "uint16",
> +                              getter, setter, NULL, (void *)v, errp);
>  }
>
>  void object_property_add_uint32_ptr(Object *obj, const char *name,
> -                                    const uint32_t *v, Error **errp)
> +                                    const uint32_t *v,
> +                                    ObjectPropertyFlags flags,
> +                                    Error **errp)
>  {
> -    object_property_add(obj, name, "uint32", property_get_uint32_ptr,
> -                        NULL, NULL, (void *)v, errp);
> +    ObjectPropertyAccessor *getter =3D NULL;
> +    ObjectPropertyAccessor *setter =3D NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) =3D=3D OBJ_PROP_FLAG_READ) {
> +        getter =3D property_get_uint32_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) =3D=3D OBJ_PROP_FLAG_WRITE) {
> +        setter =3D property_set_uint32_ptr;
> +    }
> +
> +    object_property_add(obj, name, "uint32",
> +                        getter, setter, NULL, (void *)v, errp);
>  }
>
>  void object_class_property_add_uint32_ptr(ObjectClass *klass, const char=
 *name,
> -                                          const uint32_t *v, Error **err=
p)
> +                                          const uint32_t *v,
> +                                          ObjectPropertyFlags flags,
> +                                          Error **errp)
>  {
> -    object_class_property_add(klass, name, "uint32", property_get_uint32=
_ptr,
> -                              NULL, NULL, (void *)v, errp);
> +    ObjectPropertyAccessor *getter =3D NULL;
> +    ObjectPropertyAccessor *setter =3D NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) =3D=3D OBJ_PROP_FLAG_READ) {
> +        getter =3D property_get_uint32_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) =3D=3D OBJ_PROP_FLAG_WRITE) {
> +        setter =3D property_set_uint32_ptr;
> +    }
> +
> +    object_class_property_add(klass, name, "uint32",
> +                              getter, setter, NULL, (void *)v, errp);
>  }
>
>  void object_property_add_uint64_ptr(Object *obj, const char *name,
> -                                    const uint64_t *v, Error **errp)
> +                                    const uint64_t *v,
> +                                    ObjectPropertyFlags flags,
> +                                    Error **errp)
>  {
> -    object_property_add(obj, name, "uint64", property_get_uint64_ptr,
> -                        NULL, NULL, (void *)v, errp);
> +    ObjectPropertyAccessor *getter =3D NULL;
> +    ObjectPropertyAccessor *setter =3D NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) =3D=3D OBJ_PROP_FLAG_READ) {
> +        getter =3D property_get_uint64_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) =3D=3D OBJ_PROP_FLAG_WRITE) {
> +        setter =3D property_set_uint64_ptr;
> +    }
> +
> +    object_property_add(obj, name, "uint64",
> +                        getter, setter, NULL, (void *)v, errp);
>  }
>
>  void object_class_property_add_uint64_ptr(ObjectClass *klass, const char=
 *name,
> -                                          const uint64_t *v, Error **err=
p)
> +                                          const uint64_t *v,
> +                                          ObjectPropertyFlags flags,
> +                                          Error **errp)
>  {
> -    object_class_property_add(klass, name, "uint64", property_get_uint64=
_ptr,
> -                              NULL, NULL, (void *)v, errp);
> +    ObjectPropertyAccessor *getter =3D NULL;
> +    ObjectPropertyAccessor *setter =3D NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) =3D=3D OBJ_PROP_FLAG_READ) {
> +        getter =3D property_get_uint64_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) =3D=3D OBJ_PROP_FLAG_WRITE) {
> +        setter =3D property_set_uint64_ptr;
> +    }
> +
> +    object_class_property_add(klass, name, "uint64",
> +                              getter, setter, NULL, (void *)v, errp);
>  }
>
>  typedef struct {
> diff --git a/ui/console.c b/ui/console.c
> index 82d1ddac9c..bcbe65e696 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1296,8 +1296,8 @@ static QemuConsole *new_console(DisplayState *ds, c=
onsole_type_t console_type,
>                               object_property_allow_set_link,
>                               OBJ_PROP_LINK_STRONG,
>                               &error_abort);
> -    object_property_add_uint32_ptr(obj, "head",
> -                                   &s->head, &error_abort);
> +    object_property_add_uint32_ptr(obj, "head", &s->head,
> +                                   OBJ_PROP_FLAG_READ, &error_abort);
>
>      if (!active_console || ((active_console->console_type !=3D GRAPHIC_C=
ONSOLE) &&
>          (console_type =3D=3D GRAPHIC_CONSOLE))) {
> --
> 2.20.1
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

