Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FDBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF3B20663
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5kEdFbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF3B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jooog-0003ct-0R
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1joonj-0002AI-TC
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:53:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37222
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1joonh-0007N7-AJ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593179632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mn1ydtPGwBAJexQ9to2YqXw29q/oVmls3ki6AHaXg4U=;
 b=D5kEdFbhRcoRrMa0ceKax+IPhgCoZ5rExgG4qWaZipasqSavkujqvZcl3dcqgVMr8oztaZ
 YMDnFt14EaCdkGg+/o61+hk2hURqakmFZZoUhL35Wjk/VAiHxBuXPw0dvJqS5D2hhlJcgi
 uwDL7E1A2kkVYSOicN6mR4/TSh7rNrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-EO0arRRbOVGbIxBLzjvxGg-1; Fri, 26 Jun 2020 09:53:48 -0400
X-MC-Unique: EO0arRRbOVGbIxBLzjvxGg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF6681005512;
 Fri, 26 Jun 2020 13:53:46 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5C9B10016E8;
 Fri, 26 Jun 2020 13:53:38 +0000 (UTC)
Subject: Re: [PATCH RESEND 3/9] hw/arm/smmu: Simplify the IOTLB key format
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200611161500.23580-1-eric.auger@redhat.com>
 <20200611161500.23580-4-eric.auger@redhat.com>
 <CAFEAcA-+eFh7q5-gQwTWxMCSV38ErwB-GZoigW+_sP-=Pmp1kw@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <848a0cab-ec2c-5004-d9b8-79d4678e0db5@redhat.com>
Date: Fri, 26 Jun 2020 15:53:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-+eFh7q5-gQwTWxMCSV38ErwB-GZoigW+_sP-=Pmp1kw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:55:55
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

On 6/25/20 5:03 PM, Peter Maydell wrote:
> On Thu, 11 Jun 2020 at 17:15, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> Instead of using a Jenkins hash function to generate
>> the key let's just use a 64 bit unsigned integer that
>> contains the asid and the 40 upper bits of the iova.
>> A maximum of 52-bit IOVA is supported. This change in the
>> key format also prepares for the addition of new fields
>> in subsequent patches (granule and level).
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>> index 1dceec5cb1..7b9d2f0eb7 100644
>> --- a/include/hw/arm/smmu-common.h
>> +++ b/include/hw/arm/smmu-common.h
>> @@ -88,11 +88,6 @@ typedef struct SMMUPciBus {
>>      SMMUDevice   *pbdev[]; /* Parent array is sparse, so dynamically alloc */
>>  } SMMUPciBus;
>>
>> -typedef struct SMMUIOTLBKey {
>> -    uint64_t iova;
>> -    uint16_t asid;
>> -} SMMUIOTLBKey;
> 
> I think we should keep the SMMUIOTLBKey type to abstract out what
> the key type is under the hood, so it would now be
>  typedef uint64_t SMMUIOTLBKey;

OK
> 
> (and then the code that works with SMMUIOTLBKeys should never
> directly look at it as a uint64_t. If you wanted you could
> put the abstraction layer into place with the existing
> SMMUIOTLBKey type and then change the type in a second patch.)

done this way

> 
>> +uint64_t smmu_get_iotlb_key(uint16_t asid, uint64_t iova);
> 
> This should return SMMUIOTLBKey rather than uint64_t,
> or pass in the pointer, like:
>    smmu_get_iotlb_key(SMMUIOTLBKey *key, uint16_t asid, uint64_t iova);
sure

Thanks

Eric
> 
> thanks
> -- PMM
> 


