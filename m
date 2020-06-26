Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FA7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C3320663
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPl8OK6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C3320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joooU-0003GK-UC
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1joonZ-0001ya-AU
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:53:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32190
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1joonX-0007HL-CA
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593179622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rwUZaNvroZripnZh67EbJIWuW7cvT996Qglx/6JLTMk=;
 b=BPl8OK6C1b+ZLai2na5MQT6cFisoksdYD+scu4jfU2AfOGCfdYjP75tLvtkiPIXSpWG4is
 ItMUVSyExvowAug5QwBGY6rUTVi7bB0U0vMua/yY3G2ChC2icJqxbT4HGVKOXyzJB7Ltqk
 mGQE/Im2VyJmPRwb+69UDR/aYfN99O8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-blJYXWKgNzOx4D7C1GLkyg-1; Fri, 26 Jun 2020 09:53:39 -0400
X-MC-Unique: blJYXWKgNzOx4D7C1GLkyg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0ADB108C303;
 Fri, 26 Jun 2020 13:53:36 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAA2160BF4;
 Fri, 26 Jun 2020 13:53:27 +0000 (UTC)
Subject: Re: [PATCH RESEND 6/9] hw/arm/smmu-common: Manage IOTLB block entries
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200611161500.23580-1-eric.auger@redhat.com>
 <20200611161500.23580-7-eric.auger@redhat.com>
 <CAFEAcA9FZV=jSk_9aJ_tHy=KLy+YrTFNoiqvCv7BMs0dWrHWFA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <db6d92ba-2716-40df-54d3-84fb51ab3ad3@redhat.com>
Date: Fri, 26 Jun 2020 15:53:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9FZV=jSk_9aJ_tHy=KLy+YrTFNoiqvCv7BMs0dWrHWFA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 zhangfei.gao@foxmail.com, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 6/25/20 5:30 PM, Peter Maydell wrote:
> On Thu, 11 Jun 2020 at 17:16, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> At the moment each entry in the IOTLB corresponds to a page sized
>> mapping (4K, 16K or 64K), even if the page belongs to a mapped
>> block. In case of block mapping this unefficiently consume IOTLB
>> entries.
>>
>> Change the value of the entry so that it reflects the actual
>> mapping it belongs to (block or page start address and size).
>>
>> Also the level/tg of the entry is encoded in the key. In subsequent
>> patches we will enable range invalidation. This latter is able
>> to provide the level/tg of the entry.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> 
>> -uint64_t smmu_get_iotlb_key(uint16_t asid, uint64_t iova)
>> +uint64_t smmu_get_iotlb_key(uint16_t asid, uint64_t iova,
>> +                            uint8_t tg, uint8_t level)
>>  {
>> -    return iova >> 12 | (uint64_t)(asid) << SMMU_IOTLB_ASID_SHIFT;
>> +    return iova >> 12 | (uint64_t)(asid) << SMMU_IOTLB_ASID_SHIFT |
>> +           (uint64_t)(level) << SMMU_IOTLB_LEVEL_SHIFT |
>> +           (uint64_t)(tg) << SMMU_IOTLB_TG_SHIFT;
>>  }
> 
>>  SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
>> -                                 hwaddr iova)
>> +                                SMMUTransTableInfo *tt, hwaddr iova)
>>  {
>> -    uint64_t key = smmu_get_iotlb_key(cfg->asid, iova);
>> -    SMMUTLBEntry *entry = g_hash_table_lookup(bs->iotlb, &key);
>> +    uint8_t tg = (tt->granule_sz - 10) / 2;
>> +    int level = tt->starting_level;
>> +    SMMUTLBEntry *entry = NULL;
>> +
>> +    while (level <= 3) {
>> +        uint64_t subpage_size = 1ULL << level_shift(level, tt->granule_sz);
>> +        uint64_t mask = subpage_size - 1;
>> +        uint64_t key;
>> +
>> +        key = smmu_get_iotlb_key(cfg->asid, iova & ~mask, tg, level);
>> +        entry = g_hash_table_lookup(bs->iotlb, &key);
>> +        if (entry) {
>> +            break;
>> +        }
>> +        level++;
> 
> Rather than looping around doing multiple hash table lookups like
> this, why not just avoid including the tg and level in the
> key equality test?
> 
> If I understand the range-based-invalidation feature correctly,
> the only time we care about the TG/LVL is if we're processing
> an invalidate-range command that specifies them. But in that
> case there should never be multiple entries in the bs->iotlb
> with the same iova, so we can just check whether the entry
> matches the requested TG/LVL once we've pulled it out of the
> hash table. (Or we could architecturally validly just blow
> it away regardless of requested TG/LVL -- they are only hints,
> not required-to-match.)

This change could have been done independently on the RIL feature. As we
now put block entries in the IOTLB , when we look for an iova
translation, the IOVA can be mapped using different block sizes or using
page entries. So we start looking at blocks of the bigger size (entry
level) downto the page, for instance 4TB/512MB/64KB. We cannot know
which block and size the address belongs to. I do not know if we can
make any hypothesis on whether the driver is forbidden to invalidate an
address that is not the starting address of an initial mapping.

Not a justification but an info, this is implemented the same way on x86
(except they don't have variable TG), see vtd_lookup_iotlb in
hw/i386/intel_iommu.c

Thanks

Eric
> 
> thanks
> -- PMM
> 


