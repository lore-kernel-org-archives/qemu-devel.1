Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61B5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F33206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coBu6TMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F33206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k54Rn-0008Qz-UE
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 05:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k54R8-0007r4-GU
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:49:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37646
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k54R5-0002yw-Ry
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597052982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E3IoO9kQtgf11lrSXxCtJCEcyPL/gVSaA5xS6KsvY1I=;
 b=coBu6TMbihJ6NKMm/Wvyew6qlKVe+PU5FgvBVI2y3KX7Q5cwp3f+1wIJQNwKScMs/7CdHg
 if61jcugDOe48YaCeuqphf9YmMsdLwXQivx7e9gdm6sBuL+7kQqddrW6ZTu4F+ihrclND2
 JfpVOiMhUgY4NKBmMkIK/knG7kVD+hs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-x-16WnyqMl6uRlo2FidriA-1; Mon, 10 Aug 2020 05:49:38 -0400
X-MC-Unique: x-16WnyqMl6uRlo2FidriA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE4AB102C7E9;
 Mon, 10 Aug 2020 09:49:37 +0000 (UTC)
Received: from [10.72.13.84] (ovpn-13-84.pek2.redhat.com [10.72.13.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 592C46842F;
 Mon, 10 Aug 2020 09:49:28 +0000 (UTC)
Subject: Re: Any reason VIRTQUEUE_MAX_SIZE is 1024? Can we increase this limit?
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <AM7PR05MB6695D4FF6766BF2942C345D6BB710@AM7PR05MB6695.eurprd05.prod.outlook.com>
 <20200805121107.GG361702@stefanha-x1.localdomain>
 <20200805081144-mutt-send-email-mst@kernel.org>
 <20200806123708.GC379937@stefanha-x1.localdomain>
 <e9f6ae61-c2d5-e204-f9b0-5113ef7fc330@redhat.com>
 <20200807095953.GA600298@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bf13d8ec-2233-6c1b-41c4-a1f94891124f@redhat.com>
Date: Mon, 10 Aug 2020 17:49:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807095953.GA600298@stefanha-x1.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 05:06:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Yajun Wu <yajunw@mellanox.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/8/7 下午5:59, Stefan Hajnoczi wrote:
> On Fri, Aug 07, 2020 at 11:35:08AM +0800, Jason Wang wrote:
>> On 2020/8/6 下午8:37, Stefan Hajnoczi wrote:
>>> On Wed, Aug 05, 2020 at 08:13:29AM -0400, Michael S. Tsirkin wrote:
>>>> On Wed, Aug 05, 2020 at 01:11:07PM +0100, Stefan Hajnoczi wrote:
>>>>> On Thu, Jul 30, 2020 at 07:46:09AM +0000, Yajun Wu wrote:
>>>>>> I'm doing iperf test on VIRTIO net through vhost-user(HW VDPA).
>>>>>> Find maximal acceptable tx_queue_size/rx_queue_size is 1024.
>>>>>> Basically increase queue size can get better RX rate for my case.
>>>>>>
>>>>>> Can we increase the limit(VIRTQUEUE_MAX_SIZE) to 8192 to possibly gain better performance?
>>>>> Hi,
>>>>> The VIRTIO 1.1 specification says the maximum number of descriptors is
>>>>> 32768 for both split and packed virtqueues.
>>>>>
>>>>> The vhost kernel code seems to support 32768.
>>>>>
>>>>> The 1024 limit is an implementation limit in QEMU. Increasing it would
>>>>> require QEMU code changes. For example, VIRTQUEUE_MAX_SIZE is used as
>>>>> the size of arrays.
>>>>>
>>>>> I can't think of a fundamental reason why QEMU needs to limit itself to
>>>>> 1024 descriptors. Raising the limit would require fixing up the code and
>>>>> ensuring that live migration remains compatible with older versions of
>>>>> QEMU.
>>>>>
>>>>> Stefan
>>>> There's actually a reason for a limit: in theory the vq size
>>>> also sets a limit on the number of scatter/gather entries.
>>>> both QEMU and vhost can't handle a packet split over > 1k chunks.
>>>>
>>>> We could add an extra limit for s/g size like block and scsi do,
>>>> this will need spec, guest and host side work.
>>> Interesting, thanks for explaining! This could be made explicit by
>>> changing the QEMU code to:
>>>
>>> include/hw/virtio/virtio.h:#define VIRTQUEUE_MAX_SIZE IOV_MAX
>>>
>>> Looking more closely at the vhost kernel code I see that UIO_MAXIOV is
>>> used in some places but not in vhost_vring_set_num() (ioctl
>>> VHOST_SET_VRING_NUM). Is there a reason why UIO_MAXIOV isn't enforced
>>> when the application sets the queue size?
>>
>> Actually three things:
>>
>> 1) queue size
>> 2) #descriptors in a list
>> 3) IOV size
>>
>> Spec limit the 2) to 1) but 2) may not equal to 3).
>>
>> So enforcing UIO_MAXIOV can not solve the problem completely.
>>
>> For vhost-net, it depends on socket to build skb which requires an iov array
>> to work. We need remove this limitation by:
>>
>> - build skb by vhost-net itself
>> - do piecewise copying
>>
>> Then we're not limited with #iov and more and support up to what spec
>> supports.
> If I understand correctly, you are saying vhost_net.ko does not support
> more than UIO_MAXIOV descriptors today but it could be fixed as you
> described.


Yes, but it needs major refactoring on vhost_net.

thanks


>
> Thanks!
>
> Stefan


