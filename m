Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843EBC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50EFF2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6bFouSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EFF2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihhvT-0002ti-Vx
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 17:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihhuB-0001WQ-Cf
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihhuA-0003xP-CL
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:55 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45853)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihhu9-0003wt-Ps
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:53 -0500
Received: by mail-pg1-x541.google.com with SMTP id b9so2005332pgk.12
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 14:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jITgTjhnj7lyoJXWYxFS3Q7b9u1xGvXARpfPJEwIkz8=;
 b=O6bFouSCNjB/kJSo0SlUL9fYP6wBEm0D81Yltp3OMNSyBtBbFfuANiM0v7OMCpa51A
 L14pvnOtRr3AhqtRh+GcGey/jxN+uhM/d3IYmc8Dp6+EBJ//q47LxdA4/XJcz93bDbdk
 SyWOZTKPrKNac2je1LDlmkq8Pkvu1vYNHKvRjYJYH/pbuit+H094ChHn3UlY+NfGR1FK
 9ojGVZE1DsB5WIGvfCXbODlRMU0tQhfEXdv9SB41OjmRy19+O+H9rvN8uEKvjMfGQSIs
 jJEVMRb1muo5BPrRZKcy7ZFir5cU2f1EpLaysSpKQZJVdxALyQOQCNcpkN3UU59EAmPc
 NmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jITgTjhnj7lyoJXWYxFS3Q7b9u1xGvXARpfPJEwIkz8=;
 b=GK6oDWCdOAe3m8XmiChv0NE2AqafAZ8sFw1TzjnlQwjN/ftKc1HG1Ey6DuMazcSibh
 zP9pNE0Iri5DeAH4LDrqLkYeKXW9LEh1CNZEu/FMJDfCA2kYL70zu6VCugfrOpYEaTfM
 JxM3SEWU5pE9rs+93+/KrfslSK7kjF9LfB1Q4OU7tasXUocI/eaRZFBPrB2Pi/4EKXdh
 sS1E6pJFNyf/eP6CnA2Vaq7AYdbDEhrqKHejDUJ3XTFy07mcKg6zPpTXm5JGfth1XrGc
 KChOoYlj3wA65svEY2GC+Fy+uUc+kY+EWpuFYvVl5X5C1nVftH0LX+tCTpHb/+b5ARhU
 960g==
X-Gm-Message-State: APjAAAUF2XZTDNv37hHlfOLtCRIZT/8AMQl+pDjMz+LfJViOVFs22NPE
 3raJONzLRl2A8cDHyc7IcuV+wfKrJ5M=
X-Google-Smtp-Source: APXvYqwprNZOM+I8ihlTNKEsxqqMmP6UzfhQTYEQthO5nnjWoBKNBchpC+Q8t9J3GyzsOTcNu6T8LA==
X-Received: by 2002:aa7:9192:: with SMTP id x18mr5783182pfa.125.1576708492563; 
 Wed, 18 Dec 2019 14:34:52 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id j1sm4627779pff.107.2019.12.18.14.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 14:34:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/7] configure: Unnest detection of -z,relro and -z,now
Date: Wed, 18 Dec 2019 12:34:39 -1000
Message-Id: <20191218223441.23852-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218223441.23852-1-richard.henderson@linaro.org>
References: <20191218223441.23852-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: philmd@redhat.com, i@maskray.me, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is nothing about these options that is related to PIE.
Use them unconditionally.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Do not split into two tests.
---
 configure | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 7a646ec007..2503288654 100755
--- a/configure
+++ b/configure
@@ -2040,9 +2040,6 @@ if test "$pie" != "no" ; then
     QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
     LDFLAGS="-pie $LDFLAGS"
     pie="yes"
-    if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
-      LDFLAGS="-Wl,-z,relro -Wl,-z,now $LDFLAGS"
-    fi
   else
     if test "$pie" = "yes"; then
       error_exit "PIE not available due to missing toolchain support"
@@ -2053,6 +2050,12 @@ if test "$pie" != "no" ; then
   fi
 fi
 
+# Detect support for PT_GNU_RELRO + DT_BIND_NOW.
+# The combination is known as "full relro", because .got is read-only too.
+if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
+  LDFLAGS="-Wl,-z,relro -Wl,-z,now $LDFLAGS"
+fi
+
 ##########################################
 # __sync_fetch_and_and requires at least -march=i486. Many toolchains
 # use i686 as default anyway, but for those that don't, an explicit
-- 
2.20.1


