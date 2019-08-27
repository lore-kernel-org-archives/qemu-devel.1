Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A221C41514
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096DE2186A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OE4SX5eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096DE2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2cnB-0006k3-5q
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 10:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2clZ-0005RG-FX
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2clX-0006jl-Vt
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:48:13 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34972)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2clW-0006iF-Qx
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:48:11 -0400
Received: by mail-oi1-x243.google.com with SMTP id a127so15156821oii.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 07:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lW+YK6SnMWC3ZEnbo6JUkf1RfG9JQUesY/CuxMgaErk=;
 b=OE4SX5eg2GNwwgbpt28iFBfILUagA+sAQOzC012wB//3L8aNkHOqvBgqFZSVrh4RIE
 VbzCJ1JN9lW5mL/x7WE7UE+sFsLpoRT17yquTLFFv+HVxeb2lerHL7gAWJ/c0QeF9XDL
 kC4dbgUfeY1zB+61Rc43ahdZSOvo1vK2dKehD0d9tFwkzHn0bsI5x3BePfOrX8GpsZXx
 SYGSxSzawaC6as5LhmNBUETe7ov+5R/JfJQDHHQncZBlteJqyTZQv202CCqUEb+DMjsK
 fBWyYPw2JCWvsyX0+14WwflPf2MwWx7qkDdEuLZ3nFahoPT1UoQgSox5k7y2cEUk1ven
 1rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lW+YK6SnMWC3ZEnbo6JUkf1RfG9JQUesY/CuxMgaErk=;
 b=hZdEAO0lGiFLhMx9KLGk5AA1c3/L9tvJCljersum13BFQH4vZ6g9CeWQ1f6AzaGhGV
 b+6P6XfwWPX/8S402bVfzjBz8N9YoDaqMggTRQRewTlmQrHkkJmv6IaBsHsZo7/6IRYG
 8LV9nHb7X3ITozQZEbpFnADZz/+wRVZ0zued2IIiCkOWC9l2fforRzjGK5TyGob+C4hO
 qON03mH2NKb7WIBdxUPSDMBIAiQ1b1b7WRM4hwhG05yRKBtNUadMSX6y3JdjEQFm4RjW
 8j+jJqUrGYeCHBuFaOINijF09BT5YR+UqstDOTVRE8ph8mTJ1Tp9hv+2xEjpfqbjQxi9
 BSmw==
X-Gm-Message-State: APjAAAUpDlV7WG3ByQ3wLUwdzz5wRgLe3ox81kkbIAlH+ypnw8m3ud3n
 kQ2novjS2MfhO0lGcFAW5n8/qlWA/CXvWGo15t5Hfg==
X-Google-Smtp-Source: APXvYqxy5ciPFKTVqdKeCL3Xwm2DiAnjecrgXRW6V/4UOaQqL+EAzJf4tR6egs4/eOh2ZAbM7CABOTaUq0yeWnZG2nQ=
X-Received: by 2002:a54:4718:: with SMTP id k24mr1012227oik.146.1566917287301; 
 Tue, 27 Aug 2019 07:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190816125802.25877-1-peter.maydell@linaro.org>
 <20190816125802.25877-2-peter.maydell@linaro.org>
 <750250d4-e4a0-43de-add5-24488b87cfea@linaro.org>
In-Reply-To: <750250d4-e4a0-43de-add5-24488b87cfea@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 15:47:56 +0100
Message-ID: <CAFEAcA9VoFNSLmPgosPat4GAyC50uDq7aeUeyvZ7D_1CoEHRoA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH 1/2] target/arm: Allow ARMCPRegInfo
 read/write functions to throw exceptions
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 18 Aug 2019 at 07:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/16/19 1:58 PM, Peter Maydell wrote:
> > @@ -1729,6 +1729,12 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
> >          tcg_temp_free_ptr(tmpptr);
> >          tcg_temp_free_i32(tcg_syn);
> >          tcg_temp_free_i32(tcg_isread);
> > +    } else if (ri->type & ARM_CP_RAISES_EXC) {
> > +        /*
> > +         * The readfn or writefn might raise an exception;
> > +         * synchronize the CPU state in case it does.
> > +         */
> > +        gen_a64_set_pc_im(s->pc - 4);
>
> This will now need an update for master, but otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks; applied series to target-arm.next with this squashed
in to handle the changes in master:

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b3053d3fb89..4d09ae6f424 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1719,7 +1719,7 @@ static void handle_sys(DisasContext *s, uint32_t
insn, bool isread,
          * The readfn or writefn might raise an exception;
          * synchronize the CPU state in case it does.
          */
-        gen_a64_set_pc_im(s->pc - 4);
+        gen_a64_set_pc_im(s->pc_curr);
     }

     /* Handle special cases first */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index adb97dc6a3d..78d93f63cab 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7197,7 +7197,7 @@ static int disas_coproc_insn(DisasContext *s,
uint32_t insn)
              * synchronize the CPU state in case it does.
              */
             gen_set_condexec(s);
-            gen_set_pc_im(s, s->pc - 4);
+            gen_set_pc_im(s, s->pc_curr);
         }

         /* Handle special cases first */


-- PMM

