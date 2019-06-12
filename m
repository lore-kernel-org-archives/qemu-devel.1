Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D50C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB36F208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LekifjIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB36F208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33736 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb6FX-00040R-QR
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 12:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53953)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hb6ES-000371-Dx
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hb6EQ-0000h8-Tw
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:36:16 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hb6EQ-0000fy-C3
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:36:14 -0400
Received: by mail-pf1-x444.google.com with SMTP id 19so9146659pfa.4
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 09:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=9EPnco73G4Yghc2UFqkLuEdN/QfLTJDNufx9rE9SDu0=;
 b=LekifjIWySugYErFf3Le7cXTjscZp26CYEc4NqGPnW2g9FXHmKL6faCNtGuyDUr71k
 O868rlX6GJ+yVvmMvfvz/DbmH39KtymojJ9rmDERHScN5EBMKtllO69pU3v0WTx/b4mz
 V5uFy76yx7jXhMptEfYO8WcGHEONtL+Mzv4Oy+OVqm0JzUF56PfDyW7b6JqhJ//IvNSX
 oB1vcX1SF1c/7r0a+lFLd3MqrxFL22d1ba5JRgPQcfaUanCZjxafV+ch/+7xBFG9id6r
 bKgsOXzliRZDIgnBTouhynNZLdfRobt5R/qENWc0epbzeT8id88V+bRPADbGl/Qj2XPA
 n3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=9EPnco73G4Yghc2UFqkLuEdN/QfLTJDNufx9rE9SDu0=;
 b=jAgluaI38wcGbShzfFa0Jp1HlolIgRY1EaXK6k1sG6C1d1/R/nwdtsu8rfUkP8Xio4
 kWoJbMmKTLYOb4CdmOrng7erSveBAGXiSvNPw1X1GR5+7D4DOEwOLueiX8w+QftGJNPn
 0WGq1m7gkCDs258X2bWFXZpAYJXl5l5kRiY2tm1O62D8tL/ozvRahUhiiDONA4PQHmKS
 Ok0OKxl1ks3RvOwqkjJCO1PtwplCkrlMh/0wZMBlQsWOe/NcqRYGkL7lun2EI0v+ZP97
 RWl2U5JT9tZdiGk31lqdOEu5tpOTk5pxPUJIqKtVkHog+An920OpJHcYDP4jWsgXfsEQ
 hZVQ==
X-Gm-Message-State: APjAAAV6OaHwSkGnRMomw0EGrsOLQIEFkRqubPpzbzYIp9brhn/MF+L5
 LFg6+r/ndjXXGrU+OmUwqhD5Bw==
X-Google-Smtp-Source: APXvYqy1MT342V4byz+F0cfjdVaQDPorVvYdMtIVn/jBfEqaQh8t0LaII79U7wBjPERZ/5t+M8E81w==
X-Received: by 2002:a62:1ec3:: with SMTP id
 e186mr88323921pfe.197.1560357372559; 
 Wed, 12 Jun 2019 09:36:12 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 y22sm99860pfo.39.2019.06.12.09.36.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Jun 2019 09:36:10 -0700 (PDT)
To: Michael Rolnik <mrolnik@gmail.com>
References: <20190606193012.37715-1-mrolnik@gmail.com>
 <20190606193012.37715-5-mrolnik@gmail.com>
 <9c74618e-eb1e-0225-11dc-fe51e634d265@linaro.org>
 <CAK4993gLwXopG=EFNePsHJYmTZ5uU7EgbGe3Ad4ofOdCxQX-Mg@mail.gmail.com>
 <8429d379-c7e5-72b2-31cf-c4fa80f70695@linaro.org>
 <CAK4993hk62Tg4F9Gq+zFr6wbZ==fP7UPB42zc+sBJrKSztwHyQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a8747ed2-4671-e370-38ff-10016f55a9e0@linaro.org>
Date: Wed, 12 Jun 2019 09:36:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK4993hk62Tg4F9Gq+zFr6wbZ==fP7UPB42zc+sBJrKSztwHyQ@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------3301C3312FC497D3035D6283"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v21 4/7] target/avr: Add instruction
 translation
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------3301C3312FC497D3035D6283
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 6/11/19 2:02 PM, Michael Rolnik wrote:
> I am using this
> one https://github.com/seharris/qemu-avr-tests/blob/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf
> <https://github.com/seharris/qemu-avr-tests/blob/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf> 
> it fails within __divmodsi4 function, there is rcall right after sbrc.
> 
> Thanks for helping.

Two separate bugs, fixed thus.


r~

--------------3301C3312FC497D3035D6283
Content-Type: text/x-patch;
 name="0001-fixup-target-avr-Add-instruction-translation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-fixup-target-avr-Add-instruction-translation.patch"

>From 7be2c4dfcbdca59f6b5b52f65f3fc1df6923db50 Mon Sep 17 00:00:00 2001
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 12 Jun 2019 09:31:14 -0700
Subject: [PATCH] !fixup target/avr: Add instruction translation

When skipping, the skipped NORETURN must chain to the next.
Avoid double-allocating goto_tb indexes.  Choose index 1 to
be the end of TB, which means all other branches use 0.
---
 target/avr/translate.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 4d9e2afa26..abb838b53f 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -622,7 +622,7 @@ static bool trans_BRBC(DisasContext *ctx, arg_BRBC *a)
     }
 
     tcg_gen_brcondi_i32(tcg_invert_cond(cond), var, 0, not_taken);
-    gen_goto_tb(ctx, 1, ctx->npc + a->imm);
+    gen_goto_tb(ctx, 0, ctx->npc + a->imm);
     gen_set_label(not_taken);
 
     ctx->bstate = DISAS_CHAIN;
@@ -672,7 +672,7 @@ static bool trans_BRBS(DisasContext *ctx, arg_BRBS *a)
     }
 
     tcg_gen_brcondi_i32(tcg_invert_cond(cond), var, 0, not_taken);
-    gen_goto_tb(ctx, 1, ctx->npc + a->imm);
+    gen_goto_tb(ctx, 0, ctx->npc + a->imm);
     gen_set_label(not_taken);
 
     ctx->bstate = DISAS_CHAIN;
@@ -2855,6 +2855,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
         if (skip_label) {
             canonicalize_skip(&ctx);
             gen_set_label(skip_label);
+            if (ctx.bstate == DISAS_NORETURN) {
+                ctx.bstate = DISAS_CHAIN;
+            }
         }
     } while (ctx.bstate == DISAS_NEXT
              && num_insns < max_insns
@@ -2876,7 +2879,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     case DISAS_CHAIN:
         if (!nonconst_skip) {
             /* Note gen_goto_tb checks singlestep.  */
-            gen_goto_tb(&ctx, 0, ctx.npc);
+            gen_goto_tb(&ctx, 1, ctx.npc);
             break;
         }
         tcg_gen_movi_tl(cpu_pc, ctx.npc);
-- 
2.17.1


--------------3301C3312FC497D3035D6283--

