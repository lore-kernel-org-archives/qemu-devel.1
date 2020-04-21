Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E669C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04256206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZp5E2Y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04256206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQpRf-0007jj-2k
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 05:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQpQB-0005jF-Jv
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQpQ9-0004dw-Oo
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:42:26 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:45495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQpQ8-0004aL-6E; Tue, 21 Apr 2020 05:42:25 -0400
Received: by mail-wr1-x42a.google.com with SMTP id t14so15645194wrw.12;
 Tue, 21 Apr 2020 02:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=96oLntjjoqhOPf+EtI3IXmVFJF9aW7sLCnox450L/Po=;
 b=iZp5E2Y3ExAAlUIYBUgTr2PWBZZ8j2bklma4Qk9dhh7zEX7QXajB7OHyyX4l3qVCi7
 1Vl2znquzHo5g5160DrBeq/n2Npa7fCLJm2gWQbF1Mf+XbBeMOPT8MzH3gixiQP4Gi1S
 o5daMPMtxZpBlsRIjKvhhUmQprESnV44om+iE8DaEz6+Ywku0ePiqFDCC3bf51dF2uU0
 rqWEZiJbPe8QCxYBOxpX5l8GMHUHr/ZyoRw8tZZzCaBWwXrU4eerB4YUK9Ji3HN13oyn
 5klRIJM4fIjIXeoI9nRQzd7o/twt7WXgvInYgpVgbpjE10EttZrRevJjoklcUmXz96bI
 mZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=96oLntjjoqhOPf+EtI3IXmVFJF9aW7sLCnox450L/Po=;
 b=Hg5KW/GtGAKYf0/jjK6Il5Mr8AEdiv2379dIdiNJ45T954Yvuecl8DL1HxgYohjRng
 /JBQEtZdh7bCHUnux5p4hfwGO3ozIlbkQFvHH+qUaZJ6+KdvoLxAENyXtm9flQ3jxNAp
 mGAYJIL6kRnfeaNSbfdEgEIPm1Xry0iOynST1xKYx7AueVXvWo6uhNKy1ySwRHyFyAlx
 Xn4DKDDiQSdILxChncpbmQY432PYOM/1AXjdwqiMrhXSI153hD9qUzjHpWlL5uout6n+
 94gvv9zH+/V043BgENulGuCI+taBXASd5fv7W3AK3+15/M8vUJ/8GCoACZcFluIudjZ4
 rl9w==
X-Gm-Message-State: AGi0PuYLETKkTrwW/E4vpR9g3fG9yRoRlZFKeadLUQjXvxr5fj2DQPI7
 cNXVrTfYusGKGdbqxOHUpupxIDbOOmU=
X-Google-Smtp-Source: APiQypJm7BgnP7XDy42rErTcRewogUVFVcxhNHjVfl6dY1G/KphXQxGl+02+FvoS5GYY4+/+iQKbKg==
X-Received: by 2002:a5d:654f:: with SMTP id z15mr24137450wrv.338.1587462141832; 
 Tue, 21 Apr 2020 02:42:21 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b22sm3082814wmj.1.2020.04.21.02.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 02:42:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] scripts/qmp: Use Python 3 interpreter
Date: Tue, 21 Apr 2020 11:42:15 +0200
Message-Id: <20200421094216.24927-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421094216.24927-1-f4bug@amsat.org>
References: <20200421094216.24927-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qmp/qom-get  | 2 +-
 scripts/qmp/qom-list | 2 +-
 scripts/qmp/qom-set  | 2 +-
 scripts/qmp/qom-tree | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/qmp/qom-get b/scripts/qmp/qom-get
index 007b4cd442..72ccd79330 100755
--- a/scripts/qmp/qom-get
+++ b/scripts/qmp/qom-get
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 ##
 # QEMU Object Model test tools
 #
diff --git a/scripts/qmp/qom-list b/scripts/qmp/qom-list
index 03bda3446b..5b8f9fd855 100755
--- a/scripts/qmp/qom-list
+++ b/scripts/qmp/qom-list
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 ##
 # QEMU Object Model test tools
 #
diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index c37fe78b00..b475e397fc 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 ##
 # QEMU Object Model test tools
 #
diff --git a/scripts/qmp/qom-tree b/scripts/qmp/qom-tree
index 1c8acf61e7..86233fa211 100755
--- a/scripts/qmp/qom-tree
+++ b/scripts/qmp/qom-tree
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 ##
 # QEMU Object Model test tools
 #
-- 
2.21.1


