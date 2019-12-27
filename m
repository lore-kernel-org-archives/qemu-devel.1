Return-Path: <SRS0=GTQb=2R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC62AC2D0C3
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2019 21:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D3C20740
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2019 21:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZnpM5DP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D3C20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikxKD-00014Y-Md
	for qemu-devel@archiver.kernel.org; Fri, 27 Dec 2019 16:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ikxJS-0000eo-3m
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 16:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ikxJP-0003Jc-Nh
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 16:38:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53226
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ikxJP-0003Ij-Bt
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 16:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577482702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ef45R73wUVs3ScaTkWdJPjsNKLmjXqdCbVvytw2iCmI=;
 b=eZnpM5DPCMG12O/WXuOnFQm2wuqf9i+KoW9Oao2CHNNFwQRQXeriLYO19NWwioTJqXzjyD
 y1mti9B2ygGC0lTfsurLh93LszI5kVV2l7WlKYFpf/IPzogqmf5SV/MnOs1sMK1AyBo+CC
 cVQSi2/wEb56aOJbKGIoMFkZRhd9GSQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-ltyPc85JPa6-NaBuZr7bBA-1; Fri, 27 Dec 2019 16:38:20 -0500
Received: by mail-wr1-f69.google.com with SMTP id w6so13248721wrm.16
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2019 13:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Uxu10WMtHaUTZXEfrB0X6rTZqwON32z3DSZmJj+gDB4=;
 b=OAwHVHZa/v5KM4EF01GbyP4f2eITxkv1DsKAje0O2Ly+o6WoEsJGXrc32vVroG/+Y8
 xaJJXrUbaZZw7HMgCu/+31SP8ANC7bPcwE08QuGUZUYLLAwebTfcvihX210qTk0pGYP0
 R/kpjNZXI2P5QtIc3I/O13HgMJolyAppa0gdEQOlJ24Ec3hi9RA5aCd4uSn+pP2kw28b
 zpvuSzgoOotr4Qm233OYUjzFzTRs7b9wKx4814O3jxwV02mwLftiAL5yKXEvA23dLUxC
 nkcWDb/RLwP75tmXD76XLGF848/I67KD2LtoM3A7uDKaebnBMgaD4SXuHmHCglOvMmea
 byPg==
X-Gm-Message-State: APjAAAXKFg8DkTO+VjXR7oMNUT2TFbJsO7j5g6n387DOdHYsWK4ebje1
 lkYPApZdXmZr9xjkR5WwRmt09mFY8DDiJuR4cxVUiZcZrN3sP9X3S+RoeDWcuoqvnvrqKQ1zV21
 nF6Oqwp3F8/V1UMk=
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr50146469wru.99.1577482699271; 
 Fri, 27 Dec 2019 13:38:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqxq6+vKtSJ1d86Kd2Vnev9p5ZiHSnwhINIoi+WJxJgy0iBjD8ma5Z8dh2cJl+hm1KkUchX11Q==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr50146450wru.99.1577482699076; 
 Fri, 27 Dec 2019 13:38:19 -0800 (PST)
Received: from [192.168.1.25] (abayonne-654-1-186-92.w92-134.abo.wanadoo.fr.
 [92.134.161.92])
 by smtp.gmail.com with ESMTPSA id a133sm12379731wme.29.2019.12.27.13.38.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Dec 2019 13:38:18 -0800 (PST)
Subject: Re: [PATCH] hw/i386/x86-iommu: Add missing stubs
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20191220154225.25879-1-philmd@redhat.com>
 <df27c488-0cf2-1a4d-0de8-9509f442f5fb@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <51447661-dcd5-0cc6-5ec3-b9095dda0144@redhat.com>
Date: Fri, 27 Dec 2019 22:38:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <df27c488-0cf2-1a4d-0de8-9509f442f5fb@redhat.com>
Content-Language: en-US
X-MC-Unique: ltyPc85JPa6-NaBuZr7bBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/22/19 11:31 AM, Paolo Bonzini wrote:
> On 20/12/19 16:42, Philippe Mathieu-Daud=C3=A9 wrote:
>> In commit 6c730e4af9 we introduced a stub to build the MicroVM
>> machine without Intel IOMMU. This stub is incomplete for the
>> other PC machines. Add the missing stubs.
>=20
> In other words, without this patch you cannot build without Q35 (which
> brings in the IOMMU, at least unless building
> --without-default-devices).  Is this correct?

No, this is the same, selecting either CONFIG_I440FX or CONFIG_Q35:

   LINK    x86_64-softmmu/qemu-system-x86_64
/usr/bin/ld: hw/i386/pc.o: in function `pc_machine_done':
hw/i386/pc.c:869: undefined reference to `x86_iommu_ir_supported'
/usr/bin/ld: hw/i386/acpi-build.o: in function `acpi_build':
hw/i386/acpi-build.c:2844: undefined reference to `x86_iommu_get_type'
/usr/bin/ld: hw/i386/acpi-build.o: in function `build_dmar_q35':
hw/i386/acpi-build.c:2478: undefined reference to `x86_iommu_ir_supported'
/usr/bin/ld: hw/i386/acpi-build.o: in function `build_amd_iommu':
hw/i386/acpi-build.c:2665: undefined reference to `x86_iommu_ir_supported'
/usr/bin/ld: hw/i386/acpi-build.c:2700: undefined reference to=20
`x86_iommu_ir_supported'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:206: qemu-system-x86_64] Error 1
make: *** [Makefile:483: x86_64-softmmu/all] Error 2

> Paolo
>=20
>>
>> Fixes: 6c730e4af9
>> Reported-by: Travis-CI
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   hw/i386/x86-iommu-stub.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/hw/i386/x86-iommu-stub.c b/hw/i386/x86-iommu-stub.c
>> index 03576cdccb..c5ba077f9d 100644
>> --- a/hw/i386/x86-iommu-stub.c
>> +++ b/hw/i386/x86-iommu-stub.c
>> @@ -32,3 +32,12 @@ X86IOMMUState *x86_iommu_get_default(void)
>>       return NULL;
>>   }
>>  =20
>> +bool x86_iommu_ir_supported(X86IOMMUState *s)
>> +{
>> +    return false;
>> +}
>> +
>> +IommuType x86_iommu_get_type(void)
>> +{
>> +    abort();
>> +}
>>
>=20


