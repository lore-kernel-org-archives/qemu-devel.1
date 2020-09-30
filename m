Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43C0C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 04:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515092067D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 04:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJNqF81y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515092067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNTuw-0003C6-GZ
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 00:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNTnY-0001I9-7B
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNTnT-0000bU-FK
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:32:59 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601440373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGw20eIKiIOAoBIIJQ+ThMoU0wWE4UU+clXIwJBFTTg=;
 b=UJNqF81y6FEeHo4/gEPF7ATVMAgrsCamp8Si+8+HuHl8CazYvbf0XLwzX5r+ywMvX7oz69
 34Y/WMbijA3IxJYbkXVAgoWx/GlhnxPwPaDHH6YL5TUDDFCYqowe6qtMSIE77euakMztIN
 s8jP2cUymYMnCEYmKOXcfaa/hE7JB+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-0HPtvsdrM6ugdpvTFbkxCA-1; Wed, 30 Sep 2020 00:32:51 -0400
X-MC-Unique: 0HPtvsdrM6ugdpvTFbkxCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4461185A0C3;
 Wed, 30 Sep 2020 04:32:49 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1BFC7B40D;
 Wed, 30 Sep 2020 04:32:48 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 28/46] qapi/source.py: add type hint annotations
Date: Wed, 30 Sep 2020 00:31:32 -0400
Message-Id: <20200930043150.1454766-29-jsnow@redhat.com>
In-Reply-To: <20200930043150.1454766-1-jsnow@redhat.com>
References: <20200930043150.1454766-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Annotations do not change runtime behavior.
This commit *only* adds annotations.

A note on typing of __init__: mypy requires init functions with no
parameters to document a return type of None to be considered fully
typed. In the case when there are input parameters, None may be omitted.

Since __init__ may never return any value, it is preferred to omit the
return annotation whenever possible.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qapi/mypy.ini  |  5 -----
 scripts/qapi/source.py | 31 ++++++++++++++++++-------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
index 8ab9ac52cc4..1b8555dfa39 100644
--- a/scripts/qapi/mypy.ini
+++ b/scripts/qapi/mypy.ini
@@ -34,11 +34,6 @@ disallow_untyped_defs = False
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
index e97b9a8e15e..1cc6a5b82dc 100644
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


