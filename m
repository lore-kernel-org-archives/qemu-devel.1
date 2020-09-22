Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1C0C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706EC20773
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWxo4zb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706EC20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqCu-00025T-FG
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpba-0001UM-6v
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpbY-00064z-7l
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600809219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JgejwXtms9d7shSYi6P2L9OOZ+k6Lw4Sp1jD2446/rY=;
 b=AWxo4zb+sXw9yrSbWdWkF64Gj3O+OTIZt4i0eaRNnaZLEkD1gtGEXq64C/7XAAriWvphNY
 fzZc9hfsYJNKzw4Z1GqviN68G7U33ECphdRS/Ur9czFvtflHy8DmrAiGrPpkNsR0GXnvJC
 14KbtxAclf+X5SmaOJlES5qBks0GVzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-4Sr2AnaXMUmHdfcYWhWeKg-1; Tue, 22 Sep 2020 17:13:35 -0400
X-MC-Unique: 4Sr2AnaXMUmHdfcYWhWeKg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A13FF19611A1;
 Tue, 22 Sep 2020 21:13:34 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B458673682;
 Tue, 22 Sep 2020 21:13:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 16/16] qapi/expr.py: Use an expression checker dispatch table
Date: Tue, 22 Sep 2020 17:13:13 -0400
Message-Id: <20200922211313.4082880-17-jsnow@redhat.com>
In-Reply-To: <20200922211313.4082880-1-jsnow@redhat.com>
References: <20200922211313.4082880-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This enforces a type signature against all of the top-level expression
check routines without necessarily needing to create some
overcomplicated class hierarchy for them.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/expr.py | 69 ++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index 74b2681ef8..cfd342aa04 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -31,8 +31,11 @@
 structures and contextual semantic validation.
 """
 
+from enum import Enum
 import re
 from typing import (
+    Callable,
+    Dict,
     Iterable,
     List,
     MutableMapping,
@@ -494,6 +497,26 @@ def check_event(expr: Expression, info: QAPISourceInfo) -> None:
     check_type(args, info, "'data'", allow_dict=not boxed)
 
 
+class ExpressionType(str, Enum):
+    INCLUDE = 'include'
+    ENUM = 'enum'
+    UNION = 'union'
+    ALTERNATE = 'alternate'
+    STRUCT = 'struct'
+    COMMAND = 'command'
+    EVENT = 'event'
+
+
+_CHECK_FN: Dict[str, Callable[[Expression, QAPISourceInfo], None]] = {
+    'enum': check_enum,
+    'union': check_union,
+    'alternate': check_alternate,
+    'struct': check_struct,
+    'command': check_command,
+    'event': check_event,
+}
+
+
 def check_exprs(exprs: List[_JSObject]) -> List[_JSObject]:
     """
     Validate and normalize a list of parsed QAPI schema expressions. [RW]
@@ -519,28 +542,20 @@ def check_exprs(exprs: List[_JSObject]) -> List[_JSObject]:
         assert tmp is None or isinstance(tmp, QAPIDoc)
         doc: Optional[QAPIDoc] = tmp
 
-        if 'include' in expr:
-            continue
-
-        if 'enum' in expr:
-            meta = 'enum'
-        elif 'union' in expr:
-            meta = 'union'
-        elif 'alternate' in expr:
-            meta = 'alternate'
-        elif 'struct' in expr:
-            meta = 'struct'
-        elif 'command' in expr:
-            meta = 'command'
-        elif 'event' in expr:
-            meta = 'event'
+        for kind in ExpressionType:
+            if kind in expr:
+                meta = kind
+                break
         else:
             raise QAPISemError(info, "expression is missing metatype")
 
+        if meta == ExpressionType.INCLUDE:
+            continue
+
         name = cast(str, expr[meta])  # asserted right below:
-        check_name_is_str(name, info, "'%s'" % meta)
-        info.set_defn(meta, name)
-        check_defn_name_str(name, info, meta)
+        check_name_is_str(name, info, "'%s'" % meta.value)
+        info.set_defn(meta.value, name)
+        check_defn_name_str(name, info, meta.value)
 
         if doc:
             if doc.symbol != name:
@@ -551,22 +566,8 @@ def check_exprs(exprs: List[_JSObject]) -> List[_JSObject]:
             raise QAPISemError(info,
                                "documentation comment required")
 
-        if meta == 'enum':
-            check_enum(expr, info)
-        elif meta == 'union':
-            check_union(expr, info)
-        elif meta == 'alternate':
-            check_alternate(expr, info)
-        elif meta == 'struct':
-            check_struct(expr, info)
-        elif meta == 'command':
-            check_command(expr, info)
-        elif meta == 'event':
-            check_event(expr, info)
-        else:
-            assert False, 'unexpected meta type'
-
-        check_if(expr, info, meta)
+        _CHECK_FN[meta](expr, info)
+        check_if(expr, info, meta.value)
         check_features(expr.get('features'), info)
         check_flags(expr, info)
 
-- 
2.26.2


