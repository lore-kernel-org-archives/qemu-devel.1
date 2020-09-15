Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D65C2D0E3
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 22:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D74920795
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 22:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gu+/a2Mu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D74920795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIJgn-00033p-8l
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 18:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdR-0006pg-VJ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:41:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59564
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdO-0002eb-6d
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600209669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8IBSY3vRRizP/txez2W/6YCzAC6dhjWjy9VZXC09qPI=;
 b=Gu+/a2MuVd20qxvtEGK9I9w2EUIRNuzJwu6AdKotPoj0940mfbWc7NUVmNhASm2dFj/bxU
 3neU3hPiB1qgmVQJf0OVOqRt22funz3g3UWkZY0TcrVjC3bCSHWiU45dT/bAy7vfrWjkFT
 W4JlhCcizEOfNoCf4PsQTywoBwhQHbg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-4CdUYcH_P3iUQQWbe56TmQ-1; Tue, 15 Sep 2020 18:41:05 -0400
X-MC-Unique: 4CdUYcH_P3iUQQWbe56TmQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7D001966320;
 Tue, 15 Sep 2020 22:40:53 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4444F7EEA7;
 Tue, 15 Sep 2020 22:40:52 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 10/37] qapi/common.py: delint with pylint
Date: Tue, 15 Sep 2020 18:40:00 -0400
Message-Id: <20200915224027.2529813-11-jsnow@redhat.com>
In-Reply-To: <20200915224027.2529813-1-jsnow@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 18:40:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/common.py | 16 +++++++---------
 scripts/qapi/schema.py | 14 +++++++-------
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 87d87b95e5..c665e67495 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -14,6 +14,11 @@
 import re
 
 
+EATSPACE = '\033EATSPACE.'
+POINTER_SUFFIX = ' *' + EATSPACE
+c_name_trans = str.maketrans('.-', '__')
+
+
 # ENUMName -> ENUM_NAME, EnumName1 -> ENUM_NAME1
 # ENUM_NAME -> ENUM_NAME, ENUM_NAME1 -> ENUM_NAME1, ENUM_Name2 -> ENUM_NAME2
 # ENUM24_Name -> ENUM24_NAME
@@ -42,9 +47,6 @@ def c_enum_const(type_name, const_name, prefix=None):
     return camel_to_upper(type_name) + '_' + c_name(const_name, False).upper()
 
 
-c_name_trans = str.maketrans('.-', '__')
-
-
 # Map @name to a valid C identifier.
 # If @protect, avoid returning certain ticklish identifiers (like
 # C keywords) by prepending 'q_'.
@@ -89,10 +91,6 @@ def c_name(name, protect=True):
     return name
 
 
-eatspace = '\033EATSPACE.'
-pointer_suffix = ' *' + eatspace
-
-
 class Indent:
     """
     Indent-level management.
@@ -135,12 +133,12 @@ def pop(self, amount: int = 4) -> int:
 
 
 # Generate @code with @kwds interpolated.
-# Obey indent_level, and strip eatspace.
+# Obey INDENT level, and strip EATSPACE.
 def cgen(code, **kwds):
     raw = code % kwds
     if INDENT:
         raw, _ = re.subn(r'^(?!(#|$))', str(INDENT), raw, flags=re.MULTILINE)
-    return re.sub(re.escape(eatspace) + r' *', '', raw)
+    return re.sub(re.escape(EATSPACE) + r' *', '', raw)
 
 
 def mcgen(code, **kwds):
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index b77e0e56b2..b4921b46c9 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -18,7 +18,7 @@
 import re
 from collections import OrderedDict
 
-from .common import c_name, pointer_suffix
+from .common import c_name, POINTER_SUFFIX
 from .error import QAPIError, QAPISemError
 from .expr import check_exprs
 from .parser import QAPISchemaParser
@@ -309,7 +309,7 @@ def is_implicit(self):
         return True
 
     def c_type(self):
-        return c_name(self.name) + pointer_suffix
+        return c_name(self.name) + POINTER_SUFFIX
 
     def json_type(self):
         return 'array'
@@ -430,7 +430,7 @@ def c_name(self):
 
     def c_type(self):
         assert not self.is_implicit()
-        return c_name(self.name) + pointer_suffix
+        return c_name(self.name) + POINTER_SUFFIX
 
     def c_unboxed_type(self):
         return c_name(self.name)
@@ -504,7 +504,7 @@ def connect_doc(self, doc=None):
             v.connect_doc(doc)
 
     def c_type(self):
-        return c_name(self.name) + pointer_suffix
+        return c_name(self.name) + POINTER_SUFFIX
 
     def json_type(self):
         return 'value'
@@ -896,7 +896,7 @@ def _def_builtin_type(self, name, json_type, c_type):
         self._make_array_type(name, None)
 
     def _def_predefineds(self):
-        for t in [('str',    'string',  'char' + pointer_suffix),
+        for t in [('str',    'string',  'char' + POINTER_SUFFIX),
                   ('number', 'number',  'double'),
                   ('int',    'int',     'int64_t'),
                   ('int8',   'int',     'int8_t'),
@@ -909,8 +909,8 @@ def _def_predefineds(self):
                   ('uint64', 'int',     'uint64_t'),
                   ('size',   'int',     'uint64_t'),
                   ('bool',   'boolean', 'bool'),
-                  ('any',    'value',   'QObject' + pointer_suffix),
-                  ('null',   'null',    'QNull' + pointer_suffix)]:
+                  ('any',    'value',   'QObject' + POINTER_SUFFIX),
+                  ('null',   'null',    'QNull' + POINTER_SUFFIX)]:
             self._def_builtin_type(*t)
         self.the_empty_object_type = QAPISchemaObjectType(
             'q_empty', None, None, None, None, None, [], None)
-- 
2.26.2


