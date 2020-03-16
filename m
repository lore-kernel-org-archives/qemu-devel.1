Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50293C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C56E20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x7lrWLGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C56E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDu8F-0003js-6h
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRP-0000kd-F3
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRN-0000Lr-L8
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:15 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:36952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtRN-0000Ck-BO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:13 -0400
Received: by mail-wr1-x430.google.com with SMTP id 6so22257718wre.4
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FAKlYLQafHN49zgZlDmm+hNC2Vq+rR/wo91Hdl/dBwk=;
 b=x7lrWLGnK97VKUZLUXuSvvsjuTHXN28l31yfxZldqXgcNPIDBlGNBI6iPMR9sDD1sY
 AS4OzLCfN3194/S19iZPBd0sv+5SA4V91v3PwqKjlQ46R5iKLS+5+ROjLTV1mSsbyZKO
 IEQdJGMv4gQkXuoj/1TNisbfk3NewJtfVSh4RA23oU7di2mjefCe9IzwGfU/i/FZfa+o
 c6baKonuZLcHNacU+18fW6RZDmoQqBee2vO/QmkDH2YyNfPdRbQaOplbYSbdE2o1m8j4
 ihK3T0TaaxsB4u+VpzkTw4MhA20wclEopPT4IHGwH/QfOC9UNBaT85xjk8wNwKNANeNi
 Vfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FAKlYLQafHN49zgZlDmm+hNC2Vq+rR/wo91Hdl/dBwk=;
 b=r+nZjVeWjBWiovGAXaILhVZVOBDqPnZqVlglJZOlBL4SpW21NRWMFq3z2rQ+XLlRnq
 6H7LU7CCHJ2CF97fF8jmzwtlu4V0WvB/cbOMJHKCYYTuiri/KSV+ytX5trYSCq6ruFb+
 exljxjBi8mIwgr1Dztwh4xIA+IZzU4MrbqZ2qnvElss5Rxi7CESR8QF6Ix0Wv725I59l
 pckhgz55MkSpGoGEcK2kJiA6pcvG2lNLbsf35/oEKqJMvdqKFG4eQ7kCjzW2LXC7qymr
 VJQAUHoeBD68JWzA3u8IZws2976vDH/Ru+ow/lzXkxDVwX+02Qehhof1FI9R1qH4pc+O
 5gLg==
X-Gm-Message-State: ANhLgQ36h+dlR/AAdZeaCxaxpy0mvBsrKrj3IIzDFyC/fHi5NJLFmfTK
 0BbNPp/bxr//8nATJvQtAZSw5A==
X-Google-Smtp-Source: ADFU+vsLyKiFHGPNFqDAYaVgipKMray1v17M+C1r9oXBQkjK2hkRy4Tvfv+IebZ0M9oK8TlqIECP+w==
X-Received: by 2002:adf:e5d2:: with SMTP id a18mr421223wrn.334.1584379332179; 
 Mon, 16 Mar 2020 10:22:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 98sm746549wrk.52.2020.03.16.10.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:22:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9323E1FF91;
 Mon, 16 Mar 2020 17:21:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 05/28] travis.yml: Set G_MESSAGES_DEBUG do report GLib
 errors
Date: Mon, 16 Mar 2020 17:21:32 +0000
Message-Id: <20200316172155.971-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since commit f5852efa293 we can display GLib errors with the QEMU
error reporting API. Set it to the 'error' level, as this helps
understanding failures from QEMU calls to GLib on Travis-CI.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200316101544.22361-1-philmd@redhat.com>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index b92798ac3b9..ccf68aa9abc 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -79,6 +79,7 @@ env:
     - MAIN_SOFTMMU_TARGETS="aarch64-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
     - CCACHE_SLOPPINESS="include_file_ctime,include_file_mtime"
     - CCACHE_MAXSIZE=1G
+    - G_MESSAGES_DEBUG=error
 
 
 git:
-- 
2.20.1


