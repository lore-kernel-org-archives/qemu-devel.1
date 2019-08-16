Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD82C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 20:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DCA2171F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 20:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0oZYk07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DCA2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyiid-0001Dg-2e
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 16:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sebras@gmail.com>) id 1hyi3S-000854-Sy
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 15:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sebras@gmail.com>) id 1hyi3R-00021p-Ry
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 15:38:30 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735]:34830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sebras@gmail.com>)
 id 1hyi3P-0001zw-5O; Fri, 16 Aug 2019 15:38:27 -0400
Received: by mail-qk1-x735.google.com with SMTP id r21so5717354qke.2;
 Fri, 16 Aug 2019 12:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=2AbiY5NqGuLxHSzaSmQb46FWjVADr7PsDh1kRLGvYKg=;
 b=T0oZYk07zFa+2oCXwAovuSBGryO7E9vrVMSr76+cjYZkOlJXqrY8cQSYqABJ2YGmD0
 LoqbvhWM9sSsvTjY6TwWjvxfKebJjWVpiY+2ZhaEPePLEAnOgICM8Unq51mUa0JVSfuf
 J90X2o2cI4tLHOZgWnmYsOXzJayuLqyVMumxFYSbuZdgfhfJi82j5jZAjLlIgh8iRo5s
 BeFCiznuCK0c37L3tdNVKERR9FRYHVUAudvAFyh2QBJV/CLrq/BZMOt4kncQ8xYVP3rY
 VNyUEjAyhrLaZXOYgqsusrvOYKX/hKSFuUddDLi1krf6ECfs4lh8U5vZyrLi1ANIyQlM
 Zt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=2AbiY5NqGuLxHSzaSmQb46FWjVADr7PsDh1kRLGvYKg=;
 b=PN9KT5KiyW3Ftac4Zcs/nHLFGKWgEoHpvA7LM41xRRmSeaU4WAmo1y5tQZ973gQYtM
 VEYcJMh0ndl/BcuB3mv06Hwg2LgR2ggYUS9yBXCdOIROVL1nUAOuG4vs6m8OGyum9xla
 VC1cExlwXmWBxBInbYGdDVpqoN9VXicsoS6wrEIZUT37LkA+K8dk5f7sVh2RbJjgKqcm
 B44m2MtL4kTplVFuPHocnNyt35EWRPe7Uv3vYr26KAdLTMF0jBw3STAfWsFcZLstcbTX
 W73tUqzxxX7cj+F+a+fp4t14xd6MJ9PY98dRSLXxcyXJWN7dNvEBnMShLC6P4xrcN1Rl
 J3dQ==
X-Gm-Message-State: APjAAAU2fzJ/3qxt7GJtTel3NevfxGC5pF5bZDMtv2ikXnG3+oHRSJO1
 lhOHBPbcO7h9IJKbiwXOz7YyYVO/gSHyAAOZaLudzxukOxE=
X-Google-Smtp-Source: APXvYqwoL0T4SqcSdyXKcX/bCI6Qsc4KUz8ptRMRytZJVPaowR9J2mJ+CPj0Yez6AE8nlL5kbT4co5RoKyxxAc8ljNU=
X-Received: by 2002:a37:a10:: with SMTP id 16mr9913508qkk.335.1565984305316;
 Fri, 16 Aug 2019 12:38:25 -0700 (PDT)
MIME-Version: 1.0
From: Sebastian Rasmussen <sebras@gmail.com>
Date: Fri, 16 Aug 2019 21:38:14 +0200
Message-ID: <CAAgDR1NQSoO6d-OSB_YqbrPA6vxYnq7ZJE_=LoA=eLdmoc3Rsw@mail.gmail.com>
To: qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::735
X-Mailman-Approved-At: Fri, 16 Aug 2019 16:20:23 -0400
Subject: [Qemu-devel] Translation of qemu to Swedish...
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

I noticed that a translation to Swedish was missing,
so I'd like to contribute that. Let me know if there is
some issue and I'll do my best to fix it. :)

 / Sebastian

From 9d8525b987e0db8309b6221a7e2a292fa5db9eec Mon Sep 17 00:00:00 2001
From: Sebastian Rasmussen <sebras@gmail.com>
Date: Fri, 16 Aug 2019 21:22:11 +0200
Subject: [PATCH] Added Swedish translation.

Signed-off-by: Sebastian Rasmussen <sebras@gmail.com>
---
 po/sv.po | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 po/sv.po

diff --git a/po/sv.po b/po/sv.po
new file mode 100644
index 0000000000..e1ef3f7776
--- /dev/null
+++ b/po/sv.po
@@ -0,0 +1,75 @@
+# Swedish translation of qemu po-file.
+# This file is put in the public domain.
+# Sebastian Rasmussen <sebras@gmail.com>, 2019.
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: QEMU 2.12.91\n"
+"Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
+"POT-Creation-Date: 2018-07-18 07:56+0200\n"
+"PO-Revision-Date: 2019-08-16 21:19+0200\n"
+"Last-Translator: Sebastian Rasmussen <sebras@gmail.com>\n"
+"Language-Team: Swedish <tp-sv@listor.tp-sv.se>\n"
+"Language: sv\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
+"X-Generator: Poedit 2.2.3\n"
+
+msgid " - Press Ctrl+Alt+G to release grab"
+msgstr " - Tryck Ctrl+Alt+G f=C3=B6r att sluta f=C3=A5nga"
+
+msgid " [Paused]"
+msgstr " [Pausad]"
+
+msgid "_Pause"
+msgstr "_Paus"
+
+msgid "_Reset"
+msgstr "_Starta om"
+
+msgid "Power _Down"
+msgstr "St=C3=A4ng _ner"
+
+msgid "_Quit"
+msgstr "_Avsluta"
+
+msgid "_Fullscreen"
+msgstr "_Helsk=C3=A4rm"
+
+msgid "_Copy"
+msgstr "_Kopiera"
+
+msgid "Zoom _In"
+msgstr "Zooma _in"
+
+msgid "Zoom _Out"
+msgstr "Zooma _ut"
+
+msgid "Best _Fit"
+msgstr "Anpassad _storlek"
+
+msgid "Zoom To _Fit"
+msgstr "Zooma till _anpassad storlek"
+
+msgid "Grab On _Hover"
+msgstr "F=C3=A5nga vid _hovring"
+
+msgid "_Grab Input"
+msgstr "_F=C3=A5nga inmatning"
+
+msgid "Show _Tabs"
+msgstr "Visa _flika"
+
+msgid "Detach Tab"
+msgstr "Frig=C3=B6r flik"
+
+msgid "Show Menubar"
+msgstr "Visa menyrad"
+
+msgid "_Machine"
+msgstr "_Maskin"
+
+msgid "_View"
+msgstr "_Visa"
--=20
2.23.0.rc1

