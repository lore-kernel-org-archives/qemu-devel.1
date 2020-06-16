Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217C3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5E720B80
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PE1I/Yjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5E720B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlBHU-0005iw-Ly
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB61-0003xn-Pa
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:45 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:36399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB5z-00007t-9e
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:45 -0400
Received: by mail-wr1-x42e.google.com with SMTP id q11so20672592wrp.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 05:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Itxyoaw44xcsG2G02PfO8bbyKkEnWDH8+KPdnp0/sa4=;
 b=PE1I/Yjn8jvd9/hwuoXdDg8B1L696DIf7cbWY7BlnuTWDAfL4RdNhosFTgLC4SrRJP
 0hwFVTQHxdBuy9XbTRJIrb3LGiY2rIIcqjdXm8Ke+UK6XyRxZkWFRZpi7yapXWossMKz
 LUdGcz1oNh03+Em4qEfauixVbwVoeipxnoIGdAWLb1W3VpUuUG3TUGQkbBYFPa96GmV1
 BW1Br0lPteODGxJlGxD7ZPf0M+uqMfbPHr/2wrg6xzVlI0LMEbPWqjGtz8QDu5BRkxja
 o6umSNpJE5FFP0UYIkKYUvpxnLzDTs9D2SyuZUwnKNlAAD30yq4RyhvUnvsJ5ShsxyQC
 6/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Itxyoaw44xcsG2G02PfO8bbyKkEnWDH8+KPdnp0/sa4=;
 b=AkSZjkECizN6Pk+nS/8ZEOzQITxjVjgCy723XzCbYh8Xif/ra/cWPgXL8725WZTSJB
 R+UyEzZE70h9bLJ8oKzVEx7jUMwcbKGbo0P9vKZ98xfjfbjwl8miACyO9BxfrlcwSpJ3
 vReeuArF5oyPHZExiSN4ZQFdRFchzEpZt292OE6bxEZl/f0bgKw54Tptjt45jVMgKoL/
 0xDvUsp2ZZLP53l1N8fFq0nonCBDtnfS9D/AXeRIGr2jCcJjrGPFpZ9L2iXDExvIubi4
 OZuIqRh7AWGg2peoOBbu7qG3eLqOW44TIXUUPAc62F/n2XVWSfjEgK5x6gU3Y8ifPg15
 BzdQ==
X-Gm-Message-State: AOAM530KamxT/NsUD4rf/wwD5x4GW2AzVMU6CifRaqjiiZnXANdguLFF
 5koIGGpd+xRJkL0hKD090gSKgw==
X-Google-Smtp-Source: ABdhPJz3k6lfhPEnbkdd3hsn5kzqb3WvhSb9sfF+4T6GLOGKl9HYzAfK3rKk2hJ520zvh7WluhDjvQ==
X-Received: by 2002:adf:e58c:: with SMTP id l12mr2969692wrm.34.1592312019758; 
 Tue, 16 Jun 2020 05:53:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v66sm4123611wme.13.2020.06.16.05.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 05:53:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 855311FF9C;
 Tue, 16 Jun 2020 13:53:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 13/21] include/qemu: Added tsan.h for annotations.
Date: Tue, 16 Jun 2020 13:53:16 +0100
Message-Id: <20200616125324.19045-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616125324.19045-1-alex.bennee@linaro.org>
References: <20200616125324.19045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

These annotations will allow us to give tsan
additional hints.  For example, we can inform
tsan about reads/writes to ignore to silence certain
classes of warnings.
We can also annotate threads so that the proper thread
naming shows up in tsan warning results.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200609200738.445-11-robert.foley@linaro.org>
Message-Id: <20200612190237.30436-14-alex.bennee@linaro.org>

diff --git a/include/qemu/tsan.h b/include/qemu/tsan.h
new file mode 100644
index 00000000000..09cc665f91d
--- /dev/null
+++ b/include/qemu/tsan.h
@@ -0,0 +1,71 @@
+#ifndef QEMU_TSAN_H
+#define QEMU_TSAN_H
+/*
+ * tsan.h
+ *
+ * This file defines macros used to give ThreadSanitizer
+ * additional information to help suppress warnings.
+ * This is necessary since TSan does not provide a header file
+ * for these annotations.  The standard way to include these
+ * is via the below macros.
+ *
+ * Annotation examples can be found here:
+ *  https://github.com/llvm/llvm-project/tree/master/compiler-rt/test/tsan
+ * annotate_happens_before.cpp or ignore_race.cpp are good places to start.
+ *
+ * The full set of annotations can be found here in tsan_interface_ann.cpp.
+ *  https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl/
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifdef CONFIG_TSAN
+/*
+ * Informs TSan of a happens before/after relationship.
+ */
+#define QEMU_TSAN_ANNOTATE_HAPPENS_BEFORE(addr) \
+    AnnotateHappensBefore(__FILE__, __LINE__, (void *)(addr))
+#define QEMU_TSAN_ANNOTATE_HAPPENS_AFTER(addr) \
+    AnnotateHappensAfter(__FILE__, __LINE__, (void *)(addr))
+/*
+ * Gives TSan more information about thread names it can report the
+ * name of the thread in the warning report.
+ */
+#define QEMU_TSAN_ANNOTATE_THREAD_NAME(name) \
+    AnnotateThreadName(__FILE__, __LINE__, (void *)(name))
+/*
+ * Allows defining a region of code on which TSan will not record memory READS.
+ * This has the effect of disabling race detection for this section of code.
+ */
+#define QEMU_TSAN_ANNOTATE_IGNORE_READS_BEGIN() \
+    AnnotateIgnoreReadsBegin(__FILE__, __LINE__)
+#define QEMU_TSAN_ANNOTATE_IGNORE_READS_END() \
+    AnnotateIgnoreReadsEnd(__FILE__, __LINE__)
+/*
+ * Allows defining a region of code on which TSan will not record memory
+ * WRITES.  This has the effect of disabling race detection for this
+ * section of code.
+ */
+#define QEMU_TSAN_ANNOTATE_IGNORE_WRITES_BEGIN() \
+    AnnotateIgnoreWritesBegin(__FILE__, __LINE__)
+#define QEMU_TSAN_ANNOTATE_IGNORE_WRITES_END() \
+    AnnotateIgnoreWritesEnd(__FILE__, __LINE__)
+#else
+#define QEMU_TSAN_ANNOTATE_HAPPENS_BEFORE(addr)
+#define QEMU_TSAN_ANNOTATE_HAPPENS_AFTER(addr)
+#define QEMU_TSAN_ANNOTATE_THREAD_NAME(name)
+#define QEMU_TSAN_ANNOTATE_IGNORE_READS_BEGIN()
+#define QEMU_TSAN_ANNOTATE_IGNORE_READS_END()
+#define QEMU_TSAN_ANNOTATE_IGNORE_WRITES_BEGIN()
+#define QEMU_TSAN_ANNOTATE_IGNORE_WRITES_END()
+#endif
+
+void AnnotateHappensBefore(const char *f, int l, void *addr);
+void AnnotateHappensAfter(const char *f, int l, void *addr);
+void AnnotateThreadName(const char *f, int l, char *name);
+void AnnotateIgnoreReadsBegin(const char *f, int l);
+void AnnotateIgnoreReadsEnd(const char *f, int l);
+void AnnotateIgnoreWritesBegin(const char *f, int l);
+void AnnotateIgnoreWritesEnd(const char *f, int l);
+#endif
-- 
2.20.1


