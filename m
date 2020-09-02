Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0F7C433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 05:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB8A20709
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 05:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGstgyC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB8A20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDL6Z-00007c-C1
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 01:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kDL5p-000894-ET
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 01:13:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43568)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kDL5m-00051R-OP
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 01:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599023632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5deED0lEksvphdvwLgoqrTJy8UkOe2qhLAGcI6m10PI=;
 b=iGstgyC2ATc6yr4wmhWWrogPNQhaUPyVUym8cNkJjne+FgC0vwTAwApWCE8nOJ7Au2zEpS
 +dflZDwzvV4NA56iYezamJ82OzElB8E31KRQg7MZIzM0QVYwvrnmp86uKWA4jCDsTFnz3w
 cOOcutROrdJWya3csJlQVAQWdutF6Uk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-AL2gsA_-NRaQzGujD2NbKQ-1; Wed, 02 Sep 2020 01:13:51 -0400
X-MC-Unique: AL2gsA_-NRaQzGujD2NbKQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A093189E606;
 Wed,  2 Sep 2020 05:13:50 +0000 (UTC)
Received: from [10.72.13.160] (ovpn-13-160.pek2.redhat.com [10.72.13.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5602F61983;
 Wed,  2 Sep 2020 05:13:34 +0000 (UTC)
Subject: Re: [RFC v3 1/1] memory: Skip bad range assertion if notifier
 supports arbitrary masks
To: Peter Xu <peterx@redhat.com>
References: <20200811175533.7359-1-eperezma@redhat.com>
 <20200811175533.7359-2-eperezma@redhat.com>
 <2443886f-2109-e048-b47f-886c896613ab@redhat.com>
 <CAJaqyWe0_wcXHgbAVAVNCTpG7O4YKF6FMkgKsf6SfW4dEZ4A5g@mail.gmail.com>
 <CAJaqyWe+KgnVegtprpRmVvXo7kFVFDL_erK_5Nyp4K=gTUcN=Q@mail.gmail.com>
 <eb26c5d7-465a-34ed-3f8f-bad11eda5bee@redhat.com>
 <20200819155051.GA275003@xz-x1>
 <f010e8c0-6713-a2bc-ce6b-98af5e4638be@redhat.com>
 <20200821141250.GC358043@xz-x1>
 <5e06e59d-7810-6863-20c7-d1660099cc51@redhat.com>
 <20200901193504.GA3053@xz-x1>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <63caf29f-4d19-1fcd-8053-e5d63890f317@redhat.com>
Date: Wed, 2 Sep 2020 13:13:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901193504.GA3053@xz-x1>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Eugenio Perez Martin <eperezma@redhat.com>,
 Avi Kivity <avi@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/9/2 上午3:35, Peter Xu wrote:
> On Tue, Sep 01, 2020 at 11:05:18AM +0800, Jason Wang wrote:
>> On 2020/8/21 下午10:12, Peter Xu wrote:
>>> On Thu, Aug 20, 2020 at 10:28:00AM +0800, Jason Wang wrote:
>>>> On 2020/8/19 下午11:50, Peter Xu wrote:
>>>>> On Wed, Aug 19, 2020 at 03:15:26PM +0800, Jason Wang wrote:
>>>>>> Yes, actually, I feel confused after reading the codes. Is notifier->start
>>>>>> IOVA or GPA?
>>>>>>
>>>>>> In vfio.c, we did:
>>>>>>
>>>>>>            iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
>>>>>>                                IOMMU_NOTIFIER_ALL,
>>>>>>                                section->offset_within_region,
>>>>>>                                int128_get64(llend),
>>>>>>                                iommu_idx);
>>>>>>
>>>>>> So it looks to me the start and end are GPA, but the assertion above check
>>>>>> it against IOVA which seems to be wrong ....
>>>>> It should be iova; both section->offset_within_region and llend are for the
>>>>> device's iova address space.  Thanks,
>>>>>
>>>> Interesting, how can memory region know which IOVA is used by guest?
>>> Does it need to know? :)
>>>
>>> AFAICT what we do here is only register with the whole possible IOVA address
>>> space (e.g., across the whole 64bit address space).  Then vfio will get
>>> notifications when there're new iova ranges mapped into it.
>>
>> Right, but the whole IOVA address space should be something vIOMMU specific,
>> e.g for Intel it should be calculated by GAW, but I found:
>>
>>          memory_region_init_iommu(&vtd_dev_as->iommu,
>> sizeof(vtd_dev_as->iommu),
>>                                   TYPE_INTEL_IOMMU_MEMORY_REGION, OBJECT(s),
>>                                   name, UINT64_MAX);
>>
>> which assumes UINT64_MAX.
> Right.  AFAICT it can be reduced to gaw width, but I don't see a problem either
> even with UINT64_MAX (as long as it covers the range specified by gaw).  Or did
> I miss something?


Dunno :)

Just notice this difference, for safety, maybe its better to cap it with 
GAW.

Btw, the naming of "vtd-ir" is kind of confusing, it should work without ir.

Thanks


> Thanks,
>


