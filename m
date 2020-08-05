Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882B5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 05:46:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56914206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 05:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcmFDsid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56914206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3CGC-0000FF-HG
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 01:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k3CFb-0008F9-D1
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 01:46:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35878
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k3CFY-0003yJ-AB
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 01:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596606362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dyk5hH2VIXAEWhnUjhF98siVkjaTdDCzw3x1EcpTeQo=;
 b=DcmFDsidnV1arlnve2AVYKIm+En0eUkdW4zSL+m+PUQ394LH5k3J4ax7lPSlKjY7mqCXV6
 azV/FfBlWPi5Rq8tSmZGOTxAMpOjWbxIFtE+Y2cT/p92n0CqcnElAz3W0dchiAgLqWFovT
 tMGAcVSCV15Qj7VZetjaI6IA1eeHWe0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-4HhS1IxDN16pzUlRJFLU0A-1; Wed, 05 Aug 2020 01:45:58 -0400
X-MC-Unique: 4HhS1IxDN16pzUlRJFLU0A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5399D91271;
 Wed,  5 Aug 2020 05:45:57 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CD9D88D76;
 Wed,  5 Aug 2020 05:45:41 +0000 (UTC)
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Eugenio_P=c3=a9rez?=
 <eperezma@redhat.com>
References: <20200628144746.GA239443@xz-x1>
 <54d2cdfd-97b8-9e1d-a607-d7a5e96be3a1@redhat.com>
 <20200629133403.GA266532@xz-x1>
 <2589d0e9-cc5b-a4df-8790-189b49f1a40e@redhat.com>
 <20200630153911.GD3138@xz-x1>
 <69f6d6e7-a0b1-abae-894e-4e81b7e0cc90@redhat.com>
 <ff9e7af0-18c4-57e8-fc94-904fdce1123a@redhat.com>
 <20200702154540.GI40675@xz-x1>
 <34fe0e55-c0ae-8e56-462b-6281b6cca4f5@redhat.com>
 <7c17ff0c1be07c3e490fb02abb2b39a1d9f269b8.camel@redhat.com>
 <20200804203018.GD90726@xz-x1>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <901112b8-c275-987b-d391-658cb3cf5988@redhat.com>
Date: Wed, 5 Aug 2020 13:45:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804203018.GD90726@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 01:46:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/8/5 上午4:30, Peter Xu wrote:
> On Mon, Aug 03, 2020 at 06:00:34PM +0200, Eugenio Pérez wrote:
>> On Fri, 2020-07-03 at 15:24 +0800, Jason Wang wrote:
>>> On 2020/7/2 下午11:45, Peter Xu wrote:
>>>> On Thu, Jul 02, 2020 at 11:01:54AM +0800, Jason Wang wrote:
>>>>> So I think we agree that a new notifier is needed?
>>>> Good to me, or a new flag should be easier (IOMMU_NOTIFIER_DEV_IOTLB)?
>>> That should work but I wonder something as following is better.
>>>
>>> Instead of introducing new flags, how about carry the type of event in
>>> the notifier then the device (vhost) can choose the message it want to
>>> process like:
>>>
>>> static vhost_iommu_event(IOMMUNotifier *n, IOMMUTLBEvent *event)
>>>
>>> {
>>>
>>> switch (event->type) {
>>>
>>> case IOMMU_MAP:
>>> case IOMMU_UNMAP:
>>> case IOMMU_DEV_IOTLB_UNMAP:
>>> ...
>>>
>>> }
>>>
>>> Thanks
>>>
>>>
>> Hi!
>>
>> Sorry, I thought I had this clear but now it seems not so clear to me. Do you mean to add that switch to the current
>> vhost_iommu_unmap_notify, and then the "type" field to the IOMMUTLBEntry? Is that the scope of the changes, or there is
>> something I'm missing?
>>
>> If that is correct, what is the advantage for vhost or other notifiers? I understand that move the IOMMUTLBEntry (addr,
>> len) -> (iova, mask) split/transformation to the different notifiers implementation could pollute them, but this is even a deeper change and vhost is not insterested in other events but IOMMU_UNMAP, isn't?
>>
>> On the other hand, who decide what type of event is? If I follow the backtrace of the assert in
>> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01015.html, it seems to me that it should be
>> vtd_process_device_iotlb_desc. How do I know if it should be IOMMU_UNMAP or IOMMU_DEV_IOTLB_UNMAP? If I set it in some
>> function of memory.c, I should decide the type looking the actual notifier, isn't?
> (Since Jason didn't reply yesterday, I'll try to; Jason, feel free to correct
>   me...)
>
> IMHO whether to put the type into the IOMMUTLBEntry is not important.  The
> important change should be that we introduce IOMMU_DEV_IOTLB_UNMAP (or I'd
> rather call it IOMMU_DEV_IOTLB directly which is shorter and cleaner).  With
> that information we can make the failing assertion conditional for MAP/UNMAP
> only.


Or having another dedicated device IOTLB notifier.


>    We can also allow dev-iotlb messages to take arbitrary addr_mask (so it
> becomes a length of address range; imho we can keep using addr_mask for
> simplicity, but we can comment for addr_mask that for dev-iotlb it can be not a
> real mask).


Yes.

Thanks


>
> Thanks,
>


