Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9885DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F3622074D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3622074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFchl-0007SQ-1X
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kFcXF-00087B-Ug
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:15:42 -0400
Received: from mail.ispras.ru ([83.149.199.84]:40450)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kFcXA-0006EI-5m
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:15:41 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id AEEC440A207D;
 Tue,  8 Sep 2020 12:15:30 +0000 (UTC)
Subject: Re: [PATCH v3 09/15] replay: implement replay-seek command
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <159903454714.28509.7439453309116734374.stgit@pasha-ThinkPad-X280>
 <159903459923.28509.4300111201059622860.stgit@pasha-ThinkPad-X280>
 <87sgbtrbf5.fsf@linaro.org> <8f077f41-f99b-cd46-ff3b-3cb191dc1c4c@ispras.ru>
 <87mu21r5t0.fsf@linaro.org> <1a0b8180-ae11-c6a0-6fc6-bfe87bbeaf27@ispras.ru>
 <87eendr1ty.fsf@linaro.org> <087c1214-d82f-8cd1-6418-5d823b9b5ae9@ispras.ru>
 <875z8or5qy.fsf@linaro.org> <87363sr0b9.fsf@linaro.org>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Message-ID: <682e2a30-49cf-1cdc-2546-dbef393653ba@ispras.ru>
Date: Tue, 8 Sep 2020 15:15:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87363sr0b9.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 06:54:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.626,
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08.09.2020 14:10, Alex Bennée wrote:
> 
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:
>>
>>> On 07.09.2020 19:25, Alex Bennée wrote:
>>>>
>>>> Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:
>>>>
>>>>> On 07.09.2020 17:59, Alex Bennée wrote:
>>>>>>
>>>>>> Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:
>>>>>>
>>>>>>> On 07.09.2020 15:58, Alex Bennée wrote:
>>>>>>>>
>>>>>>>> Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:
>>>>>>>>
>>>>>>>>> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>>>>>>>>>
>>>>>>>>> This patch adds hmp/qmp commands replay_seek/replay-seek that proceed
>>>>>>>>> the execution to the specified instruction count.
>>>>>>>>> The command automatically loads nearest snapshot and replays the execution
>>>>>>>>> to find the desired instruction count.
>>>>>>>>
>>>>>>>> Should there be an initial snapshot created at instruction 0? Using a
>>>>>>>> separate monitor channel:
>>>>>>>
>>>>>>> Right, you can't go to the prior state, when there is no preceding
>>>>>>> snapshot available.
>>>>>>
>>>>>> It seems creating an initial snapshot automatically would be more user
>>>>>
>>>>> Please take a look at 'Snapshotting' section of docs/replay.txt.
>>>>> Reverse debugging is considered to be run with disk image (overlay)
>>>>> and rrsnapshot option of icount, which allows creating an initial
>>>>> VM snapshot.
>>>>
>>>> Given that I'm using the block device purely for VM snapshots I think it
>>>> would be useful to document the minimal "no disk" approach - i.e. where
>>>> the disk is only used for record/replay.
>>>>
>>>> However I'm still having trouble. I can record the trace with:
>>>>
>>>>     ./qemu-system-aarch64 -cpu cortex-a53 -display none -serial stdio \
>>>>       -machine virt -kernel zephyr.elf -net none \
>>>>       -icount shift=6,align=off,sleep=off,rr=record,rrfile=record.out,rrsnapshot=rrstart  \
>>>>       -drive file=record.qcow2,if=none,id=rr \
>>>>       -monitor telnet:127.0.0.1:4444 -S
>>>
>>> Can you provide your zephyr.elf image?
>>>
>>>>
>>>> which shows:
>>>>
>>>>     (qemu) info snapshots
>>>>     info snapshots
>>>>     List of snapshots present on all disks:
>>>>     ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
>>>>     --        rrstart           653 KiB 2020-09-07 17:12:42 00:00:00.000          0
>>>>
>>>> but do I need a whole separate overlay in the replay case? I thought
>>>> supplying snapshot to the drive would prevent the replay case
>>>> overwriting what has been recorded but with:
>>>>
>>>>       -icount shift=6,align=off,sleep=off,rr=replay,rrfile=record.out \
>>>>       -drive file=record.qcow2,if=none,id=rr,snapshot
>>>
>>> When you provide qcow2 (overlay or not) for snapshotting, you don't need
>>> any 'snapshot' option on drive.
>>>
>>>>
>>>> but I get:
>>>>
>>>>     (qemu) info snapshots
>>>>     info snapshots
>>>>     There is no snapshot available.
>>>>
>>>> so if I drop the ,snapshot from the line I can at least see the snapshot
>>>> but continue doesn't seem to work:
>>>>
>>>>     (qemu) info snapshots
>>>>     info snapshots
>>>>     List of snapshots present on all disks:
>>>>     ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
>>>>     --        rrstart           653 KiB 2020-09-07 17:12:42 00:00:00.000          0
>>>>     (qemu) replay_break 190505
>>>>     replay_break 190505
>>>>     (qemu) c
>>>>     c
>>>>     (qemu) info replay
>>>>     info replay
>>>>     Replaying execution 'record.out': instruction count = 0
>>>
>>> It seems, that replay hangs. Can you try removing '-S' in record command
>>> line?
>>
>> That doesn't make any difference removing from both the record and
>> replay cases. It seems to need a loadvm to start things off.
>>
>> I've sent you an image off list. Please let me know if you can
>> replicate.
> 
> OK I can successfully use gdb to reverse debug the acceptance test (\o/)
> so I suspect there are differences in the calling setup.
> 
> The first one is ensuring that rrsnapshot is set for both record and
> replay. For this reason I think a more user friendly automatic snapshot
> would be worth setting up when record/replay is being used.
> 
> -icount sleep=off definitely breaks things. Do we keep track of the

It was ok for me:
qemu-system-aarch64 -cpu cortex-a53 -display none -serial stdio \
  -machine virt -kernel zephyr-64.elf -net none \
  -icount 
shift=6,align=off,sleep=off,rr=replay,rrfile=record.out,rrsnapshot=rrstart 
  \
  -drive file=record.qcow2,if=none,id=rr -s -S

>   icount bias as save and restore state?
> 

I don't know anything about sleep, but qemu_icount_bias is saved in 
vmstate when icount is enabled.

However, I noticed a strange condition at cpus.c:855
Shouldn't we check !sleep here instead of !icount_sleep?

     } else if (!icount_sleep) {
         error_setg(errp, "shift=auto and sleep=off are incompatible");
         return;
     }

     icount_sleep = sleep;



