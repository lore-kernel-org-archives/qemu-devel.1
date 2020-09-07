Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95540C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:00:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A0520658
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lXDIGKwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A0520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFIdC-0001dq-TJ
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 11:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFIcT-0001Dy-OS
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 10:59:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFIcR-0002Qx-Jz
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 10:59:45 -0400
Received: by mail-wr1-x442.google.com with SMTP id a17so16096912wrn.6
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 07:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=iRiqXIBxISxQ7PSSY3nDjLAq+BPDOpOwGoM24by3fyA=;
 b=lXDIGKwYfvGWUQq78v6GqyGziE/CbZhUHPDjXEcfGF7usvcbX5sz9QgJyfUDELvhLH
 HDu05TXC0QvYKBimBKx1NRVFj/1LnFStLFUqUfbUaeP4ywSSNzNZSfjqfGVtqkSa31x9
 4TxOToxZ1b6LM7/oEF+uk9V1S0jbvEbRf+FNAf2uUgKunxu5PDRh3PLoOpAlRKlFNQ3F
 2IKezW+AlI9Xv7epgII5t0PQUltQNzBg4grtgiKgcuqPpcxLHLu17xMECQRG8I7og68D
 g7xfG17C4psVvZzO93G1Svms/a9q37VNLKmWqMAVq0VBJwx3WtX9G/BC/2LrUvYZ1BgP
 KbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=iRiqXIBxISxQ7PSSY3nDjLAq+BPDOpOwGoM24by3fyA=;
 b=ai4wdU4W+j6QJ+pqc/AkmcxQwjdbJD0bR9dkgcZYA76JI3Pa730qti2KVNWzQuxkWY
 vYvNEHmL+cQwAo4kkMAUGq0FcGHS6LQbLG1TkVNrUgIzfaD6kmjAwVG/Cg/luD3heB4+
 1OnSA0RLYuMnxHo9EONBLy9gvpxNG72mz16oWgb+Io2VgE8ucYEPiOVxl3pCCN2BAlrB
 R2ThQAhQBGLYjtdjiLqP3Uz69MzKDh9hLqn+6n8Zi5chGzFwEpytVKZhLqPyQr+FErcr
 0Ddlvs1zC/SFESyZoP2k7lqQl8/tg6wvdPUv6LDK2yRRAqFvi1opI+gc7k8ZUIGDZ+TR
 LdBg==
X-Gm-Message-State: AOAM5312o2t7nSz4BzctEjFeFpMuMEM+5tmAR5tGMxCHMhadMS0eoW27
 by7Rpp183dDPRwgoqdYO5vlPwg==
X-Google-Smtp-Source: ABdhPJxkDmOuBVIVoazV9X8XD+XgPuItOWLfHaB55OYxOcA8dOXQAtUK4qj88QvC/rbhWFrOkbDQRg==
X-Received: by 2002:adf:f508:: with SMTP id q8mr21013870wro.233.1599490781781; 
 Mon, 07 Sep 2020 07:59:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o9sm28050355wrw.58.2020.09.07.07.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 07:59:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B351C1FF7E;
 Mon,  7 Sep 2020 15:59:39 +0100 (BST)
References: <159903454714.28509.7439453309116734374.stgit@pasha-ThinkPad-X280>
 <159903459923.28509.4300111201059622860.stgit@pasha-ThinkPad-X280>
 <87sgbtrbf5.fsf@linaro.org>
 <8f077f41-f99b-cd46-ff3b-3cb191dc1c4c@ispras.ru>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH v3 09/15] replay: implement replay-seek command
In-reply-to: <8f077f41-f99b-cd46-ff3b-3cb191dc1c4c@ispras.ru>
Date: Mon, 07 Sep 2020 15:59:39 +0100
Message-ID: <87mu21r5t0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:

> On 07.09.2020 15:58, Alex Benn=C3=A9e wrote:
>>=20
>> Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:
>>=20
>>> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>>>
>>> This patch adds hmp/qmp commands replay_seek/replay-seek that proceed
>>> the execution to the specified instruction count.
>>> The command automatically loads nearest snapshot and replays the execut=
ion
>>> to find the desired instruction count.
>>=20
>> Should there be an initial snapshot created at instruction 0? Using a
>> separate monitor channel:
>
> Right, you can't go to the prior state, when there is no preceding=20
> snapshot available.

It seems creating an initial snapshot automatically would be more user
friendly? What can you do to trigger a snapshot, say for example on a
gdb connect?

>
>>=20
>>    (qemu) replay_break 190505
>>    replay_break 190505
>>    (qemu) c
>>    (qemu) info replay
>>    info replay
>>    Replaying execution 'record.out': instruction count =3D 190505
>>    (qemu) replay_seek 190000
>>    replay_seek 190000
>>    snapshotting is disabled
>>=20
>> And then the guest dies with a sigabort:
>
> This could be a bug, thanks.
>
>>=20
>>    ./qemu-system-aarch64 -cpu cortex-a53 -display none -serial stdio -ma=
chine virt -kernel zephyr.elf -net none -icount shift=3D6,align=3Doff,sleep=
=3Doff,rr=3Dreplay,rrfile=3Drecord.out -drive file=3Drecord.qcow2,if=3Dnone=
,snapshot,id=3Drr -monitor telnet:127.0.0.1:4444 -S
>>    *** Booting Zephyr OS build zephyr-v2.3.0-1183-ge5628ad0faf3  ***
>>    Hello World! qemu_cortex_a53
>>    double free or corruption (out)
>>    fish: =E2=80=9C./qemu-system-aarch64 -cpu cort=E2=80=A6=E2=80=9D term=
inated by signal SIGABRT (Abort)
>>=20
>>>
>>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>   hmp-commands.hx           |   18 +++++++++
>>>   include/monitor/hmp.h     |    1
>>>   qapi/replay.json          |   20 ++++++++++
>>>   replay/replay-debugging.c |   92 ++++++++++++++++++++++++++++++++++++=
+++++++++
>>>   4 files changed, 131 insertions(+)
>>>
>>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>>> index e8ce385879..4288274c4e 100644
>>> --- a/hmp-commands.hx
>>> +++ b/hmp-commands.hx
>>> @@ -1851,6 +1851,24 @@ SRST
>>>     The command is ignored when there are no replay breakpoints.
>>>   ERST
>>>=20=20=20
>>> +    {
>>> +        .name       =3D "replay_seek",
>>> +        .args_type  =3D "icount:i",
>>> +        .params     =3D "icount",
>>> +        .help       =3D "replay execution to the specified instruction=
 count",
>>> +        .cmd        =3D hmp_replay_seek,
>>> +    },
>>> +
>>> +SRST
>>> +``replay_seek`` *icount*
>>> +Automatically proceed to the instruction count *icount*, when
>>> +replaying the execution. The command automatically loads nearest
>>> +snapshot and replays the execution to find the desired instruction.
>>> +When there is no preceding snapshot or the execution is not replayed,
>>> +then the command fails.
>>> +*icount* for the reference may be observed with ``info replay`` comman=
d.
>>> +ERST
>>> +
>>>       {
>>>           .name       =3D "info",
>>>           .args_type  =3D "item:s?",
>>> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
>>> index 21849bdda5..655eb81a4c 100644
>>> --- a/include/monitor/hmp.h
>>> +++ b/include/monitor/hmp.h
>>> @@ -133,5 +133,6 @@ void hmp_info_sev(Monitor *mon, const QDict *qdict);
>>>   void hmp_info_replay(Monitor *mon, const QDict *qdict);
>>>   void hmp_replay_break(Monitor *mon, const QDict *qdict);
>>>   void hmp_replay_delete_break(Monitor *mon, const QDict *qdict);
>>> +void hmp_replay_seek(Monitor *mon, const QDict *qdict);
>>>=20=20=20
>>>   #endif
>>> diff --git a/qapi/replay.json b/qapi/replay.json
>>> index 173ba76107..bfd83d7591 100644
>>> --- a/qapi/replay.json
>>> +++ b/qapi/replay.json
>>> @@ -99,3 +99,23 @@
>>>   #
>>>   ##
>>>   { 'command': 'replay-delete-break' }
>>> +
>>> +##
>>> +# @replay-seek:
>>> +#
>>> +# Automatically proceed to the instruction count @icount, when
>>> +# replaying the execution. The command automatically loads nearest
>>> +# snapshot and replays the execution to find the desired instruction.
>>> +# When there is no preceding snapshot or the execution is not replayed,
>>> +# then the command fails.
>>> +# icount for the reference may be obtained with @query-replay command.
>>> +#
>>> +# @icount: target instruction count
>>> +#
>>> +# Since: 5.2
>>> +#
>>> +# Example:
>>> +#
>>> +# -> { "execute": "replay-seek", "data": { "icount": 220414 } }
>>> +##
>>> +{ 'command': 'replay-seek', 'data': { 'icount': 'int' } }
>>> diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
>>> index 86e19bb217..cfd0221692 100644
>>> --- a/replay/replay-debugging.c
>>> +++ b/replay/replay-debugging.c
>>> @@ -19,6 +19,8 @@
>>>   #include "qapi/qapi-commands-replay.h"
>>>   #include "qapi/qmp/qdict.h"
>>>   #include "qemu/timer.h"
>>> +#include "block/snapshot.h"
>>> +#include "migration/snapshot.h"
>>>=20=20=20
>>>   void hmp_info_replay(Monitor *mon, const QDict *qdict)
>>>   {
>>> @@ -127,3 +129,93 @@ void hmp_replay_delete_break(Monitor *mon, const Q=
Dict *qdict)
>>>           return;
>>>       }
>>>   }
>>> +
>>> +static char *replay_find_nearest_snapshot(int64_t icount,
>>> +                                          int64_t *snapshot_icount)
>>> +{
>>> +    BlockDriverState *bs;
>>> +    QEMUSnapshotInfo *sn_tab;
>>> +    QEMUSnapshotInfo *nearest =3D NULL;
>>> +    char *ret =3D NULL;
>>> +    int nb_sns, i;
>>> +    AioContext *aio_context;
>>> +
>>> +    *snapshot_icount =3D -1;
>>> +
>>> +    bs =3D bdrv_all_find_vmstate_bs();
>>> +    if (!bs) {
>>> +        goto fail;
>>> +    }
>>> +    aio_context =3D bdrv_get_aio_context(bs);
>>> +
>>> +    aio_context_acquire(aio_context);
>>> +    nb_sns =3D bdrv_snapshot_list(bs, &sn_tab);
>>> +    aio_context_release(aio_context);
>>> +
>>> +    for (i =3D 0; i < nb_sns; i++) {
>>> +        if (bdrv_all_find_snapshot(sn_tab[i].name, &bs) =3D=3D 0) {
>>> +            if (sn_tab[i].icount !=3D -1ULL
>>> +                && sn_tab[i].icount <=3D icount
>>> +                && (!nearest || nearest->icount < sn_tab[i].icount)) {
>>> +                nearest =3D &sn_tab[i];
>>> +            }
>>> +        }
>>> +    }
>>> +    if (nearest) {
>>> +        ret =3D g_strdup(nearest->name);
>>> +        *snapshot_icount =3D nearest->icount;
>>> +    }
>>> +    g_free(sn_tab);
>>> +
>>> +fail:
>>> +    return ret;
>>> +}
>>> +
>>> +static void replay_seek(int64_t icount, QEMUTimerCB callback, Error **=
errp)
>>> +{
>>> +    char *snapshot =3D NULL;
>>> +    int64_t snapshot_icount;
>>> +
>>> +    if (replay_mode !=3D REPLAY_MODE_PLAY) {
>>> +        error_setg(errp, "replay must be enabled to seek");
>>> +        return;
>>> +    }
>>> +    if (!replay_snapshot) {
>>> +        error_setg(errp, "snapshotting is disabled");
>>> +        return;
>>> +    }
>>> +
>>> +    snapshot =3D replay_find_nearest_snapshot(icount, &snapshot_icount=
);
>>> +    if (snapshot) {
>>> +        if (icount < replay_get_current_icount()
>>> +            || replay_get_current_icount() < snapshot_icount) {
>>> +            vm_stop(RUN_STATE_RESTORE_VM);
>>> +            load_snapshot(snapshot, errp);
>>> +        }
>>> +        g_free(snapshot);
>>> +    }
>>> +    if (replay_get_current_icount() <=3D icount) {
>>> +        replay_break(icount, callback, NULL);
>>> +        vm_start();
>>> +    } else {
>>> +        error_setg(errp, "cannot seek to the specified instruction cou=
nt");
>>> +    }
>>> +}
>>> +
>>> +void qmp_replay_seek(int64_t icount, Error **errp)
>>> +{
>>> +    replay_seek(icount, replay_stop_vm, errp);
>>> +}
>>> +
>>> +void hmp_replay_seek(Monitor *mon, const QDict *qdict)
>>> +{
>>> +    int64_t icount =3D qdict_get_try_int(qdict, "icount", -1LL);
>>> +    Error *err =3D NULL;
>>> +
>>> +    qmp_replay_seek(icount, &err);
>>> +    if (err) {
>>> +        error_report_err(err);
>>> +        error_free(err);
>>> +        return;
>>> +    }
>>> +}
>>=20
>>=20


--=20
Alex Benn=C3=A9e

