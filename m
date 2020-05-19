Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F221C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A48620657
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/YZrjvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A48620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4Ob-0004BL-GF
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb4Nt-0003X4-7C
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:42:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47241
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb4Nr-00069b-EP
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589902942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eKaFaxgBXG8cBP6OWLi2MESfoOmpbhjRqqIUaY05UUI=;
 b=b/YZrjvRq+c7JoOk/QLxOwzLrX0kEmf2B2t1vNwItgnuxoqTSvNVgxCB0ikqWetp8SfNBP
 Nxl29LUukePpM/4prp9ek0ARWxxYzBzJOAtwgmQamX/SlYi3gZtAPjbNVIFxZFHOWrHowD
 E2AdfiTjhA3lFPStKR/s05Y/k4f9rmc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-PCT03Wb1N0Goo0gXzCgoGQ-1; Tue, 19 May 2020 11:42:19 -0400
X-MC-Unique: PCT03Wb1N0Goo0gXzCgoGQ-1
Received: by mail-wr1-f69.google.com with SMTP id z10so18882wrs.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 08:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eKaFaxgBXG8cBP6OWLi2MESfoOmpbhjRqqIUaY05UUI=;
 b=JKijEemhBTShSefUSx2us3t9o0TXM+CardRmVBN1O3DKl8HjAyqhCRYIUMMzahwGAR
 wjZzuzOYtRY42jsJO46kye9BKSZ/KehmqjzAVYS/w+laPY7vFLz5DKpuR00sPvr12SQ/
 yaiaG7GJxtNwWVzV7GG0egQI3qmteSsXD+GVK6yA6ycxdPGkShxLej4bzpGbPtJqpHXP
 6HWNr+SojgW6S+vZHb8qm4JK4aY5+a10Vx+QJbrWLD7YsMhnRz9T9dPeFmcmJhn+x+qv
 JxLozef22jt+MIqxHCSMBBjzvzC7j1pTL9E5GXre5v0tE92xGuayBTI24B6JlWnhSlKL
 ywIQ==
X-Gm-Message-State: AOAM531bWJMaUFQlXRLLMZ/4cztSUfnBLSf2nHmgV9WsS6/mfVNto3qd
 nY4pj9Na1ahJO6BcCqThUK5ja8/kohXzICM9JtkwoJGn83trY0GnhXueVrf6IiHIfsbJX6oJ24O
 YioSHnvI+q6mk0L0=
X-Received: by 2002:a1c:4b0e:: with SMTP id y14mr9403wma.170.1589902938177;
 Tue, 19 May 2020 08:42:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwFXLp2PyFsyjsIj6PiDuR8HrdJ8tsUR7rodozic+LQa125xhtjxgz65FSep/9hkJM0gsRkw==
X-Received: by 2002:a1c:4b0e:: with SMTP id y14mr9378wma.170.1589902937921;
 Tue, 19 May 2020 08:42:17 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id e5sm21009223wro.3.2020.05.19.08.42.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 08:42:17 -0700 (PDT)
Subject: Re: [PATCH] replay: synchronize on every virtual timer callback
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <158875304273.3986.105601155554744438.stgit@pasha-ThinkPad-X280>
 <c74e9498-75b4-d80c-e380-3d448497cfd0@redhat.com> <87wo59jky3.fsf@linaro.org>
 <b4da7577-8f42-3308-a4d6-05ff6451e944@ispras.ru> <87eergjqe5.fsf@linaro.org>
 <093880f8-72d4-f404-6792-d11c177aaedc@ispras.ru> <87h7wci5av.fsf@linaro.org>
 <934b3292-bc41-0d00-2a61-9ecbd3217454@ispras.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a52b7038-35d4-74e0-b106-67138f8cef10@redhat.com>
Date: Tue, 19 May 2020 17:42:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <934b3292-bc41-0d00-2a61-9ecbd3217454@ispras.ru>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:56:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: pbonzini@redhat.com, Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 qemu-devel@nongnu.org, pavel.dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 12:38 PM, Pavel Dovgalyuk wrote:
> 
> On 19.05.2020 13:32, Alex Bennée wrote:
>> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>>
>>> On 19.05.2020 11:11, Alex Bennée wrote:
>>>> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>>>>
>>>>> On 18.05.2020 18:56, Alex Bennée wrote:
>>>>>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>>>>>
>>>>>>> + Alex
>>>>>>>
>>>>>>> On 5/6/20 10:17 AM, Pavel Dovgalyuk wrote:
>>>>>>>> Sometimes virtual timer callbacks depend on order
>>>>>>>> of virtual timer processing and warping of virtual clock.
>>>>>>>> Therefore every callback should be logged to make replay 
>>>>>>>> deterministic.
>>>>>>>> This patch creates a checkpoint before every virtual timer 
>>>>>>>> callback.
>>>>>>>> With these checkpoints virtual timers processing and clock warping
>>>>>>>> events order is completely deterministic.
>>>>>>>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>>>>>>>> ---
>>>>>>>>      util/qemu-timer.c |    5 +++++
>>>>>>>>      1 file changed, 5 insertions(+)
>>>>>>>> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
>>>>>>>> index d548d3c1ad..47833f338f 100644
>>>>>>>> --- a/util/qemu-timer.c
>>>>>>>> +++ b/util/qemu-timer.c
>>>>>>>> @@ -588,6 +588,11 @@ bool timerlist_run_timers(QEMUTimerList 
>>>>>>>> *timer_list)
>>>>>>>>              qemu_mutex_lock(&timer_list->active_timers_lock);
>>>>>>>>                progress = true;
>>>>>>>> +        /*
>>>>>>>> +         * Callback may insert new checkpoints, therefore add 
>>>>>>>> new checkpoint
>>>>>>>> +         * for the virtual timers.
>>>>>>>> +         */
>>>>>>>> +        need_replay_checkpoint = timer_list->clock->type == 
>>>>>>>> QEMU_CLOCK_VIRTUAL;
>>>>>>>>          }
>>>>>>>>          qemu_mutex_unlock(&timer_list->active_timers_lock);
>>>>>> So the problem I have with this as with all the record/replay stuff I
>>>>>> need want to review is it's very hard to see things in action. I 
>>>>>> added a
>>>>>> *very* basic record/replay test to the aarch64 softmmu tests but they
>>>>>> won't exercise any of this code because no timers get fired. I'm
>>>>>> assuming the sort of tests that is really needed is something that 
>>>>>> not
>>>>>> only causes QEMU_CLOCK_VIRTUAL timers to fire and trigger logged HW
>>>>>> events and ensure that things don't get confused in the process.
>>>>> I encounter most of the bugs in different OS boot scenarios.
>>>>>
>>>>> We also have internal tests that include some computational, disk, and
>>>>> network interaction tasks.
>>>>>
>>>>> Is it possible to add a test like booting a "real" OS and replaying
>>>>> it?
>>>> Yes - for these bigger more complex setups we should use the acceptance
>>>> tests that run under Avocado. See "make check-acceptance".
>>> I've installed avocado and avocado-framework, but got the following 
>>> error:
>>>
>>> venv/bin/python: No module named avocado
>> Hmm make check-acceptance should automatically setup local copies of
>> avocado using virtualenv. You shouldn't need to install the system
>> version.
>>
> 
> What should I try then?

My workflow running selected tests is:

$ git clone qemu
$ mkdir qemu/build
$ cd qemu/build
qemu/build$ ../configure
qemu/build$ make arm-softmmu/all
qemu/build$ make check-venv
qemu/build$ tests/venv/bin/python -m avocado \
             --show=app,console -t machine:virt \
             run tests/acceptance/

'make check-acceptance' runs all the tests for the available QEMU 
targets built. It should call check-venv automatically.


