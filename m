Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AD7C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB1323600
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlkhOwSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB1323600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKpgJ-0007Cp-Nc
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpQ4-0002GQ-2w
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpPy-0004aT-Tm
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600808502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8a9MVlWgBGw5Ju9tvv1Bh6clLXokzrVfUNMVBIYUfO8=;
 b=dlkhOwSw5tj/GFJ3c6R+Hr2Utk83J+NWSC2aHY0ctCX+1motIQZK1Oh/Lu7PhXcza5sfjv
 DO1guNYp1loMChdGDvVuNfC7Q/c45QYPlHwtI6GIpF4sJk14HfHxPKebxoMMcCIFmUphgF
 lJdU7WyLLj/kdTaJYf5A6Z/q8yQAAi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-NKaRi7f9MUK1IJCy_niRNg-1; Tue, 22 Sep 2020 17:01:39 -0400
X-MC-Unique: NKaRi7f9MUK1IJCy_niRNg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2C4180046B;
 Tue, 22 Sep 2020 21:01:37 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7A1655767;
 Tue, 22 Sep 2020 21:01:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 22/38] qapi/source.py: add type hint annotations
Date: Tue, 22 Sep 2020 17:00:45 -0400
Message-Id: <20200922210101.4081073-23-jsnow@redhat.com>
In-Reply-To: <20200922210101.4081073-1-jsnow@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Annotations do not change runtime behavior.
This commit *only* adds annotations.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/mypy.ini  |  5 -----
 scripts/qapi/source.py | 31 ++++++++++++++++++-------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
index 9da1dccef4..43c8bd1973 100644
--- a/scripts/qapi/mypy.ini
+++ b/scripts/qapi/mypy.ini
@@ -39,11 +39,6 @@ disallow_untyped_defs = False
 disallow_incomplete_defs = False
 check_untyped_defs = False
 
-[mypy-qapi.source]
-disallow_untyped_defs = False
-disallow_incomplete_defs = False
-check_untyped_defs = False
-
 [mypy-qapi.types]
 disallow_untyped_defs = False
 disallow_incomplete_defs = False
diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
index e97b9a8e15..1cc6a5b82d 100644
--- a/scripts/qapi/source.py
+++ b/scripts/qapi/source.py
@@ -11,37 +11,42 @@
 
 import copy
 import sys
+from typing import List, Optional, TypeVar
 
 
 class QAPISchemaPragma:
-    def __init__(self):
+    def __init__(self) -> None:
         # Are documentation comments required?
         self.doc_required = False
         # Whitelist of commands allowed to return a non-dictionary
-        self.returns_whitelist = []
+        self.returns_whitelist: List[str] = []
         # Whitelist of entities allowed to violate case conventions
-        self.name_case_whitelist = []
+        self.name_case_whitelist: List[str] = []
 
 
 class QAPISourceInfo:
-    def __init__(self, fname, line, parent):
+    T = TypeVar('T', bound='QAPISourceInfo')
+
+    def __init__(self: T, fname: str, line: int, parent: Optional[T]):
         self.fname = fname
         self.line = line
         self.parent = parent
-        self.pragma = parent.pragma if parent else QAPISchemaPragma()
-        self.defn_meta = None
-        self.defn_name = None
+        self.pragma: QAPISchemaPragma = (
+            parent.pragma if parent else QAPISchemaPragma()
+        )
+        self.defn_meta: Optional[str] = None
+        self.defn_name: Optional[str] = None
 
-    def set_defn(self, meta, name):
+    def set_defn(self, meta: str, name: str) -> None:
         self.defn_meta = meta
         self.defn_name = name
 
-    def next_line(self):
+    def next_line(self: T) -> T:
         info = copy.copy(self)
         info.line += 1
         return info
 
-    def loc(self):
+    def loc(self) -> str:
         if self.fname is None:
             return sys.argv[0]
         ret = self.fname
@@ -49,13 +54,13 @@ def loc(self):
             ret += ':%d' % self.line
         return ret
 
-    def in_defn(self):
+    def in_defn(self) -> str:
         if self.defn_name:
             return "%s: In %s '%s':\n" % (self.fname,
                                           self.defn_meta, self.defn_name)
         return ''
 
-    def include_path(self):
+    def include_path(self) -> str:
         ret = ''
         parent = self.parent
         while parent:
@@ -63,5 +68,5 @@ def include_path(self):
             parent = parent.parent
         return ret
 
-    def __str__(self):
+    def __str__(self) -> str:
         return self.include_path() + self.in_defn() + self.loc()
-- 
2.26.2


