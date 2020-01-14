Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE08C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E13A207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S86TXtb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E13A207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJsK-0005Rw-7n
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irJrf-00051q-H2
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irJrd-0004fc-Sb
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:56:03 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irJrd-0004fN-K2
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:56:01 -0500
Received: by mail-wr1-x443.google.com with SMTP id b6so11708048wrq.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 02:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=nDAm5IGqvF+NA2Rcqz4QcPVr7tcDspslFr4xPEbe65E=;
 b=S86TXtb+WYTu3s+S/fXrJM6RFz2iPWKrtjNme1HxP2T74ZC8Tu3Rjfl/MgMlGCjyEm
 I7ArR+9FvzJskYkpcJwZFigOaq9iO6i94lBMm+eRjgM0aRPWyET2KFNu1PDd4yJEOI+w
 AJe3+kmbmdQGo34gWytaAZn0pnf9m5BUak+DLnMHK/nUSL8F9fAVGmrZ8yJGAfV4JVn2
 PPXFiCUCJ8bgUm6gWXUIRcmXuPdNqWogVULlUefXPgwlyuiGWC2HMaIlzhvGuqF71uxY
 KJGR3QWfIw210ECSrBKkTvKHcFXof2fviVj6sHNHiPdgJkX0/IGNrUFBQ9J/c930PvnN
 2E5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=nDAm5IGqvF+NA2Rcqz4QcPVr7tcDspslFr4xPEbe65E=;
 b=A5mbkwTIIuXjS/Q4gbjyz2fKcHicOzeePZIHrDZ0IrlCaPT9+gdC5Kv/ahabJHFq1B
 qpVm5XQabceMscWhuhdx6ETdGTPZyVUDTU2stO3CSG8qjxQte4dfboAL2kKmuvVHArWt
 6op3IvGBea27lccNdQKeoiYDzJ6NiWPNGifVp7RH2EYHpBwYN6U80JpRpWaP3kpckJSo
 paqcCqNt0WEK5KT0eYqVpxW/z3K/oQutrBUUQymCSZNZbq69taWQT5o/7W6MkDBJpVWr
 jojzks7hyuACdfXt9wHI3Atdo4Y4uHc4Q7XFGlURYW3GiEBYb/422/7GlHB+euUE3bBO
 DgsA==
X-Gm-Message-State: APjAAAVqaUBbIQjdflOiZ0UsQWcPwrEwDWhHsHvt7xF0lTY54t8itKHG
 PQua3TLyRA+3zfQIHVK+iwCIWg==
X-Google-Smtp-Source: APXvYqx3xHINgz9zwxK9xucYYPWL+cWitU4+RrkR5lkVrmRvfShBBH4Iiu+x3ZrP+rf2VRpVVSXlXQ==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr24685458wrq.196.1578999359941; 
 Tue, 14 Jan 2020 02:55:59 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o129sm18170294wmb.1.2020.01.14.02.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 02:55:58 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9C4A81FF87;
 Tue, 14 Jan 2020 10:55:57 +0000 (GMT)
References: <20200114030138.260347-1-jkz@google.com>
 <20200114030138.260347-3-jkz@google.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Josh Kunz <jkz@google.com>
Subject: Re: [PATCH 2/4] linux-user: Use `qemu_log' for strace
In-reply-to: <20200114030138.260347-3-jkz@google.com>
Date: Tue, 14 Jan 2020 10:55:57 +0000
Message-ID: <87muaqmhmq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: armbru@redhat.com, riku.voipio@iki.fi, qemu-devel@nongnu.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Josh Kunz <jkz@google.com> writes:

> This change switches linux-user strace logging to use the newer `qemu_log`
> logging subsystem rather than the older `gemu_log` (notice the "g")
> logger. `qemu_log` has several advantages, namely that it allows logging
> to a file, and provides a more unified interface for configuration
> of logging (via the QEMU_LOG environment variable or options).
>
> Signed-off-by: Josh Kunz <jkz@google.com>
> ---
>  include/qemu/log.h   |  13 ++
>  linux-user/main.c    |  17 +-
>  linux-user/qemu.h    |   1 -
>  linux-user/signal.c  |   3 +-
>  linux-user/strace.c  | 479 ++++++++++++++++++++++---------------------
>  linux-user/syscall.c |  13 +-
>  util/log.c           |   2 +
>  7 files changed, 282 insertions(+), 246 deletions(-)
>
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index 503e4f88d5..8f044c1716 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -64,6 +64,7 @@ static inline bool qemu_log_separate(void)
>  #define CPU_LOG_PLUGIN     (1 << 18)
>  /* LOG_USER is used for some informational user-mode logging. */
>  #define LOG_USER           (1 << 19)
> +#define LOG_STRACE         (1 << 20)
>
>  /* Lock output for a series of related logs.  Since this is not needed
>   * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
> @@ -154,6 +155,18 @@ void qemu_set_dfilter_ranges(const char *ranges, Err=
or **errp);
>  bool qemu_log_in_addr_range(uint64_t addr);
>  int qemu_str_to_log_mask(const char *str);
>
> +/* Add (union) the given "log_flags" to the current log mask. */
> +static inline void qemu_add_log(int log_flags)
> +{
> +    qemu_set_log(qemu_loglevel | log_flags);
> +}
> +
> +/* Remove (subtract) the given log flags from the current log mask. */
> +static inline void qemu_del_log(int log_flags)
> +{
> +    qemu_set_log(qemu_loglevel & ~(log_flags));
> +}
> +
>  /* Print a usage message listing all the valid logging categories
>   * to the specified FILE*.
>   */
> diff --git a/linux-user/main.c b/linux-user/main.c
> index c4f3de77db..0bf40c4d27 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -63,6 +63,12 @@ int have_guest_base;
>  /* Used to implement backwards-compatibility for user-mode logging. */
>  static bool force_user_mode_logging =3D true;
>
> +/*
> + * Used to implement backwards-compatibility for the `-strace`, and
> + * QEMU_STRACE options.
> + */
> +static bool enable_strace;
> +
>  /*
>   * When running 32-on-64 we should make sure we can fit all of the possi=
ble
>   * guest address space into a contiguous chunk of virtual host memory.
> @@ -378,7 +384,7 @@ static void handle_arg_singlestep(const char *arg)
>
>  static void handle_arg_strace(const char *arg)
>  {
> -    do_strace =3D 1;
> +    enable_strace =3D true;

Could we cut out the middle-man and just qemu_add_log(LOG_STRACE) here
and drop the enable_strace variable.

>  }
>
>  static void handle_arg_version(const char *arg)
> @@ -672,6 +678,15 @@ int main(int argc, char **argv, char **envp)
>      qemu_plugin_add_opts();
>
>      optind =3D parse_args(argc, argv);
> +    /*
> +     * Backwards Compatability: If handle_arg_strace just enabled strace
> +     * logging directly, then it could be accidentally turned off by a
> +     * QEMU_LOG/-d option. To make sure that strace logging is always en=
abled
> +     * when QEMU_STRACE/-strace is set, re-enable LOG_STRACE here.
> +     */
> +    if (enable_strace) {
> +        qemu_add_log(LOG_STRACE);
> +    }
>
>      if (force_user_mode_logging) {
>          /*
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index f6f5fe5fbb..02c6890c8a 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -385,7 +385,6 @@ void print_syscall_ret(int num, abi_long arg1);
>   * --- SIGSEGV {si_signo=3DSIGSEGV, si_code=3DSI_KERNEL, si_addr=3D0} ---
>   */
>  void print_taken_signal(int target_signum, const target_siginfo_t *tinfo=
);
> -extern int do_strace;
>
>  /* signal.c */
>  void process_pending_signals(CPUArchState *cpu_env);
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 5ca6d62b15..2ff0065804 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -864,9 +864,8 @@ static void handle_pending_signal(CPUArchState *cpu_e=
nv, int sig,
>          handler =3D sa->_sa_handler;
>      }
>
> -    if (do_strace) {
> +    if (unlikely(qemu_loglevel_mask(LOG_STRACE)))
>          print_taken_signal(sig, &k->info);
> -    }

Please don't drop the brace - c.f. CODING_STYLE.rst

Side note, print_taken_signal might want to consider using the
qemu_log_lock() functionality to keep sequential qemu_log's together. I
suspect you might want to do the same for syscalls.

--
Alex Benn=C3=A9e

