Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD173C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 05:48:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A017C20708
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 05:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A017C20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jav6h-0004s9-Qd
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 01:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovgaluk@ispras.ru>)
 id 1jav5J-0003ML-W5
 for qemu-devel@nongnu.org; Tue, 19 May 2020 01:46:38 -0400
Received: from mail.ispras.ru ([83.149.199.45]:35872)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1jav5I-0003Fc-K4
 for qemu-devel@nongnu.org; Tue, 19 May 2020 01:46:37 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 8B8BBCD46B;
 Tue, 19 May 2020 08:46:34 +0300 (MSK)
Subject: Re: [PATCH] replay: implement fair mutex
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
References: <158823999490.29783.7079486043043163164.stgit@pasha-ThinkPad-X280>
 <87tv0djkfy.fsf@linaro.org>
From: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Message-ID: <c1ba54d2-1709-2911-1472-e1267d686614@ispras.ru>
Date: Tue, 19 May 2020 08:46:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87tv0djkfy.fsf@linaro.org>
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, pavel.dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 18.05.2020 19:07, Alex Bennée wrote:
> Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com> writes:
>
>> In record/replay icount mode main loop thread and vCPU thread
>> do not perform simultaneously. They take replay mutex to synchronize
>> the actions. Sometimes vCPU thread waits for locking the mutex for
>> very long time, because main loop releases the mutex and takes it
>> back again.
> Where in the main loop do we keep bouncing the mutex like this? Surely
> that is the problem we should fix?

I performed kind of profilng while replaying.

Sometimes main loop takes and releases this mutex without giving a 
chance to vCPU to work.

I also got reports about the opposite behavior from the users: vCPU 
takes and releases the mutex, and main loop stalls.

>
>> Standard qemu mutex do not provide the ordering
>> capabilities.
>>
>> This patch adds a "queue" for replay mutex. Therefore thread ordering
>> becomes more "fair". Threads are executed in the same order as
>> they are trying to take the mutex.
>>
>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>> ---
>>   replay/replay-internal.c |   15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/replay/replay-internal.c b/replay/replay-internal.c
>> index eba8246aae..2e8a3e947a 100644
>> --- a/replay/replay-internal.c
>> +++ b/replay/replay-internal.c
>> @@ -22,6 +22,9 @@
>>      It also protects replay events queue which stores events to be
>>      written or read to the log. */
>>   static QemuMutex lock;
>> +/* Condition and queue for fair ordering of mutex lock requests. */
>> +static QemuCond mutex_cond;
>> +static unsigned long mutex_head, mutex_tail;
>>   
>>   /* File for replay writing */
>>   static bool write_error;
>> @@ -197,9 +200,10 @@ static __thread bool replay_locked;
>>   void replay_mutex_init(void)
>>   {
>>       qemu_mutex_init(&lock);
>> +    qemu_cond_init(&mutex_cond);
>>       /* Hold the mutex while we start-up */
>> -    qemu_mutex_lock(&lock);
>>       replay_locked = true;
>> +    ++mutex_tail;
>>   }
>>   
>>   bool replay_mutex_locked(void)
>> @@ -211,10 +215,16 @@ bool replay_mutex_locked(void)
>>   void replay_mutex_lock(void)
>>   {
>>       if (replay_mode != REPLAY_MODE_NONE) {
>> +        unsigned long id;
>>           g_assert(!qemu_mutex_iothread_locked());
>>           g_assert(!replay_mutex_locked());
>>           qemu_mutex_lock(&lock);
>> +        id = mutex_tail++;
>> +        while (id != mutex_head) {
>> +            qemu_cond_wait(&mutex_cond, &lock);
>> +        }
>>           replay_locked = true;
>> +        qemu_mutex_unlock(&lock);
>>       }
>>   }
>>   
>> @@ -222,7 +232,10 @@ void replay_mutex_unlock(void)
>>   {
>>       if (replay_mode != REPLAY_MODE_NONE) {
>>           g_assert(replay_mutex_locked());
>> +        qemu_mutex_lock(&lock);
>> +        ++mutex_head;
>>           replay_locked = false;
>> +        qemu_cond_broadcast(&mutex_cond);
>>           qemu_mutex_unlock(&lock);
>>       }
>>   }
>

