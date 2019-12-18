Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA4EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC564218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMyVWhQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC564218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUog-0005Sr-Ko
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:36:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ihUmq-0003cc-JX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:34:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ihUmm-0007Ev-Ik
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:34:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48180
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ihUml-0007Bn-Pm
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576658060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63K5BWrmO3xE0dYReX16HtHbl5N3r9OtQ8EA+uk6VOY=;
 b=PMyVWhQHGG69i19JogrLne2wA/lk0gtgNLYWpbYpEmcjbtfRgiQB0E0HuganfwcmvGyXrd
 QC6bQvEMx+szR78zg8hJSacpHuy0gq6/rC9sKU8UMUdK+r/7ljysueOPAVIpEqhA9balDh
 MYPeBFuF4atNefI+DzCstt4w9Tm8Yjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-DzPs8fcSPxiHIgFEtpj8WA-1; Wed, 18 Dec 2019 03:34:16 -0500
X-MC-Unique: DzPs8fcSPxiHIgFEtpj8WA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F40FF801E66;
 Wed, 18 Dec 2019 08:34:14 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA86E1891F;
 Wed, 18 Dec 2019 08:34:11 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH 05/16] arm/arm64: ITS: Introspection tests
To: Zenghui Yu <yuzenghui@huawei.com>, eric.auger.pro@gmail.com,
 maz@kernel.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20191216140235.10751-1-eric.auger@redhat.com>
 <20191216140235.10751-6-eric.auger@redhat.com>
 <c133ebe6-10f4-2ff7-f75f-75b755397785@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6542297b-74d2-f3c2-63d8-04bb284414df@redhat.com>
Date: Wed, 18 Dec 2019 09:34:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c133ebe6-10f4-2ff7-f75f-75b755397785@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: andre.przywara@arm.com, drjones@redhat.com, alexandru.elisei@arm.com,
 thuth@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Zenghui,

On 12/18/19 4:46 AM, Zenghui Yu wrote:
> Hi Eric,
>=20
> I have to admit that this is the first time I've looked into
> the kvm-unit-tests code, so only some minor comments inline :)

no problem. Thank you for looking at this.

By the way, with patch 16 I was able to test yout fix: "KVM: arm/arm64:
vgic: Don't rely on the wrong pending table". Reverting it produced an
error. I forgot to mention that.
>=20
> On 2019/12/16 22:02, Eric Auger wrote:
>> Detect the presence of an ITS as part of the GICv3 init
>> routine, initialize its base address and read few registers
>> the IIDR, the TYPER to store its dimensioning parameters.
>>
>> This is our first ITS test, belonging to a new "its" group.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>=20
> [...]
>=20
>> diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
>> new file mode 100644
>> index 0000000..2ce483e
>> --- /dev/null
>> +++ b/lib/arm/asm/gic-v3-its.h
>> @@ -0,0 +1,116 @@
>> +/*
>> + * All ITS* defines are lifted from include/linux/irqchip/arm-gic-v3.=
h
>> + *
>> + * Copyright (C) 2016, Red Hat Inc, Andrew Jones <drjones@redhat.com>
>> + *
>> + * This work is licensed under the terms of the GNU LGPL, version 2.
>> + */
>> +#ifndef _ASMARM_GIC_V3_ITS_H_
>> +#define _ASMARM_GIC_V3_ITS_H_
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +#define GITS_CTLR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x0000
>> +#define GITS_IIDR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x0004
>> +#define GITS_TYPER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x0008
>> +#define GITS_CBASER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x0080
>> +#define GITS_CWRITER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x0088
>> +#define GITS_CREADR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x0090
>> +#define GITS_BASER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x0100
>> +
>> +#define GITS_TYPER_PLPIS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1UL << 0)
>> +#define GITS_TYPER_IDBITS_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 8
>> +#define GITS_TYPER_DEVBITS_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 13
>> +#define GITS_TYPER_DEVBITS(r)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ((((r) >>
>> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
>> +#define GITS_TYPER_PTA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1UL << 19)
>> +#define GITS_TYPER_HWCOLLCNT_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24
>> +
>> +#define GITS_CTLR_ENABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1U << 0)
>> +
>> +#define GITS_CBASER_VALID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 (1UL << 63)
>> +#define GITS_CBASER_SHAREABILITY_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (10)
>> +#define GITS_CBASER_INNER_CACHEABILITY_SHIFT=C2=A0=C2=A0=C2=A0 (59)
>> +#define GITS_CBASER_OUTER_CACHEABILITY_SHIFT=C2=A0=C2=A0=C2=A0 (53)
>> +#define
>> GITS_CBASER_SHAREABILITY_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 GIC_BASER_SHAREABILITY(GITS_CBASER, SHAREABILITY_M=
ASK)
>> +#define
>> GITS_CBASER_INNER_CACHEABILITY_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, MASK)
>> +#define
>> GITS_CBASER_OUTER_CACHEABILITY_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 GIC_BASER_CACHEABILITY(GITS_CBASER, OUTER, MASK)
>> +#define GITS_CBASER_CACHEABILITY_MASK
>> GITS_CBASER_INNER_CACHEABILITY_MASK
>> +
>> +#define
>> GITS_CBASER_InnerShareable=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 GIC_BASER_SHAREABILITY(GITS_CBASER, InnerShareable=
)
>> +
>> +#define GITS_CBASER_nCnB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GI=
C_BASER_CACHEABILITY(GITS_CBASER,
>> INNER, nCnB)
>> +#define GITS_CBASER_nC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 GIC_BASER_CACHEABILITY(GITS_CBASER,
>> INNER, nC)
>> +#define GITS_CBASER_RaWt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GI=
C_BASER_CACHEABILITY(GITS_CBASER,
>> INNER, RaWt)
>> +#define GITS_CBASER_RaWb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GI=
C_BASER_CACHEABILITY(GITS_CBASER,
>> INNER, RaWt)
>=20
> s/RaWt/RaWb/
OK
>=20
>> +#define GITS_CBASER_WaWt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GI=
C_BASER_CACHEABILITY(GITS_CBASER,
>> INNER, WaWt)
>> +#define GITS_CBASER_WaWb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GI=
C_BASER_CACHEABILITY(GITS_CBASER,
>> INNER, WaWb)
>> +#define GITS_CBASER_RaWaWt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GIC_BASER_CA=
CHEABILITY(GITS_CBASER,
>> INNER, RaWaWt)
>> +#define GITS_CBASER_RaWaWb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GIC_BASER_CA=
CHEABILITY(GITS_CBASER,
>> INNER, RaWaWb)
>> +
>> +#define GITS_BASER_NR_REGS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8
>> +
>> +#define GITS_BASER_VALID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (1UL << 63)
>> +#define GITS_BASER_INDIRECT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (1ULL << 62)
>> +
>> +#define GITS_BASER_INNER_CACHEABILITY_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0 (=
59)
>> +#define GITS_BASER_OUTER_CACHEABILITY_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0 (=
53)
>> +#define GITS_BASER_CACHEABILITY_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x7
>> +
>> +#define GITS_BASER_nCnB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 GIC_BASER_CACHEABILITY(GITS_BASER,
>> INNER, nCnB)
>> +
>> +#define GITS_BASER_TYPE_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (56)
>> +#define GITS_BASER_TYPE(r)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (((r) >>
>> GITS_BASER_TYPE_SHIFT) & 7)
>> +#define GITS_BASER_ENTRY_SIZE_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (48)
>> +#define GITS_BASER_ENTRY_SIZE(r)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ((((r) >>
>> GITS_BASER_ENTRY_SIZE_SHIFT) & 0x1f) + 1)
>> +#define GITS_BASER_SHAREABILITY_SHIFT=C2=A0=C2=A0 (10)
>> +#define
>> GITS_BASER_InnerShareable=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 GIC_BASER_SHAREABILITY(GITS_BASER, InnerShareable)
>> +#define GITS_BASER_PAGE_SIZE_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (8)
>> +#define GITS_BASER_PAGE_SIZE_4K=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (0UL <<
>> GITS_BASER_PAGE_SIZE_SHIFT)
>> +#define GITS_BASER_PAGE_SIZE_16K=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (1UL <<
>> GITS_BASER_PAGE_SIZE_SHIFT)
>> +#define GITS_BASER_PAGE_SIZE_64K=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (2UL <<
>> GITS_BASER_PAGE_SIZE_SHIFT)
>> +#define GITS_BASER_PAGE_SIZE_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 (3UL <<
>> GITS_BASER_PAGE_SIZE_SHIFT)
>> +#define GITS_BASER_PAGES_MAX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 256
>> +#define GITS_BASER_PAGES_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (0)
>> +#define GITS_BASER_NR_PAGES(r)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (((r) & 0xff) + 1)
>> +#define GITS_BASER_PHYS_ADDR_MASK=C2=A0=C2=A0=C2=A0 0xFFFFFFFFF000
>> +
>> +#define GITS_BASER_TYPE_NONE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0
>> +#define GITS_BASER_TYPE_DEVICE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 1
>> +#define GITS_BASER_TYPE_VCPU=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 2
>> +#define GITS_BASER_TYPE_CPU=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3
>=20
> '3' is one of the reserved values of the GITS_BASER.Type field, and
> what do we expect with a "GITS_BASER_TYPE_CPU" table type? ;-)

Yes I agree. This is code extracted from the irqchip header in Dec 2016.
I should have checked again. I only use DEVICE and COLLECTION here.

I will remove all the defines I am not using at the moment. I guess most
of the defines related to memory/cache mgt are not mandated either.
>=20
> I think we can copy (and might update in the future) all these
> macros against the latest Linux kernel.
>=20
>> +#define GITS_BASER_TYPE_COLLECTION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4
>> +
>> +#define ITS_FLAGS_CMDQ_NEEDS_FLUSHING=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 0) > +
>> +struct its_typer {
>> +=C2=A0=C2=A0=C2=A0 unsigned int ite_size;
>> +=C2=A0=C2=A0=C2=A0 unsigned int eventid_bits;
>> +=C2=A0=C2=A0=C2=A0 unsigned int deviceid_bits;
>> +=C2=A0=C2=A0=C2=A0 unsigned int collid_bits;
>> +=C2=A0=C2=A0=C2=A0 unsigned int hw_collections;
>> +=C2=A0=C2=A0=C2=A0 bool pta;
>> +=C2=A0=C2=A0=C2=A0 bool cil;
>> +=C2=A0=C2=A0=C2=A0 bool cct;
>> +=C2=A0=C2=A0=C2=A0 bool phys_lpi;
>> +=C2=A0=C2=A0=C2=A0 bool virt_lpi;
>> +};
>> +
>> +struct its_data {
>> +=C2=A0=C2=A0=C2=A0 void *base;
>> +=C2=A0=C2=A0=C2=A0 struct its_typer typer;
>> +};
>> +
>> +extern struct its_data its_data;
>> +
>> +#define gicv3_its_base()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (i=
ts_data.base)
>> +
>> +extern void its_parse_typer(void);
>> +extern void its_init(void);
>> +
>> +#endif /* !__ASSEMBLY__ */
>> +#endif /* _ASMARM_GIC_V3_ITS_H_ */
>> diff --git a/lib/arm/asm/gic.h b/lib/arm/asm/gic.h
>> index 55dd84b..b44da9c 100644
>> --- a/lib/arm/asm/gic.h
>> +++ b/lib/arm/asm/gic.h
>> @@ -40,6 +40,7 @@
>> =C2=A0 =C2=A0 #include <asm/gic-v2.h>
>> =C2=A0 #include <asm/gic-v3.h>
>> +#include <asm/gic-v3-its.h>
>> =C2=A0 =C2=A0 #define PPI(irq)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ((irq) + 16)
>> =C2=A0 #define SPI(irq)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ((irq) + GIC_FIRST_SPI)
>> diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
>> new file mode 100644
>> index 0000000..34f4d0e
>> --- /dev/null
>> +++ b/lib/arm/gic-v3-its.c
>> @@ -0,0 +1,41 @@
>> +/*
>> + * Copyright (C) 2016, Red Hat Inc, Eric Auger <eric.auger@redhat.com=
>
>> + *
>> + * This work is licensed under the terms of the GNU LGPL, version 2.
>> + */
>> +#include <asm/gic.h>
>> +
>> +struct its_data its_data;
>> +
>> +void its_parse_typer(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 u64 typer =3D readq(gicv3_its_base() + GITS_TYPER)=
;
>> +
>> +=C2=A0=C2=A0=C2=A0 its_data.typer.ite_size =3D ((typer >> 4) & 0xf) +=
 1;
>> +=C2=A0=C2=A0=C2=A0 its_data.typer.pta =3D typer & GITS_TYPER_PTA;
>> +=C2=A0=C2=A0=C2=A0 its_data.typer.eventid_bits =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((typer >> GITS_TYPER_IDBI=
TS_SHIFT) & 0x1f) + 1;
>> +=C2=A0=C2=A0=C2=A0 its_data.typer.deviceid_bits =3D GITS_TYPER_DEVBIT=
S(typer) + 1;
>=20
> No need to '+1'. As GITS_TYPER_DEVBITS already helps us to calculate
> the implemented DeviceID bits.
OK
>=20
>> +
>> +=C2=A0=C2=A0=C2=A0 its_data.typer.cil =3D (typer >> 36) & 0x1;
>> +=C2=A0=C2=A0=C2=A0 if (its_data.typer.cil)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 its_data.typer.collid_bits=
 =3D ((typer >> 32) & 0xf) + 1;
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 its_data.typer.collid_bits=
 =3D 16;
>> +
>> +=C2=A0=C2=A0=C2=A0 its_data.typer.hw_collections =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (typer >> GITS_TYPER_HWCOL=
LCNT_SHIFT) & 0xff;
>> +
>> +=C2=A0=C2=A0=C2=A0 its_data.typer.cct =3D typer & 0x4;
>> +=C2=A0=C2=A0=C2=A0 its_data.typer.virt_lpi =3D typer & 0x2;
>> +=C2=A0=C2=A0=C2=A0 its_data.typer.phys_lpi =3D typer & GITS_TYPER_PLP=
IS;
>=20
> Personally, mix using of GITS_TYPER_* macros and some magic constants t=
o
> parse the TYPER makes it a bit difficult to review the code. Maybe we
> can have more such kinds of macros in the header file and get rid of al=
l
> hardcoded numbers?
Sure I will clean that up.

Thanks!

Eric
>=20
>=20
> Thanks,
> Zenghui
>=20
>=20


