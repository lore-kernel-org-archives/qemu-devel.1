Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4FCC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07EA120866
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F0l6SAcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EA120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADLF-0002jE-45
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 08:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jADKY-0002GX-RJ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jADKX-0002Fk-3u
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:47:58 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:34873)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jADKW-000295-Pg
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:47:57 -0500
Received: by mail-wm1-x336.google.com with SMTP id m3so2454200wmi.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 05:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9APHutZwb9zVRiISdPohQJLOrLAAYOlxX+PkYB+fNls=;
 b=F0l6SAcWk/LOrgxm8iCf7IjgnrAXYq4QnFuNXnb7HDdLlDZGnjGUklj+w0jKk4SGkZ
 RXMDSZVKBZAElVp8oDoBLDAfKrf/bCD/J+jqU0WK1wb4qXcuv5bXx/fcEnQbIFanyxsV
 OU7x5xJBeuBNJexh+/EdKG1O6qU1CDT49AUDvoVbBoKV0JfYo5bF0eyJjsgQLrkjn4Ut
 eSr6QxM8uIDV1BBcZUFz8ipnFPL8xxi7GiII/js26YWIwDWxB6WTv2ZQ9e4VNXMqNELB
 agjkxm4p+mi/R4372L/GL+MDk/sqDcBYEpRYcRXykNcnR/z64woWiaUyPe9NHhGcaE0i
 +uFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9APHutZwb9zVRiISdPohQJLOrLAAYOlxX+PkYB+fNls=;
 b=um39n5z1UU/G41AK+En/QFFebVL3ysNMFmVEpRREQEUE5DEb4lX7WpoGXTFxZA2Wbf
 OuwZ5K6dDYrDEycVaCfWofFDtuUmUfZGr+nzqmWxnju0bBIvmeebZXtU4YOmyuS9sOd/
 0X4+q+qQI0G6n13axJAVHyr6WIfo6YVJeTOdeTSmdZHJ1Dhc9Xg7ChFBNk8XSOWlarda
 07gM4DItf0jWrqsHYHMDOOMHo7DrkXjG66xilexUwafEQWbD0vFTJ2f60vhR3ZNaeDYR
 amU01y9gyplGpCfwV4CatGEhYRDzrtVZY4hQi6khOx6m9iBQHhlnP+XtqrwSlaZQ2S/b
 C73Q==
X-Gm-Message-State: ANhLgQ00IuMq+caQs7h/0d/ZWvOohBpU2eJejYdJ1hrHzZSEHp3YFi1E
 pkIPnS1HsIDSlbQlljvbmurTcW1nw1EogQ==
X-Google-Smtp-Source: ADFU+vu27rvSed+ud48bYlvVyPG1Lb8zizKnkCBXbrE/wF24Z7vAOuJ7Do3ToQWusYwd0Z8UabkgbA==
X-Received: by 2002:a1c:68c2:: with SMTP id d185mr4183816wmc.150.1583502473916; 
 Fri, 06 Mar 2020 05:47:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q12sm51886021wrg.71.2020.03.06.05.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 05:47:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu.nsi: Install Sphinx documentation
Date: Fri,  6 Mar 2020 13:47:51 +0000
Message-Id: <20200306134751.2572-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The old qemu-doc.html is no longer built, so update the Windows
installer to install the new Sphinx manual sets.

We install all five of the manuals, even though some of them
(notably the user-mode manual) will not be very useful to Windows
users, because skipping some of them would mean broken links
in the top level 'index.html' page.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I've tested this (building it via the fedora docker image
and installing into a Windows VM) but I don't know anything
much about the installer so there might be neater ways to do it...

NB: I didn't realize that patchew included a test of building
the Windows installer, so until we get this (or some variant)
into master I'm afraid patchew will be emailing failure reports
to every submitted patchseries. Sorry about that :-(
---
 qemu.nsi | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/qemu.nsi b/qemu.nsi
index 0c29ba359cd..1a0112265b0 100644
--- a/qemu.nsi
+++ b/qemu.nsi
@@ -177,9 +177,20 @@ SectionEnd
 !ifdef CONFIG_DOCUMENTATION
 Section "Documentation" SectionDoc
     SetOutPath "$INSTDIR"
-    File "${BINDIR}\qemu-doc.html"
+    File "${BINDIR}\index.html"
+    SetOutPath "$INSTDIR\interop"
+    FILE /r "${BINDIR}\interop\*.*"
+    SetOutPath "$INSTDIR\specs"
+    FILE /r "${BINDIR}\specs\*.*"
+    SetOutPath "$INSTDIR\system"
+    FILE /r "${BINDIR}\system\*.*"
+    SetOutPath "$INSTDIR\tools"
+    FILE /r "${BINDIR}\tools\*.*"
+    SetOutPath "$INSTDIR\user"
+    FILE /r "${BINDIR}\user\*.*"
+    SetOutPath "$INSTDIR"
     CreateDirectory "$SMPROGRAMS\${PRODUCT}"
-    CreateShortCut "$SMPROGRAMS\${PRODUCT}\User Documentation.lnk" "$INSTDIR\qemu-doc.html" "" "$INSTDIR\qemu-doc.html" 0
+    CreateShortCut "$SMPROGRAMS\${PRODUCT}\User Documentation.lnk" "$INSTDIR\index.html" "" "$INSTDIR\index.html" 0
 SectionEnd
 !endif
 
@@ -227,7 +238,12 @@ Section "Uninstall"
     Delete "$INSTDIR\qemu-io.exe"
     Delete "$INSTDIR\qemu.exe"
     Delete "$INSTDIR\qemu-system-*.exe"
-    Delete "$INSTDIR\qemu-doc.html"
+    Delete "$INSTDIR\index.html"
+    RMDir /r "$INSTDIR\interop"
+    RMDir /r "$INSTDIR\specs"
+    RMDir /r "$INSTDIR\system"
+    RMDir /r "$INSTDIR\tools"
+    RMDir /r "$INSTDIR\user"
     RMDir /r "$INSTDIR\keymaps"
     RMDir /r "$INSTDIR\share"
     ; Remove generated files
-- 
2.20.1


