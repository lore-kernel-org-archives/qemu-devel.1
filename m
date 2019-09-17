Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE7CC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5E620640
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVGgl5qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5E620640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iADq2-0000ia-9b
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 09:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iADnZ-0007bD-IV
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iADnY-0001Gr-1N
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:45:41 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iADnX-0001GI-QJ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:45:39 -0400
Received: by mail-ot1-x343.google.com with SMTP id 21so3042418otj.11
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 06:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e8L3l8MYc3jZCPR6+Okj/XXq3KtErnI+ESS4l7lTs8A=;
 b=DVGgl5qcuKTxBpnV/P3mS72eeJDDSXk4WkcHFFu4iP6ShGXzHGHO5bhJLlmMInbrhZ
 xBILgI7V3xYV4AO0jknFWotYPZUkxShM9fLphFLxdyJ5txAd4qii3o+zIdplfj0ab/Cx
 KlMz3Ibvj8MebIubx9xmrCXTeBQNIq8MIatO3f3Z3wBRdzgqGKUVMRzEtxYBQXIKZfxm
 9SYtv8IONg+oEVGGTM9cLPZ46Dgeb77UvlqG7ed2Tq26KigyxFlDHo4lg5N7FNkS0TTR
 tODm1dgrIXXvjmgQKifCTI8sR6UQUGUzJlM2SHr8SFahhS8V5TkwVO5AUhC6JrY7NfXO
 JKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e8L3l8MYc3jZCPR6+Okj/XXq3KtErnI+ESS4l7lTs8A=;
 b=cpeXLFt7AysLiot2g/f4fQYfh5V/pQvesJ0ZgcXLU424QShTrCp6gey8JXE3A3l305
 ApwDtzJ9TZZfSt0DM++PHLPQit5vOHlHBs7a2AzC3wn6uEMjJpCPjyvlmOGl5IQ0aM7a
 C6vbDfct8v4bTIsi9DvD6RxczpxHcnOHchNAabzzTgA1Af20bem7cWkZ1D/EQm/BVWcO
 ZRAebyYmUNDxFYEXbMoDB3Iukl/g+UzOQeFZtC/ff9pRVLgkSwHra8BWjP2UkqX5QRlw
 o6NnpsfuLIbLjWKbel2SDPeBdyIg70EEk5D+PJKzHwH/jfxy4mE/R3HEN6J9Nn1yfUil
 9GNw==
X-Gm-Message-State: APjAAAUyarZytXlLuj1io0sD/EtCQDd0h7cCUtsNYMhGBlxJ60rJaQPc
 4qbgIhn8Rw4Zgiw6Cg6NofsOM2w63tcDCyRxw9Q6wQ==
X-Google-Smtp-Source: APXvYqypmtrTZnVgAvfBtCqilM+V2s7l4QFQjwTDBMrKsKHzD8h5o0PYLdfOuKDj1ijes84GV6Gl41v5E0B2GaHyPY4=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr2837944oti.135.1568727938750; 
 Tue, 17 Sep 2019 06:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <9cf47438fa943b28ee987cea7b76a459@fau.de>
 <CAFEAcA-oP9QkYnQr1SQUvTks+9ySjDCn0G5yuULdOBepQi-PSw@mail.gmail.com>
 <75c41dce4fe333c0304f5e80e3ea6f34@fau.de>
In-Reply-To: <75c41dce4fe333c0304f5e80e3ea6f34@fau.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2019 14:45:27 +0100
Message-ID: <CAFEAcA8q=QvwroUA3XQji5bqR5W4nXR=oUxbA16J0qP4Ch5sjA@mail.gmail.com>
To: "Konopik, Andreas" <andreas.konopik@fau.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [Qemu-discuss] Segmentation fault on target tricore
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 qemu-discuss <qemu-discuss@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Sep 2019 at 14:06, Konopik, Andreas <andreas.konopik@fau.de> wrote:
>
> >> Using gdb and valgrind I found out that:
> >> - 'gen_mtcr()' and 'gen_mfcr()' access uninitialized values, i.e.
> >> CSFRs,
> >> which leads to the Segfault
> >> - The uninitialised values were created by stack allocation of
> >> DisasContext in 'gen_intermediate_code()'
> >
> > This definitely sounds like a bug: do you have a stack
> > backtrace from valgrind or gdb of the bad access and the
> > segfault?
> >
> > [...]
> > Thread 3 "qemu-system-tri" received signal SIGSEGV, Segmentation fault.
> > [Switching to Thread 0x7ffff10a4700 (LWP 146730)]
> > 0x00005555556edb67 in gen_mfcr (ret=0xab0, offset=<optimized out>,
> >    ctx=<optimized out>)
> >    at /home/akonopik/qemu_src/target/tricore/cpu.h:274
> > 274       return (env->features & (1ULL << feature)) != 0;
> > (gdb) bt
> > #0  0x00005555556edb67 in gen_mfcr
> >    (ret=0xab0, offset=<optimized out>, ctx=<optimized out>)
> >    at /home/akonopik/qemu_src/target/tricore/cpu.h:274

It looks like tricore_tr_init_disas_context() isn't
initializing ctx->env. If this is the problem then this
patch ought to fix it:

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index c574638c9f7..305d896cd2c 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8793,6 +8793,7 @@ static void
tricore_tr_init_disas_context(DisasContextBase *dcbase,
     CPUTriCoreState *env = cs->env_ptr;
     ctx->mem_idx = cpu_mmu_index(env, false);
     ctx->hflags = (uint32_t)ctx->base.tb->flags;
+    ctx->env = env;
 }

 static void tricore_tr_tb_start(DisasContextBase *db, CPUState *cpu)


Aside to Bastian: passing the CPU env pointer into the
DisasContext isn't ideal, because it makes it quite easy
for translate.c code to accidentally use fields of the
env struct that aren't valid for use at translate time.
I think the only uses of ctx->env you have are for checking
feature bits -- I recommend following what target/arm does here:
 * in tricore_tr_init_disas_context(), instead of copying the
   env pointer, just copy env->features into ctx->features
 * have a tricore_dc_feature(DisasContext *dc, int feature)
   that checks for the feature bit in dc->features

That way you only have access in translate.c code to
information that's safe to bake into generated code, and
it's harder to accidentally introduce bugs where generated
code depends on CPU state that isn't kept in the TB flags.

thanks
-- PMM

