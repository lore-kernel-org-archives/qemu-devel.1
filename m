Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD04C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88DF220888
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJi6rH3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DF220888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKph2-0008Pk-HF
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpQ2-0002C0-4q
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:01:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpPx-0004ZO-Vl
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600808492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VoTXH1LT6mqnbGdmbNqN1uvPhns+MLUmlaxVx2YRzLk=;
 b=ZJi6rH3xDWCGF0vADIdnPfTezP6X+LillqVFxlEyJcFyveURPQY9GwWThSPXkFHctwy7yp
 iAnHe7mpsd02BJHe+rxuBmh3XZ6E0ti2S7YadvcuzHC6UHMS7+owMlU1rokJhVMZ9if0Ta
 VyBK8SyqVXTOwcqZidDQ/V/6oe6VaXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-sHTpNouFNuG9uRJ6e8hgDw-1; Tue, 22 Sep 2020 17:01:29 -0400
X-MC-Unique: sHTpNouFNuG9uRJ6e8hgDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A0861005E5E;
 Tue, 22 Sep 2020 21:01:28 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DE4B55765;
 Tue, 22 Sep 2020 21:01:27 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 15/38] qapi/common.py: move build_params into gen.py
Date: Tue, 22 Sep 2020 17:00:38 -0400
Message-Id: <20200922210101.4081073-16-jsnow@redhat.com>
In-Reply-To: <20200922210101.4081073-1-jsnow@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

Including it in common.py creates a circular import dependency; schema
relies on common, but common.build_params requires a type annotation
from schema. To type this properly, it needs to be moved outside the
cycle.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/commands.py |  8 ++++++--
 scripts/qapi/common.py   | 23 -----------------------
 scripts/qapi/events.py   |  7 +++++--
 scripts/qapi/gen.py      | 34 ++++++++++++++++++++++++++++++++--
 4 files changed, 43 insertions(+), 29 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index d9cda3b209..9b3f24b8ed 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -14,11 +14,15 @@
 """
 
 from .common import (
-    build_params,
     c_name,
     mcgen,
 )
-from .gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
+from .gen import (
+    QAPIGenCCode,
+    QAPISchemaModularCVisitor,
+    build_params,
+    ifcontext,
+)
 
 
 def gen_command_decl(name, arg_type, boxed, ret_type):
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 730283722a..50c3d36e27 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -209,26 +209,3 @@ def gen_endif(ifcond: Sequence[str]) -> str:
 #endif /* %(cond)s */
 ''', cond=ifc)
     return ret
-
-
-def build_params(arg_type,
-                 boxed: bool,
-                 extra: Optional[str] = None) -> str:
-    ret = ''
-    sep = ''
-    if boxed:
-        assert arg_type
-        ret += '%s arg' % arg_type.c_param_type()
-        sep = ', '
-    elif arg_type:
-        assert not arg_type.variants
-        for memb in arg_type.members:
-            ret += sep
-            sep = ', '
-            if memb.optional:
-                ret += 'bool has_%s, ' % c_name(memb.name)
-            ret += '%s %s' % (memb.type.c_param_type(),
-                              c_name(memb.name))
-    if extra:
-        ret += sep + extra
-    return ret if ret else 'void'
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 6b3afa14d7..69a0ac5471 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -13,12 +13,15 @@
 """
 
 from .common import (
-    build_params,
     c_enum_const,
     c_name,
     mcgen,
 )
-from .gen import QAPISchemaModularCVisitor, ifcontext
+from .gen import (
+    QAPISchemaModularCVisitor,
+    build_params,
+    ifcontext,
+)
 from .schema import QAPISchemaEnumMember
 from .types import gen_enum, gen_enum_lookup
 
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 11472ba043..9898d513ae 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -2,9 +2,11 @@
 #
 # QAPI code generation
 #
-# Copyright (c) 2018-2019 Red Hat Inc.
+# Copyright IBM, Corp. 2011
+# Copyright (c) 2013-2019 Red Hat Inc.
 #
 # Authors:
+#  Anthony Liguori <aliguori@us.ibm.com>
 #  Markus Armbruster <armbru@redhat.com>
 #  Marc-André Lureau <marcandre.lureau@redhat.com>
 #
@@ -15,16 +17,21 @@
 import errno
 import os
 import re
+from typing import Optional
 
 from .common import (
     c_fname,
+    c_name,
     gen_endif,
     gen_if,
     guardend,
     guardstart,
     mcgen,
 )
-from .schema import QAPISchemaVisitor
+from .schema import (
+    QAPISchemaObjectType,
+    QAPISchemaVisitor,
+)
 
 
 class QAPIGen:
@@ -90,6 +97,29 @@ def _wrap_ifcond(ifcond, before, after):
     return out
 
 
+def build_params(arg_type: Optional[QAPISchemaObjectType],
+                 boxed: bool,
+                 extra: Optional[str] = None) -> str:
+    ret = ''
+    sep = ''
+    if boxed:
+        assert arg_type
+        ret += '%s arg' % arg_type.c_param_type()
+        sep = ', '
+    elif arg_type:
+        assert not arg_type.variants
+        for memb in arg_type.members:
+            ret += sep
+            sep = ', '
+            if memb.optional:
+                ret += 'bool has_%s, ' % c_name(memb.name)
+            ret += '%s %s' % (memb.type.c_param_type(),
+                              c_name(memb.name))
+    if extra:
+        ret += sep + extra
+    return ret if ret else 'void'
+
+
 class QAPIGenCCode(QAPIGen):
 
     def __init__(self, fname):
-- 
2.26.2


