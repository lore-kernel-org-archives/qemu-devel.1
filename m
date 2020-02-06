Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491ADC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1677D214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwyHN9bF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1677D214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izk5J-0002cb-93
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 11:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izk3u-0001Fn-HP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izk3s-0007Cg-Vz
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:31:30 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izk3s-00079G-Ol
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:31:28 -0500
Received: by mail-wr1-x443.google.com with SMTP id y11so7971039wrt.6
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 08:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ckqyK8jLL3N7mMxCGeQ6JXebLLmmTJwYEe1+oHoTTBs=;
 b=cwyHN9bFVax30oftMNa6TyiVr1cxUvBJVrfs5gndlfs9F8Icr1HyLMWoKETM1vrtQq
 tiJ67BSkRvOxvJ225kCwAn1Zy4uPdvPDpjzRCd09nNeDpu+YSX3/rtzxE8fcVBYFYr3g
 Qp4hoLiqxdY14krc/QdbH48fYzRP83EJSpAySx0cVYFPTe+iyB7Orgkmkd3MmLf1JjCv
 WvGO2Z3iWW1dZ6TP4iaFbkoM/WN5ORUo6Pe//Qqc2IupwSHKbay8YtI3y2JIcUXzrYIa
 SEwZoC8owo7c1ZUrSGTra9LaeH5/4c31eZmCG/woe/RbravR0IfowGcKxQeWjzPtk9Ij
 zWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ckqyK8jLL3N7mMxCGeQ6JXebLLmmTJwYEe1+oHoTTBs=;
 b=aXjDueGgeuIS8vonI9j2iIhIj8lvI1/PS75ukCqVNh8tGh/yh5wwAkrGs+9lGrCaBF
 FQMin8+Bf8JSZFNjRTjPudLsXslGZRQrxhwC/rMFwZMCdanP+NEhMEoVAMwQiNwDMUiQ
 j7YFvYssetskt2I1YqV79TlFVTkQhv9dyYPaIo89jf9FtMrria3DJfTf9T6bFZtWgiA6
 NSfb/ySQEO4gUyyDaKSirHGEiu8abVTNMux0raULreyvHxAvh2w8d1gQrlW0EBNV3Wuv
 Q/NB5rrUhTgkBmRnFA+hDGK9HR+98bdtX3uGvgRLdoeGzdDZIybnYRQLdJfuuw4njKlZ
 pjzQ==
X-Gm-Message-State: APjAAAUz6rsnlgTEq+1YbXfneimR8WegAw74HIpKXRWdeoaAH3zy+5vc
 PVS43yOSzy9tR/vEPlHEvCyOBQ==
X-Google-Smtp-Source: APXvYqyUESutueTZztpIiOI/FXTKpivxdd5cQ7z7iRZGlOTxyYCdduqpNfTBX9uLl/6aVLLbvKDBOQ==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr4965680wrw.276.1581006687070; 
 Thu, 06 Feb 2020 08:31:27 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g21sm51117wmh.17.2020.02.06.08.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 08:31:25 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 429071FF87;
 Thu,  6 Feb 2020 16:31:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PATCH v2] .readthedocs.yml: specify some minimum python requirements
Date: Thu,  6 Feb 2020 16:31:20 +0000
Message-Id: <20200206163120.31899-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU is all about the Python 3 now so lets also hint that to
ReadTheDocs in its config file.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

---
If anyone wants to include this is their next PR please do, otherwise
it will be a misc patch in my next series ;-)
---
 .readthedocs.yml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 .readthedocs.yml

diff --git a/.readthedocs.yml b/.readthedocs.yml
new file mode 100644
index 00000000000..8355dbc6343
--- /dev/null
+++ b/.readthedocs.yml
@@ -0,0 +1,20 @@
+# .readthedocs.yml
+# Read the Docs configuration file
+# See https://docs.readthedocs.io/en/stable/config-file/v2.html for details
+
+# Required
+version: 2
+
+# Build documentation in the docs/ directory with Sphinx
+sphinx:
+  configuration: docs/conf.py
+
+# We want all the document formats
+formats: all
+
+# For consistency, we require that QEMU's Sphinx extensions
+# run with at least the same minimum version of Python that
+# we require for other Python in our codebase (our conf.py
+# enforces this, and some code needs it.)
+python:
+  version: 3.5
-- 
2.20.1


