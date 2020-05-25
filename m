Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F59C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8051F2073B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGB9GrMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8051F2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdErm-0002UD-D8
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEqG-0000wP-48
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:16:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47522
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEqD-0001Dh-78
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590419795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nT4lpgYSMGD7ErgeHtGAF5Bm8H60TquL5i1tc51ad4g=;
 b=XGB9GrMUk/y2q+CIkcTGBdLckp4U7oqB48Inp1PfO1zFSGSG1DqaAAHqBkv1BUIDfN03Q7
 WHWPxeZriCL5b+IZDIkmvqVsN6VzwKleIDzyZ10yRmrcTLsx9/BWhflRWuydNz+R19/9L0
 LQOmNNnEvx4iwlliM0jrpEDkSDjp0Rk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-H37U8Ux5Mq6BHvjEPMAZdA-1; Mon, 25 May 2020 11:16:31 -0400
X-MC-Unique: H37U8Ux5Mq6BHvjEPMAZdA-1
Received: by mail-ed1-f70.google.com with SMTP id f10so7587429edn.10
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 08:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=nT4lpgYSMGD7ErgeHtGAF5Bm8H60TquL5i1tc51ad4g=;
 b=hr8sp9o25EP43WMszF8XjVExraDze1RQBcC4MHC8kPzwFLDU6ifrSJgcAl690KFIjS
 WaFRqDSocOagOaohFfiFxDuEYWCzOzgi2QtkSgDDVFnC49zZimEvgSZV2i0cHk3AqlT0
 8JccC8kOUEfP6vYkgtj43uSdBYXXeAsxEpKj8aO6qYwHQS768ypuxoBiNwZYPtdzATVK
 /6K94A81Xy4l/u4FXKAlZi3B06La0SGPBd1NsXiF5CV0cqi0igFi+fdvw98S5ixFRy+h
 uUz02WE6HwpwQlihNuqyzk2CQh+tFJk81Rj+k1QSiheZ1zfJ9SiYQgqOQ3A5wzfpBHPQ
 Acgw==
X-Gm-Message-State: AOAM533kkiVtfD/Tm1Z7QFa6PyewjVd+U45mEpEgr2EOD4ZDgL4qT2Up
 TUYIwX4Yq0E5n2eUJHhBygKnBvg+tcLzt69nyMgFwhYRjZ8BGlCiIUhaOQRc/dBzLucu0z5oZ+u
 3HcDn2DEA0Oj49yQ=
X-Received: by 2002:a17:906:1c10:: with SMTP id
 k16mr18366455ejg.511.1590419790556; 
 Mon, 25 May 2020 08:16:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcsNVxzkHyldsbmzLkvtOJ4GgNIccNy/Nz4ppg/HZvtm7DTipZRFQw2pJijnvfdbZ2owCQwQ==
X-Received: by 2002:a17:906:1c10:: with SMTP id
 k16mr18366435ejg.511.1590419790343; 
 Mon, 25 May 2020 08:16:30 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id rn17sm15547967ejb.115.2020.05.25.08.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 08:16:29 -0700 (PDT)
Subject: Re: [RFC v3 3/4] cpu-timers, icount: new modules
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20200525145440.29728-1-cfontana@suse.de>
 <20200525145440.29728-4-cfontana@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <1a4eb7bb-9b92-7536-9de3-a7e56afd9da4@redhat.com>
Date: Mon, 25 May 2020 17:16:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200525145440.29728-4-cfontana@suse.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:44:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Roman Bolshakov <r.bolshakov@yadro.com>, haxm-team@intel.com,
 Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 4:54 PM, Claudio Fontana wrote:
> refactoring of cpus.c continues with cpu timer state extraction.
> 
> cpu-timers: responsible for the cpu timers state, and for access to
> cpu clocks and ticks.
> 
> icount: counts the TCG instructions executed. As such it is specific to
> the TCG accelerator. Therefore, it is built only under CONFIG_TCG.
> 
> One complication is due to qtest, which misuses icount to warp time
> (qtest_clock_warp). In order to solve this problem, detach instead qtest
> from icount, and use a trivial separate counter for it.
> 
> This requires fixing assumptions scattered in the code that
> qtest_enabled() implies icount_enabled().
> 
> No functionality change.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  accel/qtest.c                |   6 +-
>  accel/tcg/cpu-exec.c         |  43 ++-
>  accel/tcg/tcg-all.c          |   7 +-
>  accel/tcg/translate-all.c    |   3 +-
>  docs/replay.txt              |   6 +-
>  exec.c                       |   4 -
>  hw/core/ptimer.c             |   6 +-
>  hw/i386/x86.c                |   1 +
>  include/exec/cpu-all.h       |   4 +
>  include/exec/exec-all.h      |   4 +-
>  include/qemu/timer.h         |  22 +-
>  include/sysemu/cpu-timers.h  |  72 +++++
>  include/sysemu/cpus.h        |  12 +-
>  include/sysemu/qtest.h       |   2 +
>  include/sysemu/replay.h      |   4 +-
>  replay/replay.c              |   6 +-
>  softmmu/Makefile.objs        |   2 +
>  softmmu/cpu-timers.c         | 267 ++++++++++++++++
>  softmmu/cpus.c               | 731 +------------------------------------------
>  softmmu/icount.c             | 496 +++++++++++++++++++++++++++++
>  softmmu/qtest.c              |  34 +-
>  softmmu/timers-state.h       |  45 +++
>  softmmu/vl.c                 |   8 +-
>  stubs/Makefile.objs          |   3 +-
>  stubs/clock-warp.c           |   4 +-
>  stubs/cpu-get-clock.c        |   3 +-
>  stubs/cpu-get-icount.c       |  21 --
>  stubs/icount.c               |  22 ++
>  stubs/qemu-timer-notify-cb.c |   8 +
>  stubs/qtest.c                |   5 +
>  target/alpha/translate.c     |   3 +-
>  target/arm/helper.c          |   7 +-
>  target/riscv/csr.c           |   8 +-
>  tests/ptimer-test-stubs.c    |   7 +-
>  tests/test-timed-average.c   |   2 +-
>  util/main-loop.c             |   4 +-
>  util/qemu-timer.c            |  12 +-
>  37 files changed, 1062 insertions(+), 832 deletions(-)
>  create mode 100644 include/sysemu/cpu-timers.h
>  create mode 100644 softmmu/cpu-timers.c
>  create mode 100644 softmmu/icount.c
>  create mode 100644 softmmu/timers-state.h
>  delete mode 100644 stubs/cpu-get-icount.c
>  create mode 100644 stubs/icount.c
>  create mode 100644 stubs/qemu-timer-notify-cb.c

Similarly I'd rather see this patch comes before your current #1 "move
softmmu only files from root". Anyway wait for other reviewers before
spending time to reorder the series.


