Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B6AC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 23:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4A8221EB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 23:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOXVY82k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4A8221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKrKz-0005Xx-JN
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 19:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKr2E-000203-OG
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:45:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKr2B-0000Kk-Uy
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=941wT9PRkLq+7LgTx6a7Ln++uVA8C62LzKgt4uutqu4=;
 b=KOXVY82krVeOqnmiZOj+BYS+Szic9Bb4wK5CjI5YCjVhFVK42Vb8tm8d+ZaDAXMTU9Qip6
 +mptmJIdanAMZiV7/Nqxvy5ul3C4RIkmzvtnCaj3B1PwouUwOl2lHfZCGkwoSC0sI8XP8y
 ZgRBOadGq+a41JuSKuk+gPQBb0jXR3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-xVehLaCBMpepa1M_ndME-A-1; Tue, 22 Sep 2020 18:45:11 -0400
X-MC-Unique: xVehLaCBMpepa1M_ndME-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E66E1005E77;
 Tue, 22 Sep 2020 22:45:10 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80A225C1A3;
 Tue, 22 Sep 2020 22:45:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 02/25] qapi/schema.py: Move meta-type into class instances
Date: Tue, 22 Sep 2020 18:44:38 -0400
Message-Id: <20200922224501.4087749-3-jsnow@redhat.com>
In-Reply-To: <20200922224501.4087749-1-jsnow@redhat.com>
References: <20200922224501.4087749-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
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

We are using meta as a class variable, but union types use this as a
mutable value which changes the value for the class, not the instance.

Use the empty string as the default/empty value for ease of typing. It
is still false-ish, so it will work just fine.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 55434f5c82..0201b42095 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -17,7 +17,6 @@
 import os
 import re
 from collections import OrderedDict
-from typing import Optional
 
 from .common import c_name, POINTER_SUFFIX
 from .error import QAPISourceError, QAPISemError
@@ -32,8 +31,6 @@ def visit(self, visitor: 'QAPISchemaVisitor') -> None:
 
 
 class QAPISchemaEntity(Visitable):
-    meta: Optional[str] = None
-
     def __init__(self, name: str, info, doc, ifcond=None, features=None):
         assert name is None or isinstance(name, str)
         for f in features or []:
@@ -51,6 +48,15 @@ def __init__(self, name: str, info, doc, ifcond=None, features=None):
         self._ifcond = ifcond or []
         self.features = features or []
         self._checked = False
+        self._meta = ''
+
+    @property
+    def meta(self) -> str:
+        return self._meta
+
+    @meta.setter
+    def meta(self, value: str) -> None:
+        self._meta = value
 
     def c_name(self):
         return c_name(self.name)
@@ -212,8 +218,6 @@ def describe(self):
 
 
 class QAPISchemaBuiltinType(QAPISchemaType):
-    meta = 'built-in'
-
     def __init__(self, name, json_type, c_type):
         super().__init__(name, None, None)
         assert not c_type or isinstance(c_type, str)
@@ -221,6 +225,7 @@ def __init__(self, name, json_type, c_type):
                              'value')
         self._json_type_name = json_type
         self._c_type_name = c_type
+        self._meta = 'built-in'
 
     def c_name(self):
         return self.name
@@ -245,8 +250,6 @@ def visit(self, visitor):
 
 
 class QAPISchemaEnumType(QAPISchemaType):
-    meta = 'enum'
-
     def __init__(self, name, info, doc, ifcond, features, members, prefix):
         super().__init__(name, info, doc, ifcond, features)
         for m in members:
@@ -255,6 +258,7 @@ def __init__(self, name, info, doc, ifcond, features, members, prefix):
         assert prefix is None or isinstance(prefix, str)
         self.members = members
         self.prefix = prefix
+        self._meta = 'enum'
 
     def check(self, schema):
         super().check(schema)
@@ -289,13 +293,12 @@ def visit(self, visitor):
 
 
 class QAPISchemaArrayType(QAPISchemaType):
-    meta = 'array'
-
     def __init__(self, name, info, element_type):
         super().__init__(name, info, None)
         assert isinstance(element_type, str)
         self._element_type_name = element_type
         self.element_type = None
+        self._meta = 'array'
 
     def check(self, schema):
         super().check(schema)
@@ -344,7 +347,7 @@ def __init__(self, name, info, doc, ifcond, features,
         # flat union has base, variants, and no local_members
         # simple union has local_members, variants, and no base
         super().__init__(name, info, doc, ifcond, features)
-        self.meta = 'union' if variants else 'struct'
+        self._meta = 'union' if variants else 'struct'
         assert base is None or isinstance(base, str)
         for m in local_members:
             assert isinstance(m, QAPISchemaObjectTypeMember)
@@ -456,8 +459,6 @@ def visit(self, visitor):
 
 
 class QAPISchemaAlternateType(QAPISchemaType):
-    meta = 'alternate'
-
     def __init__(self, name, info, doc, ifcond, features, variants):
         super().__init__(name, info, doc, ifcond, features)
         assert isinstance(variants, QAPISchemaVariants)
@@ -465,6 +466,7 @@ def __init__(self, name, info, doc, ifcond, features, variants):
         variants.set_defined_in(name)
         variants.tag_member.set_defined_in(self.name)
         self.variants = variants
+        self._meta = 'alternate'
 
     def check(self, schema):
         super().check(schema)
@@ -716,8 +718,6 @@ def __init__(self, name, info, typ, ifcond=None):
 
 
 class QAPISchemaCommand(QAPISchemaEntity):
-    meta = 'command'
-
     def __init__(self, name, info, doc, ifcond, features,
                  arg_type, ret_type,
                  gen, success_response, boxed, allow_oob, allow_preconfig):
@@ -733,6 +733,7 @@ def __init__(self, name, info, doc, ifcond, features,
         self.boxed = boxed
         self.allow_oob = allow_oob
         self.allow_preconfig = allow_preconfig
+        self._meta = 'command'
 
     def check(self, schema):
         super().check(schema)
@@ -779,14 +780,13 @@ def visit(self, visitor):
 
 
 class QAPISchemaEvent(QAPISchemaEntity):
-    meta = 'event'
-
     def __init__(self, name, info, doc, ifcond, features, arg_type, boxed):
         super().__init__(name, info, doc, ifcond, features)
         assert not arg_type or isinstance(arg_type, str)
         self._arg_type_name = arg_type
         self.arg_type = None
         self.boxed = boxed
+        self._meta = 'event'
 
     def check(self, schema):
         super().check(schema)
-- 
2.26.2


