Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C59C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 03:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA612070E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 03:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxanvhIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA612070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwGox-00061F-2y
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 23:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jwGoM-0005bP-Ja
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 23:13:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24383
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jwGoK-0002V4-Mc
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 23:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594955599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+HAe0e4KQMoYVES+Bl0V3jnCmjYDMFY0Lj7Q6mLWvRk=;
 b=PxanvhISghWrP0WOfVsGQglbQuKTDACRIxzQ3R5b5OQRobU3gIz7ax4FN3eJvwbaHLew/A
 LpgzK3OSUzvTCXF8zr71NKYK3291/k9CebuFJONLu0UYPNUriIc2LVFTqPqztayTyXorRd
 hZKKkmkwlWaBIYCcZZAf4/RgMescMsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-JEVHkQAPOY-lnUNiD3JepA-1; Thu, 16 Jul 2020 23:13:15 -0400
X-MC-Unique: JEVHkQAPOY-lnUNiD3JepA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFB4E8015CE;
 Fri, 17 Jul 2020 03:13:14 +0000 (UTC)
Received: from [10.72.12.157] (ovpn-12-157.pek2.redhat.com [10.72.12.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C9E972AE0;
 Fri, 17 Jul 2020 03:13:07 +0000 (UTC)
Subject: Re: [PATCH] net: check payload length limit for all frames
To: Alexander Bulekov <alxndr@bu.edu>, Li Qiang <liq3ea@gmail.com>
References: <20200716192335.1212638-1-ppandit@redhat.com>
 <CAKXe6SKL3aNiOKKLEMof6GGNjYLcX9fvfSf-0PBSX48rh4--FQ@mail.gmail.com>
 <20200717012151.tlfmc6hsfia22f4e@mozz.bu.edu>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4e4909ae-db2f-4a32-ae5c-d52149e80a8c@redhat.com>
Date: Fri, 17 Jul 2020 11:13:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717012151.tlfmc6hsfia22f4e@mozz.bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:13:19
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/17 上午9:21, Alexander Bulekov wrote:
> On 200717 0853, Li Qiang wrote:
>> P J P <ppandit@redhat.com> 于2020年7月17日周五 上午3:26写道：
>>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>>
>>> While sending packets, the check that packet 'payload_len'
>>> is within 64kB limit, seems to happen only for GSO frames.
>>> It may lead to use-after-free or out-of-bounds access like
>>> issues when sending non-GSO frames. Check the 'payload_len'
>>> limit for all packets, irrespective of the gso type.
>>>
>> Hello Prasad,
>> Which issue are you trying to solve, any reference linking?
>>
>> I also send a patch related this part and also a UAF.
>>
>> Thanks,
>> Li Qiang
> Hi Li, Prasad,
> I reported a UAF privately to QEMU-Security in May. I believe the one Li
> is referring to is this one https://bugs.launchpad.net/qemu/+bug/1886362
>
> When I saw Prasad's email, I was worried that I reported the same bug
> twice, but I can still reproduce LP#1886362 with Prasad's patch.
>
> On the other hand, I cannot reproduce either issue with Li's patch:
> Message-Id: <20200716161453.61295-1-liq3ea@163.com>
>
> Based on this, I think there were two distinct issues. Both of the
> crashes rely on e1000e tx loopback into e1000e MMIO. Since Li's
> patch adds a TX bh, it seems to mitigate such types of issues.
>
> Sorry about any confusion.
> -Alex


Could you describe the issue you saw in details? (E.g the calltrace?) 
The commit log does not explain where we can get OOB or UAF.

Thanks


>
>>> Reported-by: Alexander Bulekov <alxndr@bu.edu>
>>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>>> ---
>>>   hw/net/net_tx_pkt.c | 10 ++++------
>>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
>>> index 162f802dd7..e66998a8f9 100644
>>> --- a/hw/net/net_tx_pkt.c
>>> +++ b/hw/net/net_tx_pkt.c
>>> @@ -607,12 +607,10 @@ bool net_tx_pkt_send(struct NetTxPkt *pkt, NetClientState *nc)
>>>        * Since underlying infrastructure does not support IP datagrams longer
>>>        * than 64K we should drop such packets and don't even try to send
>>>        */
>>> -    if (VIRTIO_NET_HDR_GSO_NONE != pkt->virt_hdr.gso_type) {
>>> -        if (pkt->payload_len >
>>> -            ETH_MAX_IP_DGRAM_LEN -
>>> -            pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len) {
>>> -            return false;
>>> -        }
>>> +    if (pkt->payload_len >
>>> +        ETH_MAX_IP_DGRAM_LEN -
>>> +        pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len) {
>>> +        return false;
>>>       }
>>>
>>>       if (pkt->has_virt_hdr ||
>>> --
>>> 2.26.2
>>>
>>>


