Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD18C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 338CB208A9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzoeUU85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338CB208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqY8-0000BN-D3
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpj7-0003I6-PO
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpj5-000752-QR
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600809687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E9CQ9nBkJ2UkE7IhT+YkLiabVczHd9VF1Famx+6BpsA=;
 b=DzoeUU85Zy0IkVrzkboV/wKDralGEFppbHpFmmS0btxihMYCv9vTP5sNYY9LTZ67R+981g
 7kfpggZSQui8+TGgJz5HHNTNBx+YwD7lf9AUk5z1SAv/wt29lQYn9SM6tKrOub2eDGKcGP
 ESFR2+5+6bVRLNt0AWUXfywCxBCjSWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-TQ_1-ZiZO5eEGPEP9iCcJQ-1; Tue, 22 Sep 2020 17:21:22 -0400
X-MC-Unique: TQ_1-ZiZO5eEGPEP9iCcJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7C4C801AB3;
 Tue, 22 Sep 2020 21:21:20 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23FDE5DE50;
 Tue, 22 Sep 2020 21:21:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 1/6] qapi/error.py: refactor error classes
Date: Tue, 22 Sep 2020 17:21:10 -0400
Message-Id: <20200922212115.4084301-2-jsnow@redhat.com>
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create a ubiquitous, context-free base error class that all exceptions
in the qapi package should inherit from.

Move the QAPISourceInfo relevant fields up into QAPIErrorLocation;
making sure the order of arguments is consistent between
QAPIErrorLocation and QAPISemError.

---

The order of arguments for QAPIParseError is inconsistent, but handled
explicitly in the __init__ method; this will be addressed in forthcoming
patches, but it works correctly here.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/error.py  | 35 +++++++++++++++++++++++------------
 scripts/qapi/main.py   |  2 +-
 scripts/qapi/schema.py |  4 ++--
 3 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/scripts/qapi/error.py b/scripts/qapi/error.py
index ae60d9e2fe..47f266f33d 100644
--- a/scripts/qapi/error.py
+++ b/scripts/qapi/error.py
@@ -11,23 +11,35 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
+from typing import Optional
+
+from .source import QAPISourceInfo
+
 
 class QAPIError(Exception):
-    def __init__(self, info, col, msg):
-        Exception.__init__(self)
+    """Base class for all exceptions from the QAPI module."""
+
+
+class QAPISourceError(QAPIError):
+    """Error class for all exceptions identifying a source location."""
+    def __init__(self,
+                 info: QAPISourceInfo,
+                 msg: str,
+                 col: Optional[int] = None):
+        super().__init__()
         self.info = info
-        self.col = col
         self.msg = msg
+        self.col = col
 
-    def __str__(self):
+    def __str__(self) -> str:
         loc = str(self.info)
         if self.col is not None:
-            assert self.info.line is not None
-            loc += ':%s' % self.col
-        return loc + ': ' + self.msg
+            loc += f":{self.col}"
+        return f"{loc}: {self.msg}"
 
 
-class QAPIParseError(QAPIError):
+class QAPIParseError(QAPISourceError):
+    """Error class for all QAPI schema parsing errors."""
     def __init__(self, parser, msg):
         col = 1
         for ch in parser.src[parser.line_pos:parser.pos]:
@@ -35,9 +47,8 @@ def __init__(self, parser, msg):
                 col = (col + 7) % 8 + 1
             else:
                 col += 1
-        super().__init__(parser.info, col, msg)
+        super().__init__(parser.info, msg, col)
 
 
-class QAPISemError(QAPIError):
-    def __init__(self, info, msg):
-        super().__init__(info, None, msg)
+class QAPISemError(QAPISourceError):
+    """Error class for semantic QAPI errors."""
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index 3f8338ade8..302b9eee81 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -45,7 +45,7 @@ def generate(schema_file: str,
     if match and match.end() != len(prefix):
         msg = "funny character '{:s}' in prefix '{:s}'".format(
             prefix[match.end()], prefix)
-        raise QAPIError('', None, msg)
+        raise QAPIError(msg)
 
     schema = QAPISchema(schema_file)
     gen_types(schema, output_dir, prefix, builtins)
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 3023bab44b..121d8488d2 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -20,7 +20,7 @@
 from typing import Optional
 
 from .common import c_name, POINTER_SUFFIX
-from .error import QAPIError, QAPISemError
+from .error import QAPISourceError, QAPISemError
 from .expr import check_exprs
 from .parser import QAPISchemaParser
 
@@ -841,7 +841,7 @@ def _def_entity(self, ent):
         other_ent = self._entity_dict.get(ent.name)
         if other_ent:
             if other_ent.info:
-                where = QAPIError(other_ent.info, None, "previous definition")
+                where = QAPISourceError(other_ent.info, "previous definition")
                 raise QAPISemError(
                     ent.info,
                     "'%s' is already defined\n%s" % (ent.name, where))
-- 
2.26.2


