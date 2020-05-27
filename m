Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B71C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 08:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4361E20723
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 08:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4361E20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdrsg-0006WG-F1
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 04:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1jdrrz-0005dF-5X; Wed, 27 May 2020 04:57:03 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:2033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1jdrrx-0007Sy-Dp; Wed, 27 May 2020 04:57:02 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8A0C741C12;
 Wed, 27 May 2020 10:56:49 +0200 (CEST)
Subject: Re: [RFC PATCH 2/3] block: Allow bdrv_run_co() from different
 AioContext
To: Kevin Wolf <kwolf@redhat.com>
References: <20200512144318.181049-1-kwolf@redhat.com>
 <20200512144318.181049-3-kwolf@redhat.com>
 <2ab7bae7-03c3-f269-1db1-202aeb41bdf3@proxmox.com>
 <20200525164150.GD19863@linux.fritz.box>
 <20200526164215.GA8886@linux.fritz.box>
From: Stefan Reiter <s.reiter@proxmox.com>
Message-ID: <dae54d1b-422a-e088-a2a9-61bf4661707d@proxmox.com>
Date: Wed, 27 May 2020 10:56:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200526164215.GA8886@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=s.reiter@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 04:56:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/26/20 6:42 PM, Kevin Wolf wrote:
> Am 25.05.2020 um 18:41 hat Kevin Wolf geschrieben:
>> Am 25.05.2020 um 16:18 hat Stefan Reiter geschrieben:
>>> On 5/12/20 4:43 PM, Kevin Wolf wrote:
>>>> Coroutine functions that are entered through bdrv_run_co() are already
>>>> safe to call from synchronous code in a different AioContext because
>>>> bdrv_coroutine_enter() will schedule them in the context of the node.
>>>>
>>>> However, the coroutine fastpath still requires that we're already in the
>>>> right AioContext when called in coroutine context.
>>>>
>>>> In order to make the behaviour more consistent and to make life a bit
>>>> easier for callers, let's check the AioContext and automatically move
>>>> the current coroutine around if we're not in the right context yet.
>>>>
>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>>> ---
>>>>    block/io.c | 15 ++++++++++++++-
>>>>    1 file changed, 14 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/block/io.c b/block/io.c
>>>> index c1badaadc9..7808e8bdc0 100644
>>>> --- a/block/io.c
>>>> +++ b/block/io.c
>>>> @@ -895,8 +895,21 @@ static int bdrv_run_co(BlockDriverState *bs, CoroutineEntry *entry,
>>>>                           void *opaque, int *ret)
>>>>    {
>>>>        if (qemu_in_coroutine()) {
>>>> -        /* Fast-path if already in coroutine context */
>>>> +        Coroutine *self = qemu_coroutine_self();
>>>> +        AioContext *bs_ctx = bdrv_get_aio_context(bs);
>>>> +        AioContext *co_ctx = qemu_coroutine_get_aio_context(self);
>>>> +
>>>> +        if (bs_ctx != co_ctx) {
>>>> +            /* Move to the iothread of the node */
>>>> +            aio_co_schedule(bs_ctx, self);
>>>> +            qemu_coroutine_yield();
>>>
>>> I'm pretty sure this can lead to a race: When the thread we're re-scheduling
>>> to is faster to schedule us than we can reach qemu_coroutine_yield, then
>>> we'll get an abort ("Co-routine re-entered recursively"), since co->caller
>>> is still set.
>>>
>>> I've seen this happen in our code when I try to do the scheduling fandangle
>>> there.
>>
>> Ah, crap. I guess letting a coroutine re-schedule itself is only safe
>> within the same thread then.
>>
>>> Is there a safer way to have a coroutine reschedule itself? Some lock
>>> missing?
>>
>> There is no problem that can't be solved by adding another level of
>> indirection... We would have to schedule a BH in the original thread
>> that will only schedule the coroutine in its new thread after it has
>> yielded.
>>
>> Maybe we should actually introduce a helper function that moves the
>> current coroutine to a different AioContext this way.
> 
> Like this:
> 
> https://repo.or.cz/qemu/kevin.git/commitdiff/ed0244ba4ac699f7e8eaf7512ff25645cf43bda2
> 

Commit looks good to me, using aio_co_reschedule_self fixes all aborts 
I've been seeing.

> The series for which I need this isn't quite ready yet, so I haven't
> sent it as a patch yet, but if it proves useful in other contexts, we
> can always commit it without the rest.
> 

I did a quick search for places where a similar pattern is used and 
found 'hw/9pfs/coth.h', where this behavior is already described (though 
the bh seems to be scheduled using the threadpool API, which I'm not 
really familiar with). All other places where qemu_coroutine_yield() is 
preceded by a aio_co_schedule() only do so in the same AioContext, which 
should be safe.

> Kevin
> 
> 


