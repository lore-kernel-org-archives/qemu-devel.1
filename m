Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF76DC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B43821744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImyCB995"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B43821744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6WOK-000593-Og
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 04:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j6WMz-00046B-V0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:19:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j6WMy-0004cP-62
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:19:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37448
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j6WMy-0004bz-2W
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582622351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WSVqLgJ+NFbrdheLNdarJ5hx9TYLuywf7js9M+enFVY=;
 b=ImyCB995NqFKldv+TVK96+NtVld8NPIISXBZ2jLDm5oZAYW/n+udZ7lq5TucLfEkVR3M+C
 1wWXV2GQeGPlYw6kIBwmBtDoaZM3Y6+5OvVm2BWPV6GZXNfPg655ZAcKyG+8Ufv3Ko0RNp
 mPbfrRxrC/lph4AyDE2aTQmCwoQEZTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229--ghF1jdmP2GCw7S9KYttlQ-1; Tue, 25 Feb 2020 04:19:04 -0500
X-MC-Unique: -ghF1jdmP2GCw7S9KYttlQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 068EDDB66;
 Tue, 25 Feb 2020 09:19:03 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 336845C105;
 Tue, 25 Feb 2020 09:18:58 +0000 (UTC)
Subject: Re: [RFC v2 5/6] tpm: Add the SysBus TPM TIS device
From: Auger Eric <eric.auger@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200214183704.14389-1-eric.auger@redhat.com>
 <20200214183704.14389-6-eric.auger@redhat.com>
 <b0c30022-e6f3-b52d-60f8-e94db6b6fe99@linux.ibm.com>
 <0f249506-1d16-2a4c-c3b4-1644536a64f5@redhat.com>
Message-ID: <13c8e9f4-16d9-6926-a2d0-a5771b8d4bf3@redhat.com>
Date: Tue, 25 Feb 2020 10:18:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <0f249506-1d16-2a4c-c3b4-1644536a64f5@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 2/17/20 7:13 PM, Auger Eric wrote:
> Hi Stefan,
>=20
> On 2/16/20 7:32 PM, Stefan Berger wrote:
>> On 2/14/20 1:37 PM, Eric Auger wrote:
>>> Introduce the tpm-tis-device which is a sysbus device
>>> and is bound to be used on ARM.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> ---
>>> =C2=A0 hw/tpm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 5 ++
>>> =C2=A0 hw/tpm/Makefile.objs=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> =C2=A0 hw/tpm/tpm_tis_sysbus.c | 159 ++++++++++++++++++++++++++++++++++=
++++++
>>> =C2=A0 include/sysemu/tpm.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> =C2=A0 4 files changed, 166 insertions(+)
>>> =C2=A0 create mode 100644 hw/tpm/tpm_tis_sysbus.c
>>>
>>> diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
>>> index 686f8206bb..4794e7fe28 100644
>>> --- a/hw/tpm/Kconfig
>>> +++ b/hw/tpm/Kconfig
>>> @@ -7,6 +7,11 @@ config TPM_TIS_ISA
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on TPM && ISA_BUS
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select TPM_TIS
>>> =C2=A0 +config TPM_TIS_SYSBUS
>>> +=C2=A0=C2=A0=C2=A0 bool
>>> +=C2=A0=C2=A0=C2=A0 depends on TPM
>>> +=C2=A0=C2=A0=C2=A0 select TPM_TIS
>>> +
>>> =C2=A0 config TPM_TIS
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on TPM
>>> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
>>> index 3ef2036cca..f1ec4beb95 100644
>>> --- a/hw/tpm/Makefile.objs
>>> +++ b/hw/tpm/Makefile.objs
>>> @@ -1,6 +1,7 @@
>>> =C2=A0 common-obj-$(CONFIG_TPM) +=3D tpm_util.o
>>> =C2=A0 obj-$(call lor,$(CONFIG_TPM_TIS),$(CONFIG_TPM_CRB)) +=3D tpm_ppi=
.o
>>> =C2=A0 common-obj-$(CONFIG_TPM_TIS_ISA) +=3D tpm_tis_isa.o
>>> +common-obj-$(CONFIG_TPM_TIS_SYSBUS) +=3D tpm_tis_sysbus.o
>>> =C2=A0 common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis_common.o
>>> =C2=A0 common-obj-$(CONFIG_TPM_CRB) +=3D tpm_crb.o
>>> =C2=A0 common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
>>> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
>>> new file mode 100644
>>> index 0000000000..18c02aed67
>>> --- /dev/null
>>> +++ b/hw/tpm/tpm_tis_sysbus.c
>>> @@ -0,0 +1,159 @@
>>> +/*
>>> + * tpm_tis_sysbus.c - QEMU's TPM TIS SYSBUS Device
>>> + *
>>> + * Copyright (C) 2006,2010-2013 IBM Corporation
>>> + *
>>> + * Authors:
>>> + *=C2=A0 Stefan Berger <stefanb@us.ibm.com>
>>> + *=C2=A0 David Safford <safford@us.ibm.com>
>>> + *
>>> + * Xen 4 support: Andrease Niederl <andreas.niederl@iaik.tugraz.at>
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>>> later.
>>> + * See the COPYING file in the top-level directory.
>>> + *
>>> + * Implementation of the TIS interface according to specs found at
>>> + * http://www.trustedcomputinggroup.org. This implementation currently
>>> + * supports version 1.3, 21 March 2013
>>> + * In the developers menu choose the PC Client section then find the T=
IS
>>> + * specification.
>>> + *
>>> + * TPM TIS for TPM 2 implementation following TCG PC Client Platform
>>> + * TPM Profile (PTP) Specification, Familiy 2.0, Revision 00.43
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "hw/qdev-properties.h"
>>> +#include "migration/vmstate.h"
>>> +#include "tpm_util.h"
>>> +#include "hw/sysbus.h"
>>> +#include "tpm_tis.h"
>>> +
>>> +typedef struct TPMStateSysBus {
>>> +=C2=A0=C2=A0=C2=A0 /*< private >*/
>>> +=C2=A0=C2=A0=C2=A0 SysBusDevice parent_obj;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /*< public >*/
>>> +=C2=A0=C2=A0=C2=A0 TPMState state; /* not a QOM object */
>>> +} TPMStateSysBus;
>>> +
>>> +#define TPM_TIS_SYSBUS(obj) OBJECT_CHECK(TPMStateSysBus, (obj),
>>> TYPE_TPM_TIS_SYSBUS)
>>> +
>>> +static int tpm_tis_pre_save_sysbus(void *opaque)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 TPMStateSysBus *sbdev =3D opaque;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return tpm_tis_pre_save(&sbdev->state);
>>> +}
>>> +
>>> +static const VMStateDescription vmstate_tpm_tis_sysbus =3D {
>>> +=C2=A0=C2=A0=C2=A0 .name =3D "tpm-tis",
>>> +=C2=A0=C2=A0=C2=A0 .version_id =3D 0,
>>> +=C2=A0=C2=A0=C2=A0 .pre_save=C2=A0 =3D tpm_tis_pre_save_sysbus,
>>> +=C2=A0=C2=A0=C2=A0 .fields =3D (VMStateField[]) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_BUFFER(state.buffer=
, TPMStateSysBus),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT16(state.rw_off=
set, TPMStateSysBus),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT8(state.active_=
locty, TPMStateSysBus),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT8(state.abortin=
g_locty, TPMStateSysBus),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT8(state.next_lo=
cty, TPMStateSysBus),
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_STRUCT_ARRAY(state.=
loc, TPMStateSysBus,
>>> TPM_TIS_NUM_LOCALITIES,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0, vmstate_locty, TPMLocality),
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_END_OF_LIST()
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +};
>>> +
>>> +static void tpm_tis_sysbus_request_completed(TPMIf *ti, int ret)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 TPMStateSysBus *sbdev =3D TPM_TIS_SYSBUS(ti);
>>> +=C2=A0=C2=A0=C2=A0 TPMState *s =3D &sbdev->state;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 tpm_tis_request_completed(s, ret);
>>> +}
>>> +
>>> +static enum TPMVersion tpm_tis_sysbus_get_tpm_version(TPMIf *ti)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 TPMStateSysBus *sbdev =3D TPM_TIS_SYSBUS(ti);
>>> +=C2=A0=C2=A0=C2=A0 TPMState *s =3D &sbdev->state;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return tpm_tis_get_tpm_version(s);
>>> +}
>>> +
>>> +static void tpm_tis_sysbus_reset(DeviceState *dev)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 TPMStateSysBus *sbdev =3D TPM_TIS_SYSBUS(dev);
>>> +=C2=A0=C2=A0=C2=A0 TPMState *s =3D &sbdev->state;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return tpm_tis_reset(s);
>>> +}
>>> +
>>> +static Property tpm_tis_sysbus_properties[] =3D {
>>> +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq=
_num,
>>> TPM_TIS_IRQ),
>>> +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.b=
e_driver),
>>> +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_e=
nabled, true),
>>> +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_END_OF_LIST(),
>>> +};
>>> +
>>> +static void tpm_tis_sysbus_initfn(Object *obj)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 TPMStateSysBus *sbdev =3D TPM_TIS_SYSBUS(obj);
>>> +=C2=A0=C2=A0=C2=A0 TPMState *s =3D &sbdev->state;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 memory_region_init_io(&s->mmio, obj, &tpm_tis_memor=
y_ops,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 s, "tpm-tis-mmio",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 TPM_TIS_NUM_LOCALITIES <<
>>> TPM_TIS_LOCALITY_SHIFT);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>>> +=C2=A0=C2=A0=C2=A0 sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
>>> +}
>>> +
>>> +static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 TPMStateSysBus *sbdev =3D TPM_TIS_SYSBUS(dev);
>>> +=C2=A0=C2=A0=C2=A0 TPMState *s =3D &sbdev->state;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!tpm_find()) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "at most o=
ne TPM device is permitted");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!s->be_driver) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "'tpmdev' =
property is required");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +}
>>> +
>>> +static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);
>>> +=C2=A0=C2=A0=C2=A0 TPMIfClass *tc =3D TPM_IF_CLASS(klass);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 device_class_set_props(dc, tpm_tis_sysbus_propertie=
s);
>>> +=C2=A0=C2=A0=C2=A0 dc->vmsd=C2=A0 =3D &vmstate_tpm_tis_sysbus;
>>> +=C2=A0=C2=A0=C2=A0 tc->model =3D TPM_MODEL_TPM_TIS;
>>> +=C2=A0=C2=A0=C2=A0 dc->realize =3D tpm_tis_sysbus_realizefn;
>>> +=C2=A0=C2=A0=C2=A0 dc->user_creatable =3D true;
>>> +=C2=A0=C2=A0=C2=A0 dc->reset =3D tpm_tis_sysbus_reset;
>>> +=C2=A0=C2=A0=C2=A0 tc->request_completed =3D tpm_tis_sysbus_request_co=
mpleted;
>>> +=C2=A0=C2=A0=C2=A0 tc->get_version =3D tpm_tis_sysbus_get_tpm_version;
>>> +}
>>> +
>>> +static const TypeInfo tpm_tis_sysbus_info =3D {
>>> +=C2=A0=C2=A0=C2=A0 .name =3D TYPE_TPM_TIS_SYSBUS,
>>> +=C2=A0=C2=A0=C2=A0 .parent =3D TYPE_SYS_BUS_DEVICE,
>>> +=C2=A0=C2=A0=C2=A0 .instance_size =3D sizeof(TPMStateSysBus),
>>> +=C2=A0=C2=A0=C2=A0 .instance_init =3D tpm_tis_sysbus_initfn,
>>> +=C2=A0=C2=A0=C2=A0 .class_init=C2=A0 =3D tpm_tis_sysbus_class_init,
>>> +=C2=A0=C2=A0=C2=A0 .interfaces =3D (InterfaceInfo[]) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { TYPE_TPM_IF },
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +};
>>> +
>>> +static void tpm_tis_sysbus_register(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 type_register_static(&tpm_tis_sysbus_info);
>>> +}
>>> +
>>> +type_init(tpm_tis_sysbus_register)
>>> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
>>> index 1691b92c28..f37851b1aa 100644
>>> --- a/include/sysemu/tpm.h
>>> +++ b/include/sysemu/tpm.h
>>> @@ -44,6 +44,7 @@ typedef struct TPMIfClass {
>>> =C2=A0 } TPMIfClass;
>>> =C2=A0 =C2=A0 #define TYPE_TPM_TIS_ISA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "tpm-tis"
>>> +#define TYPE_TPM_TIS_SYSBUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "tpm-tis-device"
>>
>>
>> hm, replace the rather generic 'device' with 'sysbus'?
> I used the "-device" suffix because this kind of naming was used for
> virtio-<type>-device when based on MMIO rather than virtio-<type>-pci.
> For instance virtio-net-device instead of virtio-net-pci. There are
> quite a lot of devices using that suffix. I only see xen-sysbus with the
> sysbus suffix.
>=20
> Now personally I don't have any strong preference and I will pick up the
> name chosen by consensus.

Does anyone else have an opinion on the name to be chosen for this new
device:

1) tpm-tis-device or
2) tpm-tis-sysbus ?

Thanks

Eric

>>
>>
>> Otherwise looks really good.
> Thank you
>=20
> Best Regards
>=20
> Eric
>>
>>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>
>>
>>> =C2=A0 #define TYPE_TPM_CRB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "tpm-crb"
>>> =C2=A0 #define TYPE_TPM_SPAPR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "tpm-spapr"
>>> =C2=A0=20
>>
>>
>=20
>=20


