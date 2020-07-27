Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC92C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDBFD20663
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YEjmhsae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBFD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02Jn-0003Ew-4j
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02Az-0007MK-KD
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:17 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:52690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02Ax-0006Rl-Sk
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:17 -0400
Received: by mail-wm1-x32f.google.com with SMTP id x5so13423788wmi.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 05:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RKEsFJMIWwY073toT6Xkvo3y6i6P51ZDeJuJoM8XuRk=;
 b=YEjmhsaengNg6bkktVpVNv8GJwUaknWjpM8E1sJXf/F4hwGIf6yrLPLSMSsdHWofSp
 8o/4Y57ZHg+6dC2uBPuIIRw5bwaNVxxX3+Ck2Dhe0B6JMxirr6ujhuYxq3FvIYXZ/pH5
 l+r3VjlxVFQlgEMPEmCws0YKGVdRCvkA4nWvdEKixEzF5zpq7CTl5ogR2gQH2aFWZTT/
 IGGpRtdAn7hTro+ra0JFipim49+gO7hIXgtfQbH2QWhSr9jAFuwROEt/+OhSo+77PU4m
 vHhHfmcf7mMkPes72JNLFKQHLapPCmJdMgNXYBdzOG/u1d6LoTlGBl5PjkbBSYw4rmWO
 Tj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RKEsFJMIWwY073toT6Xkvo3y6i6P51ZDeJuJoM8XuRk=;
 b=ZlhX7Zyk+Hcu0/2HSI6VcRZGWTYJIAkk2GoJQjNtz9svC4LX4/CE6ukvfo47EXIyHr
 /yMpzrM8cMkzoZW4f3L+AuU3AJ8BVG7iQ24YLw5r4a/Wwt5GCp35/QWO8e7ANWfrerEa
 TQntqfexFYF05LdoMu0Fu4RFKoeC9KOUzQ4sKxZKzAWGj+EOTNg+/nVgzzAAPsH0V2ZT
 N6p1JYhKkHWVp9pLl4o4GlRezfg8lJ5/eiC+T0PAsyb9Zw1fqnW+TB7IbhoZ20BHS7ac
 QUUEed3VRiAMaWOH5XrB45r0mUEegbHqokGj90zEkGAWHDIYRqUiJy1ju9x13pIkDoLx
 LKOQ==
X-Gm-Message-State: AOAM532fxT3DTIkoUS819vc6Esj25Ka/ZRi/0eR3wx7v/uCaVECb0IgG
 /y/b+PXRcwCbgpR+w14F6NDZqQ==
X-Google-Smtp-Source: ABdhPJyEoRruEBhM623HPtWiDrx4wZ9e6Pvx0aNszoRKfyDtqFRuFuvbXcfpd8+02uyo4BxPHBvEDQ==
X-Received: by 2002:a1c:27c1:: with SMTP id n184mr21283442wmn.6.1595852654480; 
 Mon, 27 Jul 2020 05:24:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g3sm13638572wrb.59.2020.07.27.05.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 05:24:06 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3FA9D1FF98;
 Mon, 27 Jul 2020 13:23:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 09/16] tests/docker: fix update command due to python3
 str/bytes distinction
Date: Mon, 27 Jul 2020 13:23:50 +0100
Message-Id: <20200727122357.31263-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727122357.31263-1-alex.bennee@linaro.org>
References: <20200727122357.31263-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Does this seem convoluted to you? It feels a little complicated to me.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200724064509.331-10-alex.bennee@linaro.org>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index c9f20d8d093..356d7618f1a 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -24,7 +24,7 @@ import tempfile
 import re
 import signal
 from tarfile import TarFile, TarInfo
-from io import StringIO
+from io import StringIO, BytesIO
 from shutil import copy, rmtree
 from pwd import getpwuid
 from datetime import datetime, timedelta
@@ -541,13 +541,14 @@ class UpdateCommand(SubCommand):
 
         # Create a Docker buildfile
         df = StringIO()
-        df.write("FROM %s\n" % args.tag)
-        df.write("ADD . /\n")
-        df.seek(0)
+        df.write(u"FROM %s\n" % args.tag)
+        df.write(u"ADD . /\n")
+
+        df_bytes = BytesIO(bytes(df.getvalue(), "UTF-8"))
 
         df_tar = TarInfo(name="Dockerfile")
-        df_tar.size = len(df.buf)
-        tmp_tar.addfile(df_tar, fileobj=df)
+        df_tar.size = df_bytes.getbuffer().nbytes
+        tmp_tar.addfile(df_tar, fileobj=df_bytes)
 
         tmp_tar.close()
 
-- 
2.20.1


