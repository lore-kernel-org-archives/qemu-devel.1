Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B80C4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7EC238D6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZ4+MIlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7EC238D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLbub-0003sQ-2B
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 20:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbcG-00014M-2O
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbc2-0000BC-2d
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:29:35 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600993761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LPf1pzMj8KPhnb+3IXk7jMQ4s+1YpfsVGd6crqm9dQA=;
 b=iZ4+MIlJgsnJg0yA8yiLXy5bQGuPpnCuFFA2SaQh5/e/wwPWhu6wz9vGxdDrWVg8hjzEl/
 mK+SIad9Mj323nJp9Gwr2nXg1CRXBAMkITJedMGWfcWNlRv1589kMrc+EWTbj7DRtAJeh6
 RQiqRDqe/jk/eem7aTW8mTxkIUHFnu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-fyQ42eXUO26POFKaNYVKsA-1; Thu, 24 Sep 2020 20:29:18 -0400
X-MC-Unique: fyQ42eXUO26POFKaNYVKsA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D621188C125
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 00:29:17 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BCA205D9DD;
 Fri, 25 Sep 2020 00:29:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/47] qapi/common.py: delint with pylint
Date: Thu, 24 Sep 2020 20:28:30 -0400
Message-Id: <20200925002900.465855-18-jsnow@redhat.com>
In-Reply-To: <20200925002900.465855-1-jsnow@redhat.com>
References: <20200925002900.465855-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At this point, that just means using a consistent strategy for constant names.
constants get UPPER_CASE and names not used externally get a leading underscore.

As a preference, while renaming constants to be UPPERCASE, move them to
the head of the file. Generally, it's nice to be able to audit the code
that runs on import in one central place.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qapi/common.py | 17 +++++++----------
 scripts/qapi/schema.py | 14 +++++++-------
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index b35318b72c..c096df0d2d 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -13,6 +13,10 @@
 
 import re
 
+EATSPACE = '\033EATSPACE.'
+POINTER_SUFFIX = ' *' + EATSPACE
+_C_NAME_TRANS = str.maketrans('.-', '__')
+
 
 # ENUMName -> ENUM_NAME, EnumName1 -> ENUM_NAME1
 # ENUM_NAME -> ENUM_NAME, ENUM_NAME1 -> ENUM_NAME1, ENUM_Name2 -> ENUM_NAME2
@@ -42,9 +46,6 @@ def c_enum_const(type_name, const_name, prefix=None):
     return camel_to_upper(type_name) + '_' + c_name(const_name, False).upper()
 
 
-c_name_trans = str.maketrans('.-', '__')
-
-
 # Map @name to a valid C identifier.
 # If @protect, avoid returning certain ticklish identifiers (like
 # C keywords) by prepending 'q_'.
@@ -82,17 +83,13 @@ def c_name(name, protect=True):
                      'not_eq', 'or', 'or_eq', 'xor', 'xor_eq'])
     # namespace pollution:
     polluted_words = set(['unix', 'errno', 'mips', 'sparc', 'i386'])
-    name = name.translate(c_name_trans)
+    name = name.translate(_C_NAME_TRANS)
     if protect and (name in c89_words | c99_words | c11_words | gcc_words
                     | cpp_words | polluted_words):
         return 'q_' + name
     return name
 
 
-eatspace = '\033EATSPACE.'
-pointer_suffix = ' *' + eatspace
-
-
 class Indentation:
     """
     Indentation level management.
@@ -132,12 +129,12 @@ def decrease(self, amount: int = 4) -> None:
 
 
 # Generate @code with @kwds interpolated.
-# Obey indent, and strip eatspace.
+# Obey indent, and strip EATSPACE.
 def cgen(code, **kwds):
     raw = code % kwds
     if indent:
         raw = re.sub(r'^(?!(#|$))', str(indent), raw, flags=re.MULTILINE)
-    return re.sub(re.escape(eatspace) + r' *', '', raw)
+    return re.sub(re.escape(EATSPACE) + r' *', '', raw)
 
 
 def mcgen(code, **kwds):
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index cfc52e1ae4..74c6b96d39 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -18,7 +18,7 @@
 import os
 import re
 
-from .common import c_name, pointer_suffix
+from .common import POINTER_SUFFIX, c_name
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


