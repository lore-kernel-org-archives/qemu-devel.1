Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DD5C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DBE620684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d99Ev7SZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBE620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqbn-0002zD-HL
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpjA-0003Nl-73
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:21:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42969
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpj6-000758-4S
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600809687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=anPAbXBkp03pw8LMYlKFzKmngBz/OfqgdOSOuSjY1Y0=;
 b=d99Ev7SZEcWWfiBY8OvvTlJg8mosaQPcb8B6Pwf56yQL47HDj6Ma2LXNxbVgszRhVVJpcJ
 hr43GjCqzeOARnejrCbOPID5R1JONB9speXZ34a9Msn/0OuOxgYxFD/u+c5FjWmLm0auel
 crz7dG0YSCh/91Ltt5cUnYLQmEeEgZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-Ij-knH8KOamVazj3FUkOzQ-1; Tue, 22 Sep 2020 17:21:23 -0400
X-MC-Unique: Ij-knH8KOamVazj3FUkOzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E467C801ABC;
 Tue, 22 Sep 2020 21:21:22 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1ADC25DE50;
 Tue, 22 Sep 2020 21:21:22 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 3/6] qapi/error.py: move QAPIParseError to parser.py
Date: Tue, 22 Sep 2020 17:21:12 -0400
Message-Id: <20200922212115.4084301-4-jsnow@redhat.com>
In-Reply-To: <20200922212115.4084301-1-jsnow@redhat.com>
References: <20200922212115.4084301-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 17:01:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/error.py  | 12 ------------
 scripts/qapi/parser.py | 14 +++++++++++++-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/scripts/qapi/error.py b/scripts/qapi/error.py
index 47f266f33d..ab6a0f6271 100644
--- a/scripts/qapi/error.py
+++ b/scripts/qapi/error.py
@@ -38,17 +38,5 @@ def __str__(self) -> str:
         return f"{loc}: {self.msg}"
 
 
-class QAPIParseError(QAPISourceError):
-    """Error class for all QAPI schema parsing errors."""
-    def __init__(self, parser, msg):
-        col = 1
-        for ch in parser.src[parser.line_pos:parser.pos]:
-            if ch == '\t':
-                col = (col + 7) % 8 + 1
-            else:
-                col += 1
-        super().__init__(parser.info, msg, col)
-
-
 class QAPISemError(QAPISourceError):
     """Error class for semantic QAPI errors."""
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index cb2595ce60..7e7eda9ed9 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -18,10 +18,22 @@
 import re
 from collections import OrderedDict
 
-from .error import QAPIError, QAPIParseError, QAPISemError
+from .error import QAPIError, QAPISourceError, QAPISemError
 from .source import QAPISourceInfo
 
 
+class QAPIParseError(QAPISourceError):
+    """Error class for all QAPI schema parsing errors."""
+    def __init__(self, parser, msg):
+        col = 1
+        for ch in parser.src[parser.line_pos:parser.pos]:
+            if ch == '\t':
+                col = (col + 7) % 8 + 1
+            else:
+                col += 1
+        super().__init__(parser.info, msg, col)
+
+
 class QAPIDocError(QAPIError):
     """Documentation parsing error."""
 
-- 
2.26.2


