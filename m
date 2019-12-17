Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762E5C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 07:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41738206D3
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 07:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOOxrO73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41738206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih7f9-00076j-AF
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 02:52:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ih7eW-0006fg-EB
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 02:52:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ih7eU-00049i-VK
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 02:52:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40307
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ih7eU-00045k-Ro
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 02:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576569138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HIpEEdQE5UPPmfNYbYoPzcRmU5MfjFLjjQN+UUTam2k=;
 b=QOOxrO73PsoX7F2ySW1v7FWRyuW1QAW/+8v1GLsqshExMqvsXU8Nz2VyAQK5Zr5hnX4EgV
 KjS6YPbzIfP/KucYYRUnU8/Sg5OpO28ziweN1jI/BqfgfjAslwrhgON3aqdmg9MteZf5pq
 BDEgCYG5vir233LY5nxgLeE28N4h3cg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-fgbXfYSrO36Ac8tx4xl3fQ-1; Tue, 17 Dec 2019 02:52:15 -0500
Received: by mail-wm1-f71.google.com with SMTP id l13so578335wmj.8
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 23:52:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m/19A9lgutO/iLu/npeRRGTHWZcg5gMe9X+KQOZE5Gk=;
 b=n6SELiVGtvuRjbNdbyjbAVkLlQNqntuHH2GHrmW+YphLL7ehRvYuF+K7n6lqqmhR2a
 gQ9p4eepLEVSCYGX96qjlIyhOzowQaTSm2QgJtiwNcbW3SYM8mX2EPkH29l9wwU8WeWN
 rhMUh357/TtygRknF56nPIfN3xjnkpaW9+wh9cwhCcwKTvoKBdK/GPYGHPxuDg4dpg3D
 XpWaKKchl7wHE2MpOKdp/LTyqJktXejSUlSgphWHRSmsxYVKNgAS79Xma7pzVYDj6a4i
 omW5tNbS4a47mhN0rCxHrnQV+wY85txD/ALSMx0kivJdKCYZbM5yf7TVRI3Hh/kEtRl9
 6xbw==
X-Gm-Message-State: APjAAAVZXWxijKbf5cEWAHbccmYIVyIt1EKGdA0STAJ/tra+Dk/2ndEb
 XcJtFLi5uU6nyNG59LR3V7pNaNxZCz4SD/xUA9DhD+y5ZfXlO3FeW+VzyLet6/iSedkX7xv5SZL
 GdbUTgsi8RJUItq4=
X-Received: by 2002:a1c:7918:: with SMTP id l24mr3963751wme.125.1576569134628; 
 Mon, 16 Dec 2019 23:52:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxH9bjT+oXmrBIzDV3KCYTPmcDdWkCJ8PC+rRgkV8/INDAH8amcDS6mO5Cxkpr8JDZ4SBaFGA==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr3963727wme.125.1576569134356; 
 Mon, 16 Dec 2019 23:52:14 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id c195sm2144166wmd.45.2019.12.16.23.52.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 23:52:13 -0800 (PST)
Subject: Re: [PULL 3/4] i386: Add new CPU model Cooperlake
To: Xiaoyao Li <xiaoyao.li@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, 
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20191216193825.1794153-1-ehabkost@redhat.com>
 <20191216193825.1794153-4-ehabkost@redhat.com>
 <2fe2f699-699a-6ee5-1323-b092757822e5@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a54bf239-4491-1679-daeb-568b1bb4c5d2@redhat.com>
Date: Tue, 17 Dec 2019 08:52:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2fe2f699-699a-6ee5-1323-b092757822e5@intel.com>
Content-Language: en-US
X-MC-Unique: fgbXfYSrO36Ac8tx4xl3fQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tao Xu <tao3.xu@intel.com>,
 Richard Henderson <rth@twiddle.net>, Cathy Zhang <cathy.zhang@intel.com>,
 Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 3:26 AM, Xiaoyao Li wrote:
> On 12/17/2019 3:38 AM, Eduardo Habkost wrote:
>> From: Cathy Zhang <cathy.zhang@intel.com>
>>
>> Cooper Lake is intel's successor to Cascade Lake, the new
>> CPU model inherits features from Cascadelake-Server, while
>> add one platform associated new feature: AVX512_BF16. Meanwhile,
>> add STIBP for speculative execution.
>>
>> Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Reviewed-by: Tao Xu <tao3.xu@intel.com>
>> Message-Id: <1571729728-23284-4-git-send-email-cathy.zhang@intel.com>
>> Reviewed-by: Bruce Rogers <brogers@suse.com>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>> =C2=A0 target/i386/cpu.c | 60 ++++++++++++++++++++++++++++++++++++++++++=
+++++
>> =C2=A0 1 file changed, 60 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 69f518a21a..de828e29d8 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -3159,6 +3159,66 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 { /* end of list */ }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "Cooperlake",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .level =3D 0xd,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .vendor =3D CPUID_VENDOR_INT=
EL,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .family =3D 6,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .model =3D 85,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .stepping =3D 10,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .features[FEAT_1_EDX] =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR |=20
>> CPUID_MMX |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV |=20
>> CPUID_MCA |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC |=20
>> CPUID_CX8 |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_DE | CPUID_FP87,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .features[FEAT_1_ECX] =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA |=20
>> CPUID_EXT_MOVBE |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .features[FEAT_8000_0001_EDX=
] =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_EXT2_NX | CPUID_EXT2_SYSCALL,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .features[FEAT_8000_0001_ECX=
] =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_EXT3_ABM | CPUID_EXT3_LAHF_LM |=20
>> CPUID_EXT3_3DNOWPREFETCH,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .features[FEAT_7_0_EBX] =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 |=20
>> CPUID_7_0_EBX_SMEP |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS |=20
>> CPUID_7_0_EBX_INVPCID |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED |=20
>> CPUID_7_0_EBX_ADX |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .features[FEAT_7_0_ECX] =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_7_0_ECX_PKU |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_7_0_ECX_AVX512VNNI,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .features[FEAT_7_0_EDX] =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_STIBP |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_7_0_EDX_SPEC_CTRL_SSBD |=20
>> CPUID_7_0_EDX_ARCH_CAPABILITIES,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .features[FEAT_ARCH_CAPABILI=
TIES] =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MSR_=
ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MSR_=
ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .features[FEAT_7_1_EAX] =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_7_1_EAX_AVX512_BF16,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Missing: XSAVES (not=
 supported by some Linux versions,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * including v4.1 to v4=
.12).
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * KVM doesn't yet expo=
se any XSAVES state save component,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and the only one def=
ined in Skylake (processor tracing)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * probably will block =
migration anyway.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .features[FEAT_XSAVE] =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_XSAVE_XGETBV1,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .features[FEAT_6_EAX] =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUI=
D_6_EAX_ARAT,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .xlevel =3D 0x80000008,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .model_id =3D "Intel Xeon Pr=
ocessor (Cooperlake)",
>> +=C2=A0=C2=A0=C2=A0 },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "Icelak=
e-Client",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .level =3D 0xd,
>>
>=20
> Hi Eduardo,
>=20
> Since this CPU model has been hold for a while, it misses the VMX=20
> features added by Paolo recently.
>=20
> Besides, there are two bits PSCHANGE_MC_NO(bit 6) and TAA_NO(bit 8) of=20
> MSR_IA32_ARCH_CAPABILITIES disclosed recently, that are also missed in=20
> this CPU model.
>=20
> Should we hold off this and update a new patch with the above features=20
> added?
> Or we make this merged and send a new patch to add a new version for the=
=20
> above?

It would be simpler if you can prepare a patch to correct this one.
Add the "Fixes: 22a866b6166" tag in it.

Thanks!

Phil.


