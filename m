Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE54C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 09:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0858120782
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 09:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHOVQBmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0858120782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQodz-00030Z-Lz
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 05:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQod8-0002Tf-Tl
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 05:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQod5-0002yk-6Y
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 05:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602235437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HDSqihNIDBF1hdyHP4SnTVBfcB0UTpOP0W2lbak/XHA=;
 b=WHOVQBmQl16uShyMD3ZVRajNR1kM7RLqeVDCoq45AjyxcFdNIaORxAlneQnFwzyIhvdF07
 /mAHmOEY8OsWrGyXenI6lX7tTStZmdFEnhUM3GxGKoNVaMIuR5svUlJVEyhBXk93XiHm/d
 GmrSm1bcoT6Ldkpg/MWXmEZ/WkfAvCA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-j0ZsrPbxMCeUw01S_-oNxA-1; Fri, 09 Oct 2020 05:23:56 -0400
X-MC-Unique: j0ZsrPbxMCeUw01S_-oNxA-1
Received: by mail-wr1-f71.google.com with SMTP id b6so4991620wrn.17
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 02:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HDSqihNIDBF1hdyHP4SnTVBfcB0UTpOP0W2lbak/XHA=;
 b=cJzlgZ3N60W0UWgxH+Zf+dHje5/QgOOAv52MLpiv9cUZuWAhM9BRPfqfayukf4Evfc
 H6IleYwmoMWy6DpUn8iIJDwsDIexSw0mBjSmkIwvEIYLTPUzVAdcQTrUIHZZkI01a7sp
 M/47IuJbx5bGAXna4+XHt1YK4eTe6MGGXbMmLT8jSaM4ArFdvkaYOngPdjmFbwinEJKf
 sD1nE9wfCpLOCiilKU0LwBQ3PhG6jeGyL/BoDdsdYLlUuTKsgp6RonumoM4kI4pvLtRF
 exAfCH3un5q7PjdIVdoY/G2nWO3/jK7peiJuaaRRGIsdIdM0XMaG8hgZzSSdrOg56iFm
 /MXw==
X-Gm-Message-State: AOAM533ofrhRbaUHCgdihF/hPWyX4NGPwfGfuVJtAXKRBp14UTqsX3Op
 2pzEtXWBxpWxvDLUUZffyyJaRZOh+kSnhU+o2LtuYJsSO8/a/F3bi4lHn4kM9IJID9z0uJh25w/
 H395oyQ79Btcc8cE=
X-Received: by 2002:a7b:cb8c:: with SMTP id m12mr13811195wmi.12.1602235434507; 
 Fri, 09 Oct 2020 02:23:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXmNPo4JcXvLLStTUcyMaHUFYg0t7Xz/gYfhPCfH4nVHLc52IJd8FMjxA+wRo/s/x1oV4rkw==
X-Received: by 2002:a7b:cb8c:: with SMTP id m12mr13811173wmi.12.1602235434242; 
 Fri, 09 Oct 2020 02:23:54 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i14sm12348512wro.96.2020.10.09.02.23.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 02:23:53 -0700 (PDT)
Subject: Re: does make check now require TCG? Or is it a parallelism issue?
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
References: <11ef73ff-4178-b3e8-2e49-44ff014a13ed@suse.de>
 <569520f6-adf6-6212-9625-a184bf499e24@redhat.com>
 <e6300199-39e3-4f11-d97e-e2e7d9a9e8ef@suse.de>
 <16b01645-7a80-7f79-aba0-fd6c6c8ba6e8@suse.de>
 <62339951-606d-15d0-e2ad-bd46f3e6de87@redhat.com>
 <0b6397b1-019c-4b92-f00d-09214e276e46@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b8487188-e492-d6f3-6c3d-c33fdf6f2404@redhat.com>
Date: Fri, 9 Oct 2020 11:23:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <0b6397b1-019c-4b92-f00d-09214e276e46@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Alex Bennee <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 6:35 PM, Claudio Fontana wrote:
> On 10/8/20 6:31 PM, Paolo Bonzini wrote:
>> On 08/10/20 18:25, Claudio Fontana wrote:
>>> On 10/8/20 5:34 PM, Claudio Fontana wrote:
>>>> On 10/8/20 5:02 PM, Paolo Bonzini wrote:
>>>>> On 08/10/20 16:48, Claudio Fontana wrote:
>>>>>> on master, a build without tcg like:
>>>>>>
>>>>>> exec '../configure' '--disable-tcg' '--enable-kvm' '--enable-hax' "$@"
>>>>>>
>>>>>> make -j120 check
>>>>>> Generating qemu-version.h with a meson_exe.py custom command
>>>>>> make: *** No rule to make target 'qemu-system-aarch64', needed by 'check-block'.  Stop.
>>>>>> make: *** Waiting for unfinished jobs....
>>>>>>
>>>>>> qemu-system-aarch64 is required for check-block now?
>>>>>
>>>>> No, it's not, it's an unnecessary dependency.  This will fix it:
>>>>>
>>>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>>>> index 5aca98e60c..1ca70d88ce 100644
>>>>> --- a/tests/Makefile.include
>>>>> +++ b/tests/Makefile.include
>>>>> @@ -140,7 +140,7 @@ QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) = tests/qemu-iotests/socket_scm_helper$(EXE
>>>>>   check: check-block
>>>>>   check-block: $(SRC_PATH)/tests/check-block.sh qemu-img$(EXESUF) \
>>>>>   		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
>>>>> -		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
>>>>> +		qemu-system-$(patsubst ppc64%,ppc64, $(shell uname -m))
>>>>>   	@$<
>>>>>   endif
>>>>>   
>>>>>
>>>>>
>>>>
>>>> thanks this works!
>>>>
>>>>>> If I run without -j:
>>>>>>
>>>>>> Running test qtest-i386: qmp-cmd-test
>>>>>> Broken pipe
>>>>>> ../tests/qtest/libqtest.c:175: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
>>>>>> ERROR qtest-i386: qmp-cmd-test - too few tests run (expected 53, got 45)
>>>>>> make: *** [Makefile.mtest:1074: run-test-151] Error 1
>>>>>
>>>>> This one is different and I've never seen it.
>>>>
>>>> This one seems an additional, non-tcg build only error, will update when I have more details.
>>>>
>>>>>
>>>>> Paolo
>>>>>
>>>>
>>>> Ciao,
>>>>
>>>> Claudio
>>>>
>>>
>>> Seems to be some QMP calls to icount code from replay happening during the tests, which of course do not find any icount there..
>>>
>>> (gdb) bt
>>> #0  0x00007f2b4d115520 in raise () at /lib64/libc.so.6
>>> #1  0x00007f2b4d116b01 in abort () at /lib64/libc.so.6
>>> #2  0x000056295aaf5889 in icount_get_raw () at ../stubs/icount.c:20
>>> #3  0x000056295a7934a5 in replay_get_current_icount () at ../replay/replay.c:71
>>> #4  0x000056295a78719d in qmp_query_replay (errp=errp@entry=0x7ffe727a4538) at ../replay/replay-debugging.c:55
>>> #5  0x000056295aac0137 in qmp_marshal_query_replay (args=<optimized out>, ret=0x7ffe727a45a0, errp=0x7ffe727a4598)
>>>      at qapi/qapi-commands-replay.c:55
>>> #6  0x000056295aae88a3 in qmp_dispatch
>>>      (cmds=0x56295b3b5ce0 <qmp_commands>, request=request@entry=0x7f2b3c004db0, allow_oob=<optimized out>) at ../qapi/qmp-dispatch.c:155
>>> #7  0x000056295aa6ab7f in monitor_qmp_dispatch (mon=0x56295bee7f80, req=0x7f2b3c004db0) at ../monitor/qmp.c:145
>>> #8  0x000056295aa6b3ba in monitor_qmp_bh_dispatcher (data=<optimized out>) at ../monitor/qmp.c:234
>>> #9  0x000056295aaeb5b8 in aio_bh_poll (ctx=ctx@entry=0x56295bcd5130) at ../util/async.c:164
>>> #10 0x000056295aad76de in aio_dispatch (ctx=0x56295bcd5130) at ../util/aio-posix.c:380
>>> #11 0x000056295aaeb49e in aio_ctx_dispatch (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>)
>>>      at ../util/async.c:306
>>> #12 0x00007f2b4e268f07 in g_main_context_dispatch () at /usr/lib64/libglib-2.0.so.0
>>> #13 0x000056295aac96fa in glib_pollfds_poll () at ../util/main-loop.c:221
>>> #14 0x000056295aac96fa in os_host_main_loop_wait (timeout=-1) at ../util/main-loop.c:244
>>> #15 0x000056295aac96fa in main_loop_wait (nonblocking=nonblocking@entry=0) at ../util/main-loop.c:520
>>> #16 0x000056295a99083d in qemu_main_loop () at ../softmmu/vl.c:1677
>>> #17 0x000056295a71b17e in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at ../softmmu/main.c:50
>>>
>>
>> Ah, query-replay probably should return an error if !tcg_enabled().
>>
>> Paolo
>>
> 
> aha, and we might even compile away (almost) the whole replay/ if not under tcg, and just put the necessary qmp stuff in stubs/ ... ?

Soft accelerator are TCG and QTest. Replay only works with soft
accelerator. Should replay work with QTest? Is this useful?
(if there are no instructions, what can we replay, IRQs?)

If replay is only usable with TCG, can we merge it into it?
It seems quite accel-related.

Noob questions as I don't understand well the coverage of replay.

Regards,

Phil.


