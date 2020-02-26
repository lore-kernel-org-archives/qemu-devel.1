Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02691C4BA18
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71A424650
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Drq9pusZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71A424650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j71D1-000605-1B
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 13:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j71BQ-0003xC-71
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:13:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j71BN-0001Ab-Tn
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:13:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52010
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j71BN-0001AA-QM
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582740797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dF4AphZnyYCsK5rvScAvOr8vc+ZLjYYMku9g6SdRFM=;
 b=Drq9pusZSxx1OxUXVuX+LKIvOAV8btBOQyEtFW5QyYnyhYLFc3cLSMzUoJZRN6Eiz6rWgK
 c070G3iB2Pfyah+e85WvV7gvQRUy+PCMF54sZPHMVrCWlSSwT0MmatnlIUYEy7t3jQbF3l
 AUqchoAbrURckgHSzzR40ulXu6KUN6g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-eBo5v_P6P8yjeci6IE5m5g-1; Wed, 26 Feb 2020 13:13:15 -0500
X-MC-Unique: eBo5v_P6P8yjeci6IE5m5g-1
Received: by mail-wr1-f71.google.com with SMTP id n12so100362wrp.19
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 10:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CFkXNEV3DEBhDV7T1m4SavDBYV06a90sP6zI76AthVQ=;
 b=SxBtOMeXdK5qw+EzfV0+gekQ+0EueEihMKV8JFLY3x+Ra75wTvX5Ne4o1Go17l/dQK
 IySq6CfotSJ2I0LKYUPwVCiCuQWueIFUxsU4G0gXSKSyQhB37ZLOPHHKOTAJ2ViQS5Un
 NO5rfUC4BdMAefNLdNy0TRQot5f4kmXZ/cwcAd6Di5mzQirOl72XURoUFSjj0j3tNFQS
 D3bKyqPhONRfv/PVuABDDdRjZglmZTaPaSvA2Nct05EpUEucwKv65vE0a6c5R/aB9MT4
 jSnt4/5oCmX/FfGL4/1yheFna2iWN4A+RW6+byHMyzEEh+ktnrheJVBeo5AOXbgQ9Tgz
 E6+w==
X-Gm-Message-State: APjAAAVIW8WPdV64UKD3yhhqhNNNMJlueDVTR+eNjcGIpmSMUpbn4nTO
 6MQo80Ll7ctpmwsO1Mva1fubiL6w2FvV0AZRaoOC8EqhsPlYYb5IWcokYsKuPAgvRuk9NAEbB81
 ZQ7Y3IpJtMnRVjts=
X-Received: by 2002:a05:600c:2c06:: with SMTP id
 q6mr133220wmg.154.1582740793252; 
 Wed, 26 Feb 2020 10:13:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwsEsKoPjDZMRdNh3cf0y9Kph6onilB0Gqit/d3oSwKrm0buyx/mTAQVYnFBrHvDmMa/2zmQA==
X-Received: by 2002:a05:600c:2c06:: with SMTP id
 q6mr133204wmg.154.1582740793002; 
 Wed, 26 Feb 2020 10:13:13 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id j11sm3912193wmi.3.2020.02.26.10.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 10:13:12 -0800 (PST)
Subject: Re: [PATCH] hw/i386/intel_iommu: Simplify vtd_find_as_from_bus_num()
 logic
To: Peter Xu <peterx@redhat.com>
References: <20200226174956.17018-1-philmd@redhat.com>
 <20200226180150.GF140200@xz-x1>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1a04e3bb-f0f0-c263-9db4-a1b01cbbcb44@redhat.com>
Date: Wed, 26 Feb 2020 19:13:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226180150.GF140200@xz-x1>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Liu Yi L <yi.l.liu@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/26/20 7:01 PM, Peter Xu wrote:
> On Wed, Feb 26, 2020 at 06:49:56PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Reorder the if() statement to simplify the function.
>> This avoid bugs like the one fixed by commit a2e1cd41ccf.
>=20
> This seems to hint that this patch fixes a problem, but it's pure
> refactoring, right?

Pure refactoring yes, I meant: If the code was written this way, we=20
wouldn't had the bug fixed by a2e1cd41ccf.

>=20
> And I'm not sure about git-diff -w or so, but... I can't apply such a
> patch cleanly using "git am".  Are you sure a patch like this would
> work (without space change information)?

Ah sorry I didn't think of that (I really thought git-am would apply it).

>=20
> Thanks,
>=20
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   hw/i386/intel_iommu.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 6258c58ac9..e720a8939c 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -987,14 +987,17 @@ static bool vtd_slpte_nonzero_rsvd(uint64_t slpte,=
 uint32_t level)
>>   static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState *s, uint8_t bu=
s_num)
>>   {
>>       VTDBus *vtd_bus =3D s->vtd_as_by_bus_num[bus_num];
>> -    if (!vtd_bus) {
>> +    GHashTableIter iter;
>> +
>> +    if (vtd_bus) {
>> +        return vtd_bus;
>> +    }
>> +
>>       /*
>>        * Iterate over the registered buses to find the one which
>>        * currently hold this bus number, and update the bus_num
>>        * lookup table:
>>        */
>> -        GHashTableIter iter;
>> -
>>       g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
>>       while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
>>           if (pci_bus_num(vtd_bus->bus) =3D=3D bus_num) {
>> @@ -1002,9 +1005,8 @@ static VTDBus *vtd_find_as_from_bus_num(IntelIOMMU=
State *s, uint8_t bus_num)
>>               return vtd_bus;
>>           }
>>       }
>> -        vtd_bus =3D NULL;
>> -    }
>> -    return vtd_bus;
>> +
>> +    return NULL;
>>   }
>>  =20
>>   /* Given the @iova, get relevant @slptep. @slpte_level will be the las=
t level
>> --=20
>> 2.21.1
>>
>=20


