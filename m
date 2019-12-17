Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0DAC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 026B421D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026B421D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihFui-0000C7-Uw
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 11:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1ihFs4-0005KN-DY
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1ihFs2-0000Dt-RO
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:38:51 -0500
Received: from kerio.kamp.de ([195.62.97.192]:42192)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>)
 id 1ihFs2-0000AM-L0; Tue, 17 Dec 2019 11:38:50 -0500
X-Footer: a2FtcC5kZQ==
Received: from [172.21.12.60] ([172.21.12.60]) (authenticated user pl@kamp.de)
 by kerio.kamp.de with ESMTPSA
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
 Tue, 17 Dec 2019 17:38:43 +0100
Subject: Re: bdrv_co_pwritev: Assertion `!waited || !use_local_qiov' failed.
To: Kevin Wolf <kwolf@redhat.com>
References: <16b69066-cabb-3412-0005-886055352a05@kamp.de>
 <20191217155255.GA6580@linux.fritz.box>
From: Peter Lieven <pl@kamp.de>
Message-ID: <b3603dd5-3743-7e87-da14-417bb8aeeb3b@kamp.de>
Date: Tue, 17 Dec 2019 17:38:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217155255.GA6580@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 195.62.97.192
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
Cc: vsementsov@virtuozzo.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 qemu block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.12.19 um 16:52 schrieb Kevin Wolf:
> Am 17.12.2019 um 15:14 hat Peter Lieven geschrieben:
>> I have a vserver running Qemu 4.0 that seems to reproducibly hit the
>> following assertion:
>>
>>   bdrv_co_pwritev: Assertion `!waited || !use_local_qiov' failed.
>>
>> I noticed that the padding code was recently reworked in commit
>> 2e2ad02f2c. In the new code I cannot find a similar assertion. Was
>> the assertion wrong or why was it dropped?
> No, the assertion in the old version makes sense to me. The code goes
> basically like this:
>
>      if (head unaligned) {
>          /* Make sure no new conflicting request will be started */
>          mark_request_serialising()
>
>          /* Wait if a conflicting request is already in flight */
>          wait_serialising_requests()
>
>          adjust start of the request
>      }
>
>      if (tail unaligned) {
>          /* Make sure no new conflicting request will be started */
>          mark_request_serialising()
>
>          /* Wait if a conflicting request is already in flight. If we
>           * already had an unaligned head, we already waited for
>           * conflicting requests and no new requests may have been
>           * started, so in this case this must be a no-op. */
>          wait_serialising_requests()
>
>          adjust end of the request
>      }
>
> If the assertion fails, we already waited in the "head unaligned" case,
> but a new request snuck in even though we marked this request as
> serialising, so the other request should have waited.
>
> This might mean that a wait_serialising_requests() is missing somewhere.
>
>> I try to add some debugging code to find out what is exactly happing.
>> Especially the requests that are in flight when the assertion is
>> triggered.
> You can just have a look at bs->tracked_requests in gdb (if you can
> trigger the bug in a debugging environment). However, at the time of the
> assertion it's too late, we have waited for the bad request to complete,
> so it's gone now. You probably need to tell
> bdrv_wait_serialising_requests() that it's not supposed to wait, so you
> can assert the condition already there.
>
> (In the new code, I think the situation is different because both head
> and tail are handled at once, so we don't even have two instances of
> mark_request_serialising() and wait_serialising_requests() any more. But
> if a bug existed previously, it probably still exists.)


Thanks for your detailed explanation. This makes things a bit clearer.

I will try reproduce and get a better insight what is happening.


 From a first look at the code I was curious that we modify req->overlap_bytes and req->overlap_offset

without the bs->reqs_lock lock held. We also modify req->serializing. All three are accessed in wait_serializing_requests

while we might modify them.


Best,

Peter




