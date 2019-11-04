Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D25DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 12:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A34218BA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 12:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rSf4Wf57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A34218BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRbFq-0006AD-Ft
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 07:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iRbFC-0005ic-6B
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 07:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iRbFA-0003fb-FX
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 07:14:01 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:34730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iRbFA-0003e3-4k
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 07:14:00 -0500
Received: by mail-wm1-x330.google.com with SMTP id v3so13895447wmh.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 04:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+lr026ViL5pP9sUZ3TRnWegeVegWWlpZ5aPe8Lgdc9E=;
 b=rSf4Wf57I7N0KlsDdCR/nTY9Hz9Nj6h7RG7jSHWiXwOE75y2n/XVXjtgI5PaVbzNI0
 AFtQXUY9XZyICHaOCPbVZlin+0RXuwOEvII3Xaq86ZCFljkl8TcIdjDaaCc+yXD8/kEA
 Meaoh2A22ZQEN7SK9xKShslYAMZAilDrwyAHPUxwjGWK6btn1PKTNE8TYNwGhAeMX1Lo
 r8iJO6KbTWrKFY6MGvHZ4s7NCt7lMJqBVrSk5tAVuxU0Ienq49NoKwpsSWuUstGDMhzm
 26jZGfRGTgBK1adf0azdmbsn29gifRGNL74Xe+8DDyQfyKeEo3FqhyXu2Cl7xv+8Kmfb
 jlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+lr026ViL5pP9sUZ3TRnWegeVegWWlpZ5aPe8Lgdc9E=;
 b=WqBJqPI+Bto2O/XIijXA3u1NmJtJxs+igNTL/g8c1NffuTW39v2KlKT9+lwADDYESe
 k7hyHMG/vaPgze3jrB/UBcSvbkmiUn3hivQrE2TwCCFgsSChsvZWPQakklY0gRO/Kkn6
 tOtgrwLfIknV5ISlW2Hw6RxIE552Pp7J15YuVPGw9nAxF5PvmExtFpBqhDubco1uW3IJ
 q4VHqzFGbyoltUQ7BLxDjuqy7B5EiSfKoFBj9LFCtJ4VqyVAWhQchNhunweTbABOOt2Z
 3bVs9N2FoLVj0GebWQ3IwmPmtEoAGhsUiyVtFjcVQev6mDgxENE9j2Qh12nZPt7bbZ9K
 YtIw==
X-Gm-Message-State: APjAAAWGjloS5uR75LZ4I7GJos3G5M0j8GV0pcdjHUWjIMadyG33jLas
 TrHEu+Tq/lJiReapfqvMaxmAjA==
X-Google-Smtp-Source: APXvYqxCeBGgE4okRWM5P1QAi6cBGxcKUpnqlrNaFHmLV1RsKhdNSJoPVSfqO4Lfh647s7Y/ipZU8Q==
X-Received: by 2002:a1c:c28a:: with SMTP id
 s132mr22234938wmf.162.1572869638483; 
 Mon, 04 Nov 2019 04:13:58 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 14sm4742136wrc.65.2019.11.04.04.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 04:13:57 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6DBC71FF87;
 Mon,  4 Nov 2019 12:13:56 +0000 (GMT)
References: <CAEyhzFtb6Gn86VkR+BXbUPsHLtfbjDwotwZXDVyLCMjbrTXWrA@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: logfile issue
In-reply-to: <CAEyhzFtb6Gn86VkR+BXbUPsHLtfbjDwotwZXDVyLCMjbrTXWrA@mail.gmail.com>
Date: Mon, 04 Nov 2019 12:13:56 +0000
Message-ID: <87tv7jkfej.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Cc: Peter Puhov <peter.puhov@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> We hit an issue when trying to change the log file from the monitor
> console.  The root of the issue here is that the qemu_logfile handle
> is not thread safe.  So when we try to close the file, we end up with
> a seg fault.  The full analysis is below along with some possible
> solutions.
> Will plan to post a patch soon, but any comments or opinions on our
> proposed solution would be appreciated.  Thanks.
>
> The version of QEMU we are using is: master as of about Oct 15,
> 9020e9526cd08c4dc99d54dba48730de2908c970.
>
> This is what we did to reproduce the issue.
> First we enable logging and select the log file.
> (qemu) log in_asm,out_asm,op
> (qemu) logfile asm.out
>
> Then we start this command in the guest.  This just keeps the guest
> performing operations that result in logging to be constantly
> generated.
> $ for i in {0..1000}; do ls -l; done
>
> Next we switch to the monitor console and change the file.
> (qemu) logfile asm_new.log
>
> This action causes a seg fault.  Please see the stack trace (below).
>
> The code, which changes the log file unconditionally
> (qemu_set_log_filename()), closes the qemu_logfile, sets it to NULL,
> and then opens the new file.
> Since the file handle is still in use, we end up with a seg fault when
> the code which is trying to log ends up using a NULL file handle.

Yep, good catch.

> We are considering a few solutions.
>
> A straightforward solution would be to simply prevent the file from
> being changed while logging is enabled.  In other words, force the
> user to first disable logging before changing the log file.
> This solution seems to cover the general case.  However, if a user
> were to disable logging and change the log file in quick succession,
> we would still be subject to a similar race.  A log call could still
> make it through the logging enable check and proceed to use a file
> handle that gets changed to NULL.
>
> Another option is to add a mutex to prevent the qemu_logfile handle
> from being changed while it is in use.  This certainly works and has
> the advantage of being fairly straightforward.  Also we are thinking
> that since the mutex would only be used when logging is enabled it has
> the advantage of not having an effect on the normal case performance.
> Another option is to implement a simple atomic ref count and prevent
> the file from being changed while there are outstanding references.

The mutex is the simplest but I wonder if it show up on heavy usage? The
log file is already doing file locking for the areas that want
contiguous log statements.

I wonder if using RCU to swap out the new and old FD would make things a
bit smoother here? You would have to tweak the qemu_log_lock/unlock
functions to preserve the current FD around the lock and call_rcu a
freeing function when a new handle is set.

> We are leaning towards the mutex option, and plan to post a patch
> soon, but would appreciate comments or opinions on this solution.
>
> Thanks,
> Rob Foley
>
> stack trace
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Thread 10 "qemu-system-aar" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0xffff113f9d90 (LWP 9493)] __flockfile
> (stream=3D0x0) at ../sysdeps/pthread/flockfile.c:27
> 27 ../sysdeps/pthread/flockfile.c: No such file or directory.
> (gdb) bt
> #0  __flockfile (stream=3D0x0) at ../sysdeps/pthread/flockfile.c:27
> #1  0x0000aaaae0fac8b8 in qemu_flockfile (f=3D<optimized out>) at
> /home/rob/qemu/qemu_unchanged/include/sysemu/os-posix.h:87
> #2  qemu_log_lock () at /home/rob/qemu/qemu_unchanged/include/qemu/log.h:=
57
> #3  translator_loop (ops=3D0xaaaae17f1348 <aarch64_translator_ops>,
> db=3D0xffff113f9088, db@entry=3D0xffff113f9098,
> cpu=3Dcpu@entry=3D0xaaab0a52bc50,
>     tb=3Dtb@entry=3D0xffff4c92d000 <code_gen_buffer+814927796>,
> max_insns=3Dmax_insns@entry=3D512) at
> /home/rob/qemu/qemu_unchanged/accel/tcg/translator.c:121
> #4  0x0000aaaae10c1c18 in gen_intermediate_code
> (cpu=3Dcpu@entry=3D0xaaab0a52bc50, tb=3Dtb@entry=3D0xffff4c92d000
> <code_gen_buffer+814927796>, max_insns=3Dmax_insns@entry=3D512)
>     at /home/rob/qemu/qemu_unchanged/target/arm/translate.c:11320
> #5  0x0000aaaae0fab248 in tb_gen_code (cpu=3D0xaaab0a52bc50,
> cpu@entry=3D0xffffabe2a000, pc=3D187650897458448, cs_base=3D65536,
> flags=3D43690, cflags=3D-16252928, cflags@entry=3D524288)
>     at /home/rob/qemu/qemu_unchanged/accel/tcg/translate-all.c:1738
> #6  0x0000aaaae0fa8e74 in tb_find (cf_mask=3D524288, tb_exit=3D0,
> last_tb=3D0xffff4c92cc40 <code_gen_buffer+814926836>,
> cpu=3D0xffffabe2a000)
>     at /home/rob/qemu/qemu_unchanged/accel/tcg/cpu-exec.c:408
> #7  cpu_exec (cpu=3D0xffffabe2a000, cpu@entry=3D0xaaab0a52bc50) at
> /home/rob/qemu/qemu_unchanged/accel/tcg/cpu-exec.c:730
> #8  0x0000aaaae0f6de24 in tcg_cpu_exec (cpu=3D0xaaab0a52bc50) at
> /home/rob/qemu/qemu_unchanged/cpus.c:1454
> #9  0x0000aaaae0f70908 in qemu_tcg_cpu_thread_fn (arg=3D0xaaab0a52bc50)
> at /home/rob/qemu/qemu_unchanged/cpus.c:1762
> #10 0x0000aaaae145bd38 in qemu_thread_start (args=3D<optimized out>) at
> /home/rob/qemu/qemu_unchanged/util/qemu-thread-posix.c:519
> #11 0x0000ffffabe0a088 in start_thread (arg=3D0xffffcc20410f) at
> pthread_create.c:463
> #12 0x0000ffffabd7a4ec in thread_start () at
> ../sysdeps/unix/sysv/linux/aarch64/clone.S:78


--
Alex Benn=C3=A9e

