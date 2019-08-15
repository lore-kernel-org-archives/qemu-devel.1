Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81181C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A5B3206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DkJDsT/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5B3206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIU1-00041Y-9W
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hyIT7-0003GZ-Dj
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hyIT1-00040u-SK
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:19:17 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53042)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hyIT1-00040h-LR
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:19:11 -0400
Received: by mail-wm1-x344.google.com with SMTP id o4so1736476wmh.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 09:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=jE4/H3ZcGHKEAkpJEvCy9ZY+H2orhbWFbJwTJnT6Xxw=;
 b=DkJDsT/nAnr0Vk26lARZGluWbrmD757n4TJcx505c7usuVf8b9BtEWe49GKyRMRQ/a
 3tc0WA4JhprsjZR6edO+YcIiFhJmYHmd9Y+ionf8aBq/acdf8au2bhM8pdnqm5fV6c/R
 ENWOIkZZFYnkicLogaLLpz5cL1WFCHwouhFGAXPEWGfb50HpNVx7k1cQyrqBKAQ455Fd
 ybuiwuprUlHPZx5W1ypvnN6zDQjFzWahDMa6JtnfMDZF0euAA2ohCSg7w7Sl/dhNKkbo
 HOVxEBlKCiUUpmhwOqNa1oy93C9xXHOtUoMNipdpESZ44z+Z0sMDelPnk5Y9rS94WtRs
 r/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=jE4/H3ZcGHKEAkpJEvCy9ZY+H2orhbWFbJwTJnT6Xxw=;
 b=Ax8kjXHUP20zW3zJ7Z0jpMXcwu3dC5OiVfQ2T2Onj9cDzHmGz9QOZ0xrDajJMOHpx6
 yNO1DLY3GQktLY1yX7cnmSaNYrg+q0O+Ro60qblswTFMXnmnvbJem13kXkOl2AfUub46
 UOfKHcIXX9Ji+6YMzx53S91iI41TmV4ijJJy9OJI8mJ1ABiI/YuSopltFXX7lOPHRt9f
 ADzoS5Y4+Rbrne3chBDMPvfVoZxpRRkM79igP00TqkxZA41cDWZzcAT0TYnTkGypGL1/
 H53xGh+zxwl7DVoMqqPPg8c9g3q4MGfFPd/pYUy2Ohh0r5HUcaxWb3bQB+D3OZ0ar8Ct
 x7Xg==
X-Gm-Message-State: APjAAAVFaH1Ho6KIfC303/RFsL+3+YW4pBp+jviUo1u0z2LioY82IX2m
 yO8y7IKU1Xbc5V3a+KTF9vBE1w==
X-Google-Smtp-Source: APXvYqyGxahV1xXnobrKVIJMEsJqAXRa/py5TWW0Hc1iPPxnVBplxR5lf4PNKaRA5wN5GqPgfo6ywQ==
X-Received: by 2002:a1c:9a4b:: with SMTP id c72mr3494888wme.102.1565885949276; 
 Thu, 15 Aug 2019 09:19:09 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id e14sm1381407wme.35.2019.08.15.09.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2019 09:19:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 36C461FF87;
 Thu, 15 Aug 2019 17:19:08 +0100 (BST)
References: <20190815023725.2659-1-vandersonmr2@gmail.com>
 <20190815023725.2659-3-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190815023725.2659-3-vandersonmr2@gmail.com>
Date: Thu, 15 Aug 2019 17:19:08 +0100
Message-ID: <87k1bemmf7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v1 2/2] tb-stats: adding TBStatistics info
 into perf dump
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, vandersonmr <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> Adding TBStatistics information to linux perf TB's symbol names.
>
> This commit depends on the following PATCH:
> [PATCH v5 00/10] Measure Tiny Code Generation Quality
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/perf/jitdump.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/accel/tcg/perf/jitdump.c b/accel/tcg/perf/jitdump.c
> index 6f4c0911c2..b2334fd601 100644
> --- a/accel/tcg/perf/jitdump.c
> +++ b/accel/tcg/perf/jitdump.c
> @@ -8,6 +8,7 @@
>  #include <sys/syscall.h>
>  #include <elf.h>
>
> +#include "exec/tb-stats.h"
>  #include "jitdump.h"
>  #include "qemu-common.h"
>
> @@ -135,7 +136,19 @@ void start_jitdump_file(void)
>  void append_load_in_jitdump_file(TranslationBlock *tb)
>  {
>      GString *func_name =3D g_string_new(NULL);
> -    g_string_printf(func_name, "TB virt:0x"TARGET_FMT_lx"%c", tb->pc, '\=
0');
> +    if (tb->tb_stats) {
> +        TBStatistics *tbs =3D tb->tb_stats;
> +        g =3D stat_per_translation(tbs, code.num_guest_inst);
> +        ops =3D stat_per_translation(tbs, code.num_tcg_ops);
> +        ops_opt =3D stat_per_translation(tbs, code.num_tcg_ops_opt);
> +        spills =3D stat_per_translation(tbs, code.spills);

Where are the declarations for these functions?

--
Alex Benn=C3=A9e

