Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488FEC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 02:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A7821655
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 02:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A7821655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifwww-0006YW-AJ
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 21:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <julien.grall.oss@gmail.com>) id 1ifvOL-0004Sz-9Z
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 19:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julien.grall.oss@gmail.com>) id 1ifvOJ-0003uJ-OD
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 19:34:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <julien.grall.oss@gmail.com>)
 id 1ifvOJ-0003ty-Hy
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 19:34:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so625471wmc.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 16:34:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZH/tB32VwDWBcIO+jyMZHCZ/gY+cgypzth0Gb94tIZ8=;
 b=c/UV8R3HVtiBvGoaI8PdSRuJB9D5GdSTBnLG70Cl5ThpRd8f5dm4jjfBarji6yWFfO
 yOH3PfwK3zCquTQl9okhl3P+52IBrJF89fZhc2Nn0jx0PFGbGo4Q1jpSrSkqUaaLHb0k
 7yUF2dvRMELZg1/f05roVAJfXp/xnt5JrWkrmwHQoXw5Dko5pnvwzOC2ndPBJd8/4Vgr
 hIIIs3ZHZS1sYX1U9r5t19co5mqZF2d6yeXfaq+ERKaEp0GYBfTHrjnzVwHjenKvQjq3
 aTdJd+jWMG0RqSUR2N42qwEEqZYTHgSYlOqKmbUlJi/y9N8KUIr/ogtLoauaU9o11ndc
 ukYw==
X-Gm-Message-State: APjAAAXYrBW+GREU0LwXle1XUUMzjutYf/z6X9Sv5dty8Al6XgRfaXoD
 F4ZoZhgpcsx/qnHlAXZR/S4Ztx1kW7w=
X-Google-Smtp-Source: APXvYqxoFm3nJNtpmA00EH9GTcs0FElV3akt62kTgHGRqlzZXagNWnXTXEYZ2wkS2cKce3EboBdh5g==
X-Received: by 2002:a05:600c:24d1:: with SMTP id
 17mr16533141wmu.151.1576283677969; 
 Fri, 13 Dec 2019 16:34:37 -0800 (PST)
Received: from a483e7b01a66.ant.amazon.com (54-240-197-230.amazon.com.
 [54.240.197.230])
 by smtp.gmail.com with ESMTPSA id a184sm12388953wmf.29.2019.12.13.16.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 16:34:37 -0800 (PST)
Subject: xen-block: race condition when stopping the device (WAS: Re:
 [Xen-devel] [xen-4.13-testing test] 144736: regressions - FAIL)
To: "Durrant, Paul" <pdurrant@amazon.com>, Ian Jackson <ian.jackson@citrix.com>
References: <osstest-144736-mainreport@xen.org>
 <e05a3bc4-2c1d-7e71-af42-d6362c4f6d07@suse.com>
 <6ea2af3c-b277-1118-7c83-ebcb0809d449@xen.org>
 <24051.30893.31444.319978@mariner.uk.xensource.com>
 <7a0ef296-eb50-fbda-63e2-8d890fad5111@xen.org>
 <a65ae7dca64f4f718f116b9174893730@EX13D32EUC003.ant.amazon.com>
From: Julien Grall <julien@xen.org>
Message-ID: <65df8a75-a658-1a14-6780-66c8706bcc80@xen.org>
Date: Sat, 14 Dec 2019 00:34:36 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <a65ae7dca64f4f718f116b9174893730@EX13D32EUC003.ant.amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
X-Mailman-Approved-At: Fri, 13 Dec 2019 21:13:09 -0500
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
Cc: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org,
 osstest service owner <osstest-admin@xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paul,

On 13/12/2019 15:55, Durrant, Paul wrote:
>> -----Original Message-----
>> From: Xen-devel <xen-devel-bounces@lists.xenproject.org> On Behalf Of
>> Julien Grall
>> Sent: 13 December 2019 15:37
>> To: Ian Jackson <ian.jackson@citrix.com>
>> Cc: Jürgen Groß <jgross@suse.com>; xen-devel@lists.xenproject.org; Stefano
>> Stabellini <sstabellini@kernel.org>; osstest service owner <osstest-
>> admin@xenproject.org>; Anthony Perard <anthony.perard@citrix.com>
>> Subject: Re: [Xen-devel] [xen-4.13-testing test] 144736: regressions -
>> FAIL
>>
>> +Anthony
>>
>> On 13/12/2019 11:40, Ian Jackson wrote:
>>> Julien Grall writes ("Re: [Xen-devel] [xen-4.13-testing test] 144736:
>> regressions - FAIL"):
>>>> AMD Seattle boards (laxton*) are known to fail booting time to time
>>>> because of PCI training issue. We have workaround for it (involving
>>>> longer power cycle) but this is not 100% reliable.
>>>
>>> This wasn't a power cycle.  It was a software-initiated reboot.  It
>>> does appear to hang in the firmware somewhere.  Do we expect the pci
>>> training issue to occur in this case ?
>>
>> The PCI training happens at every reset (including software). So I may
>> have confused the workaround for firmware corruption with the PCI
>> training. We definitely have a workfround for the former.
>>
>> For the latter, I can't remember if we did use a new firmware or just
>> hope it does not happen often.
>>
>> I think we had a thread on infra@ about the workaround some times last
>> year. Sadly this was sent on my Arm e-mail address and I didn't archive
>> it before leaving :(. Can you have a look if you can find the thread?
>>
>>>
>>>>>>     test-armhf-armhf-xl-vhd      18 leak-check/check         fail
>> REGR.
>>>>>> vs. 144673
>>>>>
>>>>> That one is strange. A qemu process seems to have have died producing
>>>>> a core file, but I couldn't find any log containing any other
>> indication
>>>>> of a crashed program.
>>>>
>>>> I haven't found anything interesting in the log. @Ian could you set up
>>>> a repro for this?
>>>
>>> There is some heisenbug where qemu crashes with very low probability.
>>> (I forget whether only on arm or on x86 too).  This has been around
>>> for a little while.  I doubt this particular failure will be
>>> reproducible.
>>
>> I can't remember such bug been reported on Arm before. Anyway, I managed
>> to get the stack trace from gdb:
>>
>> Core was generated by `/usr/local/lib/xen/bin/qemu-system-i386
>> -xen-domid 1 -chardev socket,id=libxl-c'.
>> Program terminated with signal SIGSEGV, Segmentation fault.
>> #0  0x006342be in xen_block_handle_requests (dataplane=0x108e600) at
>> /home/osstest/build.144736.build-armhf/xen/tools/qemu-xen-
>> dir/hw/block/dataplane/xen-block.c:531
>> 531
>> /home/osstest/build.144736.build-armhf/xen/tools/qemu-xen-
>> dir/hw/block/dataplane/xen-block.c:
>> No such file or directory.
>> [Current thread is 1 (LWP 1987)]
>> (gdb) bt
>> #0  0x006342be in xen_block_handle_requests (dataplane=0x108e600) at
>> /home/osstest/build.144736.build-armhf/xen/tools/qemu-xen-
>> dir/hw/block/dataplane/xen-block.c:531
>> #1  0x0063447c in xen_block_dataplane_event (opaque=0x108e600) at
>> /home/osstest/build.144736.build-armhf/xen/tools/qemu-xen-
>> dir/hw/block/dataplane/xen-block.c:626
>> #2  0x008d005c in xen_device_poll (opaque=0x107a3b0) at
>> /home/osstest/build.144736.build-armhf/xen/tools/qemu-xen-dir/hw/xen/xen-
>> bus.c:1077
>> #3  0x00a4175c in run_poll_handlers_once (ctx=0x1079708,
>> timeout=0xb1ba17f8) at
>> /home/osstest/build.144736.build-armhf/xen/tools/qemu-xen-dir/util/aio-
>> posix.c:520
>> #4  0x00a41826 in run_poll_handlers (ctx=0x1079708, max_ns=8000,
>> timeout=0xb1ba17f8) at
>> /home/osstest/build.144736.build-armhf/xen/tools/qemu-xen-dir/util/aio-
>> posix.c:562
>> #5  0x00a41956 in try_poll_mode (ctx=0x1079708, timeout=0xb1ba17f8) at
>> /home/osstest/build.144736.build-armhf/xen/tools/qemu-xen-dir/util/aio-
>> posix.c:597
>> #6  0x00a41a2c in aio_poll (ctx=0x1079708, blocking=true) at
>> /home/osstest/build.144736.build-armhf/xen/tools/qemu-xen-dir/util/aio-
>> posix.c:639
>> #7  0x0071dc16 in iothread_run (opaque=0x107d328) at
>> /home/osstest/build.144736.build-armhf/xen/tools/qemu-xen-
>> dir/iothread.c:75
>> #8  0x00a44c80 in qemu_thread_start (args=0x1079538) at
>> /home/osstest/build.144736.build-armhf/xen/tools/qemu-xen-dir/util/qemu-
>> thread-posix.c:502
>> #9  0xb67ae5d8 in ?? ()
>> Backtrace stopped: previous frame identical to this frame (corrupt stack?)
>>
>> This feels like a race condition between the init/free code with
>> handler. Anthony, does it ring any bell?
>>
> 
>  From that stack bt it looks like an iothread managed to run after the sring was NULLed. This should not be able happen as the dataplane should have been moved back onto QEMU's main thread context before the ring is unmapped.

My knowledge of this code is fairly limited, so correct me if I am wrong.

blk_set_aio_context() would set the context for the block aio. AFAICT, 
the only aio for the block is xen_block_complete_aio().

In the stack above, we are not dealing with a block aio but an aio tie 
to the event channel (see the call from xen_device_poll). So I don't 
think the blk_set_aio_context() would affect the aio.

So it would be possible to get the iothread running because we received 
a notification on the event channel while we are stopping the block (i.e 
xen_block_dataplane_stop()).

If xen_block_dataplane_stop() grab the context lock first, then the 
iothread dealing with the event may wait on the lock until its released.

By the time the lock is grabbed, we may have free all the resources 
(including srings). So the event iothread will end up to dereference a 
NULL pointer.

It feels to me we need a way to quiesce all the iothreads (blk, 
event,...) before continuing. But I am a bit unsure how to do this in QEMU.

Cheers,

-- 
Julien Grall

