Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFD6C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61FF72082F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQvpL9ab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FF72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j30Eu-0001FE-Km
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 11:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j30EJ-0000jM-CO
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j30EH-0004Z9-QT
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:23:43 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53455)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j30EH-0004YR-It; Sat, 15 Feb 2020 11:23:41 -0500
Received: by mail-wm1-x342.google.com with SMTP id s10so13105428wmh.3;
 Sat, 15 Feb 2020 08:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SCCdopDbU7XQ4hQfu835spsCeEblh1Woi3AoAzNNFMo=;
 b=IQvpL9ab/0bZxeCa++wQJYHcTGc/aiUKlrOObOo6suY6Fh7TCxDaAEIaYxPQ96cfNw
 abnYMgXntn6EXwPjj0D37OF1lPB0PnXtw+QvnPyJxin4G9NDCQxuQm55PCb0nArhp4nf
 Qb+7sWtbkCrAEd6l4rvr3gnVBw21gnIhnNFZAPxOQroikbX8vzZNFMouIjodELZk8Llr
 uiWWN5UIRl8V6pxiTb5tikxk9TXZLncyywwBcDXughfvfwC89ehMM0bQKpD0/mNZM1yd
 Z36t/5oAZR3zA/DeAIKidW0CV3KiSgyuafqOhJTtEn7tOfWZgH3eAPqSjoukU3oh6sYS
 WgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=SCCdopDbU7XQ4hQfu835spsCeEblh1Woi3AoAzNNFMo=;
 b=UKfWIWRNq3t4WaL7UNZ7SrGaL2gkJGjl7ygfSqaNd1Lla3F4DTjjN6ZpdPxHIo4IRO
 WMleuy6imd+abLW9x1OilwABVgrJ2ubEh/Z4b6ZAlIFQRU6wlFuw1hM0C04BZUe2n0bl
 6aX0wfx0qyZMbs8FGDqDA632x3bAPURh0uT32Oi66cjDsAwt5V5jvil6EePRrSh/izLM
 C7ynaSYbOkDgXaMiK3yZrQWUE4gu1imXuvxMEXyQf7kRFcWbHes+aNntgpEAEsBd4GyD
 N1knS5DXnIz+FdC2A1ggAoQSd7WBWYHfWAN+hXgZzltkmi7L5jfbECn9nxc0FkwplYF2
 gZSA==
X-Gm-Message-State: APjAAAVdUKdRo91uLgvz9/IPmfe8M1eQGLG2HXnJqdjAlQn/j1jqQBK1
 mUxlhD8RMPFq/AOzQ2zoQ4dlmvcI+4g=
X-Google-Smtp-Source: APXvYqye8czUxddrBbwW0UjEXq56E+CusNt+83eeme8iSREsFKleggGUdY38U4DjeVBI1DSLPihsog==
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr11116374wmh.164.1581783819640; 
 Sat, 15 Feb 2020 08:23:39 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id z133sm12592312wmb.7.2020.02.15.08.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 08:23:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: Avoid compiling system tools on user build by
 default
Date: Sat, 15 Feb 2020 17:23:37 +0100
Message-Id: <20200215162337.5809-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

User-mode does not need the sytem tools. Do not build them by
default if user specified --disable-system.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configure | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 16f94cd96b..557ca4bd04 100755
--- a/configure
+++ b/configure
@@ -455,7 +455,7 @@ guest_agent_ntddscsi="no"
 guest_agent_msi=""
 vss_win32_sdk=""
 win_sdk="no"
-want_tools="yes"
+want_tools=""
 libiscsi=""
 libnfs=""
 coroutine=""
@@ -2199,6 +2199,15 @@ else
     echo big/little test failed
 fi
 
+##########################################
+# system tools
+if test "$want_tools" != "yes" && test "$softmmu" = "no"; then
+    want_tools=no
+fi
+if test -z "$want_tools"; then
+    want_tools=yes
+fi
+
 ##########################################
 # cocoa implies not SDL or GTK
 # (the cocoa UI code currently assumes it is always the active UI
-- 
2.21.1


