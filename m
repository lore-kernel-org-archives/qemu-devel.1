Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B5EC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 00:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4AE2070E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 00:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="feh1JZ0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4AE2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipM1x-0003zL-00
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 19:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1ipM0Y-0002gZ-6i
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1ipM0W-00082e-AS
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:49:05 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1ipM0W-00080r-4C
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:49:04 -0500
Received: by mail-pl1-x641.google.com with SMTP id g6so1820058plt.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 16:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=H3zSPRBKP4ZzdR/6KbzozHd86904u26K/mFmLx9RqzI=;
 b=feh1JZ0rixUc1SjMjv50oJb+Uu0jBd1QfUGkdIbmUF5sZoItk0fH7Db7tog+l1OVyA
 O9NQCNB3K0pra7lD1nuchRau60eAPdIIErh1IksBuIYc8iCau2N4YV9zKFu7WISVT6yQ
 TslejvK561l3b7IBA6S2mxO8r5zvPGciY6HWySoKnBKNMhISoHLeoUNR9YZtTcyC7qYV
 af2TWoNv6xqbeZPY8tHdFQ8st2A7+q21hHZKH17TftXAaUgbdiwUQlb2Kyub0atwwukS
 wE3Dliy7tKS4c5OqmFn6aaibx7MInXh7JDJ6vcd3G5SC4l0mbxFH+NGJgyxyC8a/IowV
 rI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=H3zSPRBKP4ZzdR/6KbzozHd86904u26K/mFmLx9RqzI=;
 b=QfeZzS3MuZJgTEMkMU4nPuCXoo8Bd9J1R9RQq2JXnsyEXmtmpjr5DEs2F21YEwG2hG
 RIIt1ctG2fLljffax47f9Sov/7i3TfGaTVZQvMUuHegVGQVbdS/VKHHq98XEnhKQjN8O
 rk/BOXz+g7u1ARcq0Vw+yEPEDo/8eH9CqyS8Ke33Hcj9sI/d7T/bayqY6VuSHWxyatbO
 dfcxdxfakZdW+rP2wwFJeRZKMm8B3DPI9uPN5MkP/knsWzIbv/qFWOOcQKMr5ik/sSd6
 z2HW13vUuX/81/j8q6Bv3VIStoDaHDuIwEXS0J+lUTlEoaBPJgpfliqZ9xY9xwHO/wCL
 jUKw==
X-Gm-Message-State: APjAAAWHSp+9Q3WKsKx8fPHrHKd/y9CHIUZCvzoUt3d5+jqBz3tXKFGj
 uukR2g4/xtOzsYOPhb9XPhF2uha7t2c=
X-Google-Smtp-Source: APXvYqxlNnHVU8Ubb9ccyNzIKNObfpQSyuIe2VJ4nm//zGUmzvwpz4fhSU0OO4ISvy8yuiRoUV5gow==
X-Received: by 2002:a17:90a:a88d:: with SMTP id
 h13mr1739046pjq.55.1578530942843; 
 Wed, 08 Jan 2020 16:49:02 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id z29sm5115273pge.21.2020.01.08.16.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 16:49:02 -0800 (PST)
Date: Wed, 08 Jan 2020 16:49:02 -0800 (PST)
X-Google-Original-Date: Wed, 08 Jan 2020 14:40:48 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 26/36] target/riscv: Remove the hret instruction
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <c83aac89b3f1825c4c3ae282495a28572031f7d5.1575914822.git.alistair.francis@wdc.com>
References: <c83aac89b3f1825c4c3ae282495a28572031f7d5.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-5bd4e131-6645-4d27-8255-5837e004f8c2@palmerdabbelt-glaptop>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 09 Dec 2019 10:11:48 PST (-0800), Alistair Francis wrote:
> The hret instruction does not exist in the new spec versions, so remove
> it from QEMU.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/insn32.decode                     | 1 -
>  target/riscv/insn_trans/trans_privileged.inc.c | 5 -----
>  2 files changed, 6 deletions(-)
>
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index cfd9ca6d2b..b883672e63 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -75,7 +75,6 @@ ecall       000000000000     00000 000 00000 1110011
>  ebreak      000000000001     00000 000 00000 1110011
>  uret        0000000    00010 00000 000 00000 1110011
>  sret        0001000    00010 00000 000 00000 1110011
> -hret        0010000    00010 00000 000 00000 1110011
>  mret        0011000    00010 00000 000 00000 1110011
>  wfi         0001000    00101 00000 000 00000 1110011
>  hfence_gvma 0110001    ..... ..... 000 00000 1110011 @hfence_gvma
> diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc.c
> index b9b5a89b52..76c2fad71c 100644
> --- a/target/riscv/insn_trans/trans_privileged.inc.c
> +++ b/target/riscv/insn_trans/trans_privileged.inc.c
> @@ -58,11 +58,6 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
>  #endif
>  }
>
> -static bool trans_hret(DisasContext *ctx, arg_hret *a)
> -{
> -    return false;
> -}
> -
>  static bool trans_mret(DisasContext *ctx, arg_mret *a)
>  {
>  #ifndef CONFIG_USER_ONLY

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

