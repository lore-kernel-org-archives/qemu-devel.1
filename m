Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99074C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 06:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F03220757
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 06:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F03220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc1M9-0004nW-Jh
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 02:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovgaluk@ispras.ru>)
 id 1jc1LR-0004Ms-Hj
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:39:49 -0400
Received: from mail.ispras.ru ([83.149.199.45]:39082)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1jc1LQ-0008Lg-Ce
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:39:49 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 0B7ECCD462;
 Fri, 22 May 2020 09:39:45 +0300 (MSK)
Subject: Re: [PATCH] replay: synchronize on every virtual timer callback
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <158875304273.3986.105601155554744438.stgit@pasha-ThinkPad-X280>
 <0a778b07-3d20-90f3-9b8e-69f035c6f11b@redhat.com>
From: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Message-ID: <403691ad-3e4f-d982-944d-a95a2fc0cc30@ispras.ru>
Date: Fri, 22 May 2020 09:39:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0a778b07-3d20-90f3-9b8e-69f035c6f11b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=83.149.199.45; envelope-from=dovgaluk@ispras.ru;
 helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 02:35:28
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
Cc: pavel.dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 21.05.2020 16:22, Paolo Bonzini wrote:
> On 06/05/20 10:17, Pavel Dovgalyuk wrote:
>> Sometimes virtual timer callbacks depend on order
>> of virtual timer processing and warping of virtual clock.
>> Therefore every callback should be logged to make replay deterministic.
>> This patch creates a checkpoint before every virtual timer callback.
>> With these checkpoints virtual timers processing and clock warping
>> events order is completely deterministic.
>>
>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>> ---
>>   util/qemu-timer.c |    5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
>> index d548d3c1ad..47833f338f 100644
>> --- a/util/qemu-timer.c
>> +++ b/util/qemu-timer.c
>> @@ -588,6 +588,11 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
>>           qemu_mutex_lock(&timer_list->active_timers_lock);
>>   
>>           progress = true;
>> +        /*
>> +         * Callback may insert new checkpoints, therefore add new checkpoint
>> +         * for the virtual timers.
>> +         */
>> +        need_replay_checkpoint = timer_list->clock->type == QEMU_CLOCK_VIRTUAL;
> You need to check replay_mode != REPLAY_MODE_NONE, either here or in the
> "if (need_replay_checkpoint)" above.  If you choose the latter, you can
> remove the other "if (replay_mode != REPLAY_MODE_NONE)".

I forgot about the changes that prohibited event processing for the 
virtual clock checkpoint.

This allowed to make this part simpler, please check the new version.

However, event processing still waits for refactoring. I'll do it after 
upstreaming the tests for the record/replay to prevent regression.


>
> Also, there is a comment that says that checkpointing "must only be done
> once since the clock value stays the same".  Is that actually a "can"
> rather than a "must"?  Should the central replay logic have something
> like a checkpoint count, that prevents adding back-to-back equal
> checkpoints?

I don't really think that this happens very often, but it worth 
implementing. I'll try it later.


Pavel Dovgalyuk



