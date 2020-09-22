Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DA3C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5418C20757
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjQjGqgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5418C20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKr3G-0002NF-Be
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqt3-0004eP-Ld
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqt1-0007fj-Rk
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zf3U7GT859YgMsfNxOYBu76mnA//cyA3+FAGAPVPv3I=;
 b=AjQjGqgHcHXGl29WH8uf58vIRECV74wxpzaF327im3SrJQ6ClHcdEQml7WIP+mhMl0HMxw
 /49zxgelDhhoDwSw3Wda4PPLB9CCDRJyYG0wSqlz8spTWQ9Xwm3WA+xS/8hNbRF+fgrzYR
 fk03afFzSoQYzy3JssVT/oM2QR7gC00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-qoncvMnvPzWAb5OZd-7p_A-1; Tue, 22 Sep 2020 18:35:45 -0400
X-MC-Unique: qoncvMnvPzWAb5OZd-7p_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80CD41074641;
 Tue, 22 Sep 2020 22:35:44 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABAA560BF4;
 Tue, 22 Sep 2020 22:35:43 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 16/26] qapi/pragma.py: Move QAPISchemaPragma into its own
 module
Date: Tue, 22 Sep 2020 18:35:15 -0400
Message-Id: <20200922223525.4085762-17-jsnow@redhat.com>
In-Reply-To: <20200922223525.4085762-1-jsnow@redhat.com>
References: <20200922223525.4085762-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:47:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/pragma.py | 25 +++++++++++++++++++++++++
 scripts/qapi/source.py | 15 ++-------------
 2 files changed, 27 insertions(+), 13 deletions(-)
 create mode 100644 scripts/qapi/pragma.py

diff --git a/scripts/qapi/pragma.py b/scripts/qapi/pragma.py
new file mode 100644
index 0000000000..7f3db9ab87
--- /dev/null
+++ b/scripts/qapi/pragma.py
@@ -0,0 +1,25 @@
+#
+# QAPI pragma information
+#
+# Copyright (c) 2020 John Snow, for Red Hat Inc.
+#
+# Authors:
+#  John Snow <jsnow@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+
+from typing import List
+
+
+class QAPISchemaPragma:
+    # Replace with @dataclass in Python 3.7+
+    # pylint: disable=too-few-public-methods
+
+    def __init__(self) -> None:
+        # Are documentation comments required?
+        self.doc_required = False
+        # Whitelist of commands allowed to return a non-dictionary
+        self.returns_whitelist: List[str] = []
+        # Whitelist of entities allowed to violate case conventions
+        self.name_case_whitelist: List[str] = []
diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
index d1de9e36b1..fe1424be03 100644
--- a/scripts/qapi/source.py
+++ b/scripts/qapi/source.py
@@ -11,20 +11,9 @@
 
 import copy
 import sys
-from typing import List, Optional, TypeVar
+from typing import Optional, TypeVar
 
-
-class QAPISchemaPragma:
-    # Replace with @dataclass in Python 3.7+
-    # pylint: disable=too-few-public-methods
-
-    def __init__(self) -> None:
-        # Are documentation comments required?
-        self.doc_required = False
-        # Whitelist of commands allowed to return a non-dictionary
-        self.returns_whitelist: List[str] = []
-        # Whitelist of entities allowed to violate case conventions
-        self.name_case_whitelist: List[str] = []
+from .pragma import QAPISchemaPragma
 
 
 class QAPISourceInfo:
-- 
2.26.2


