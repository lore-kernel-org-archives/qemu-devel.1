Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18E9C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A5221775
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9fbHGhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A5221775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPWhJ-0006Ia-2C
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 16:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPWX9-0000Ve-HI
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 15:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPWX7-0007AP-AG
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 15:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601927548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ybbMySC/0u9IR0Th546QMy9LpOxRoMz0sTM2iXqSsaA=;
 b=E9fbHGhSvEF8oZG6NNLQr+kL8+ySQlrycDmIwVJtFRhSIx40EdpCdEEXDCku/Ysmd249Bx
 3KybqXwRRdqmnQsl4Guhyip/W5dkeBVEf6FSzlkXWEODSGSQQ4iGe6E6AtwbRMQ8JzmRYJ
 IhmANW2sgs+6/mGSE+KWZp/+f+X0psE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-uuvLHfLLPxubuSa1Da-wnA-1; Mon, 05 Oct 2020 15:52:26 -0400
X-MC-Unique: uuvLHfLLPxubuSa1Da-wnA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01FAD1015CA6
 for <qemu-devel@nongnu.org>; Mon,  5 Oct 2020 19:52:26 +0000 (UTC)
Received: from scv.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD37C5C1BD;
 Mon,  5 Oct 2020 19:52:24 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 17/36] qapi/common.py: move build_params into gen.py
Date: Mon,  5 Oct 2020 15:51:39 -0400
Message-Id: <20201005195158.2348217-18-jsnow@redhat.com>
In-Reply-To: <20201005195158.2348217-1-jsnow@redhat.com>
References: <20201005195158.2348217-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Including it in common.py creates a circular import dependency; schema
relies on common, but common.build_params requires a type annotation
from schema. To type this properly, it needs to be moved outside the
cycle.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qapi/commands.py |  9 +++++++--
 scripts/qapi/common.py   | 23 -----------------------
 scripts/qapi/events.py   |  9 ++-------
 scripts/qapi/gen.py      | 31 +++++++++++++++++++++++++++++--
 4 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 5dc2f5a9fa8..f67393f8713 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -13,8 +13,13 @@
 See the COPYING file in the top-level directory.
 """
 
-from .common import build_params, c_name, mcgen
-from .gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
+from .common import c_name, mcgen
+from .gen import (
+    QAPIGenCCode,
+    QAPISchemaModularCVisitor,
+    build_params,
+    ifcontext,
+)
 
 
 def gen_command_decl(name, arg_type, boxed, ret_type):
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 0ef38ea5fe0..9ab0685cc51 100644
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
index 6b3afa14d72..f840a62ed92 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -12,13 +12,8 @@
 See the COPYING file in the top-level directory.
 """
 
-from .common import (
-    build_params,
-    c_enum_const,
-    c_name,
-    mcgen,
-)
-from .gen import QAPISchemaModularCVisitor, ifcontext
+from .common import c_enum_const, c_name, mcgen
+from .gen import QAPISchemaModularCVisitor, build_params, ifcontext
 from .schema import QAPISchemaEnumMember
 from .types import gen_enum, gen_enum_lookup
 
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 1fed712b43b..f2e2746fea5 100644
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
@@ -15,16 +17,18 @@
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
+from .schema import QAPISchemaObjectType, QAPISchemaVisitor
 
 
 class QAPIGen:
@@ -90,6 +94,29 @@ def _wrap_ifcond(ifcond, before, after):
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


