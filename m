Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70366C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 15:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 284DB2075C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 15:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONg1H5GR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284DB2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaiO7-0003aq-Bd
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 10:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iaiIu-0000RR-Oh
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iaiIq-0001HS-Ov
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:35:32 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iaiIp-00016t-RR
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:35:28 -0500
Received: by mail-wr1-x444.google.com with SMTP id w15so4738375wru.4
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 07:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rdS0pBsjTbXU6XBuj/RG0shyMUIgzZcBtNWsn0zEOxs=;
 b=ONg1H5GRSDxsu3eWxM92PQ80BcXX8E+GIvtikR2347cdtT74G8NhXHIsSyIZDjGd56
 IkuB0ZPViOX1QHPfVcmCBw3i+WY6XfZ/RwJ7isXXbD9sKR8JptbUzPFn0xKG7Q7z8h42
 501XibOxnFTLlhbfwVTFNKtUhoJjXSbmtDL81YRokno9H31Dy+ljpJ5/aWrQQIJ03i9a
 vA9SCVk4toFpmb616l7SW2v6suCpwhxkwaRKQavLRywSHuSq00p/+fILsbHeEKlFdf6u
 4CzMcEP5FaB0V5UHW5EmbGrOU3qM1aoxYrpd7dPof/0NtuayfvbQ9FYnDAa5172WfpAh
 8i9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rdS0pBsjTbXU6XBuj/RG0shyMUIgzZcBtNWsn0zEOxs=;
 b=ZyK4U3iW9YKkA4NXHDgMz5AU3xKHOP7z/3Ci/CoiNKtNzoCjmhNbpVfpC+1dMX1i26
 DysJw/hqgsfM/SoqYzEGwfAziv3vVsf/LhXHHxmJTCA52cYpuQlMmzn4oRE+JGIH+jJy
 jqokKau9KZlBRKCZu+CCuCP6qGVOznWn71Ii2lJiVSVLGx2uk+WJacV8XIV99qddtaK9
 h9jprcLreFlLE4dT49hG9hLa+9iD46uBzS1E07dHISvzSKifcyoy9OeTFhvh7Z/tfhWV
 tIF+2hnK/XUQX2scZivjUrBNs4VWpYJex3BErIOIvz231ojTdzCr44yJpk89hzO4as9j
 NyFw==
X-Gm-Message-State: APjAAAX1MITg+0Bio35rbPss2x78RI9lMdDl3oVzjEm0Ulf1VxXK2fos
 Q1K8vAm4ndO21gW6LcIrAIdID73mybt0Bo4Wb44=
X-Google-Smtp-Source: APXvYqyLU0PffhFZdSgVNReI6JDSbqw1WV1fuMK+8MpfsI8EjDK0ch+Plew77RsHXXuuflmi7ByMtsh05bIu8tfHVTU=
X-Received: by 2002:a5d:670a:: with SMTP id o10mr57124362wru.312.1575041723371; 
 Fri, 29 Nov 2019 07:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20191128164810.54279-1-felipe@nutanix.com>
 <20191128164810.54279-2-felipe@nutanix.com>
 <CAJ+F1C+5poE0Cfsw3WqwLMa_1Rke6m+nUmchxBSYPfZg8+muHw@mail.gmail.com>
 <6E7B22ED-0FF0-4D5A-BEBF-8EED3DCF2A1C@nutanix.com>
In-Reply-To: <6E7B22ED-0FF0-4D5A-BEBF-8EED3DCF2A1C@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 29 Nov 2019 19:35:10 +0400
Message-ID: <CAJ+F1C+JJK5YXp=rjB4Cy97OQxCc8pXDaR_jTwmQYGWarEJ-1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] qom/object: enable setter for uint types
To: Felipe Franciosi <felipe@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

On Fri, Nov 29, 2019 at 7:14 PM Felipe Franciosi <felipe@nutanix.com> wrote=
:
>
> Heya,
>
> > On Nov 28, 2019, at 8:35 PM, Marc-Andr=C3=A9 Lureau <marcandre.lureau@g=
mail.com> wrote:
> >
> > Hi
> >
> > On Thu, Nov 28, 2019 at 8:48 PM Felipe Franciosi <felipe@nutanix.com> w=
rote:
> >>
> >> Traditionally, the uint-specific property helpers only offer getters.
> >> When adding object (or class) uint types, one must therefore use the
> >> generic property helper if a setter is needed (and probably duplicate
> >> some code writing their own getters/setters).
> >>
> >> This enhances the uint-specific property helper APIs by adding a
> >> bitwise-or'd 'flags' field and modifying all clients of that API to se=
t
> >> this paramater to OBJ_PROP_FLAG_RD. This maintains the current behavio=
ur
> >> whilst allowing others to also set OBJ_PROP_FLAG_WR in the future (whi=
ch
> >> will automatically install a setter). Other flags may be added later.
> >
> > For readability, I would have the full spelling:
> > OBJECT_PROPERTY_FLAG_READ/OBJECT_PROPERTY_FLAG_WRITE (and an alias
> > OBJECT_PROPERTY_FLAG_READWRITE =3D READ|WRITE)
>
> I personally prefer the abbreviated version because, IMHO, it's
> sufficiently understandable and make the code cleaner.

I disagree, abbreviations make the code unnecessarily harder to read.
Typing it is a one time thing, and often editor can auto-complete.

>
> Clients of these are already having to use fairly long function names
> (eg.  object_property_add_uint64_ptr -- 30 chars long) and then would
> need to use equally long flags (eg. OBJECT_PROPERTY_FLAG_READWRITE
> also has 30 chars).
>
> I looked it up and found precedence for both models:
>
> https://github.com/qemu/qemu/blob/master/include/block/block.h#L234
> BlockOpType defines enums like BLOCK_OP_TYPE_EJECT
>
> https://github.com/qemu/qemu/blob/master/include/block/block.h#L264
> The permission enums are abbreviated (eg. BLK_PERM_RESIZE)
>
> Is there a broader direction that we should follow here?
>
> Otherwise, can I persuade you to meet me in the middle and we change
> _RD to _READ, _WR to _WRITE, but continue using OBJ_PROP_FLAG?
> Note that I didn't abuse it by going with OBJ_PROP_FL_ :)

We use OBJECT_ prefix for object.h pretty consistently

OBJ_PROP_LINK is imho a bad precedent (I just noticed), but since it
exists, one may want to stick to OBJ_PROP_ prefix for now for
consitency.

>
> As for the alias, I noticed your suggestion in the previous e-mail.
> But I have never seen such combinations in enums that define
> bitwise-or'd flags. For example:
> https://github.com/qemu/qemu/blob/master/include/standard-headers/drivers=
/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h#L106
> https://github.com/qemu/qemu/blob/master/include/qapi/qmp/dispatch.h#L21
>
> It would make sense if this was pound-defined and not enum'd. What do
> you reckon? I'm happy to switch to pound-define and include the
> _READWRITE, but if sticking to enum I think we're better without it.

enum are better imho, see for ex G_PARAM_READWRITE:

https://gitlab.gnome.org/GNOME/glib/blob/master/gobject/gparam.h#L150


> >
> >>
> >> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> >> ---
> >> hw/acpi/ich9.c       |   4 +-
> >> hw/acpi/pcihp.c      |   7 +-
> >> hw/acpi/piix4.c      |  12 +--
> >> hw/isa/lpc_ich9.c    |   4 +-
> >> hw/ppc/spapr_drc.c   |   2 +-
> >> include/qom/object.h |  42 +++++++--
> >> qom/object.c         | 216 ++++++++++++++++++++++++++++++++++++++-----
> >> ui/console.c         |   4 +-
> >> 8 files changed, 243 insertions(+), 48 deletions(-)
> >>
> >> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> >> index 2034dd749e..236300d2a9 100644
> >> --- a/hw/acpi/ich9.c
> >> +++ b/hw/acpi/ich9.c
> >> @@ -454,12 +454,12 @@ void ich9_pm_add_properties(Object *obj, ICH9LPC=
PMRegs *pm, Error **errp)
> >>     pm->s4_val =3D 2;
> >>
> >>     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
> >> -                                   &pm->pm_io_base, errp);
> >> +                                   &pm->pm_io_base, OBJ_PROP_FLAG_RD,=
 errp);
> >>     object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
> >>                         ich9_pm_get_gpe0_blk,
> >>                         NULL, NULL, pm, NULL);
> >>     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
> >> -                                   &gpe0_len, errp);
> >> +                                   &gpe0_len, OBJ_PROP_FLAG_RD, errp)=
;
> >>     object_property_add_bool(obj, "memory-hotplug-support",
> >>                              ich9_pm_get_memory_hotplug_support,
> >>                              ich9_pm_set_memory_hotplug_support,
> >> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> >> index 8413348a33..c8a7194b19 100644
> >> --- a/hw/acpi/pcihp.c
> >> +++ b/hw/acpi/pcihp.c
> >> @@ -80,7 +80,8 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque=
)
> >>
> >>         *bus_bsel =3D (*bsel_alloc)++;
> >>         object_property_add_uint32_ptr(OBJECT(bus), ACPI_PCIHP_PROP_BS=
EL,
> >> -                                       bus_bsel, &error_abort);
> >> +                                       bus_bsel, OBJ_PROP_FLAG_RD,
> >> +                                       &error_abort);
> >>     }
> >>
> >>     return bsel_alloc;
> >> @@ -373,9 +374,9 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState=
 *s, PCIBus *root_bus,
> >>     memory_region_add_subregion(address_space_io, s->io_base, &s->io);
> >>
> >>     object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_BASE_PROP, &s-=
>io_base,
> >> -                                   &error_abort);
> >> +                                   OBJ_PROP_FLAG_RD, &error_abort);
> >>     object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_LEN_PROP, &s->=
io_len,
> >> -                                   &error_abort);
> >> +                                   OBJ_PROP_FLAG_RD, &error_abort);
> >> }
> >>
> >> const VMStateDescription vmstate_acpi_pcihp_pci_status =3D {
> >> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> >> index 93aec2dd2c..06d964a840 100644
> >> --- a/hw/acpi/piix4.c
> >> +++ b/hw/acpi/piix4.c
> >> @@ -443,17 +443,17 @@ static void piix4_pm_add_propeties(PIIX4PMState =
*s)
> >>     static const uint16_t sci_int =3D 9;
> >>
> >>     object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_ENABLE_=
CMD,
> >> -                                  &acpi_enable_cmd, NULL);
> >> +                                  &acpi_enable_cmd, OBJ_PROP_FLAG_RD,=
 NULL);
> >>     object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_DISABLE=
_CMD,
> >> -                                  &acpi_disable_cmd, NULL);
> >> +                                  &acpi_disable_cmd, OBJ_PROP_FLAG_RD=
, NULL);
> >>     object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK,
> >> -                                  &gpe0_blk, NULL);
> >> +                                  &gpe0_blk, OBJ_PROP_FLAG_RD, NULL);
> >>     object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK_LE=
N,
> >> -                                  &gpe0_blk_len, NULL);
> >> +                                  &gpe0_blk_len, OBJ_PROP_FLAG_RD, NU=
LL);
> >>     object_property_add_uint16_ptr(OBJECT(s), ACPI_PM_PROP_SCI_INT,
> >> -                                  &sci_int, NULL);
> >> +                                  &sci_int, OBJ_PROP_FLAG_RD, NULL);
> >>     object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
> >> -                                  &s->io_base, NULL);
> >> +                                  &s->io_base, OBJ_PROP_FLAG_RD, NULL=
);
> >> }
> >>
> >> static void piix4_pm_realize(PCIDevice *dev, Error **errp)
> >> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> >> index 17c292e306..f5526f9c3b 100644
> >> --- a/hw/isa/lpc_ich9.c
> >> +++ b/hw/isa/lpc_ich9.c
> >> @@ -645,9 +645,9 @@ static void ich9_lpc_add_properties(ICH9LPCState *=
lpc)
> >>                         ich9_lpc_get_sci_int,
> >>                         NULL, NULL, NULL, NULL);
> >>     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABL=
E_CMD,
> >> -                                  &acpi_enable_cmd, NULL);
> >> +                                  &acpi_enable_cmd, OBJ_PROP_FLAG_RD,=
 NULL);
> >>     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISAB=
LE_CMD,
> >> -                                  &acpi_disable_cmd, NULL);
> >> +                                  &acpi_disable_cmd, OBJ_PROP_FLAG_RD=
, NULL);
> >>
> >>     ich9_pm_add_properties(OBJECT(lpc), &lpc->pm, NULL);
> >> }
> >> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> >> index 62f1a42592..ace2db0413 100644
> >> --- a/hw/ppc/spapr_drc.c
> >> +++ b/hw/ppc/spapr_drc.c
> >> @@ -553,7 +553,7 @@ static void spapr_dr_connector_instance_init(Objec=
t *obj)
> >>     SpaprDrc *drc =3D SPAPR_DR_CONNECTOR(obj);
> >>     SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> >>
> >> -    object_property_add_uint32_ptr(obj, "id", &drc->id, NULL);
> >> +    object_property_add_uint32_ptr(obj, "id", &drc->id, OBJ_PROP_FLAG=
_RD, NULL);
> >>     object_property_add(obj, "index", "uint32", prop_get_index,
> >>                         NULL, NULL, NULL, NULL);
> >>     object_property_add(obj, "fdt", "struct", prop_get_fdt,
> >> diff --git a/include/qom/object.h b/include/qom/object.h
> >> index 128d00c77f..4836c54e93 100644
> >> --- a/include/qom/object.h
> >> +++ b/include/qom/object.h
> >> @@ -1579,65 +1579,91 @@ void object_class_property_add_tm(ObjectClass =
*klass, const char *name,
> >>                                   void (*get)(Object *, struct tm *, E=
rror **),
> >>                                   Error **errp);
> >>
> >> +typedef enum {
> >> +    /* Automatically add a getter to the property */
> >> +    OBJ_PROP_FLAG_RD =3D (1UL << 0),
> >> +    /* Automatically add a setter to the property */
> >> +    OBJ_PROP_FLAG_WR =3D (1UL << 1),
> >> +} ObjectPropertyFlags;
> >> +
> >> /**
> >>  * object_property_add_uint8_ptr:
> >>  * @obj: the object to add a property to
> >>  * @name: the name of the property
> >>  * @v: pointer to value
> >> + * @flags: bitwise-or'd ObjectPropertyFlags
> >>  * @errp: if an error occurs, a pointer to an area to store the error
> >>  *
> >>  * Add an integer property in memory.  This function will add a
> >>  * property of type 'uint8'.
> >>  */
> >> void object_property_add_uint8_ptr(Object *obj, const char *name,
> >> -                                   const uint8_t *v, Error **errp);
> >> +                                   const uint8_t *v, ObjectPropertyFl=
ags flags,
> >> +                                   Error **errp);
> >> void object_class_property_add_uint8_ptr(ObjectClass *klass, const cha=
r *name,
> >> -                                         const uint8_t *v, Error **er=
rp);
> >> +                                         const uint8_t *v,
> >> +                                         ObjectPropertyFlags flags,
> >> +                                         Error **errp);
> >>
> >> /**
> >>  * object_property_add_uint16_ptr:
> >>  * @obj: the object to add a property to
> >>  * @name: the name of the property
> >>  * @v: pointer to value
> >> + * @flags: bitwise-or'd ObjectPropertyFlags
> >>  * @errp: if an error occurs, a pointer to an area to store the error
> >>  *
> >>  * Add an integer property in memory.  This function will add a
> >>  * property of type 'uint16'.
> >>  */
> >> void object_property_add_uint16_ptr(Object *obj, const char *name,
> >> -                                    const uint16_t *v, Error **errp);
> >> +                                    const uint16_t *v,
> >> +                                    ObjectPropertyFlags flags,
> >> +                                    Error **errp);
> >> void object_class_property_add_uint16_ptr(ObjectClass *klass, const ch=
ar *name,
> >> -                                          const uint16_t *v, Error **=
errp);
> >> +                                          const uint16_t *v,
> >> +                                          ObjectPropertyFlags flags,
> >> +                                          Error **errp);
> >>
> >> /**
> >>  * object_property_add_uint32_ptr:
> >>  * @obj: the object to add a property to
> >>  * @name: the name of the property
> >>  * @v: pointer to value
> >> + * @flags: bitwise-or'd ObjectPropertyFlags
> >>  * @errp: if an error occurs, a pointer to an area to store the error
> >>  *
> >>  * Add an integer property in memory.  This function will add a
> >>  * property of type 'uint32'.
> >>  */
> >> void object_property_add_uint32_ptr(Object *obj, const char *name,
> >> -                                    const uint32_t *v, Error **errp);
> >> +                                    const uint32_t *v,
> >> +                                    ObjectPropertyFlags flags,
> >> +                                    Error **errp);
> >> void object_class_property_add_uint32_ptr(ObjectClass *klass, const ch=
ar *name,
> >> -                                          const uint32_t *v, Error **=
errp);
> >> +                                          const uint32_t *v,
> >> +                                          ObjectPropertyFlags flags,
> >> +                                          Error **errp);
> >>
> >> /**
> >>  * object_property_add_uint64_ptr:
> >>  * @obj: the object to add a property to
> >>  * @name: the name of the property
> >>  * @v: pointer to value
> >> + * @flags: bitwise-or'd ObjectPropertyFlags
> >>  * @errp: if an error occurs, a pointer to an area to store the error
> >>  *
> >>  * Add an integer property in memory.  This function will add a
> >>  * property of type 'uint64'.
> >>  */
> >> void object_property_add_uint64_ptr(Object *obj, const char *name,
> >> -                                    const uint64_t *v, Error **Errp);
> >> +                                    const uint64_t *v,
> >> +                                    ObjectPropertyFlags flags,
> >> +                                    Error **Errp);
> >> void object_class_property_add_uint64_ptr(ObjectClass *klass, const ch=
ar *name,
> >> -                                          const uint64_t *v, Error **=
Errp);
> >> +                                          const uint64_t *v,
> >> +                                          ObjectPropertyFlags flags,
> >> +                                          Error **Errp);
> >>
> >> /**
> >>  * object_property_add_alias:
> >> diff --git a/qom/object.c b/qom/object.c
> >> index d51b57fba1..6f300b5317 100644
> >> --- a/qom/object.c
> >> +++ b/qom/object.c
> >> @@ -2326,6 +2326,22 @@ static void property_get_uint8_ptr(Object *obj,=
 Visitor *v, const char *name,
> >>     visit_type_uint8(v, name, &value, errp);
> >> }
> >>
> >> +static void property_set_uint8_ptr(Object *obj, Visitor *v, const cha=
r *name,
> >> +                                   void *opaque, Error **errp)
> >> +{
> >> +    uint8_t *field =3D opaque;
> >> +    uint8_t value;
> >> +    Error *local_err =3D NULL;
> >> +
> >> +    visit_type_uint8(v, name, &value, &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +        return;
> >> +    }
> >> +
> >> +    *field =3D value;
> >> +}
> >> +
> >> static void property_get_uint16_ptr(Object *obj, Visitor *v, const cha=
r *name,
> >>                                     void *opaque, Error **errp)
> >> {
> >> @@ -2333,6 +2349,22 @@ static void property_get_uint16_ptr(Object *obj=
, Visitor *v, const char *name,
> >>     visit_type_uint16(v, name, &value, errp);
> >> }
> >>
> >> +static void property_set_uint16_ptr(Object *obj, Visitor *v, const ch=
ar *name,
> >> +                                    void *opaque, Error **errp)
> >> +{
> >> +    uint16_t *field =3D opaque;
> >> +    uint16_t value;
> >> +    Error *local_err =3D NULL;
> >> +
> >> +    visit_type_uint16(v, name, &value, &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +        return;
> >> +    }
> >> +
> >> +    *field =3D value;
> >> +}
> >> +
> >> static void property_get_uint32_ptr(Object *obj, Visitor *v, const cha=
r *name,
> >>                                     void *opaque, Error **errp)
> >> {
> >> @@ -2340,6 +2372,22 @@ static void property_get_uint32_ptr(Object *obj=
, Visitor *v, const char *name,
> >>     visit_type_uint32(v, name, &value, errp);
> >> }
> >>
> >> +static void property_set_uint32_ptr(Object *obj, Visitor *v, const ch=
ar *name,
> >> +                                    void *opaque, Error **errp)
> >> +{
> >> +    uint32_t *field =3D opaque;
> >> +    uint32_t value;
> >> +    Error *local_err =3D NULL;
> >> +
> >> +    visit_type_uint32(v, name, &value, &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +        return;
> >> +    }
> >> +
> >> +    *field =3D value;
> >> +}
> >> +
> >> static void property_get_uint64_ptr(Object *obj, Visitor *v, const cha=
r *name,
> >>                                     void *opaque, Error **errp)
> >> {
> >> @@ -2347,60 +2395,180 @@ static void property_get_uint64_ptr(Object *o=
bj, Visitor *v, const char *name,
> >>     visit_type_uint64(v, name, &value, errp);
> >> }
> >>
> >> +static void property_set_uint64_ptr(Object *obj, Visitor *v, const ch=
ar *name,
> >> +                                    void *opaque, Error **errp)
> >> +{
> >> +    uint64_t *field =3D opaque;
> >> +    uint64_t value;
> >> +    Error *local_err =3D NULL;
> >> +
> >> +    visit_type_uint64(v, name, &value, &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +        return;
> >> +    }
> >> +
> >> +    *field =3D value;
> >> +}
> >> +
> >> void object_property_add_uint8_ptr(Object *obj, const char *name,
> >> -                                   const uint8_t *v, Error **errp)
> >> +                                   const uint8_t *v,
> >> +                                   ObjectPropertyFlags flags,
> >> +                                   Error **errp)
> >> {
> >> -    object_property_add(obj, name, "uint8", property_get_uint8_ptr,
> >> -                        NULL, NULL, (void *)v, errp);
> >> +    ObjectPropertyAccessor *getter =3D NULL;
> >> +    ObjectPropertyAccessor *setter =3D NULL;
> >> +
> >> +    if ((flags & OBJ_PROP_FLAG_RD) =3D=3D OBJ_PROP_FLAG_RD) {
> >> +        getter =3D property_get_uint8_ptr;
> >> +    }
> >> +
> >> +    if ((flags & OBJ_PROP_FLAG_WR) =3D=3D OBJ_PROP_FLAG_WR) {
> >> +        setter =3D property_set_uint8_ptr;
> >> +    }
> >> +
> >> +    object_property_add(obj, name, "uint8",
> >> +                        getter, setter, NULL, (void *)v, errp);
> >> }
> >>
> >> void object_class_property_add_uint8_ptr(ObjectClass *klass, const cha=
r *name,
> >> -                                         const uint8_t *v, Error **er=
rp)
> >> +                                         const uint8_t *v,
> >> +                                         ObjectPropertyFlags flags,
> >> +                                         Error **errp)
> >> {
> >> -    object_class_property_add(klass, name, "uint8", property_get_uint=
8_ptr,
> >> -                              NULL, NULL, (void *)v, errp);
> >> +    ObjectPropertyAccessor *getter =3D NULL;
> >> +    ObjectPropertyAccessor *setter =3D NULL;
> >> +
> >> +    if ((flags & OBJ_PROP_FLAG_RD) =3D=3D OBJ_PROP_FLAG_RD) {
> >> +        getter =3D property_get_uint8_ptr;
> >> +    }
> >> +
> >> +    if ((flags & OBJ_PROP_FLAG_WR) =3D=3D OBJ_PROP_FLAG_WR) {
> >> +        setter =3D property_set_uint8_ptr;
> >> +    }
> >> +
> >> +    object_class_property_add(klass, name, "uint8",
> >> +                              getter, setter, NULL, (void *)v, errp);
> >> }
> >>
> >> void object_property_add_uint16_ptr(Object *obj, const char *name,
> >> -                                    const uint16_t *v, Error **errp)
> >> +                                    const uint16_t *v,
> >> +                                    ObjectPropertyFlags flags,
> >> +                                    Error **errp)
> >> {
> >> -    object_property_add(obj, name, "uint16", property_get_uint16_ptr,
> >> -                        NULL, NULL, (void *)v, errp);
> >> +    ObjectPropertyAccessor *getter =3D NULL;
> >> +    ObjectPropertyAccessor *setter =3D NULL;
> >> +
> >> +    if ((flags & OBJ_PROP_FLAG_RD) =3D=3D OBJ_PROP_FLAG_RD) {
> >> +        getter =3D property_get_uint16_ptr;
> >> +    }
> >> +
> >> +    if ((flags & OBJ_PROP_FLAG_WR) =3D=3D OBJ_PROP_FLAG_WR) {
> >> +        setter =3D property_set_uint16_ptr;
> >> +    }
> >> +
> >> +    object_property_add(obj, name, "uint16",
> >> +                        getter, setter, NULL, (void *)v, errp);
> >> }
> >>
> >> void object_class_property_add_uint16_ptr(ObjectClass *klass, const ch=
ar *name,
> >> -                                          const uint16_t *v, Error **=
errp)
> >> +                                          const uint16_t *v,
> >> +                                          ObjectPropertyFlags flags,
> >> +                                          Error **errp)
> >> {
> >> -    object_class_property_add(klass, name, "uint16", property_get_uin=
t16_ptr,
> >> -                              NULL, NULL, (void *)v, errp);
> >> +    ObjectPropertyAccessor *getter =3D NULL;
> >> +    ObjectPropertyAccessor *setter =3D NULL;
> >> +
> >> +    if ((flags & OBJ_PROP_FLAG_RD) =3D=3D OBJ_PROP_FLAG_RD) {
> >> +        getter =3D property_get_uint16_ptr;
> >> +    }
> >> +
> >> +    if ((flags & OBJ_PROP_FLAG_WR) =3D=3D OBJ_PROP_FLAG_WR) {
> >> +        setter =3D property_set_uint16_ptr;
> >> +    }
> >> +
> >> +    object_class_property_add(klass, name, "uint16",
> >> +                              getter, setter, NULL, (void *)v, errp);
> >> }
> >>
> >> void object_property_add_uint32_ptr(Object *obj, const char *name,
> >> -                                    const uint32_t *v, Error **errp)
> >> +                                    const uint32_t *v,
> >> +                                    ObjectPropertyFlags flags,
> >> +                                    Error **errp)
> >> {
> >> -    object_property_add(obj, name, "uint32", property_get_uint32_ptr,
> >> -                        NULL, NULL, (void *)v, errp);
> >> +    ObjectPropertyAccessor *getter =3D NULL;
> >> +    ObjectPropertyAccessor *setter =3D NULL;
> >> +
> >> +    if ((flags & OBJ_PROP_FLAG_RD) =3D=3D OBJ_PROP_FLAG_RD) {
> >> +        getter =3D property_get_uint32_ptr;
> >> +    }
> >> +
> >> +    if ((flags & OBJ_PROP_FLAG_WR) =3D=3D OBJ_PROP_FLAG_WR) {
> >> +        setter =3D property_set_uint32_ptr;
> >> +    }
> >> +
> >> +    object_property_add(obj, name, "uint32",
> >> +                        getter, setter, NULL, (void *)v, errp);
> >> }
> >>
> >> void object_class_property_add_uint32_ptr(ObjectClass *klass, const ch=
ar *name,
> >> -                                          const uint32_t *v, Error **=
errp)
> >> +                                          const uint32_t *v,
> >> +                                          ObjectPropertyFlags flags,
> >> +                                          Error **errp)
> >> {
> >> -    object_class_property_add(klass, name, "uint32", property_get_uin=
t32_ptr,
> >> -                              NULL, NULL, (void *)v, errp);
> >> +    ObjectPropertyAccessor *getter =3D NULL;
> >> +    ObjectPropertyAccessor *setter =3D NULL;
> >> +
> >> +    if ((flags & OBJ_PROP_FLAG_RD) =3D=3D OBJ_PROP_FLAG_RD) {
> >> +        getter =3D property_get_uint32_ptr;
> >> +    }
> >> +
> >> +    if ((flags & OBJ_PROP_FLAG_WR) =3D=3D OBJ_PROP_FLAG_WR) {
> >> +        setter =3D property_set_uint32_ptr;
> >> +    }
> >> +
> >> +    object_class_property_add(klass, name, "uint32",
> >> +                              getter, setter, NULL, (void *)v, errp);
> >> }
> >>
> >> void object_property_add_uint64_ptr(Object *obj, const char *name,
> >> -                                    const uint64_t *v, Error **errp)
> >> +                                    const uint64_t *v,
> >> +                                    ObjectPropertyFlags flags,
> >> +                                    Error **errp)
> >> {
> >> -    object_property_add(obj, name, "uint64", property_get_uint64_ptr,
> >> -                        NULL, NULL, (void *)v, errp);
> >> +    ObjectPropertyAccessor *getter =3D NULL;
> >> +    ObjectPropertyAccessor *setter =3D NULL;
> >> +
> >> +    if ((flags & OBJ_PROP_FLAG_RD) =3D=3D OBJ_PROP_FLAG_RD) {
> >> +        getter =3D property_get_uint64_ptr;
> >> +    }
> >> +
> >> +    if ((flags & OBJ_PROP_FLAG_WR) =3D=3D OBJ_PROP_FLAG_WR) {
> >> +        setter =3D property_set_uint64_ptr;
> >> +    }
> >> +
> >> +    object_property_add(obj, name, "uint64",
> >> +                        getter, setter, NULL, (void *)v, errp);
> >> }
> >>
> >> void object_class_property_add_uint64_ptr(ObjectClass *klass, const ch=
ar *name,
> >> -                                          const uint64_t *v, Error **=
errp)
> >> +                                          const uint64_t *v,
> >> +                                          ObjectPropertyFlags flags,
> >> +                                          Error **errp)
> >> {
> >> -    object_class_property_add(klass, name, "uint64", property_get_uin=
t64_ptr,
> >> -                              NULL, NULL, (void *)v, errp);
> >> +    ObjectPropertyAccessor *getter =3D NULL;
> >> +    ObjectPropertyAccessor *setter =3D NULL;
> >> +
> >> +    if ((flags & OBJ_PROP_FLAG_RD) =3D=3D OBJ_PROP_FLAG_RD) {
> >> +        getter =3D property_get_uint64_ptr;
> >> +    }
> >> +
> >> +    if ((flags & OBJ_PROP_FLAG_WR) =3D=3D OBJ_PROP_FLAG_WR) {
> >> +        setter =3D property_set_uint64_ptr;
> >> +    }
> >> +
> >> +    object_class_property_add(klass, name, "uint64",
> >> +                              getter, setter, NULL, (void *)v, errp);
> >> }
> >>
> >> typedef struct {
> >> diff --git a/ui/console.c b/ui/console.c
> >> index 82d1ddac9c..7d6ef90978 100644
> >> --- a/ui/console.c
> >> +++ b/ui/console.c
> >> @@ -1296,8 +1296,8 @@ static QemuConsole *new_console(DisplayState *ds=
, console_type_t console_type,
> >>                              object_property_allow_set_link,
> >>                              OBJ_PROP_LINK_STRONG,
> >>                              &error_abort);
> >> -    object_property_add_uint32_ptr(obj, "head",
> >> -                                   &s->head, &error_abort);
> >> +    object_property_add_uint32_ptr(obj, "head", &s->head,
> >> +                                   OBJ_PROP_FLAG_RD, &error_abort);
> >>
> >>     if (!active_console || ((active_console->console_type !=3D GRAPHIC=
_CONSOLE) &&
> >>         (console_type =3D=3D GRAPHIC_CONSOLE))) {
> >> --
> >> 2.20.1
> >>
> >
> >
> > looks good otherwise
>
> Thanks,
> Felipe
>
>
> >
>
> > --
> > Marc-Andr=C3=A9 Lureau
>


--=20
Marc-Andr=C3=A9 Lureau

