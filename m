Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97572C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6316520774
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rfewv+Vx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6316520774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGkrx-0001XW-Jy
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGkqI-0008RQ-UJ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGkqH-0006hC-RJ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:47:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36821)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGkqH-0006gu-OP
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585061265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qsIoL5Z7PY4kuzINEbb/UeqJn6DCaDPZ0HHRFWRsDUA=;
 b=Rfewv+Vxl8m/lySx6pvBEHg6guSmPP7GJCVlF9BAfKDvrM4Hd/TdQ/qo8lSrkJYbrvjFAD
 NwD6TItjovaSp+8G/NQx7lOD/QYIAjN2rgIvvWXDe9zdzXinvj4yvGaRgQCGa6v7G/EFQJ
 fe2AL6rO7AGc0k4tLtrjMEBtbr+KdoQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-4ocLme_bMeWBhegO8uJGGQ-1; Tue, 24 Mar 2020 10:47:43 -0400
X-MC-Unique: 4ocLme_bMeWBhegO8uJGGQ-1
Received: by mail-ed1-f71.google.com with SMTP id b12so12036430edy.7
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 07:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k70VFiKfJdi6EgI9uJjnXPafsgQGBusNt9dgFGjtg1k=;
 b=VLUOyoX08S1F2RSfiFLOWrUN+oW7eiFgs/j6Uhm9cpvt2BPyG/2DH+wvML+QuTqZST
 i5QWQzsRelC+w3Gyt+0gj16HEStZFTKvTy1PIByJMATslYuBHrRdYeem1dYlnATizSCR
 9D8KsoaSXgoufn86+n5qv9VU6omWtJPyYQWxCE6BQXgrRWJbrdKtnkibw8k2oq3i+1J0
 pgtWiVfRUUN02azSIijSxhNxnfssOqWYQmMr5qNVJhwi5kvCvpevuphNi3+cW1XjanMR
 /7fg1Yz0qH/MF7fTspVOHtzLxa1YUT5c/VAOHrQM5/OQxnEvjJUTzq6aUAXXUQGhha5z
 0k1Q==
X-Gm-Message-State: ANhLgQ26G08rwfU96+CTQ32UwcmibHXwiL5A0dDMf2JgNOOo1n39dPsE
 i/XJV/N6UBEHdXDuvqe4cM/dvBlpNqgS8bHYq8c7cA02neKikx3gHKLruyjq2YCwcxLdpP1TGOD
 1Y8ptFfCY4/QRvFw=
X-Received: by 2002:a17:906:e259:: with SMTP id
 gq25mr23737028ejb.262.1585061262619; 
 Tue, 24 Mar 2020 07:47:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvu0wuqtV2op571eXBajAf8Bi8MGnh8prBpXVaVEkIcpj8GJ/pfrOu/lLL/yPzljoNI1Wfvaw==
X-Received: by 2002:a17:906:e259:: with SMTP id
 gq25mr23737012ejb.262.1585061262279; 
 Tue, 24 Mar 2020 07:47:42 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id t13sm1308714edj.8.2020.03.24.07.47.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 07:47:41 -0700 (PDT)
Subject: Re: [PATCH qemu] vfio/spapr: Fix page size calculation
To: Greg Kurz <groug@kaod.org>
References: <20200324063912.25063-1-aik@ozlabs.ru>
 <87ddd733-8498-57a5-2fe2-8f1a3e60e0c9@redhat.com>
 <20200324153017.01c45ec0@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <357712a6-2e9e-b3e1-549c-de73bad4ec6e@redhat.com>
Date: Tue, 24 Mar 2020 15:47:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324153017.01c45ec0@bahia.lan>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/24/20 3:30 PM, Greg Kurz wrote:
> On Tue, 24 Mar 2020 14:27:35 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>>
>>
>> On 3/24/20 7:39 AM, Alexey Kardashevskiy wrote:
>>> Coverity detected an issue (CID 1421903) with potential call of clz64(0=
)
>>> which returns 64 which make it do "<<" with a negative number.
>>>
>>> This checks the mask and avoids undefined behaviour.
>>>
>>> In practice pgsizes and memory_region_iommu_get_min_page_size() always
>>> have some common page sizes and even if they did not, the resulting pag=
e
>>> size would be 0x8000.0000.0000.0000 (gcc 9.2) and
>>> ioctl(VFIO_IOMMU_SPAPR_TCE_CREATE) would fail anyway.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>>    hw/vfio/spapr.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
>>> index 33692fc86fd6..2900bd19417a 100644
>>> --- a/hw/vfio/spapr.c
>>> +++ b/hw/vfio/spapr.c
>>> @@ -147,7 +147,7 @@ int vfio_spapr_create_window(VFIOContainer *contain=
er,
>>>    {
>>>        int ret =3D 0;
>>>        IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(section->mr)=
;
>>> -    uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu_=
mr);
>>> +    uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu_=
mr), pgmask;
>>>        unsigned entries, bits_total, bits_per_level, max_levels;
>>>        struct vfio_iommu_spapr_tce_create create =3D { .argsz =3D sizeo=
f(create) };
>>>        long rampagesize =3D qemu_minrampagesize();
>>> @@ -159,8 +159,8 @@ int vfio_spapr_create_window(VFIOContainer *contain=
er,
>>>        if (pagesize > rampagesize) {
>>>            pagesize =3D rampagesize;
>>>        }
>>> -    pagesize =3D 1ULL << (63 - clz64(container->pgsizes &
>>> -                                   (pagesize | (pagesize - 1))));
>>> +    pgmask =3D container->pgsizes & (pagesize | (pagesize - 1));
>>
>> Is that ROUND_UP(container->pgsizes, pagesize)?
>>
>=20
> This means we clip all page sizes greater than pagesize from
> container->pgsizes... It doesn't look like ROUND_UP() semantics
> to me.

Ah. Extracting it as a new function with meaningful name would help code=20
review :)

>=20
>>> +    pagesize =3D pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
>>>        if (!pagesize) {
>>>            error_report("Host doesn't support page size 0x%"PRIx64
>>>                         ", the supported mask is 0x%lx",
>>>
>>
>>
>=20


