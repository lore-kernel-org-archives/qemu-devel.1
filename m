Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF54C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989A721556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tj0yeLuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989A721556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6X7D-0002IP-Ox
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j6X62-0000zW-5X
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:05:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j6X60-0005FY-Uc
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:05:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45091
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j6X60-0005FF-Pv
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582625144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7OSKE5FfEEqR2AAK4vhOTEXWBAuXPKaR5aBgEfmckDA=;
 b=Tj0yeLuZDv1w0at5hkNquMuU+tbZWVFfojf6jEdEiMoHCSfkNXhTOSQBoraSxb05ykkmVz
 8sNm/AT+I8OG1vUbboaIOm0nLiaHu0soL98mEsKqwmKpB9qpprYFsGSFpEyIcGCLViiXEm
 nNmEpkaja3B232PWyqD8J4NTTWMJHyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-mQ9hdc2aPLGnyH5Y6nxKwg-1; Tue, 25 Feb 2020 05:05:40 -0500
X-MC-Unique: mQ9hdc2aPLGnyH5Y6nxKwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C3F9802C92;
 Tue, 25 Feb 2020 10:05:39 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B564D88854;
 Tue, 25 Feb 2020 10:05:32 +0000 (UTC)
Subject: Re: [RFC v2 4/6] tpm: Separate TPM_TIS and TPM_TIS_ISA configs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 eric.auger.pro@gmail.com, stefanb@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200214183704.14389-1-eric.auger@redhat.com>
 <20200214183704.14389-5-eric.auger@redhat.com>
 <3d53d213-0135-6b9f-7684-39c4d6ae1321@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <187b7a1b-6f69-1f48-a7be-1b374ec89a48@redhat.com>
Date: Tue, 25 Feb 2020 11:05:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3d53d213-0135-6b9f-7684-39c4d6ae1321@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 2/14/20 8:03 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/14/20 7:37 PM, Eric Auger wrote:
>> Let's separate the compilation of tpm_tis_common.c from
>> the compilation of tpm_tis_isa.c
>>
>> The common part will be also compiled along with the
>> tpm_tis_sysbus device.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> =C2=A0 default-configs/i386-softmmu.mak | 2 +-
>> =C2=A0 hw/i386/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>> =C2=A0 hw/tpm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 7 ++++++-
>> =C2=A0 hw/tpm/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 ++-
>> =C2=A0 tests/qtest/Makefile.include=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>> =C2=A0 5 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/default-configs/i386-softmmu.mak
>> b/default-configs/i386-softmmu.mak
>> index 4cc64dafa2..84d1a2487c 100644
>> --- a/default-configs/i386-softmmu.mak
>> +++ b/default-configs/i386-softmmu.mak
>> @@ -20,7 +20,7 @@
>> =C2=A0 #CONFIG_SGA=3Dn
>> =C2=A0 #CONFIG_TEST_DEVICES=3Dn
>> =C2=A0 #CONFIG_TPM_CRB=3Dn
>> -#CONFIG_TPM_TIS=3Dn
>> +#CONFIG_TPM_TIS_ISA=3Dn
>> =C2=A0 #CONFIG_VTD=3Dn
>> =C2=A0 =C2=A0 # Boards:
>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>> index cdc851598c..c93f32f657 100644
>> --- a/hw/i386/Kconfig
>> +++ b/hw/i386/Kconfig
>> @@ -20,7 +20,7 @@ config PC
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imply SGA
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imply TEST_DEVICES
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imply TPM_CRB
>> -=C2=A0=C2=A0=C2=A0 imply TPM_TIS
>> +=C2=A0=C2=A0=C2=A0 imply TPM_TIS_ISA
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imply VGA_PCI
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imply VIRTIO_VGA
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select FDC
>> diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
>> index 9e67d990e8..686f8206bb 100644
>> --- a/hw/tpm/Kconfig
>> +++ b/hw/tpm/Kconfig
>> @@ -2,9 +2,14 @@ config TPMDEV
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on TPM
>> =C2=A0 -config TPM_TIS
>> +config TPM_TIS_ISA
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on TPM && ISA_BUS
>=20
> Maybe you can relax to "depends on ISA_BUS" ...

No I am forced to keep it to pass
make docker-test-mingw@fedora

Otherwise I get:
make: *** No rule to make target 'x86_64-softmmu/config-devices.mak',
needed by 'config-all-devices.mak'.  Stop.
Traceback (most recent call last):

As we discussed earlier with mingw configure sets TPM to false.


>=20
>> +=C2=A0=C2=A0=C2=A0 select TPM_TIS
>> +
>> +config TPM_TIS
>> +=C2=A0=C2=A0=C2=A0 bool
>> +=C2=A0=C2=A0=C2=A0 depends on TPM
>=20
> ... since TPM_TIS depends on TPM.
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select TPMDEV
>> =C2=A0 =C2=A0 config TPM_CRB
>> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
>> index fcc4c2f27c..3ef2036cca 100644
>> --- a/hw/tpm/Makefile.objs
>> +++ b/hw/tpm/Makefile.objs
>> @@ -1,6 +1,7 @@
>> =C2=A0 common-obj-$(CONFIG_TPM) +=3D tpm_util.o
>> =C2=A0 obj-$(call lor,$(CONFIG_TPM_TIS),$(CONFIG_TPM_CRB)) +=3D tpm_ppi.=
o
>> -common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis_isa.o tpm_tis_common.o
>> +common-obj-$(CONFIG_TPM_TIS_ISA) +=3D tpm_tis_isa.o
>> +common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis_common.o
>> =C2=A0 common-obj-$(CONFIG_TPM_CRB) +=3D tpm_crb.o
>> =C2=A0 common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
>> =C2=A0 common-obj-$(CONFIG_TPM_EMULATOR) +=3D tpm_emulator.o
>> diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
>> index eb0f23b108..33dd3c89cc 100644
>> --- a/tests/qtest/Makefile.include
>> +++ b/tests/qtest/Makefile.include
>> @@ -54,8 +54,8 @@ check-qtest-i386-y +=3D q35-test
>> =C2=A0 check-qtest-i386-y +=3D vmgenid-test
>> =C2=A0 check-qtest-i386-$(CONFIG_TPM_CRB) +=3D tpm-crb-swtpm-test
>> =C2=A0 check-qtest-i386-$(CONFIG_TPM_CRB) +=3D tpm-crb-test
>> -check-qtest-i386-$(CONFIG_TPM_TIS) +=3D tpm-tis-swtpm-test
>> -check-qtest-i386-$(CONFIG_TPM_TIS) +=3D tpm-tis-test
>> +check-qtest-i386-$(CONFIG_TPM_TIS_ISA) +=3D tpm-tis-swtpm-test
>> +check-qtest-i386-$(CONFIG_TPM_TIS_ISA) +=3D tpm-tis-test
>> =C2=A0 check-qtest-i386-$(CONFIG_SLIRP) +=3D test-netfilter
>> =C2=A0 check-qtest-i386-$(CONFIG_POSIX) +=3D test-filter-mirror
>> =C2=A0 check-qtest-i386-$(CONFIG_RTL8139_PCI) +=3D test-filter-redirecto=
r
>>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Thanks!

Eric
>=20


