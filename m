Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BE2C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF5B206B8
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tse6dTGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF5B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLfUY-0003dx-Mo
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 00:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1jLfTw-0003Ew-FM
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1jLfTv-0006d7-AB
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:05:00 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:51740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1jLfTv-0006cU-0l
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:04:59 -0400
Received: by mail-pj1-x1043.google.com with SMTP id n4so197213pjp.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 21:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lrP9Nnpyn7AwZU8Ih6xNIyZ8h5UrDJrgYwrVrW5PZEc=;
 b=Tse6dTGjs/yzxxuoO+/0GoB/QhVe61gs2pQUP0Ghhpmb3myQgFf96bA587hOD52F/t
 o3Ffv1+SsgBsz4iA4K1M0Y02XkmuUuADqpu2AxUfnyPtLlw0i6ag5J+Dl15PAuqPzhg9
 UkY+iIdKzNnRy9FhPG8NuJPm5kpquHr5HV8HyUH03o4c10ECL8+OyK2cS/4adcTXuV7c
 gXoZJTSfxBeGqUejVpSJp9Kq80Q6EHjA83YGVIbx539JLCJVSbsSEmt+fsKzRvG6u8gz
 NDQO+9cBkOvbs1wXCrbUi8cHWgeS51k8EfjzhPzJa8WgirCVN+pkXh82z5d0EHrZy3n6
 Mgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lrP9Nnpyn7AwZU8Ih6xNIyZ8h5UrDJrgYwrVrW5PZEc=;
 b=MngImibkVTRVDQ/t1JJj319yIoOej06Pn/Uk+5blirHNmhJxT3KT84GMgGJ4g0FUEq
 8FUrJUwM+YtH0HKcnNzbkIVhaMNZFGnXEqJle31k3WoZTJyWTYmnEJW2DFOUzKMqfiIx
 m/5mmC3z0UlGPqqfQLSLtf/WlgPt5gvfDXqrSrgTmd5QFNSnSryqaZWxbF8C1XexoEKz
 pCpZEfKktlg8GsYN0DsfGFZeyFQ2f+bzdMpDMH5ko+sEDIeFwZrqmom2CwFxRGffjFZg
 qhHYEfchaWzrODQMOMt3iGKrDSzNWpEtfGogh1Iai2tUj92MvBbvKu3xHlMlLh49EcO2
 MlRw==
X-Gm-Message-State: AGi0Pub1MQV4FQIG7MApyfJXgJeJBPvfF7gWfB6M0X2K3uSLI5X0hegy
 YyrBthNmXfZCL0+S7BfYgw2r3HB19Fp8aTumnUI=
X-Google-Smtp-Source: APiQypJOo25T3rTMG01VRgPr4fzbJ85FczeNoL+AztvFlhOA4xXE/YI29NK9hSHxJmSAmXgWNg64Yv5St0FY8NTuzVU=
X-Received: by 2002:a17:902:fe08:: with SMTP id
 g8mr575705plj.333.1586232297574; 
 Mon, 06 Apr 2020 21:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200407030938.26537-1-richard.henderson@linaro.org>
In-Reply-To: <20200407030938.26537-1-richard.henderson@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 6 Apr 2020 21:04:46 -0700
Message-ID: <CAMo8BfJ9+fnA2xp8PMKm039oW-qVtTxpON6Ux=tkBySS=cQhxQ@mail.gmail.com>
Subject: Re: [PATCH for-5.0?] target/xtensa: Statically allocate
 xtensa_insnbufs
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 6, 2020 at 8:09 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rather than dynamically allocate, and risk failing to free
> when we longjmp out of the translator, allocate the maximum
> buffer size from any of the supported cpus, which is 8:

There's macro MAX_INSN_LENGTH that defines maximal supported
instruction length in bytes. Maybe the following instead, along the lines
of what libisa does dynamically?:

--8<--
From 08cc91b0d51e244766d73aae23aebd194b598378 Mon Sep 17 00:00:00 2001
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 6 Apr 2020 20:59:54 -0700
Subject: [PATCH] target/xtensa: statically allocate xtensa_insnbufs in
DisasContext

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |  3 +++
 target/xtensa/helper.c    |  1 +
 target/xtensa/translate.c | 12 ++----------
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index c0d69fad96c5..7a46dccbe11b 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -213,6 +213,9 @@ enum {
 #define MEMCTL_IL0EN 0x1

 #define MAX_INSN_LENGTH 64
+#define MAX_INSNBUF_LENGTH \
+    ((MAX_INSN_LENGTH + sizeof(xtensa_insnbuf_word) - 1) / \
+     sizeof(xtensa_insnbuf_word))
 #define MAX_INSN_SLOTS 32
 #define MAX_OPCODE_ARGS 16
 #define MAX_NAREG 64
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 376a61f3397c..278415ae0e06 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -96,6 +96,7 @@ static void init_libisa(XtensaConfig *config)

     config->isa = xtensa_isa_init(config->isa_internal, NULL, NULL);
     assert(xtensa_isa_maxlength(config->isa) <= MAX_INSN_LENGTH);
+    assert(xtensa_insnbuf_size(dc->config->isa) <= MAX_INSNBUF_LENGTH);
     opcodes = xtensa_isa_num_opcodes(config->isa);
     formats = xtensa_isa_num_formats(config->isa);
     regfiles = xtensa_isa_num_regfiles(config->isa);
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 8aa972cafdf3..91c7776c2544 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -72,8 +72,8 @@ struct DisasContext {
     unsigned cpenable;

     uint32_t op_flags;
-    xtensa_insnbuf insnbuf;
-    xtensa_insnbuf slotbuf;
+    xtensa_insnbuf_word insnbuf[MAX_INSNBUF_LENGTH];
+    xtensa_insnbuf_word slotbuf[MAX_INSNBUF_LENGTH];
 };

 static TCGv_i32 cpu_pc;
@@ -1174,10 +1174,6 @@ static void
xtensa_tr_init_disas_context(DisasContextBase *dcbase,
     dc->callinc = ((tb_flags & XTENSA_TBFLAG_CALLINC_MASK) >>
                    XTENSA_TBFLAG_CALLINC_SHIFT);

-    if (dc->config->isa) {
-        dc->insnbuf = xtensa_insnbuf_alloc(dc->config->isa);
-        dc->slotbuf = xtensa_insnbuf_alloc(dc->config->isa);
-    }
     init_sar_tracker(dc);
 }

@@ -1267,10 +1263,6 @@ static void xtensa_tr_tb_stop(DisasContextBase
*dcbase, CPUState *cpu)
     DisasContext *dc = container_of(dcbase, DisasContext, base);

     reset_sar_tracker(dc);
-    if (dc->config->isa) {
-        xtensa_insnbuf_free(dc->config->isa, dc->insnbuf);
-        xtensa_insnbuf_free(dc->config->isa, dc->slotbuf);
-    }
     if (dc->icount) {
         tcg_temp_free(dc->next_icount);
     }
--8<--
-- 
Thanks.
-- Max

