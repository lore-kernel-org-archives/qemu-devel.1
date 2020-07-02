Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048C2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:40:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3FEC20672
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIMrMcbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FEC20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr0Nu-0004yB-11
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 10:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jr0NE-0004RJ-7F
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:39:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58154
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jr0NC-0001P9-Hu
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593700773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1WuIeeap1mHpTmFAcJT42dujJMnsFtoRuTdFCnKTtd4=;
 b=cIMrMcbbbb9nsIv50CEPmIJXg+9fY0VsprPukajypEPIPaXFFfUyNFTWb2Yb9XGLqPJRUh
 UY5nUs/F9JRp+zdVEKPLYNiTFsULwsKRTFUiQj6sVB78SL9XLcMR20KBOrpEt5AGCovtxN
 dRahfLW60+Kgk5VD5LJ75PCSaV7W4rA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-s4Wz7ig2PqSS_zDdOCaWIA-1; Thu, 02 Jul 2020 10:39:29 -0400
X-MC-Unique: s4Wz7ig2PqSS_zDdOCaWIA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7B6E1052508;
 Thu,  2 Jul 2020 14:39:27 +0000 (UTC)
Received: from [10.36.112.70] (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E60907167A;
 Thu,  2 Jul 2020 14:39:18 +0000 (UTC)
Subject: Re: [PATCH RESEND 6/9] hw/arm/smmu-common: Manage IOTLB block entries
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200611161500.23580-1-eric.auger@redhat.com>
 <20200611161500.23580-7-eric.auger@redhat.com>
 <CAFEAcA9FZV=jSk_9aJ_tHy=KLy+YrTFNoiqvCv7BMs0dWrHWFA@mail.gmail.com>
 <db6d92ba-2716-40df-54d3-84fb51ab3ad3@redhat.com>
 <CAFEAcA8ez0ycijFSZrVA3haaoKGho2Q2gQR=cDiiAm7S=-t6OQ@mail.gmail.com>
 <0936903d-109f-c9cf-b40e-767fe7a21dae@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f3b4aba2-bd9a-35f0-b393-4f66e66f62c2@redhat.com>
Date: Thu, 2 Jul 2020 16:39:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0936903d-109f-c9cf-b40e-767fe7a21dae@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:00:43
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

On 6/30/20 6:29 PM, Auger Eric wrote:
> Hi Peter,
> 
> On 6/30/20 5:50 PM, Peter Maydell wrote:
>> On Fri, 26 Jun 2020 at 14:53, Auger Eric <eric.auger@redhat.com> wrote:
>>> On 6/25/20 5:30 PM, Peter Maydell wrote:
>>>> Rather than looping around doing multiple hash table lookups like
>>>> this, why not just avoid including the tg and level in the
>>>> key equality test?
>>>>
>>>> If I understand the range-based-invalidation feature correctly,
>>>> the only time we care about the TG/LVL is if we're processing
>>>> an invalidate-range command that specifies them. But in that
>>>> case there should never be multiple entries in the bs->iotlb
>>>> with the same iova, so we can just check whether the entry
>>>> matches the requested TG/LVL once we've pulled it out of the
>>>> hash table. (Or we could architecturally validly just blow
>>>> it away regardless of requested TG/LVL -- they are only hints,
>>>> not required-to-match.)
>>>
>>> This change could have been done independently on the RIL feature. As we
>>> now put block entries in the IOTLB , when we look for an iova
>>> translation, the IOVA can be mapped using different block sizes or using
>>> page entries. So we start looking at blocks of the bigger size (entry
>>> level) downto the page, for instance 4TB/512MB/64KB. We cannot know
>>> which block and size the address belongs to.
>>
>> Yes, but we wouldn't need to care which TG and LVL the
>> address belongs to if we didn't put them into
>> the key, would we? I'm probably missing something here, but
>> just because the hardware might want to use the hints in
>> the invalidation-command about TG and LVL doesn't inherently
>> mean QEMU is most efficient if it cares about the hints.
> 
> OK I think I understand your point now. It is not necessary to put
> TG/LVL in the key as log as they are in the entry. I will look at this
> implementation ...

Looking further at the implementation, if we don't encode the LVL in the
key (but just encode the block addr), on invalidation, we are not able
to remove the associated entry in one shot, using g_hash_table_remove().
We are obliged to use g_hash_table_foreach_remove and sort out the
entries according to the invalidation parameters.

Putting the TG and LVL in the key allows to do this in one short if
num_pages == 1. See [8/9] hw/arm/smmuv3: Get prepared for range
invalidation, smmu_iotlb_inv_iova() implementation.

So my understanding is it is obviously feasible to get rid of TG/LVL in
the key but may be less optimal when range invalidation gets used by the
guest (most invalidations having num_pages == 1)

Thanks

Eric
> 
> Thanks
> 
> Eric
>>
>> thanks
>> -- PMM
>>
> 
> 


