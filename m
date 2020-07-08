Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238B1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2BF20772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxdyIjcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2BF20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIUV-0007Wm-4j
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jtHvG-00063B-8N
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:48:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55062
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jtHvE-0004hM-ES
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j21N4yUr1lJUCFKo3UGze6l1P5VU4mEmZu1jTSNrfAQ=;
 b=GxdyIjcWjdJR27RgxX7i3U08SfwzM5TQ6GiV9D8wbysvzPUQwgwwI21cI0Yy43GxmpK4L1
 /dvB5o0kiHZBud11I66zOB9fRRNgcNgD3tks3JXSLK/pqXo6MNFgSrDbxAPkucV6dZKg+o
 I1yHn9b5wVrtB3u1lOrPAAHeOY81Wg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-lUxyPUqdOqW2FwjcjCEQfg-1; Wed, 08 Jul 2020 01:42:48 -0400
X-MC-Unique: lUxyPUqdOqW2FwjcjCEQfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01C038005B0;
 Wed,  8 Jul 2020 05:42:47 +0000 (UTC)
Received: from [10.72.12.240] (ovpn-12-240.pek2.redhat.com [10.72.12.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D3A460E1C;
 Wed,  8 Jul 2020 05:42:32 +0000 (UTC)
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
To: Peter Xu <peterx@redhat.com>
References: <54d2cdfd-97b8-9e1d-a607-d7a5e96be3a1@redhat.com>
 <20200629133403.GA266532@xz-x1>
 <2589d0e9-cc5b-a4df-8790-189b49f1a40e@redhat.com>
 <20200630153911.GD3138@xz-x1>
 <69f6d6e7-a0b1-abae-894e-4e81b7e0cc90@redhat.com>
 <ff9e7af0-18c4-57e8-fc94-904fdce1123a@redhat.com>
 <20200702154540.GI40675@xz-x1>
 <34fe0e55-c0ae-8e56-462b-6281b6cca4f5@redhat.com>
 <20200703130338.GD6677@xz-x1>
 <c985b804-126c-94a1-b05e-430075f9e390@redhat.com>
 <20200707195429.GF88106@xz-x1>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5004a059-6eb0-4ef3-40b7-94dfbf9ec08f@redhat.com>
Date: Wed, 8 Jul 2020 13:42:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707195429.GF88106@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/8 上午3:54, Peter Xu wrote:
> On Tue, Jul 07, 2020 at 04:03:10PM +0800, Jason Wang wrote:
>> On 2020/7/3 下午9:03, Peter Xu wrote:
>>> On Fri, Jul 03, 2020 at 03:24:19PM +0800, Jason Wang wrote:
>>>> On 2020/7/2 下午11:45, Peter Xu wrote:
>>>>> On Thu, Jul 02, 2020 at 11:01:54AM +0800, Jason Wang wrote:
>>>>>> So I think we agree that a new notifier is needed?
>>>>> Good to me, or a new flag should be easier (IOMMU_NOTIFIER_DEV_IOTLB)?
>>>> That should work but I wonder something as following is better.
>>>>
>>>> Instead of introducing new flags, how about carry the type of event in the
>>>> notifier then the device (vhost) can choose the message it want to process
>>>> like:
>>>>
>>>> static vhost_iommu_event(IOMMUNotifier *n, IOMMUTLBEvent *event)
>>>>
>>>> {
>>>>
>>>> switch (event->type) {
>>>>
>>>> case IOMMU_MAP:
>>>> case IOMMU_UNMAP:
>>>> case IOMMU_DEV_IOTLB_UNMAP:
>>>> ...
>>>>
>>>> }
>>> Looks ok to me, though imo we should still keep the registration information,
>>> so VT-d knows which notifiers is interested in which events.  E.g., we can
>>> still do something like vtd_as_has_map_notifier().
>>
>> Is this for a better performance?
>>
>> I wonder whether it's worth since we can't not have both vhost and vtd to be
>> registered into the same as.
> /me failed to follow this sentence.. :(


Sorry, I meant "vfio" instead "vtd".


>
>> So it should be functional equivalent to vtd_as_has_notifier().
> For example: in vtd_iommu_replay() we'll skip the replay if vhost has
> registered the iommu notifier because vtd_as_has_map_notifier() will return
> false.


Two questions:

- Do we care the performance here? If not, vhost may just ignore the MAP 
event?
- If we care the performance, it's better to implement the MAP event for 
vhost, otherwise it could be a lot of IOTLB miss

Thanks


>    It'll only return true if the device is a vfio-pci device.
>
> Without vtd_as_has_map_notifier(), how could we do that?
>


