Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CF1C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED4720578
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4blRKKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED4720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Yzf-0000gW-9y
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1Yya-0008DS-Rh
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1YyZ-0004eR-5M
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:05:32 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35603)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1YyY-0004ck-WD
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:05:31 -0500
Received: by mail-ot1-x341.google.com with SMTP id r16so10867850otd.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G1jURSo5T7R3/OVg1l3JWmam1EdHXtX+kNZhPKvN5hU=;
 b=e4blRKKF2IeJwfd9ihwleXHdVAaGGU0/1oxHWC0vtSnUjhyPHH+nKcwKj/L5E5JubX
 WLDikO85BzX/D+Qy+iNtdZ2lyOAQXLxTPxInH1hi64yNfNeN8waYd4bLKNuflVKivzyz
 IhJNqCEDd9PhG5C7FwkmSlTKOp5s+fNAzWlgUDAKMyWzJ3nC5RiYFi9nVmPp8viso7gf
 k6qzqmwBNxe1ULkS1K3eWbZ3xMLfqHhSW+GMjTLmj4XmKYLNjQZGt1/pH9D/aks8XRoZ
 a8T5gF5HF1gmMjsVVLTUubQAhhk557MjWx6h+U6YfTbugj+yRIKIb6Kh4kgzSy2/KV1J
 heSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G1jURSo5T7R3/OVg1l3JWmam1EdHXtX+kNZhPKvN5hU=;
 b=YXWgWzQKeTSssBpv6++xf/ThRBsM2ryF2rRm8IFT+TZHXw0Xn9hg3NIqDdv3Y3JBgI
 f0WL2j4oj2HM4fL/XRthkrgIpavzrqy7lwwIIZ2sZnHC1xRvKClWKPZ8VmFFrDZ2lmwT
 Ep+MoifQxA7ll/MrRKgYLHt8j7BB1G+2rbFEqygnezLY0fFZWMYSC7k1ihQyuzowa9Am
 g3bdWIT5FUpJNHmPVyTRCOs51ENyRR1iQ6wV/pUUku94sxsiOWYeDByQJofLE6ZFn68r
 yU6dVnQUaUywwWihwB+wjfPFCwBIE6allV+hSochay266DmCj67Apng6CPbMMed37Unh
 8UVA==
X-Gm-Message-State: APjAAAWA+zWyt3JO/3EQ7rGYZUQa1wGFyMY0WkxBbKw4hOBpzV3j6cs2
 KJJ3crt05ml5MrMnfP1AxiotwWk9RjIRdbCvzlkZ1g==
X-Google-Smtp-Source: APXvYqxkd+z8hGOxIQla//DLNu7+bTRC5fZjKLL0G6pQIIL5/Aid7mwJSx7863XG5OyxEx53kbBVZebZRPt794Arwfo=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr5683525otq.221.1581440729720; 
 Tue, 11 Feb 2020 09:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20200204171053.1718013-1-laurent@vivier.eu>
 <20200204171053.1718013-5-laurent@vivier.eu>
In-Reply-To: <20200204171053.1718013-5-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2020 17:05:18 +0000
Message-ID: <CAFEAcA_9BGGr7uCqjT7R2jKSWXd6dZkxhtFvgEe4pGOXVbpW_Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] linux-user: fix use of SIGRTMIN
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Marlies Ruck <marlies.ruck@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Josh Kunz <jkz@google.com>, Taylor Simpson <tsimpson@quicinc.com>,
 Matus Kysel <mkysel@tachyum.com>,
 =?UTF-8?B?TWlsb8WhIFN0b2phbm92acSH?= <milos.stojanovic@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Feb 2020 at 17:11, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Some RT signals can be in use by glibc,
> it's why SIGRTMIN (34) is generally greater than __SIGRTMIN (32).
>
> So SIGRTMIN cannot be mapped to TARGET_SIGRTMIN.
>
> Instead of swapping only SIGRTMIN and SIGRTMAX, map all the
> range [TARGET_SIGRTMIN ... TARGET_SIGRTMAX - X] to
>       [__SIGRTMIN + X ... SIGRTMAX ]
> (SIGRTMIN is __SIGRTMIN + X).
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---

In general I think this is a good approach to trying to deal
with this long-standing issue in a pragmatic and not too
complicated way, so thanks for writing this patchset. I have
some fairly minor comments on the code below.

>
> Notes:
>     v2: ignore error when target sig <= TARGET_NSIG but host sig > SIGRTMAX
>         replace i, j by target_sig, host_sig
>         update signal_table_init() trace message
>
>  linux-user/signal.c     | 37 ++++++++++++++++++++++++++++++-------
>  linux-user/trace-events |  3 +++
>  2 files changed, 33 insertions(+), 7 deletions(-)
>
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index c1e664f97a7c..e7e5581a016f 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -498,18 +498,23 @@ static int core_dump_signal(int sig)
>
>  static void signal_table_init(void)
>  {
> -    int host_sig, target_sig;
> +    int host_sig, target_sig, count;
>
>      /*
> -     * Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
> -     * host libpthread signals.  This assumes no one actually uses SIGRTMAX :-/
> -     * To fix this properly we need to do manual signal delivery multiplexed
> -     * over a single host signal.
> +     * some RT signals can be in use by glibc,
> +     * it's why SIGRTMIN (34) is generally greater than __SIGRTMIN (32)
>       */
> -    host_to_target_signal_table[__SIGRTMIN] = __SIGRTMAX;
> -    host_to_target_signal_table[__SIGRTMAX] = __SIGRTMIN;
> +    for (host_sig = SIGRTMIN; host_sig <= SIGRTMAX; host_sig++) {
> +        target_sig = host_sig - SIGRTMIN + TARGET_SIGRTMIN;
> +        if (target_sig <= TARGET_NSIG) {
> +            host_to_target_signal_table[host_sig] = target_sig;
> +        }
> +    }

So the effect of this is that we now support target signals
starting from TARGET_SIGRTMIN and going up until we run out
of host realtime signals that the host libc hasn't reserved ?
That seems reasonable, since glibc at least uses only the
lower 2 rt signals and probably nobody's using the upper ones.
But this would be a good place to have a comment explaining
the limitation (and that if it needed to be fixed we'd have
to multiplex guest signals onto a single host signal). You
could also mention that attempts to configure the "missing"
signals via sigaction will be silently ignored.

>      /* generate signal conversion tables */
> +    for (target_sig = 1; target_sig <= TARGET_NSIG; target_sig++) {
> +        target_to_host_signal_table[target_sig] = _NSIG; /* poison */
> +    }
>      for (host_sig = 1; host_sig < _NSIG; host_sig++) {
>          if (host_to_target_signal_table[host_sig] == 0) {
>              host_to_target_signal_table[host_sig] = host_sig;
> @@ -519,6 +524,15 @@ static void signal_table_init(void)
>              target_to_host_signal_table[target_sig] = host_sig;
>          }
>      }
> +
> +    if (TRACE_SIGNAL_TABLE_INIT_BACKEND_DSTATE()) {

This isn't the right way to conditionalize expensive stuff
that's only used in trace events. You want to use
trace_event_get_state_backends() (see docs/devel/tracing.txt
for details).

> +        for (target_sig = 1, count = 0; target_sig <= TARGET_NSIG; target_sig++) {
> +            if (target_to_host_signal_table[target_sig] == _NSIG) {
> +                count++;
> +            }
> +        }
> +        trace_signal_table_init(count);
> +    }
>  }
>
>  void signal_init(void)
> @@ -817,6 +831,8 @@ int do_sigaction(int sig, const struct target_sigaction *act,
>      int host_sig;
>      int ret = 0;
>
> +    trace_signal_do_sigaction_guest(sig, TARGET_NSIG);
> +
>      if (sig < 1 || sig > TARGET_NSIG || sig == TARGET_SIGKILL || sig == TARGET_SIGSTOP) {
>          return -TARGET_EINVAL;
>      }
> @@ -847,6 +863,13 @@ int do_sigaction(int sig, const struct target_sigaction *act,
>
>          /* we update the host linux signal state */
>          host_sig = target_to_host_signal(sig);
> +        trace_signal_do_sigaction_host(host_sig, TARGET_NSIG);
> +        if (host_sig > SIGRTMAX) {
> +            /* we don't have enough host signals to map all target signals */
> +            qemu_log_mask(LOG_UNIMP, "Unsupported target signal #%d, ignored\n",
> +                          sig);
> +            return 0;

We should have a comment here mentioning why we don't return
an error code here (and explicitly noting that the Go runtime
is the major one which we don't want to upset).

> +        }
>          if (host_sig != SIGSEGV && host_sig != SIGBUS) {
>              sigfillset(&act1.sa_mask);
>              act1.sa_flags = SA_SIGINFO;
> diff --git a/linux-user/trace-events b/linux-user/trace-events
> index f6de1b8befc0..0296133daeb6 100644
> --- a/linux-user/trace-events
> +++ b/linux-user/trace-events
> @@ -1,6 +1,9 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>
>  # signal.c
> +signal_table_init(int i) "number of unavailable signals: %d"
> +signal_do_sigaction_guest(int sig, int max) "target signal %d (MAX %d)"
> +signal_do_sigaction_host(int sig, int max) "host signal %d (MAX %d)"
>  # */signal.c
>  user_setup_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=0x%"PRIx64
>  user_setup_rt_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=0x%"PRIx64

thanks
-- PMM

