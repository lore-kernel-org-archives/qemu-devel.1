Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D0BC2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 19:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A14EA206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 19:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLVwX8/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14EA206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHBZV-0001eb-Pm
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 15:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBY0-0008AA-G1
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 15:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBXz-0008H2-8v
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 15:18:40 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBXz-0008GY-2u; Wed, 25 Mar 2020 15:18:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id l20so4168702wmi.3;
 Wed, 25 Mar 2020 12:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K/JaHB+lFk7HG80DcgONiqIurhrs6UE02bBz6uqJR8c=;
 b=cLVwX8/AKjx5dwLq4t8JJORTVvuXAwK1uGvNmRoxl6ZLkb+MntiBtYZ2hBIgiWV+e9
 jZJ6/YYqMxgMIFkBI0f14zO3qTy5xVv2pyRksIqKoXGVCA3KShdjBZ7SnM25JH6NrmqR
 JUhVSihnxCr3lQdmAJzxZX/YuxRAdUL3b0XhzWdiNCekoyB/KXjqFoVJzi7U0+REAOiz
 dbJQXNI3xPnCoRcopblHfzGguFYbOMKoaT1GlCaYD5K+YXys4jo+wiY72orvR+TVJYuH
 He1QkL7vL4bTu2EGqPboeQQLTNDAkxvMIajZednFRdJjSmyF9BHqDxtKjsnWF0P3v2FD
 Hu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=K/JaHB+lFk7HG80DcgONiqIurhrs6UE02bBz6uqJR8c=;
 b=gUjQ3osXYzhxTt8BBu84ytOJJr9gvitpIh3SZCTtdsRhDa20iWzUEQtyiTXJn+WAmc
 hIvQVfqQnTSJG5T6B0CVDuLgcQWNTUDm7/JYDPAIYIn0wSDZKo8YeuDEK8N5oqYqFTrI
 Afb/y1YLYW4RgzwMvuJGvWLWCjcZjoISHVKBTY1tM6Plv1oqqHv54ayj4/C8YjJXCEH4
 orvN5WcXX59oPmF5HkqBrL00LQ544T+EnY7Mw9R/Y8f7EQcl3pBlBQe3f23MyvWrpnoI
 L9S6klir2ZHhJ8lIUL7tr0Ktv8ltxUyRaMQRT6lde+LAshXueLzYQBMtyKzQpHVqCJqh
 8OHA==
X-Gm-Message-State: ANhLgQ1s10ACC9wNHyH91fjk23EGYWBYGF4QpoDaAe5fBPRHrCK2rQDW
 fZcG+4ojtrx8OUtvbz5byAabLscVHCc=
X-Google-Smtp-Source: ADFU+vuROd1aMCAmH89F03zQCayPuBM54QQs9QdkvzeModzun4oQn5Zc+cBk7XEeNC3dyQQtxl6cZA==
X-Received: by 2002:a1c:456:: with SMTP id 83mr4977190wme.54.1585163917680;
 Wed, 25 Mar 2020 12:18:37 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id r17sm6345672wrx.46.2020.03.25.12.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 12:18:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 01/12] scripts/coccinelle: Add script to catch missing
 error_propagate() calls
Date: Wed, 25 Mar 2020 20:18:19 +0100
Message-Id: <20200325191830.16553-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325191830.16553-1-f4bug@amsat.org>
References: <20200325191830.16553-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In some places in we put an error into a local Error*, but forget
to check for failure and pass it back to the caller.
Add a Coccinelle patch to catch automatically add the missing code.

Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 ...ect_property_missing_error_propagate.cocci | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 scripts/coccinelle/object_property_missing_error_propagate.cocci

diff --git a/scripts/coccinelle/object_property_missing_error_propagate.cocci b/scripts/coccinelle/object_property_missing_error_propagate.cocci
new file mode 100644
index 0000000000..104e345273
--- /dev/null
+++ b/scripts/coccinelle/object_property_missing_error_propagate.cocci
@@ -0,0 +1,58 @@
+// Add missing error-propagation code
+//
+// Copyright: (C) 2020 Philippe Mathieu-Daudé.
+// This work is licensed under the terms of the GNU GPLv2 or later.
+//
+// spatch \
+//  --macro-file scripts/cocci-macro-file.h --include-headers \
+//  --sp-file scripts/coccinelle/object_property_missing_error_propagate.cocci \
+//  --keep-comments --smpl-spacing --in-place --dir hw
+//
+// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg691638.html
+
+@match exists@
+typedef Error;
+Error *err;
+identifier func, errp;
+identifier object_property_set_type1 =~ "^object_property_set_.*";
+identifier object_property_set_type2 =~ "^object_property_set_.*";
+expression obj;
+@@
+void func(..., Error **errp)
+{
+ <+...
+ object_property_set_type1(obj, ..., &err);
+ ... when != err
+ object_property_set_type2(obj, ..., &err);
+ ...+>
+}
+
+@@
+Error *match.err;
+identifier match.errp;
+identifier match.object_property_set_type1;
+expression match.obj;
+@@
+ object_property_set_type1(obj, ..., &err);
++if (err) {
++    error_propagate(errp, err);
++    return;
++}
+
+@manual depends on never match@
+Error *err;
+identifier object_property_set_type1 =~ "^object_property_set_.*";
+identifier object_property_set_type2 =~ "^object_property_set_.*";
+position p;
+@@
+ object_property_set_type1@p(..., &err);
+ ... when != err
+ object_property_set_type2(..., &err);
+
+@script:python@
+f << manual.object_property_set_type1;
+p << manual.p;
+@@
+print("[[manual check required: "
+      "error_propagate() might be missing in {}() {}:{}:{}]]".format(
+            f, p[0].file, p[0].line, p[0].column))
-- 
2.21.1


