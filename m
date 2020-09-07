Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883A2C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E70E1207C3
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJcos/r2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70E1207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFEE2-0001MU-OO
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 06:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFEDS-0000xn-M7
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 06:17:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFEDQ-0001dw-2u
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 06:17:38 -0400
Received: by mail-wr1-x443.google.com with SMTP id c18so15179374wrm.9
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 03:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=W9a/LfMQc1HV7u5hEPDc3bEmXKHLSUhwVWJqWUvocsA=;
 b=mJcos/r2LFujs7pWObvMfTl5EGSlqmr+byja6IdJ8PuOhYVkLyvpycqGlMPzPLQgqI
 wtIAFPz0m9bTh8471df7T4oixzecoUjvQb5R1GDVHkZ+b1TJfndN98kiOFmKw5JYEdHN
 zfeqSJZrY3qeQSTDMLgyadF94gxV5p4HiEuaWn5uOKNHt8/Gdizcxb3rR7mvcMaPn0AI
 bmea2q56ampmgiWoSkC4wZimuwvgxrg9xyqDURcMFNAvx4IGyMGhtNlLTDuyq2pimZSI
 UBN1es5fYe4ZxCJty2JdQjq5uRPPCxEX0AXJX/FyyXgW3eqtQJnTmGiXpPe6y1fo1KD6
 brBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=W9a/LfMQc1HV7u5hEPDc3bEmXKHLSUhwVWJqWUvocsA=;
 b=CdSrHyMsRwSLOStnLDf/ggVGduyMeW/Dn0UAoZs6SxCCKZMFxHDnATLP8gJMZirDQA
 GUgBjtJzRFcYXUvCQwJY2VlbPhIgyshsjsswOkH5PRnIldgwXHzx3hbaPQ1pph7TDrsi
 OjCac9Tv0X2A21BelUl4eIMZW6UftftYvUhctJlqfwhQN/WBdZuPLY4uaQc6BzkabD2o
 +bxreldgP/o8MzqD/J+GdeTHrGL6ZBZL/7w+KNCUYVcLnjw9Zhjv02IO4P3/6aoJWXMD
 b2XFQGevsCoRtSJTkQGxbENtH+u5Gzdh2PZ1wP7BSTYtMSlq3rg1N8zgnZmzCjtaOm5E
 cR8A==
X-Gm-Message-State: AOAM533AVtdi+czdC+HyZHHa0BivQUGI53cjWiHz3R5lFBvOj83vm3QE
 LYMWDVXUHQAXlNfOCAcJWl/HGg==
X-Google-Smtp-Source: ABdhPJx1E68dg2vxr0+tBMhueEUsD4WrBswfAeNOYT+keVH+Fj2jGHj2DNVwS7EYqIutUsI/Y0NftQ==
X-Received: by 2002:adf:f80a:: with SMTP id s10mr22009369wrp.351.1599473853515; 
 Mon, 07 Sep 2020 03:17:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o4sm24115007wru.55.2020.09.07.03.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 03:17:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E36B51FF7E;
 Mon,  7 Sep 2020 11:17:31 +0100 (BST)
References: <159903454714.28509.7439453309116734374.stgit@pasha-ThinkPad-X280>
 <159903455305.28509.6834799024577960185.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH v3 01/15] replay: don't record interrupt poll
In-reply-to: <159903455305.28509.6834799024577960185.stgit@pasha-ThinkPad-X280>
Date: Mon, 07 Sep 2020 11:17:31 +0100
Message-ID: <874ko9sxfo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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

> Interrupt poll is not a real interrupt event. It is needed only for
> thread safety. This interrupt is used for i386 and converted
> to hardware interrupt by cpu_handle_interrupt function.
> Therefore it is not needed to be recorded, because hardware
> interrupt will be recorded after converting.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> ---
>  accel/tcg/cpu-exec.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 66d38f9d85..28aff1bb1e 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -429,8 +429,7 @@ static inline bool cpu_handle_halt(CPUState *cpu)
>  {
>      if (cpu->halted) {
>  #if defined(TARGET_I386) && !defined(CONFIG_USER_ONLY)
> -        if ((cpu->interrupt_request & CPU_INTERRUPT_POLL)
> -            && replay_interrupt()) {
> +        if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
>              X86CPU *x86_cpu =3D X86_CPU(cpu);
>              qemu_mutex_lock_iothread();
>              apic_poll_irq(x86_cpu->apic_state);
> @@ -587,7 +586,13 @@ static inline bool cpu_handle_interrupt(CPUState *cp=
u,
>             and via longjmp via cpu_loop_exit.  */
>          else {
>              if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
> -                replay_interrupt();
> +                if (true
> +#if defined(TARGET_I386)
> +                    && !(interrupt_request & CPU_INTERRUPT_POLL)
> +#endif
> +                ) {
> +                    replay_interrupt();
> +                }

The cpu-exec code has enough special casing in it without adding more
ugly ifdefs. You could hoist the check into:

  /*
   * CPU_INTERRUPT_POLL is a virtual event which gets converted into a
   * "real" interrupt event later. It does not need to be recorded for
   * replay purposes.
   */
  static inline bool replay_valid_interrupt(int interrupt) {
  #ifdef TARGET_I386
      return !(interrupt_request & CPU_INTERRUPT_POLL);
  #else
      return true;
  #endif
  }

and then the logic is a cleaner in the function:

  if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
      if (replay_valid_interrupt(interrupt_request)) {
          replay_interrupt();
      }

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

