Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED83BC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 08:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6B22080C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 08:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEwi1hKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6B22080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY3p4-0004ro-Qk
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 04:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY3nU-0003KB-Ux
 for qemu-devel@nongnu.org; Mon, 11 May 2020 04:28:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59525
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY3nS-0005pd-VE
 for qemu-devel@nongnu.org; Mon, 11 May 2020 04:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589185702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EdEkKifv9sBa/sBVzNieXwncHlzbzRmDxxk06hFaTkk=;
 b=SEwi1hKvFUCHIK3ZJFguO3KId9hvHg2WJndMuSmDxbcxz+T+w5Qggj8HxjSwdCM5nZlD4M
 NPPULTHzPFP4kzrWFMkkN6j0habnQzeTyoRpb4+XeGy9B1rSKtBfqjAHNTh+X0PX7CzCpy
 nZiuEdLljiB+31Myz/0nDLgrOQsLbUw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-33GSdhuLPiyN6klXLqTgsQ-1; Mon, 11 May 2020 04:28:20 -0400
X-MC-Unique: 33GSdhuLPiyN6klXLqTgsQ-1
Received: by mail-wm1-f71.google.com with SMTP id w189so4282876wmg.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 01:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EdEkKifv9sBa/sBVzNieXwncHlzbzRmDxxk06hFaTkk=;
 b=BBp6iO8M4GPkol9FASer24/IzldqkLumaTJnGzfFLdeSCchrJfgHIrr7B790N8+0Gn
 oWQvH8pNvc2qb+/TVgBvTDu4vANqFCrH8obA/zMFnKkxKEr6+31NwF5AUibl1F/RaUi9
 1TYHVrZ2gB3sA57JLYhvaaVBVK8eITDy+Nz9Nz2KLbxS0UX6/v1IJF26fuXRM+/PqFLu
 ily0eYSdL+KfMQzPwexRN3pF5mj7pKAXjl2WWeINj2nAXZJwveaMBprNKoMXSds9oaQp
 sZV3dEUKRm7YEdmLuz/Ud5t6In66ep7bKW1foP+3T5n76ec17rhwE2HBqgsHhhY0uO5x
 byRw==
X-Gm-Message-State: AGi0PuYk06lP1Q5wBN3v68W81YWmh9HUVdnCdIr1Ps8LYzaEzbiArd48
 JbXiSBgv03tbH6SQ1CC55/kYeRioBCztCDaCG6DfIb97bM4iPH3O85A3xqByMKKbdvwEw5EoDS4
 XfGJcHhguNlRiLgo=
X-Received: by 2002:a1c:9e51:: with SMTP id h78mr32303664wme.177.1589185698795; 
 Mon, 11 May 2020 01:28:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypJAU1InPfKBnYFEIuqlGR3bbHZHjIaOPNt8tuAxZed7CU5KeOpacJszWuRXnEv0xoQJzsIS5Q==
X-Received: by 2002:a1c:9e51:: with SMTP id h78mr32303639wme.177.1589185698557; 
 Mon, 11 May 2020 01:28:18 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 1sm26363072wmi.0.2020.05.11.01.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 01:28:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] scripts/tracetool: Update maintainer email address
Date: Mon, 11 May 2020 10:28:16 +0200
Message-Id: <20200511082816.696-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:55:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is an effort in progress to generate a QEMU Python
package. As I'm not sure this old email is still valid,
update it to not produce package with broken maintainer
email.

Patch created mechanically by running:

 $ sed -i 's,\(__email__ *= "\)stefanha@linux.vnet.ibm.com",\1stefanha@redhat.com",' \
         $(git grep -l 'email.*stefanha@linux.vnet.ibm.com')

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 scripts/tracetool.py                             | 2 +-
 scripts/tracetool/__init__.py                    | 2 +-
 scripts/tracetool/backend/__init__.py            | 2 +-
 scripts/tracetool/backend/dtrace.py              | 2 +-
 scripts/tracetool/backend/log.py                 | 2 +-
 scripts/tracetool/backend/simple.py              | 2 +-
 scripts/tracetool/backend/ust.py                 | 2 +-
 scripts/tracetool/format/__init__.py             | 2 +-
 scripts/tracetool/format/c.py                    | 2 +-
 scripts/tracetool/format/d.py                    | 2 +-
 scripts/tracetool/format/h.py                    | 2 +-
 scripts/tracetool/format/stap.py                 | 2 +-
 scripts/tracetool/format/tcg_h.py                | 2 +-
 scripts/tracetool/format/tcg_helper_c.py         | 2 +-
 scripts/tracetool/format/tcg_helper_h.py         | 2 +-
 scripts/tracetool/format/tcg_helper_wrapper_h.py | 2 +-
 scripts/tracetool/transform.py                   | 2 +-
 scripts/tracetool/vcpu.py                        | 2 +-
 18 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/scripts/tracetool.py b/scripts/tracetool.py
index 264cc9eecc..31146242b7 100755
--- a/scripts/tracetool.py
+++ b/scripts/tracetool.py
@@ -10,7 +10,7 @@
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@linux.vnet.ibm.com"
+__email__      = "stefanha@redhat.com"
 
 
 import sys
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 13d29f1e42..3ccfa1e116 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -9,7 +9,7 @@
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@linux.vnet.ibm.com"
+__email__      = "stefanha@redhat.com"
 
 
 import re
diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index 54cab2c4de..7bfcc86cc5 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -50,7 +50,7 @@
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@linux.vnet.ibm.com"
+__email__      = "stefanha@redhat.com"
 
 
 import os
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index 638990db79..5711892ba0 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -9,7 +9,7 @@
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@linux.vnet.ibm.com"
+__email__      = "stefanha@redhat.com"
 
 
 from tracetool import out
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 23b274c0fd..877222bbe9 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -9,7 +9,7 @@
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@linux.vnet.ibm.com"
+__email__      = "stefanha@redhat.com"
 
 
 from tracetool import out
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index b650c262b5..a74d61fcd6 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -9,7 +9,7 @@
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@linux.vnet.ibm.com"
+__email__      = "stefanha@redhat.com"
 
 
 from tracetool import out
diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
index a772a3b53b..6c0a5f8d68 100644
--- a/scripts/tracetool/backend/ust.py
+++ b/scripts/tracetool/backend/ust.py
@@ -9,7 +9,7 @@
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@linux.vnet.ibm.com"
+__email__      = "stefanha@redhat.com"
 
 
 from tracetool import out
diff --git a/scripts/tracetool/format/__init__.py b/scripts/tracetool/format/__init__.py
index aba2f7a441..2dc46f3dd9 100644
--- a/scripts/tracetool/format/__init__.py
+++ b/scripts/tracetool/format/__init__.py
@@ -32,7 +32,7 @@
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@linux.vnet.ibm.com"
+__email__      = "stefanha@redhat.com"
 
 
 import os
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index 78af8aff72..23d82ea861 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -9,7 +9,7 @@
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@linux.vnet.ibm.com"
+__email__      = "stefanha@redhat.com"
 
 
 from tracetool import out
diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
index d3980b914b..0afb5f3f47 100644
--- a/scripts/tracetool/format/d.py
+++ b/scripts/tracetool/format/d.py
@@ -9,7 +9,7 @@
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@linux.vnet.ibm.com"
+__email__      = "stefanha@redhat.com"
 
 
 from tracetool import out
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index 83e1a2f355..e94f0be7da 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -9,7 +9,7 @@
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@linux.vnet.ibm.com"
+__email__      = "stefanha@redhat.com"
 
 
 from tracetool import out
diff --git a/scripts/tracetool/format/stap.py b/scripts/tracetool/format/stap.py
index 8fc808f2ef..a218b0445c 100644
--- a/scripts/tracetool/format/stap.py
+++ b/scripts/tracetool/format/stap.py
@@ -9,7 +9,7 @@
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@linux.vnet.ibm.com"
+__email__      = "stefanha@redhat.com"
 
 
 from tracetool import out
diff --git a/scripts/tracetool/format/tcg_h.py b/scripts/tracetool/format/tcg_h.py
index 0180e3d76c..33cf6a31b3 100644
--- a/scripts/tracetool/format/tcg_h.py
+++ b/scripts/tracetool/format/tcg_h.py
@@ -9,7 +9,7 @@
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@linux.vnet.ibm.com"
+__email__      = "stefanha@redhat.com"
 
 
 from tracetool import out, Arguments
diff --git a/scripts/tracetool/format/tcg_helper_c.py b/scripts/tracetool/format/tcg_helper_c.py
index 6527b69afd..2db6317f3c 100644
--- a/scripts/tracetool/format/tcg_helper_c.py
+++ b/scripts/tracetool/format/tcg_helper_c.py
@@ -9,7 +9,7 @@
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@linux.vnet.ibm.com"
+__email__      = "stefanha@redhat.com"
 
 
 from tracetool import Arguments, out
diff --git a/scripts/tracetool/format/tcg_helper_h.py b/scripts/tracetool/format/tcg_helper_h.py
index 98ebe52f18..08554fbc85 100644
--- a/scripts/tracetool/format/tcg_helper_h.py
+++ b/scripts/tracetool/format/tcg_helper_h.py
@@ -9,7 +9,7 @@
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@linux.vnet.ibm.com"
+__email__      = "stefanha@redhat.com"
 
 
 from tracetool import out
diff --git a/scripts/tracetool/format/tcg_helper_wrapper_h.py b/scripts/tracetool/format/tcg_helper_wrapper_h.py
index 6adeab74df..0c5a9797d1 100644
--- a/scripts/tracetool/format/tcg_helper_wrapper_h.py
+++ b/scripts/tracetool/format/tcg_helper_wrapper_h.py
@@ -9,7 +9,7 @@
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@linux.vnet.ibm.com"
+__email__      = "stefanha@redhat.com"
 
 
 from tracetool import out
diff --git a/scripts/tracetool/transform.py b/scripts/tracetool/transform.py
index 8fd4dcf20d..ea8b27799d 100644
--- a/scripts/tracetool/transform.py
+++ b/scripts/tracetool/transform.py
@@ -9,7 +9,7 @@
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@linux.vnet.ibm.com"
+__email__      = "stefanha@redhat.com"
 
 
 def _transform_type(type_, trans):
diff --git a/scripts/tracetool/vcpu.py b/scripts/tracetool/vcpu.py
index 0b104e4f15..b54e4f4e7a 100644
--- a/scripts/tracetool/vcpu.py
+++ b/scripts/tracetool/vcpu.py
@@ -10,7 +10,7 @@
 __license__    = "GPL version 2 or (at your option) any later version"
 
 __maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@linux.vnet.ibm.com"
+__email__      = "stefanha@redhat.com"
 
 
 from tracetool import Arguments, try_import
-- 
2.21.3


