Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BE5C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 13:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9DE4207DE
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 13:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DE4207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFHGz-0000sF-Ok
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 09:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kFHGQ-0000Da-Db
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 09:32:54 -0400
Received: from mail.ispras.ru ([83.149.199.84]:46486)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kFHGO-0000ax-P1
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 09:32:54 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id E1C9840A2045;
 Mon,  7 Sep 2020 13:32:49 +0000 (UTC)
Subject: Re: [PATCH v3 09/15] replay: implement replay-seek command
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <159903454714.28509.7439453309116734374.stgit@pasha-ThinkPad-X280>
 <159903459923.28509.4300111201059622860.stgit@pasha-ThinkPad-X280>
 <87v9gprc10.fsf@linaro.org>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Message-ID: <e617386e-ac87-7d1e-2e67-9eda0f8337ad@ispras.ru>
Date: Mon, 7 Sep 2020 16:32:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87v9gprc10.fsf@linaro.org>
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

On 07.09.2020 15:45, Alex Bennée wrote:
> 
> Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:
> 
>> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>>
>> This patch adds hmp/qmp commands replay_seek/replay-seek that proceed
>> the execution to the specified instruction count.
>> The command automatically loads nearest snapshot and replays the execution
>> to find the desired instruction count.
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
> 
> 
> This seems to break the build:
> 
>    Warning, treated as error:
>    /home/alex/lsrc/qemu.git/docs/../hmp-commands.hx:1863:Definition list ends without a blank line; unexpected unindent.

Thanks, I've added an indent.


Pavel Dovgalyuk

