Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8627EC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F616206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SoZuwXyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F616206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1R2W-0003eG-Ez
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 03:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j1R0h-0001rr-7W
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j1R0f-0006mN-La
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:35:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51022
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j1R0f-0006ia-IK
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581410109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9+CI0JYwGa6Vv0/CTm+jg5tp89NPY/HVAp0X0ZCeoc=;
 b=SoZuwXyJd4cbn/uvT3j3zVR5qM3rJBGsS5tHoGy6gNgCMToBWFaHoSvLm0Eo63d/XmQDyi
 FMh7jfqtPp5ccEg0nSPEClWs3K8ltmE25ixkzuIcW5PUO18oPnWgsHXHvTv9LG/f9E/KVF
 uevpnWCAKmNgI3YQeVyKBR/qWpk9zG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-EnjpStFMO5yk7aGCWo22bA-1; Tue, 11 Feb 2020 03:35:04 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD182107ACCA;
 Tue, 11 Feb 2020 08:34:58 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8020C26FB2;
 Tue, 11 Feb 2020 08:34:49 +0000 (UTC)
Subject: Re: [RFC 1/2] tpm: Let the TPM TIS device be usable on ARM
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 eric.auger.pro@gmail.com, stefanb@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200210131523.27540-1-eric.auger@redhat.com>
 <20200210131523.27540-2-eric.auger@redhat.com>
 <5cbd1960-6138-f4d0-948f-1983cb0f93b0@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e69f69c5-40f5-1fe5-f298-129324cc7055@redhat.com>
Date: Tue, 11 Feb 2020 09:34:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5cbd1960-6138-f4d0-948f-1983cb0f93b0@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: EnjpStFMO5yk7aGCWo22bA-1
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 2/11/20 9:25 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/10/20 2:15 PM, Eric Auger wrote:
>> Implement support for TPM on aarch64 by using the
>> TPM TIS MMIO frontend. Instead of being an ISA device,
>> the TPM TIS device becomes a sysbus device on ARM. It is
>> bound to be dynamically instantiated.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> I am aware such kind of #ifde'fy is frown upon but this is just
>> for starting the discussion
>=20
> I doubt this can be accepted upstream, because a target has to choose
> between using sysbus OR isa devices, not both.
yep that was a first shot to show how this can be derived for ARM but
this deserves some additional care.

Anyway it currently breaks the x86 code because CONFIG_ISA_BUS is never
defined :-( config-devices.h should be included to fix that. Meaning
that the tpm-tis.o should be compiled with additional -I options. In
that prospect tpm-tis.o should be an obj-y and not a common-obj (Connie).
>=20
>> ---
>> =C2=A0 hw/tpm/Kconfig=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 hw/tpm/tpm_tis.c | 16 ++++++++++++++++
>> =C2=A0 2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
>> index 9e67d990e8..326c89e6df 100644
>> --- a/hw/tpm/Kconfig
>> +++ b/hw/tpm/Kconfig
>> @@ -4,7 +4,7 @@ config TPMDEV
>> =C2=A0 =C2=A0 config TPM_TIS
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>> -=C2=A0=C2=A0=C2=A0 depends on TPM && ISA_BUS
>> +=C2=A0=C2=A0=C2=A0 depends on TPM
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select TPMDEV
>> =C2=A0 =C2=A0 config TPM_CRB
>> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
>> index 31facb896d..cfc840942f 100644
>> --- a/hw/tpm/tpm_tis.c
>> +++ b/hw/tpm/tpm_tis.c
>> @@ -30,6 +30,7 @@
>> =C2=A0 =C2=A0 #include "hw/acpi/tpm.h"
>> =C2=A0 #include "hw/pci/pci_ids.h"
>> +#include "hw/sysbus.h"
>> =C2=A0 #include "hw/qdev-properties.h"
>> =C2=A0 #include "migration/vmstate.h"
>> =C2=A0 #include "sysemu/tpm_backend.h"
>> @@ -65,7 +66,11 @@ typedef struct TPMLocality {
>> =C2=A0 } TPMLocality;
>> =C2=A0 =C2=A0 typedef struct TPMState {
>> +#ifdef CONFIG_ISA_BUS
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ISADevice busdev;
>> +#else
>> +=C2=A0=C2=A0=C2=A0 SysBusDevice busdev;
>> +#endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MemoryRegion mmio;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned char buffer[TPM_TIS_BUFFE=
R_MAX];
>> @@ -967,6 +972,7 @@ static void tpm_tis_realizefn(DeviceState *dev,
>> Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, =
"'tpmdev' property is required");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +#ifdef CONFIG_ISA_BUS
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->irq_num > 15) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, =
"IRQ %d is outside valid range of 0 to 15",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->irq_num);
>> @@ -982,6 +988,7 @@ static void tpm_tis_realizefn(DeviceState *dev,
>> Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_ppi_init(&s->=
ppi, isa_address_space(ISA_DEVICE(dev)),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TPM_PPI_ADDR_B=
ASE, OBJECT(s));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +#endif
>> =C2=A0 }
>> =C2=A0 =C2=A0 static void tpm_tis_initfn(Object *obj)
>> @@ -991,6 +998,10 @@ static void tpm_tis_initfn(Object *obj)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory_region_init_io(&s->mmio, OBJECT(s)=
, &tpm_tis_memory_ops,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 s, "tpm-tis-mmio",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 TPM_TIS_NUM_LOCALITIES <<
>> TPM_TIS_LOCALITY_SHIFT);
>> +#ifndef CONFIG_ISA_BUS
>> +=C2=A0=C2=A0=C2=A0 sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>> +=C2=A0=C2=A0=C2=A0 sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
>> +#endif
>> =C2=A0 }
>> =C2=A0 =C2=A0 static void tpm_tis_class_init(ObjectClass *klass, void *d=
ata)
>> @@ -1002,6 +1013,7 @@ static void tpm_tis_class_init(ObjectClass
>> *klass, void *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_class_set_props(dc, tpm_tis_proper=
ties);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->reset =3D tpm_tis_reset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->vmsd=C2=A0 =3D &vmstate_tpm_tis;
>=20
> With your #ifde'fy in mind, you probably need to restrict this to sysbus:
>=20
> =C2=A0 #ifndef CONFIG_ISA_BUS
>=20
>> +=C2=A0=C2=A0=C2=A0 dc->user_creatable =3D true;
>=20
> =C2=A0 #endif
yes you're right, this only applies to sysbus
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tc->model =3D TPM_MODEL_TPM_TIS;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tc->get_version =3D tpm_tis_get_tpm_versi=
on;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tc->request_completed =3D tpm_tis_request=
_completed;
>> @@ -1009,7 +1021,11 @@ static void tpm_tis_class_init(ObjectClass
>> *klass, void *data)
>> =C2=A0 =C2=A0 static const TypeInfo tpm_tis_info =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D TYPE_TPM_TIS,
>> +#ifdef CONFIG_ISA_BUS
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent =3D TYPE_ISA_DEVICE,
>> +#else
>> +=C2=A0=C2=A0=C2=A0 .parent =3D TYPE_SYS_BUS_DEVICE,
>> +#endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .instance_size =3D sizeof(TPMState),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .instance_init =3D tpm_tis_initfn,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .class_init=C2=A0 =3D tpm_tis_class_init,
>>
>=20
> From the sysbus device PoV the patch looks OK.
>=20
> You don't need much to remove the RFC tag:
>=20
> - rename TYPE_TPM_TIS as TYPE_TPM_TIS_ISA
> - rename TPMState as TPMCommonState, add an abstract TYPE_TPM_TIS
> parent, let TYPE_TPM_TIS_ISA be a child
> - add TYPE_TPM_TIS_SYSBUS also child.
Yes I tried my luck without too much hopes ;-)

Thanks!

Eric
>=20


