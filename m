Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272E0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F113220829
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F113220829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0nou-0004nZ-88
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 11:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1k0nnn-0003r3-S1
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 11:15:31 -0400
Received: from 20.mo3.mail-out.ovh.net ([178.33.47.94]:33275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1k0nnl-0001pj-RC
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 11:15:31 -0400
Received: from player762.ha.ovh.net (unknown [10.110.115.173])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 27ACD25E820
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 17:15:18 +0200 (CEST)
Received: from kaod.org (bad36-1-78-202-132-1.fbx.proxad.net [78.202.132.1])
 (Authenticated sender: clg@kaod.org)
 by player762.ha.ovh.net (Postfix) with ESMTPSA id A3CED14CDD546;
 Wed, 29 Jul 2020 15:15:09 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G0047b7a6a19-3090-437b-9bb5-a0acfd90bf0b,565E08D03F5381EE4F4017DF562F253825237DEE)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH] hw/net/ftgmac100: Fix integer overflow in
 ftgmac100_do_tx()
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200710085417.638904-1-mcascell@redhat.com>
 <CAFEAcA-pRXOz5JVcwHa8=oaeogwaOK0YVXYQiJUpdM_rFZ+QTA@mail.gmail.com>
 <d7affe2b-0a2c-4e06-a874-daccf16bd136@kaod.org>
 <CAFEAcA9=_RC0w-EgjdPw=UWXZ-ufHjkeDWTMj_jXfSQL8G9GHA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <77ff42a9-a5a4-dea7-0b9a-c699c35b32f9@kaod.org>
Date: Wed, 29 Jul 2020 17:15:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9=_RC0w-EgjdPw=UWXZ-ufHjkeDWTMj_jXfSQL8G9GHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10557844905496578972
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrieeggdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdejkedrvddtvddrudefvddrudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejiedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.33.47.94; envelope-from=clg@kaod.org;
 helo=20.mo3.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 11:15:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 Mauro Matteo Cascella <mcascell@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, ziming zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sorry for the late answer.

On 7/13/20 6:15 PM, Peter Maydell wrote:
> On Mon, 13 Jul 2020 at 15:19, Cédric Le Goater <clg@kaod.org> wrote:
>> On 7/10/20 1:33 PM, Peter Maydell wrote:
>>> Andrew, Cedric: do you have the datasheet for this device? Do you
>>> know if we should also be flagging the error back to the
>>> guest somehow?
>>
>> zero is the only invalid size of a transmit buffer and the specs does
>> not have any special information on which bit to raise in that case.
> 
> I found a datasheet which might or might not be the equivalent
> bit of hardware -- does your datasheet have a note on the
> TXBUF_SIZE field of a tx descriptor that says "When the size is 0,
> the descriptor would be discarded" ? (Though I found another
> random doc that just says it's illegal...)

I only have : 

  TXBUF SIZE: Transmit buffer size in byte
  The transmit buffer size can not be zero.

>> I think FTGMAC100_INT_NO_NPTXBUF (transmit buffer unavailable) is our
>> best option and we should add an extra 'len == 0' test in front of
>> the dma_memory_read() call to raise it. A zero length is not considered
>> bogus by dma_memory_read() it seems.
> 
> My best guess at "what the hardware does" here would be:
>  * TXBUF_SIZE in a tx descriptor can be anything: the h/w
>    would happily allow you to assemble a tx packet with a
>    whole series of 1-byte sized buffers, each with its own
>    tx descriptor

yes. 

>  * zero-byte tx descriptors might just be marked "done" and
>    skipped over since they have no actual data

yes.

>  * any checking on max/min lengths would be done
>    only on the accumulated total-packet length (we do this
>    this way already for the frame-too-big check)

yes.

>  * I suspect "transmit buffer unavailable" means "the ethernet
>    controller needs more data but the next tx descriptor
>    is still marked as owned by the guest" -- this is certainly
>    what we currently do with it, and that doesn't seem like
>    the best thing to signal for the "tx packet too small"
>    case. It's possible that the hardware simply sends out a
>    runt packet of some form if the software tells it to do
>    that. My vote would be for handling it with XPKT_LOST,
>    the same way we do for over-large frames. 

XPKT_LOST means that packets are lost due to late/excessive 
collision. I have used this status for large frames because
not other bits made sense.

>    This probably
>    is not what the hardware does but at least it's a
>    coherent thing that the guest might be expecting to have
>    happen for a tx attempt and it matches the fact that we
>    really are not going to put it on the 'wire'.

I agree.

> 
> Side note: I suspect that any failures from
> dma_memory_read() and dma_memory_write() should be
> reported as AHB_ERR (currently we have a mix of
> ignoring them or using NO_NPTXBUF).

AHB_ERR is not used in the Aspeed implementation. I checked with 
them. But I think it makes sense for other implementations, so we
can add this status for Linux.

NO_NPTXBUF means a lack a transmit descriptors.


XPKT_LOST is our best choice then.

Thanks,

C. 

> (It would in theory be possible to test some of these edge
> cases on real hardware, but that kind of bare-metal test
> case is usually a pain to put together and way overkill
> for this situation, so I don't think we should bother.)
> 
>> Is address zero considered bogus ?
>> If not, we need to check that also.
> 
> Writes to address 0 are fine, it is not a special physical address.
> 
> thanks
> -- PMM
> 


