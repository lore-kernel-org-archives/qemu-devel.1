Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAB9C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 13:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF729215A4
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 13:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF729215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFHBb-0006Rm-JW
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 09:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kFHB6-00061f-SC
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 09:27:24 -0400
Received: from mail.ispras.ru ([83.149.199.84]:45808)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kFHB4-0008T9-2Y
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 09:27:24 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id DD00940A2047;
 Mon,  7 Sep 2020 13:27:15 +0000 (UTC)
Subject: Re: [PATCH v3 09/15] replay: implement replay-seek command
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <159903454714.28509.7439453309116734374.stgit@pasha-ThinkPad-X280>
 <159903459923.28509.4300111201059622860.stgit@pasha-ThinkPad-X280>
 <87sgbtrbf5.fsf@linaro.org>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Message-ID: <8f077f41-f99b-cd46-ff3b-3cb191dc1c4c@ispras.ru>
Date: Mon, 7 Sep 2020 16:27:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87sgbtrbf5.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 09:27:16
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.825,
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

On 07.09.2020 15:58, Alex Bennée wrote:
> 
> Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:
> 
>> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>>
>> This patch adds hmp/qmp commands replay_seek/replay-seek that proceed
>> the execution to the specified instruction count.
>> The command automatically loads nearest snapshot and replays the execution
>> to find the desired instruction count.
> 
> Should there be an initial snapshot created at instruction 0? Using a
> separate monitor channel:

Right, you can't go to the prior state, when there is no preceding 
snapshot available.

> 
>    (qemu) replay_break 190505
>    replay_break 190505
>    (qemu) c
>    (qemu) info replay
>    info replay
>    Replaying execution 'record.out': instruction count = 190505
>    (qemu) replay_seek 190000
>    replay_seek 190000
>    snapshotting is disabled
> 
> And then the guest dies with a sigabort:

This could be a bug, thanks.

> 
>    ./qemu-system-aarch64 -cpu cortex-a53 -display none -serial stdio -machine virt -kernel zephyr.elf -net none -icount shift=6,align=off,sleep=off,rr=replay,rrfile=record.out -drive file=record.qcow2,if=none,snapshot,id=rr -monitor telnet:127.0.0.1:4444 -S
>    *** Booting Zephyr OS build zephyr-v2.3.0-1183-ge5628ad0faf3  ***
>    Hello World! qemu_cortex_a53
>    double free or corruption (out)
>    fish: “./qemu-system-aarch64 -cpu cort…” terminated by signal SIGABRT (Abort)
> 
>>
>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   hmp-commands.hx           |   18 +++++++++
>>   include/monitor/hmp.h     |    1
>>   qapi/replay.json          |   20 ++++++++++
>>   replay/replay-debugging.c |   92 +++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 131 insertions(+)
>>
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index e8ce385879..4288274c4e 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -1851,6 +1851,24 @@ SRST
>>     The command is ignored when there are no replay breakpoints.
>>   ERST
>>   
>> +    {
>> +        .name       = "replay_seek",
>> +        .args_type  = "icount:i",
>> +        .params     = "icount",
>> +        .help       = "replay execution to the specified instruction count",
>> +        .cmd        = hmp_replay_seek,
>> +    },
>> +
>> +SRST
>> +``replay_seek`` *icount*
>> +Automatically proceed to the instruction count *icount*, when
>> +replaying the execution. The command automatically loads nearest
>> +snapshot and replays the execution to find the desired instruction.
>> +When there is no preceding snapshot or the execution is not replayed,
>> +then the command fails.
>> +*icount* for the reference may be observed with ``info replay`` command.
>> +ERST
>> +
>>       {
>>           .name       = "info",
>>           .args_type  = "item:s?",
>> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
>> index 21849bdda5..655eb81a4c 100644
>> --- a/include/monitor/hmp.h
>> +++ b/include/monitor/hmp.h
>> @@ -133,5 +133,6 @@ void hmp_info_sev(Monitor *mon, const QDict *qdict);
>>   void hmp_info_replay(Monitor *mon, const QDict *qdict);
>>   void hmp_replay_break(Monitor *mon, const QDict *qdict);
>>   void hmp_replay_delete_break(Monitor *mon, const QDict *qdict);
>> +void hmp_replay_seek(Monitor *mon, const QDict *qdict);
>>   
>>   #endif
>> diff --git a/qapi/replay.json b/qapi/replay.json
>> index 173ba76107..bfd83d7591 100644
>> --- a/qapi/replay.json
>> +++ b/qapi/replay.json
>> @@ -99,3 +99,23 @@
>>   #
>>   ##
>>   { 'command': 'replay-delete-break' }
>> +
>> +##
>> +# @replay-seek:
>> +#
>> +# Automatically proceed to the instruction count @icount, when
>> +# replaying the execution. The command automatically loads nearest
>> +# snapshot and replays the execution to find the desired instruction.
>> +# When there is no preceding snapshot or the execution is not replayed,
>> +# then the command fails.
>> +# icount for the reference may be obtained with @query-replay command.
>> +#
>> +# @icount: target instruction count
>> +#
>> +# Since: 5.2
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "replay-seek", "data": { "icount": 220414 } }
>> +##
>> +{ 'command': 'replay-seek', 'data': { 'icount': 'int' } }
>> diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
>> index 86e19bb217..cfd0221692 100644
>> --- a/replay/replay-debugging.c
>> +++ b/replay/replay-debugging.c
>> @@ -19,6 +19,8 @@
>>   #include "qapi/qapi-commands-replay.h"
>>   #include "qapi/qmp/qdict.h"
>>   #include "qemu/timer.h"
>> +#include "block/snapshot.h"
>> +#include "migration/snapshot.h"
>>   
>>   void hmp_info_replay(Monitor *mon, const QDict *qdict)
>>   {
>> @@ -127,3 +129,93 @@ void hmp_replay_delete_break(Monitor *mon, const QDict *qdict)
>>           return;
>>       }
>>   }
>> +
>> +static char *replay_find_nearest_snapshot(int64_t icount,
>> +                                          int64_t *snapshot_icount)
>> +{
>> +    BlockDriverState *bs;
>> +    QEMUSnapshotInfo *sn_tab;
>> +    QEMUSnapshotInfo *nearest = NULL;
>> +    char *ret = NULL;
>> +    int nb_sns, i;
>> +    AioContext *aio_context;
>> +
>> +    *snapshot_icount = -1;
>> +
>> +    bs = bdrv_all_find_vmstate_bs();
>> +    if (!bs) {
>> +        goto fail;
>> +    }
>> +    aio_context = bdrv_get_aio_context(bs);
>> +
>> +    aio_context_acquire(aio_context);
>> +    nb_sns = bdrv_snapshot_list(bs, &sn_tab);
>> +    aio_context_release(aio_context);
>> +
>> +    for (i = 0; i < nb_sns; i++) {
>> +        if (bdrv_all_find_snapshot(sn_tab[i].name, &bs) == 0) {
>> +            if (sn_tab[i].icount != -1ULL
>> +                && sn_tab[i].icount <= icount
>> +                && (!nearest || nearest->icount < sn_tab[i].icount)) {
>> +                nearest = &sn_tab[i];
>> +            }
>> +        }
>> +    }
>> +    if (nearest) {
>> +        ret = g_strdup(nearest->name);
>> +        *snapshot_icount = nearest->icount;
>> +    }
>> +    g_free(sn_tab);
>> +
>> +fail:
>> +    return ret;
>> +}
>> +
>> +static void replay_seek(int64_t icount, QEMUTimerCB callback, Error **errp)
>> +{
>> +    char *snapshot = NULL;
>> +    int64_t snapshot_icount;
>> +
>> +    if (replay_mode != REPLAY_MODE_PLAY) {
>> +        error_setg(errp, "replay must be enabled to seek");
>> +        return;
>> +    }
>> +    if (!replay_snapshot) {
>> +        error_setg(errp, "snapshotting is disabled");
>> +        return;
>> +    }
>> +
>> +    snapshot = replay_find_nearest_snapshot(icount, &snapshot_icount);
>> +    if (snapshot) {
>> +        if (icount < replay_get_current_icount()
>> +            || replay_get_current_icount() < snapshot_icount) {
>> +            vm_stop(RUN_STATE_RESTORE_VM);
>> +            load_snapshot(snapshot, errp);
>> +        }
>> +        g_free(snapshot);
>> +    }
>> +    if (replay_get_current_icount() <= icount) {
>> +        replay_break(icount, callback, NULL);
>> +        vm_start();
>> +    } else {
>> +        error_setg(errp, "cannot seek to the specified instruction count");
>> +    }
>> +}
>> +
>> +void qmp_replay_seek(int64_t icount, Error **errp)
>> +{
>> +    replay_seek(icount, replay_stop_vm, errp);
>> +}
>> +
>> +void hmp_replay_seek(Monitor *mon, const QDict *qdict)
>> +{
>> +    int64_t icount = qdict_get_try_int(qdict, "icount", -1LL);
>> +    Error *err = NULL;
>> +
>> +    qmp_replay_seek(icount, &err);
>> +    if (err) {
>> +        error_report_err(err);
>> +        error_free(err);
>> +        return;
>> +    }
>> +}
> 
> 


