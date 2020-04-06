Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00EAC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B14F206F8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zv67Gidq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B14F206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVwx-0004pp-Md
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqk-0001TS-3N
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqh-0001Rh-Jq
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:47:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:35397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqh-0001LY-2M
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:47:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id i19so333533wmb.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iReDTzs2Dt50WrfdNdr1+4DatVHniwe5YHMC666osXs=;
 b=Zv67GidqC99G9Gve+Ccp7YzDO1MRq3kW4OVGIlwS0rpyZYGj45aYTI/PxuIFvjdGlp
 +y2ZB9LClb1vzF9rMAeW3dsAMdmvQLFbbX9B4Q86BCVwasrd+ZsILTTiEFPbfgwI5Llw
 79tKup106tKsBObTfcg5pj1nSQrpqaUA6bm++UzZ9fVb/afNf/1BQ8Di6GP8GYjVSLUJ
 OngYWB4vWdq1zyEeLlQQJ4ERT4HrSMYEHqkYG312LRinyPbgdfnozgGngmBgONi44YoQ
 SWylms/zKsL4hPt+KwTXSVE1FMKmwNw2jw5U6n4HRlYTl/SUEtpYTa+CsGipJMGxrBn7
 2jOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=iReDTzs2Dt50WrfdNdr1+4DatVHniwe5YHMC666osXs=;
 b=dJFbA1+9MMzdEeK5CgkT8eVrva0DoPVN/ZiQNhtl8fDUie7utSy2vxCdgiqwfJYQnV
 q7YqxdmIItPfrQ+Q/sLdS6HBJUbugpQNLOXIz2KYQksoe2v4R95qJDpji6j2arMyHIv1
 7g+ZC0i4Oa3mXc4PVuRzjmqV8K6VnJc/I3cCgaLiFWUHlKqX9nkoTAJpiMy0E+lqtDwm
 6yOIwlGeTArbJPXlPXOFNMH+0RkJPpNS7IgJNNqJ0cOSiFr4/vS8hf9kkJNHpomFNCxi
 Z0yZeLnoQ6KV3182amB0u9EOiA/LNEVsaA3ahk7RuKN2LYjgvECU7NydwrjcGGA3BLYl
 +cQg==
X-Gm-Message-State: AGi0PubGxnQTdWXOXvOw9CrAqJmnDppbBYEXvXVNG19RiPpeyFq87KU6
 ZzZoxOr2vAQyV59h/6QEh0JRq1+X7Gw=
X-Google-Smtp-Source: APiQypLdx/GjEcHz6rJ7WbzX0/P9ebNLuTecdw2Ea/3fCP6OGGDNcJhQB5QpOMmbt16ngpOExEDkOQ==
X-Received: by 2002:a05:600c:2257:: with SMTP id
 a23mr529751wmm.128.1586195268801; 
 Mon, 06 Apr 2020 10:47:48 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:47:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 02/54] scripts/coccinelle: Script to simplify
 DeviceClass error propagation
Date: Mon,  6 Apr 2020 19:46:51 +0200
Message-Id: <20200406174743.16956-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a device uses an Error* with data not modified before realize(),
this call can be moved to init(). Add a Coccinelle patch to find such
uses.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 ...implify-init-realize-error_propagate.cocci | 69 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 70 insertions(+)
 create mode 100644 scripts/coccinelle/simplify-init-realize-error_propagate.cocci

diff --git a/scripts/coccinelle/simplify-init-realize-error_propagate.cocci b/scripts/coccinelle/simplify-init-realize-error_propagate.cocci
new file mode 100644
index 0000000000..2e3ec4d98a
--- /dev/null
+++ b/scripts/coccinelle/simplify-init-realize-error_propagate.cocci
@@ -0,0 +1,69 @@
+// Find error-propagation calls that don't need to be in DeviceClass::realize()
+// because they don't use information user can change before calling realize(),
+// so they can be moved to DeviceClass:initfn() where error propagation is not
+// needed.
+//
+// Copyright: (C) 2020 Philippe Mathieu-Daudé
+// This work is licensed under the terms of the GNU GPLv2 or later.
+//
+// spatch \
+//  --macro-file scripts/cocci-macro-file.h \
+//  --sp-file \
+//    scripts/coccinelle/simplify-init-realize-error_propagate.cocci \
+//  --timeout 60
+//
+// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg692500.html
+
+
+@ match_class_init @
+TypeInfo info;
+identifier class_initfn;
+@@
+    info.class_init = class_initfn;
+
+
+@ match_instance_init @
+TypeInfo info;
+identifier instance_initfn;
+@@
+    info.instance_init = instance_initfn;
+
+
+@ match_realize @
+identifier match_class_init.class_initfn;
+DeviceClass *dc;
+identifier realizefn;
+@@
+void class_initfn(...)
+{
+    ...
+    dc->realize = realizefn;
+    ...
+}
+
+
+@ propagate_in_realize @
+identifier match_realize.realizefn;
+identifier err;
+identifier errp;
+identifier func_with_errp =~ "(?!object_property_set_link)";
+symbol error_abort, error_fatal;
+position pos;
+@@
+void realizefn@pos(..., Error **errp)
+{
+    ...
+    Error *err = NULL;
+    <+...
+    func_with_errp(..., \(&error_abort\|&error_fatal\));
+    ...+>
+}
+
+
+@ script:python @
+initfn << match_instance_init.instance_initfn;
+realizefn << match_realize.realizefn;
+p << propagate_in_realize.pos;
+@@
+print('>>> possible moves from {}() to {}() in {}:{}'
+      .format(initfn, realizefn, p[0].file, p[0].line))
diff --git a/MAINTAINERS b/MAINTAINERS
index 9d156d73b3..d06ffeddd5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2057,6 +2057,7 @@ F: scripts/coccinelle/err-bad-newline.cocci
 F: scripts/coccinelle/error-use-after-free.cocci
 F: scripts/coccinelle/error_propagate_null.cocci
 F: scripts/coccinelle/remove_local_err.cocci
+F: scripts/coccinelle/simplify-init-realize-error_propagate.cocci
 F: scripts/coccinelle/use-error_fatal.cocci
 
 GDB stub
-- 
2.21.1


