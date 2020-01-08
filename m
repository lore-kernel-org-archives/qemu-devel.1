Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CE5C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E3920678
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NT+DlOeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E3920678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCsF-0005MR-LL
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 10:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ipCoM-0001p9-TP
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ipCoL-0007Yc-NJ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:59:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27802
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ipCoL-0007YF-Jf
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578495593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fFYIF8ZdTAD8k9euNtihp5ry8OyQtjs/RvA8CMTdmh8=;
 b=NT+DlOeQ4tzCY7n5mhFA7YszsnaXmOQP0eyVNm0d0Tq6FDk37ZfieNZwgpEmpCnxUBauM7
 x1zmGTp4fjCbyMKA+4E2bw158q/e1NP4CfPv49tzymhbEmuIL9LK7eo9+MRAg+utbnwX8a
 ZRD6w3gltFIX3m9eFyqwAufp+773mRo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-oTIGoC9JPx29WC0rzbT-hg-1; Wed, 08 Jan 2020 09:59:49 -0500
Received: by mail-wr1-f70.google.com with SMTP id u12so1533521wrt.15
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 06:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MLzIGaZzdEEgusdjGwD6Pmgs5JYLqMw3A2MztWx9gaQ=;
 b=dLHGSFFSIaygdc3lDJgkG0xvMkphdM+F7RZTZakIxOAJIU11azFQrUcQMEWC4JsKeF
 mlx1fRoExCiO9wZoJF55rL4Fjhi2PUihqDFJV1k1wMbk7y/qTK9ysnJiA2hwBRVVnHRW
 Hfg14ZeqZG48glTVmDlBi7lEtjWmHyOUWaD+QIjJkKNRhI/FATU5Fw9D6WT2lbeQ/kRR
 ooeD/65/GoRmvEbWBxwpPLXRbedSR3aoUP0P5UqSutM9BvXmEOcAirPkz2R16QJ5uojd
 a5B0kHeS4gHrM0RRavvCeHh4own8E9YUpW+oUj453V1z+fFiFRktPg37isKNhpVuaVCj
 vC0A==
X-Gm-Message-State: APjAAAWSudWT0M2g3W26vslW/BAvkss0SwyTvjmv2kuVIX+89Bzq1h+D
 hO1yqGn+Ycus0OEao+nBC827NpFb2T0jY+admkLRR6tdy/VNQTix0IWc/dA0IOwSZKeR7hiCaB9
 pXPys9B8gFJ5+AGU=
X-Received: by 2002:a1c:a78c:: with SMTP id q134mr4064021wme.98.1578495588503; 
 Wed, 08 Jan 2020 06:59:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqzylaoxCvjvFJH/G3Q2zllps869qAsZq7b3Fyq1Voff7946Q6iKd0qFU0fXHqA2avPxL5OuBw==
X-Received: by 2002:a1c:a78c:: with SMTP id q134mr4063997wme.98.1578495588241; 
 Wed, 08 Jan 2020 06:59:48 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id d10sm4692485wrw.64.2020.01.08.06.59.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 06:59:47 -0800 (PST)
Subject: Re: [PATCH] vl: fix memory leak in configure_accelerators
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 kuhn.chenqun@huawei.com, qemu-devel@nongnu.org
References: <20200108114207.58084-1-kuhn.chenqun@huawei.com>
 <2bf0ae4f-b024-c421-b9d2-eefe99453e04@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d5626e7e-31fc-9065-7654-028c1af1d979@redhat.com>
Date: Wed, 8 Jan 2020 15:59:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2bf0ae4f-b024-c421-b9d2-eefe99453e04@redhat.com>
Content-Language: en-US
X-MC-Unique: oTIGoC9JPx29WC0rzbT-hg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: liyiting@huawei.com, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 pannengyuan@huawei.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/01/20 15:56, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/8/20 12:42 PM, kuhn.chenqun@huawei.com wrote:
>> From: Chen Qun <kuhn.chenqun@huawei.com>
>>
>> The accel_list forgot to free, the asan output:
>>
>> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>> =C2=A0=C2=A0=C2=A0=C2=A0 #0 0xffff919331cb in __interceptor_malloc
>> (/lib64/libasan.so.4+0xd31cb)
>> =C2=A0=C2=A0=C2=A0=C2=A0 #1 0xffff913f7163 in g_malloc (/lib64/libglib-2=
.0.so.0+0x57163)
>> =C2=A0=C2=A0=C2=A0=C2=A0 #2 0xffff91413d9b in g_strsplit (/lib64/libglib=
-2.0.so.0+0x73d9b)
>> =C2=A0=C2=A0=C2=A0=C2=A0 #3 0xaaab42fb58e7 in configure_accelerators /qe=
mu/vl.c:2777
>> =C2=A0=C2=A0=C2=A0=C2=A0 #4 0xaaab42fb58e7 in main /qemu/vl.c:4121
>> =C2=A0=C2=A0=C2=A0=C2=A0 #5 0xffff8f9b0b9f in __libc_start_main (/lib64/=
libc.so.6+0x20b9f)
>> =C2=A0=C2=A0=C2=A0=C2=A0 #6 0xaaab42fc1dab=C2=A0
>> (/qemu/build/aarch64-softmmu/qemu-system-aarch64+0x8b1dab)
>>
>> Indirect leak of 4 byte(s) in 1 object(s) allocated from:
>> =C2=A0=C2=A0=C2=A0=C2=A0 #0 0xffff919331cb in __interceptor_malloc
>> (/lib64/libasan.so.4+0xd31cb)
>> =C2=A0=C2=A0=C2=A0=C2=A0 #1 0xffff913f7163 in g_malloc (/lib64/libglib-2=
.0.so.0+0x57163)
>> =C2=A0=C2=A0=C2=A0=C2=A0 #2 0xffff9141243b in g_strdup (/lib64/libglib-2=
.0.so.0+0x7243b)
>> =C2=A0=C2=A0=C2=A0=C2=A0 #3 0xffff91413e6f in g_strsplit (/lib64/libglib=
-2.0.so.0+0x73e6f)
>> =C2=A0=C2=A0=C2=A0=C2=A0 #4 0xaaab42fb58e7 in configure_accelerators /qe=
mu/vl.c:2777
>> =C2=A0=C2=A0=C2=A0=C2=A0 #5 0xaaab42fb58e7 in main /qemu/vl.c:4121
>> =C2=A0=C2=A0=C2=A0=C2=A0 #6 0xffff8f9b0b9f in __libc_start_main (/lib64/=
libc.so.6+0x20b9f)
>> =C2=A0=C2=A0=C2=A0=C2=A0 #7 0xaaab42fc1dab=C2=A0
>> (/qemu/build/aarch64-softmmu/qemu-system-aarch64+0x8b1dab)
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
>> ---
>> =C2=A0 vl.c | 1 +
>> =C2=A0 1 file changed, 1 insertion(+)
>>
>> diff --git a/vl.c b/vl.c
>> index 86474a55c9..035a24e52b 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -2788,6 +2788,7 @@ static void configure_accelerators(const char
>> *progname)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("invalid accelerator %s", *tmp)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_strfreev(accel_list);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (accel !=3D NU=
LL) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_report("The -accel and \"-machine accel=3D\" options
>> are incompatible");
>>
>=20

Cc; qemu-trivial@nongnu.org


