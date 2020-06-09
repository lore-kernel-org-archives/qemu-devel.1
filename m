Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B658C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:41:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA925207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wQEW/nUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA925207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jibhB-0003wg-1X
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 06:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibe7-0007am-BX
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:19 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:54584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibe4-0004NW-Qt
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:19 -0400
Received: by mail-wm1-x32d.google.com with SMTP id g10so2314769wmh.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p4FX53f1uEMaQTO+XmVG4SpfpCIx1tkSo1o781lno5w=;
 b=wQEW/nUkjh2tW9rSCF5dE1raID99Ho8cPoz/ucxoEFknft0CFH6ILrQOVzaydaadQC
 oWWRfWh/EJfGUrvJnWhQchnqlc9Jh6YJ18GoQFXNVazcSaxKj6Ojoe0S6WXdsNy4MYOz
 o+enQH8Jgqn+F5z6tvLIwACxwuL1/6L8jP5lIbXGUAVQzXBKP4UYj+iy2OM5Nzy/PiTt
 N1ylY6MXBHj6KCAk4FCMh9W3luxlpieVT6P3lz8oxew5wJRDHr9dG/vwAS2gG2Ekn7yR
 Du1EAiPAreIb0AqSR/awtMOUo7JvPO+qcvExSUI8Mb1+j5zGuoIeo5FXwCdv/0KhmNp5
 lf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p4FX53f1uEMaQTO+XmVG4SpfpCIx1tkSo1o781lno5w=;
 b=KwvOTqF+NG5SdB7tYccf2P0Dorgn1Ef67Y7VAONCGi08xoe3KCMcGe3wRL2FP0zi7O
 yi5T5VpIsBYRgT/wH5btZCw/Pu959yh+XDq/Jw2/uP+sUh/ZhTubfuLmMyv++ELCZqPM
 lVr9YQFZRM7RfcTAnWQxPRNAxCqbtA6kPNJH5dq6W4k8zkoF5XQv92Y5Dg9A5RH2YOc3
 ERd2BeSQ1reuhjj5eFcFZ213jk1a/2ZKo/CP6clgvp2WDxu3Cpt9de3x+XMrXfhX82iN
 zG6o3UXbCodUOzrxbu8PuLWQY26nJHjHUwDN9Yo0jQ4uRlAkwXuBeXWe8lNeY27UAQPy
 hyTQ==
X-Gm-Message-State: AOAM532H7DLLupxKrDV+eRWiE5pKJvzmvyt/6yBGdX42MS+bjvaBJ0hQ
 NcpnMflk8W5k1jSHX9qUmY/3BA==
X-Google-Smtp-Source: ABdhPJwCzoqtnTmFAv1vO3F7EHP60asM+wdOF7UEtaQOd1S7yf3XzO3FfuJttz7K4Qnyps5JMqIk1A==
X-Received: by 2002:a1c:2044:: with SMTP id g65mr3646039wmg.16.1591699095215; 
 Tue, 09 Jun 2020 03:38:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c5sm3092785wrb.72.2020.06.09.03.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 03:38:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A03191FF90;
 Tue,  9 Jun 2020 11:38:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 04/17] exec: flush the whole TLB if a watchpoint crosses a page
 boundary
Date: Tue,  9 Jun 2020 11:37:56 +0100
Message-Id: <20200609103809.23443-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609103809.23443-1-alex.bennee@linaro.org>
References: <20200609103809.23443-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no particular reason why you can't have a watchpoint in TCG
that covers a large chunk of the address space. We could be clever
about it but these cases are pretty rare and we can assume the user
will expect a little performance degradation.

NB: In my testing gdb will silently squash a watchpoint like:

  watch (char[0x7fffffffff]) *0x0

to a 4 byte watchpoint. Practically it will limit the maximum size
based on max-value-size. However given enough of a tweak the sky is
the limit.

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200605154929.26910-5-alex.bennee@linaro.org>

diff --git a/exec.c b/exec.c
index be4be2df3a1..a0bf9d61c87 100644
--- a/exec.c
+++ b/exec.c
@@ -1038,6 +1038,7 @@ int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           int flags, CPUWatchpoint **watchpoint)
 {
     CPUWatchpoint *wp;
+    vaddr in_page;
 
     /* forbid ranges which are empty or run off the end of the address space */
     if (len == 0 || (addr + len - 1) < addr) {
@@ -1058,7 +1059,12 @@ int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
         QTAILQ_INSERT_TAIL(&cpu->watchpoints, wp, entry);
     }
 
-    tlb_flush_page(cpu, addr);
+    in_page = -(addr | TARGET_PAGE_MASK);
+    if (len <= in_page) {
+        tlb_flush_page(cpu, addr);
+    } else {
+        tlb_flush(cpu);
+    }
 
     if (watchpoint)
         *watchpoint = wp;
-- 
2.20.1


