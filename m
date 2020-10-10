Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5FAC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B61207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuqtjKpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B61207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLmf-0004KV-MG
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiH-0000UK-8n
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:33 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiC-0007S0-RD
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:30 -0400
Received: by mail-wm1-x342.google.com with SMTP id d81so13302448wmc.1
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MCMj0TR+Fl9dY8Kl27uG0iFSZwgVew5RPBCHaa3rL38=;
 b=ZuqtjKpT5MXbZVwy+FCYabCWRL6j3TgGf5uHfwWaDOUujD/i3aHxKCH9SdbSTmCRE7
 Ldrjq3hdIkTevQpyVltIu4Ik78DmwkNiJmvYyUSmf6qUNz/sNbdPcoVfc1HqrwtlQUi+
 S5K2387QYUddiFSrOYNZabGxI8eEpmRm8067t6B7LQVe88FIvIWV4s+G9MFbB9+RzsGc
 vUh52T2qn3xdsmoTxet8kBKxF0QFYOozKtlXeFWFguFyL3pHdnNx2TCUmtXYlzxr8jJW
 gxJDTb9rBFmRGNYghxQ02OcOoX+jHHGizV0rg0pT2l+dvV7J5UdY4G7emSMi/elejCmy
 YE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MCMj0TR+Fl9dY8Kl27uG0iFSZwgVew5RPBCHaa3rL38=;
 b=oU6jxzAfv0To5UpAsbOLK5ikRSA6+0LWz1KO5Ki1WjahWuuqy+7jC7YXkSE29/EhP+
 MwQSBngDRBd3TaYc9mxkAt9OwXMg7mvzC2kTCtvhrFgKnXajHkn909t7PsFhEXDSyk/L
 a4rttfaTHjA5mfggQ71zeIoRQXTgzZa2eC5HjAT8TOST4GCHv6w7/ylBN07yBHv0Xyql
 aAJpqca2f7vYPMSvHicBLeTDgWA5XSGBKZ50m7Zn9kS51wvE3JLsE9BjEhSDc9XziBGc
 Az+yF16uEArCIbirJH0imRshzxSw9MXApMMxqF8c4t6m9U2Br67GUigth00b8tMWJMTQ
 rsng==
X-Gm-Message-State: AOAM5333M2tK2T7b3an/KKx8BZ19r7PqCXIiwQo/SMSutywoA3QBN2hv
 bUjJ1zpnJHEAgv8mPY6q3z5wOR9Tod4=
X-Google-Smtp-Source: ABdhPJwwKkazENrdC7jgR5WP9EMaZvakRFVl6PX+zsV16ZunlWBU1LR8Hi7WFFbadpmjmkfe72dMGA==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr3910567wms.36.1602362607246; 
 Sat, 10 Oct 2020 13:43:27 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm2705471wme.38.2020.10.10.13.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:43:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/20] hw/core/clock: add the clock_new helper function
Date: Sat, 10 Oct 2020 22:43:03 +0200
Message-Id: <20201010204319.3119239-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010204319.3119239-1-f4bug@amsat.org>
References: <20201010204319.3119239-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Luc Michel <luc@lmichel.fr>

This function creates a clock and parents it to another object with a given
name. It calls clock_setup_canonical_path before returning the new
clock.

This function is useful to create clocks in devices when one doesn't
want to expose it at the qdev level (as an input or an output).

Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
Message-Id: <20201010135759.437903-4-luc@lmichel.fr>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/clock.h | 13 +++++++++++++
 hw/core/clock.c    | 15 +++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/hw/clock.h b/include/hw/clock.h
index d357594df99..cbc5e6ced1e 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -90,6 +90,19 @@ extern const VMStateDescription vmstate_clock;
  */
 void clock_setup_canonical_path(Clock *clk);
 
+/**
+ * clock_new:
+ * @parent: the clock parent
+ * @name: the clock object name
+ *
+ * Helper function to create a new clock and parent it to @parent. There is no
+ * need to call clock_setup_canonical_path on the returned clock as it is done
+ * by this function.
+ *
+ * @return the newly created clock
+ */
+Clock *clock_new(Object *parent, const char *name);
+
 /**
  * clock_set_callback:
  * @clk: the clock to register the callback into
diff --git a/hw/core/clock.c b/hw/core/clock.c
index 7066282f7b9..f866717a835 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -23,6 +23,21 @@ void clock_setup_canonical_path(Clock *clk)
     clk->canonical_path = object_get_canonical_path(OBJECT(clk));
 }
 
+Clock *clock_new(Object *parent, const char *name)
+{
+    Object *obj;
+    Clock *clk;
+
+    obj = object_new(TYPE_CLOCK);
+    object_property_add_child(parent, name, obj);
+    object_unref(obj);
+
+    clk = CLOCK(obj);
+    clock_setup_canonical_path(clk);
+
+    return clk;
+}
+
 void clock_set_callback(Clock *clk, ClockCallback *cb, void *opaque)
 {
     clk->callback = cb;
-- 
2.26.2


