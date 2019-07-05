Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46054C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 17:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20EA720989
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 17:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EA720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjSQF-0002X5-7o
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 13:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34475)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjSOg-0001XX-1U
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 13:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjSOe-0000uu-59
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 13:53:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35877)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hjSOc-0000ki-FF
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 13:53:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so4302769wme.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 10:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KxU9EGIdr0ZhJPrxWzl1G/6UVXOSN7YR3TK/ZbMcplY=;
 b=rmNQoz1Ar4fOjwNqzqQwisR3Pn2e6YBPJKu6zumInrKA9Erzu1b0e/T987e6iG7Q0b
 352YQOfUXcg5ZzoNAvpdtZ+zkWgK+2R7BC9tL84BkvM62EDna5dQWX83tHx2J9WDGIY5
 LYYr7e3fhZSiJpcxyGNWmRWTpqTUlZLVItKS2EJKV7Kq6Q4JtVzkA4X5qiShBWW5UDc0
 KKpHbwMBs4Egwww/lotFnMd6bvnTL3W+lgkyOfTw6jH4ilYzNMZ71/98hdf5ctnupIM/
 Kbdjw20fIPtQ+N0dzMCWaxuP65ckoABH8hY2BGzlX7HVMG/d5PGZgUKUf3boTjfZKua2
 ILLg==
X-Gm-Message-State: APjAAAUPE67bwZaxPl81wGi3RSvU7/MKIPz1+IkkWXagxbBrRqlhdlPb
 cnFgPI9e9bYTp6NXC86hoHNVcUmdgW0=
X-Google-Smtp-Source: APXvYqya8ziE0f6oDK2rwYhmmFvhFFham/RoPNMSrd2CdbOyys11GsMIYATsXa1DtIldhLTWf26MMw==
X-Received: by 2002:a1c:dc07:: with SMTP id t7mr4472810wmg.164.1562349191490; 
 Fri, 05 Jul 2019 10:53:11 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id f7sm8309795wrv.38.2019.07.05.10.53.10
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 10:53:10 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <20190703171005.26231-1-philmd@redhat.com>
 <20190703172501.GI23082@redhat.com>
 <20190704102457.GE1609@stefanha-x1.localdomain>
 <20190704102837.GA24190@redhat.com>
 <20190705080717.GD10995@stefanha-x1.localdomain>
 <8470a203-430b-1814-b2ef-6adf3fa739a6@redhat.com>
 <87d0iok4ai.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c4997dee-932c-eb57-23b9-4b51e8856f91@redhat.com>
Date: Fri, 5 Jul 2019 19:53:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87d0iok4ai.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [RFC PATCH-for-4.2] tracing: Allow to tune tracing
 options via the environment
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/19 3:19 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>> On 7/5/19 10:07 AM, Stefan Hajnoczi wrote:
>>> On Thu, Jul 04, 2019 at 11:28:37AM +0100, Daniel P. Berrangé wrote:
>>>> On Thu, Jul 04, 2019 at 11:24:57AM +0100, Stefan Hajnoczi wrote:
>>>>> On Wed, Jul 03, 2019 at 06:25:01PM +0100, Daniel P. Berrangé wrote:
>>>>>> On Wed, Jul 03, 2019 at 07:10:05PM +0200, Philippe Mathieu-Daudé wrote:
>>>>>>> We can pass trace trace options with the -trace command line
>>>>>>> argument.
>>>>>>>
>>>>>>> Tracing might be useful when running qtests. To avoid to have
>>>>>>> to modify the tests and recompile, add the possibility to pass
>>>>>>> trace options via the shell environment.
> 
> Unless I'm missing something, you don't have to recompile to pass
> additional options.  The qtest binaries already read environment
> variables QTEST_QEMU_BINARY and QTEST_QEMU_IMG.  Have them point to
> suitable wrappers.
> 
> Perhaps there's still a need for a more convenient way.
> 
>>>>>>>
>>>>>>> We add:
>>>>>>> - QEMU_TRACE_EVENTS:    List of events to enable (coma separated)
>>>>>>> - QEMU_TRACE_EVENTFILE: File with list of events to enable
>>>>>>> - QEMU_TRACE_LOGFILE:   File to log the trace events.
>>>>>>>
>>>>>>> Example of use:
>>>>>>>
>>>>>>>   $ QEMU_TRACE_EVENTS=pl011\* make check-qtest-arm
>>>>>>>     TEST    check-qtest-arm: tests/boot-serial-test
>>>>>>>   18650@1562168430.027490:pl011_can_receive LCR 0x00000000 read_count 0 returning 1
>>>>>>>   18650@1562168430.027535:pl011_can_receive LCR 0x00000000 read_count 0 returning 1
>>>>>>>   18650@1562168430.027544:pl011_can_receive LCR 0x00000000 read_count 0 returning 1
>>>>>>>   18650@1562168430.028037:pl011_can_receive LCR 0x00000000 read_count 0 returning 1
>>>>>>>   18650@1562168430.028049:pl011_can_receive LCR 0x00000000 read_count 0 returning 1
>>>>>>>   18650@1562168430.028057:pl011_can_receive LCR 0x00000000 read_count 0 returning 1
>>>>>>>   18653@1562168430.053250:pl011_write addr 0x00000000 value 0x00000054
>>>>>>>   18653@1562168430.053276:pl011_irq_state irq state 0
>>>>>>>   [...]
>>>>>>>
>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>>>> ---
>>>>>>> I'm not sure where to document that...
>>>>>>> ---
>>>>>>>  trace/control.c | 9 +++++++++
>>>>>>>  1 file changed, 9 insertions(+)
>>>>>>>
>>>>>>> diff --git a/trace/control.c b/trace/control.c
>>>>>>> index 43fb7868db..aea802623c 100644
>>>>>>> --- a/trace/control.c
>>>>>>> +++ b/trace/control.c
>>>>>>> @@ -288,6 +288,8 @@ void trace_fini_vcpu(CPUState *vcpu)
>>>>>>>  
>>>>>>>  bool trace_init_backends(void)
>>>>>>>  {
>>>>>>> +    char *trace_env;
>>>>>>> +
>>>>>>>  #ifdef CONFIG_TRACE_SIMPLE
>>>>>>>      if (!st_init()) {
>>>>>>>          fprintf(stderr, "failed to initialize simple tracing backend.\n");
>>>>>>> @@ -306,6 +308,13 @@ bool trace_init_backends(void)
>>>>>>>      openlog(NULL, LOG_PID, LOG_DAEMON);
>>>>>>>  #endif
>>>>>>>  
>>>>>>> +    trace_init_file(getenv("QEMU_TRACE_LOGFILE"));
>>>>>>> +    trace_init_events(getenv("QEMU_TRACE_EVENTFILE"));
>>>>>>> +    trace_env = getenv("QEMU_TRACE_EVENTS");
>>>>>>> +    if (trace_env) {
>>>>>>> +        trace_enable_events(trace_env);
>>>>>>> +    }
>>>>>>> +
>>>>>>
>>>>>> I don't think it is a nice idea to add this via environment variables
>>>>>> to QEMU itself. Why not modify libqtest qtest_init_without_qmp_handshake
>>>>>> to read the env vars and then pass a suitable -trace arg when spawning
>>>>>> QEMU ?
>>>>>
>>>>> What is the concern about adding these environment variables to QEMU?
>>>>>
>>>>> It is convenient to be able to use tracing even if QEMU is invoked by
>>>>> something you cannot modify/control.
>>>>>
>>>>> The main issues I see with environment variables are:
>>>>>
>>>>> 1. Security.  Is there a scenario where an attacker can use environment
>>>>>    variables to influence the behavior of a QEMU process running at a
>>>>>    different trust level?
> 
> The common (and sad) solution for this is to require whatever runs $PROG
> at a different trust level to scrub the environment.

I hope people concerned by security build QEMU with the NOP trace backend.

>>>>> 2. Name collision.  What is the chance that existing users already
>>>>>    define environment variables with these names and that unexpected
>>>>>    behavior could result?
>>>>
>>>> One of the biggest problems with QEMU in general has been poorly modelled
>>>> & defined interfaces for configuration. At runtime we've solved this with
>>>> QMP. At startup we're still fighting the horror of QemuOpts in general and
>>>> haven't got startup modelling to be on a par with that offered by QEMU.
>>>> It was even worse when Audio didn't even use QemuOpts and instead used
>>>> an arbitrary set of poorly defined env variables. To me adding yet another
>>>> way to configure QEMU via env vars is moving in the opposite direction to
>>>> what we want.
>>>
>>> In this case the environment variables are optional and meant for cases
>>> where the user cannot change the QEMU command-line.  I think they serve
>>> a different purpose from the audio subsystem environment variables and
>>> I'd be happy to merge them.
> 
> You're right, there is a difference between "also" and "only".  Audio
> could only be configured via environment, and that was without doubt
> awful.  Does not imply permitting trace configuration via environment
> also would be similarly awful.
> 
> However, adding special cases as needed is what got us into the startup
> mess Dan highlighted.  Are we confident tracing will remain the only
> thing we also want to configure via environment?
> 
> I sympathize with Dan's plea for more uniform configuration interfaces.

I understand. It would be clearer to have this position documented in
HACKING.

>>> Philippe: Have you tried adding the environment variable to libqtest as
>>> Dan suggested and did it work for your use case?
> 
> This would fit into our existing use of the environment with qtest.  Try
> grep '"QTEST_'.
> 
>> Yes, but we loose the ability to use this feature from linux-user and
>> other tools:
>>
>> $ git grep trace_opt_parse
>> bsd-user/main.c:851:            trace_file = trace_opt_parse(optarg);
>> linux-user/main.c:387:    trace_file = trace_opt_parse(arg);
>> qemu-img.c:5063:            trace_file = trace_opt_parse(optarg);
>> qemu-io.c:579:            trace_file = trace_opt_parse(optarg);
>> qemu-nbd.c:862:            trace_file = trace_opt_parse(optarg);
>> scsi/qemu-pr-helper.c:969:            trace_file = trace_opt_parse(optarg);
>> vl.c:3730:                trace_file = trace_opt_parse(optarg);
>>
>> So I'm now mixed about the trade off regarding Daniel worries.
> 
> Philippe, your commit message mentions just qtest.  That use case would
> be covered by Dan's suggestion, wouldn't it?  If not, please explain.
> If you have additional use cases, please state them.

I'm fine with qtests. I was thinking on how sometimes I use ld.so's
LD_DEBUG env var, and thought it might be useful to use it a similar
way, but in a test environment (not restricted to qtests, but also
avocado tests and docker tests).
We can modify each type of test to use the '-trace' command line
argument. While it is a bit more of work, I understand the design
motivations to have a uniform interface.

Thanks,

Phil.

