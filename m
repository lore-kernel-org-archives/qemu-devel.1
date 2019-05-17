Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06D1C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982292133D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu8+oHqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982292133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54784 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRlgT-0005eR-Pc
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:50:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hRlbL-0001La-8z
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hRlbJ-0005c2-U0
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:19 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:39785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hRlbJ-0005at-P8
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:17 -0400
Received: by mail-yw1-xc44.google.com with SMTP id w21so3353064ywd.6
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 15:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=KO9FR2wnB/UsZf46rgIZq75rCEsrhLW+LB3x7uowhw8=;
	b=Nu8+oHqhDejdPKOeHI906DhMTh82QwXVqr7QY7v8t6SHUiZkFoJ4RdAq5O2s1vyWNA
	0b6JgzlIZkQ/cddTviXgI/00lQuUSLAyIVGK/gXlusGjWt0GO6bEyOn+J0Q9wMx8fQl/
	iBVLfBJRG/ukDT/63afRkBscFTjawF5OJXR44k/pckEdGe9NAVZ9tclTRWuVYeFLLySA
	KAIS2hVKGEdBNUE2mnVQIMfT3PQu+GeFPZf+YXJpRG/h6l+Pet9Iq4R+QHOgQVGaMfZB
	KTp3ZUx7F9dmcIWyrYGPGYIMay+4lEX1/s7Rs/LQlHV8VmwYlSMvIsKcCQLOviD7Gcxf
	xmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=KO9FR2wnB/UsZf46rgIZq75rCEsrhLW+LB3x7uowhw8=;
	b=p7b5kaB0RTRDbR/i8/oZa47qILfI8RJ1ABap+GmZysemGvZ/evlyeK9kLCTh460Rde
	vxdgzoGD1oCUykTorfYVg9BJHPvzN1WiOai1b1zRS9Q4+jxqbWwEMEGntTirONl+iEIa
	pG9DQRXpUdhfq4US3gvojXhfcXY09ZItf2RCaJ9lGYNv8OJzqgF7jZz+8MQMvZxjg0o8
	N5eDP/vl7o5i0ZbY+paDXHh0pxdtJGMr1HzHO6DvcdhysKUqav+hYWqMJK9qgla7dkIc
	5oxAz+r5UluPxQdOWanv//+Ft5pcvAhkcS9vanCpBjJ7pjLOlgLgAy6ZRaFXLkE3jcmn
	ENwg==
X-Gm-Message-State: APjAAAXehIAhtDninQXxF4uQJD64eOud1IDkOdauDdmqSYorXzj6xQZE
	DEse8hwXRd+/QCNF3MvE2rj/DepYV1uYWQ==
X-Google-Smtp-Source: APXvYqw4htd6MxDmKAdNhCrCu4wixDBKwpJBMJS5eiWqOjm4D14x8I32SjoSvVrz2JwDkmouFBdFMA==
X-Received: by 2002:a81:9982:: with SMTP id
	q124mr15064034ywg.493.1558133117048; 
	Fri, 17 May 2019 15:45:17 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id
	u73sm2480260ywf.62.2019.05.17.15.45.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 15:45:16 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 18:44:46 -0400
Message-Id: <20190517224450.15566-8-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517224450.15566-1-jan.bobek@gmail.com>
References: <20190517224450.15566-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RISU v2 07/11] test_i386: change syntax from nasm to
 gas
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jan Bobek <jan.bobek@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows us to drop dependency on NASM and build the test image
with GCC only. Adds support for x86_64, too.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 Makefile    |  3 +++
 test_i386.S | 41 +++++++++++++++++++++++++++++++++++++++++
 test_i386.s | 27 ---------------------------
 3 files changed, 44 insertions(+), 27 deletions(-)
 create mode 100644 test_i386.S
 delete mode 100644 test_i386.s

diff --git a/Makefile b/Makefile
index b362dbe..6ab014a 100644
--- a/Makefile
+++ b/Makefile
@@ -49,6 +49,9 @@ $(PROG): $(OBJS)
 %_$(ARCH).elf: %_$(ARCH).s
 	$(AS) -o $@ $<
 
+%_$(ARCH).elf: %_$(ARCH).S
+	$(CC) $(CPPFLAGS) -o $@ -c $<
+
 clean:
 	rm -f $(PROG) $(OBJS) $(BINS)
 
diff --git a/test_i386.S b/test_i386.S
new file mode 100644
index 0000000..456b99c
--- /dev/null
+++ b/test_i386.S
@@ -0,0 +1,41 @@
+/*#############################################################################
+ * Copyright (c) 2010 Linaro Limited
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *
+ * Contributors:
+ *     Peter Maydell (Linaro) - initial implementation
+ *###########################################################################*/
+
+/* A trivial test image for x86 */
+
+/* Initialise the registers to avoid spurious mismatches */
+	xor	%eax, %eax
+	sahf				/* init eflags */
+
+	mov	$0x12345678, %eax
+	mov	$0x9abcdef0, %ebx
+	mov	$0x97361234, %ecx
+	mov	$0x84310284, %edx
+	mov	$0x83624173, %edi
+	mov	$0xfaebfaeb, %esi
+	mov	$0x84610123, %ebp
+
+#ifdef __x86_64__
+	movq	$0x123456789abcdef0, %r8
+	movq	$0xaaaabbbbccccdddd, %r9
+	movq	$0x1010101010101010, %r10
+	movq	$0x1111111111111111, %r11
+	movq	$0x1212121212121212, %r12
+	movq	$0x1313131313131313, %r13
+	movq	$0x1414141414141414, %r14
+	movq	$0x1515151515151515, %r15
+#endif
+
+/* do compare */
+	ud1	%eax, %eax
+
+/* exit test */
+	ud1	%ecx, %eax
diff --git a/test_i386.s b/test_i386.s
deleted file mode 100644
index a2140a0..0000000
--- a/test_i386.s
+++ /dev/null
@@ -1,27 +0,0 @@
-;###############################################################################
-;# Copyright (c) 2010 Linaro Limited
-;# All rights reserved. This program and the accompanying materials
-;# are made available under the terms of the Eclipse Public License v1.0
-;# which accompanies this distribution, and is available at
-;# http://www.eclipse.org/legal/epl-v10.html
-;#
-;# Contributors:
-;#     Peter Maydell (Linaro) - initial implementation
-;###############################################################################
-
-; A trivial test image for x86
-
-BITS 32
-; Initialise the registers to avoid spurious mismatches
-mov eax, 0x12345678
-mov ebx, 0x9abcdef0
-mov ecx, 0x97361234
-mov edx, 0x84310284
-mov edi, 0x83624173
-mov esi, 0xfaebfaeb
-mov ebp, 0x84610123
-; UD1 : do compare
-UD1
-
-; UD2 : exit test
-UD2
-- 
2.20.1


