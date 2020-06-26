Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7AAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8898020663
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wg0mvBG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8898020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joooe-0003ay-Pu
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1joonp-0002JK-85
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:54:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48700
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1joonn-0007SH-EO
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593179638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Coc7YhNwRtaq+GZF70Tm/pQLX8ecmv6v06aUbi2xqE=;
 b=Wg0mvBG5cH9VTQemjqS0qvpGIY9wXrdCOR26bn1eApBM2PT2+O6xfpMsdHeqxachGA2OLC
 mDstWTSi2Uo9jBw6YPAlkk582tLiap+Ne3G7qc/7ha2QFuUYIdSCC7Ro3BJDYVFfMWOa+f
 TwLW6o9dpYFMN8Ho2pj5K3vlkb4qxlI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-yWFyqraoMfOA9bGxxW2h1g-1; Fri, 26 Jun 2020 09:53:55 -0400
X-MC-Unique: yWFyqraoMfOA9bGxxW2h1g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5107F107ACCA;
 Fri, 26 Jun 2020 13:53:52 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57E8F19C4F;
 Fri, 26 Jun 2020 13:53:44 +0000 (UTC)
Subject: Re: [PATCH RESEND 1/9] hw/arm/smmu-common: Factorize some code in
 smmu_ptw_64()
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200611161500.23580-1-eric.auger@redhat.com>
 <20200611161500.23580-2-eric.auger@redhat.com>
 <CAFEAcA-8EjTYGb-RCp6=znbpWUS7rZZuCHTFtPSmQ6NzMM2mXg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e6e0080a-8d66-8dde-0179-90b95b554cca@redhat.com>
Date: Fri, 26 Jun 2020 15:53:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-8EjTYGb-RCp6=znbpWUS7rZZuCHTFtPSmQ6NzMM2mXg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:49:42
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

On 6/25/20 4:49 PM, Peter Maydell wrote:
> On Thu, 11 Jun 2020 at 17:15, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> Page and block PTE decoding can share some code. Let's
>> first handle table PTE and factorize some code shared by
>> page and block PTEs.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/smmu-common.c | 51 ++++++++++++++++----------------------------
>>  1 file changed, 18 insertions(+), 33 deletions(-)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index e13a5f4a7c..f2de2be527 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -186,12 +186,12 @@ static int smmu_ptw_64(SMMUTransCfg *cfg,
>>          uint64_t subpage_size = 1ULL << level_shift(level, granule_sz);
>>          uint64_t mask = subpage_size - 1;
>>          uint32_t offset = iova_level_offset(iova, inputsize, level, granule_sz);
>> -        uint64_t pte;
>> +        uint64_t pte, gpa;
>>          dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
>>          uint8_t ap;
>>
>>          if (get_pte(baseaddr, offset, &pte, info)) {
>> -                goto error;
>> +            break;
> 
> get_pte() fills in info->type (to SMMU_PTW_ERR_WALK_EABT) on
> error; changing this from "goto error" to "break" means we'll
> now execute the "info->type = SMMU_PTW_ERR_TRANSLATION" that
> comes between the end of the while loop and the error: label,
> overwriting the wrong error type.

Agreed.

Thanks

Eric
> 
> thanks
> -- PMM
> 


