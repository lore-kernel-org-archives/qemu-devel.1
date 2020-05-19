Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE24BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 05:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD5720709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 05:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD5720709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1javG5-0001F8-VH
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 01:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovgaluk@ispras.ru>)
 id 1javFM-0000oU-NT
 for qemu-devel@nongnu.org; Tue, 19 May 2020 01:57:00 -0400
Received: from mail.ispras.ru ([83.149.199.45]:36938)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1javFL-0004pO-Ja
 for qemu-devel@nongnu.org; Tue, 19 May 2020 01:57:00 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 5A776CD465;
 Tue, 19 May 2020 08:56:56 +0300 (MSK)
Subject: Re: [PATCH] replay: synchronize on every virtual timer callback
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <158875304273.3986.105601155554744438.stgit@pasha-ThinkPad-X280>
 <c74e9498-75b4-d80c-e380-3d448497cfd0@redhat.com> <87wo59jky3.fsf@linaro.org>
From: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Message-ID: <b4da7577-8f42-3308-a4d6-05ff6451e944@ispras.ru>
Date: Tue, 19 May 2020 08:56:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87wo59jky3.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=83.149.199.45; envelope-from=dovgaluk@ispras.ru;
 helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 01:40:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 qemu-devel@nongnu.org, pavel.dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 18.05.2020 18:56, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>
>> + Alex
>>
>> On 5/6/20 10:17 AM, Pavel Dovgalyuk wrote:
>>> Sometimes virtual timer callbacks depend on order
>>> of virtual timer processing and warping of virtual clock.
>>> Therefore every callback should be logged to make replay deterministic.
>>> This patch creates a checkpoint before every virtual timer callback.
>>> With these checkpoints virtual timers processing and clock warping
>>> events order is completely deterministic.
>>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>>> ---
>>>    util/qemu-timer.c |    5 +++++
>>>    1 file changed, 5 insertions(+)
>>> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
>>> index d548d3c1ad..47833f338f 100644
>>> --- a/util/qemu-timer.c
>>> +++ b/util/qemu-timer.c
>>> @@ -588,6 +588,11 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
>>>            qemu_mutex_lock(&timer_list->active_timers_lock);
>>>              progress = true;
>>> +        /*
>>> +         * Callback may insert new checkpoints, therefore add new checkpoint
>>> +         * for the virtual timers.
>>> +         */
>>> +        need_replay_checkpoint = timer_list->clock->type == QEMU_CLOCK_VIRTUAL;
>>>        }
>>>        qemu_mutex_unlock(&timer_list->active_timers_lock);
> So the problem I have with this as with all the record/replay stuff I
> need want to review is it's very hard to see things in action. I added a
> *very* basic record/replay test to the aarch64 softmmu tests but they
> won't exercise any of this code because no timers get fired. I'm
> assuming the sort of tests that is really needed is something that not
> only causes QEMU_CLOCK_VIRTUAL timers to fire and trigger logged HW
> events and ensure that things don't get confused in the process.

I encounter most of the bugs in different OS boot scenarios.

We also have internal tests that include some computational, disk, and 
network interaction tasks.

Is it possible to add a test like booting a "real" OS and replaying it?

>
> If I read up the file I just get more questions than answers. For
> example why do we release the qemu_timers lock before processing the
> replay event? Is it that the replay event could cause another timer to

We release the lock, because accessing the replay module may process 
some events and add more timers.

> be consumed? That seems suspect to me given we should only be expiring
> times in the run loop.
>
> Could the code be re-factored to use QEMU_LOCK_GUARD? It's hard to know
> and I really wouldn't want to try that re-factoring without some sort of
> confidence we were properly exercising the semantics of record/replay
> and alive to potential regressions.

QEMU_LOCK_GUARD looks nice. But we'll still need unlock/lock pairs 
around checkpoint and timer callback.

>
> Please realise I do like the concept of record/replay and I'd love to
> get more features merged (like for example the reverse debug patches).
> However by it's very nature it gets it's fingers deeply intertwined with
> the main run loop and we really need to better exercise the code in our
> tests.
>
> FWIW you can have an:
>
> Acked-by: Alex Bennée <alex.bennee@linaro.org>

Thanks.

>
> which means it doesn't look obviously broken to me and it doesn't seem
> to break the non-record/replay cases because that's all I can really
> test.
>
>

