Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13910C4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 23:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0AC420881
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 23:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jNYXMMMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AC420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFoRQ-0004jO-2l
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 19:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iFoQV-000494-Ag
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 19:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iFoQU-00033Z-8k
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 19:52:59 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34852)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iFoQU-000335-1c
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 19:52:58 -0400
Received: by mail-pl1-x641.google.com with SMTP id y10so611971plp.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 16:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=YSnlhCmlA8Qg+kgyP8DOZPiH3d/vplXaX6h7i1qGnXU=;
 b=jNYXMMMRYVEhEFJCocpxW0Zjy/I/YUITHiFz2TuV3ZJ9OuCkYq3Mz1RKVj7EzgvLnd
 wk2mzB2DH1NDNosztZvBVVl76p2qUQv1BfFPpR4XW0OVGclGbwpM8U8sW7TVF9qLS62k
 YEfmPjAXY+3d1Ay6lR17wDvOpv/UT1QE4ajM93ZTLwFUjvOPvVsxkmq6fAH8rcWJdLZ8
 /ffubBtjtHeOIZOCbI7GPQw0+5o/KU7VPz34UE1lbZrzp9b2zRwzbAQ3VJEL7lx5aXCM
 ta3zumIFqy/qmvWDboTyySSciQMJLo+gsLUi1x/kNfCQmj0w9CMl4wGFy7vgFN+iEiYa
 SXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=YSnlhCmlA8Qg+kgyP8DOZPiH3d/vplXaX6h7i1qGnXU=;
 b=f3FWrOCf+j2oVjzQMf3aX37X28sH7W+bF1YTMENvDzikSWRjuhfs4ZWd9uY2eO9bRd
 py2km8J/l5Jj4wsFHaqpjzFuQSjIwWFcaQ5hv2YvuptSxQIIxrCqh7IKgY2MhvprZ5K9
 /tPcEDbr+6k7M6LoE4Cc0yWn+RcyfggOk/cyWL8yQIobE1sxCeE7bVRANMbm7bNxO9Nm
 Um0UlAoObFMEVoCR9GVwDOZ7I7uklrCwzzuRRcSckEgA56Pi+Ub0+HvHJCdPWqCuJyYm
 5uGyucvY05HHCnUVJQ6RcMZGLPFJBAfwR/o6ZdF0xQIfYJfPzJR69dbfMufT9jkh77SY
 ir/w==
X-Gm-Message-State: APjAAAUKAi73ySptG1+cFz/QKPykeelrjWvknz/mKeUX/gvrvbyW2p49
 BxrL/dM4JOBnRJ/bLVfOrUUMYtsefsiiyg==
X-Google-Smtp-Source: APXvYqwI6MqTDZKpKu6Uy5WraJcgejZvbSW4wIlI3hWpXDy8G4d16eBuc1A0TRtVKx4M8mE007G37g==
X-Received: by 2002:a17:902:b497:: with SMTP id
 y23mr6689706plr.82.1570060376372; 
 Wed, 02 Oct 2019 16:52:56 -0700 (PDT)
Received: from localhost (c-73-15-177-105.hsd1.ca.comcast.net. [73.15.177.105])
 by smtp.gmail.com with ESMTPSA id l189sm459098pgd.46.2019.10.02.16.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2019 16:52:55 -0700 (PDT)
Date: Wed, 02 Oct 2019 16:52:55 -0700 (PDT)
X-Google-Original-Date: Wed, 02 Oct 2019 16:44:52 PDT (-0700)
Subject: Re: [PATCH v1 21/28] target/riscv: Respect MPRV and SPRV for floating
 point ops
In-Reply-To: <8a628d1542d547b6d639cdba51db67590d0b56de.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-7c045b6d-544e-40df-95a6-e46c479e41c8@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: qemu-riscv@nongnu.org, Anup Patel <Anup.Patel@wdc.com>,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 16:38:44 PDT (-0700), Alistair Francis wrote:
> Respect the contents of MSTATUS.MPRV and HSTATUS.SPRV when performing
> floating point operations when V=0.

I'm confused as to what this has to do with floating point.

>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/translate.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 19771904f4..ea19ba9c5d 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -750,7 +750,21 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>      ctx->mstatus_fs = ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
>      ctx->priv_ver = env->priv_ver;
>  #if !defined(CONFIG_USER_ONLY)
> -    ctx->virt_enabled = riscv_cpu_virt_enabled(env);
> +    if (riscv_has_ext(env, RVH)) {
> +        ctx->virt_enabled = riscv_cpu_virt_enabled(env);
> +        if (env->priv_ver == PRV_M &&
> +            get_field(*env->mstatus, MSTATUS_MPRV) &&
> +            get_field(*env->mstatus, MSTATUS_MPV)) {
> +            ctx->virt_enabled = true;
> +        } else if (env->priv == PRV_S &&
> +                   !riscv_cpu_virt_enabled(env) &&
> +                   get_field(env->hstatus, HSTATUS_SPRV) &&
> +                   get_field(env->hstatus, HSTATUS_SPV)) {
> +            ctx->virt_enabled = true;
> +        }
> +    } else {
> +        ctx->virt_enabled = false;
> +    }
>  #else
>      ctx->virt_enabled = false;
>  #endif

