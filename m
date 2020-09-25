Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF5CC4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0C3238D6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBM+CPpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0C3238D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLbm0-0001b2-LD
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 20:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbc3-00010N-5F
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbc1-0000B3-BW
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:29:22 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600993760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=itd7Gk2vFiXD6pma457JcdqSYp+OjlBf6wrCUoFxFd4=;
 b=hBM+CPpgUzthP22HjdpvE/f8XEa3G03kFp/N1mfJbDBLIX89a7YI7UEBram9mbYeT9CPI+
 H34Aw9RlqYQZZp7HN5CQBRH1KzdyItf/F4pJ+A+ov9uq/hjlGYviK11gDfqlQsOEShf8l0
 d/D7nWFnRV0WsCeznToB6Wl2j6YvSBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-gwmXmQ4PPBi3xfhCNymz7w-1; Thu, 24 Sep 2020 20:29:17 -0400
X-MC-Unique: gwmXmQ4PPBi3xfhCNymz7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9681C8015A5
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 00:29:16 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F37855D9DD;
 Fri, 25 Sep 2020 00:29:15 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/47] qapi/common.py: Add indent manager
Date: Thu, 24 Sep 2020 20:28:29 -0400
Message-Id: <20200925002900.465855-17-jsnow@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
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

Code style tools really dislike the use of global keywords, because it
generally involves re-binding the name at runtime which can have strange
effects depending on when and how that global name is referenced in
other modules.

Make a little indent level manager instead.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qapi/common.py | 49 ++++++++++++++++++++++++++++--------------
 scripts/qapi/visit.py  |  7 +++---
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index cee63eb95c..b35318b72c 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -93,33 +93,50 @@ def c_name(name, protect=True):
 pointer_suffix = ' *' + eatspace
 
 
-def genindent(count):
-    ret = ''
-    for _ in range(count):
-        ret += ' '
-    return ret
+class Indentation:
+    """
+    Indentation level management.
 
+    :param initial: Initial number of spaces, default 0.
+    """
+    def __init__(self, initial: int = 0) -> None:
+        self._level = initial
 
-indent_level = 0
+    def __int__(self) -> int:
+        return self._level
 
+    def __repr__(self) -> str:
+        return "{}({:d})".format(type(self).__name__, self._level)
 
-def push_indent(indent_amount=4):
-    global indent_level
-    indent_level += indent_amount
+    def __str__(self) -> str:
+        """Return the current indentation as a string of spaces."""
+        return ' ' * self._level
 
+    def __bool__(self) -> bool:
+        """True when there is a non-zero indentation."""
+        return bool(self._level)
 
-def pop_indent(indent_amount=4):
-    global indent_level
-    indent_level -= indent_amount
+    def increase(self, amount: int = 4) -> None:
+        """Increase the indentation level by ``amount``, default 4."""
+        self._level += amount
+
+    def decrease(self, amount: int = 4) -> None:
+        """Decrease the indentation level by ``amount``, default 4."""
+        if self._level < amount:
+            raise ArithmeticError(
+                f"Can't remove {amount:d} spaces from {self!r}")
+        self._level -= amount
+
+
+indent = Indentation()
 
 
 # Generate @code with @kwds interpolated.
-# Obey indent_level, and strip eatspace.
+# Obey indent, and strip eatspace.
 def cgen(code, **kwds):
     raw = code % kwds
-    if indent_level:
-        indent = genindent(indent_level)
-        raw = re.sub(r'^(?!(#|$))', indent, raw, flags=re.MULTILINE)
+    if indent:
+        raw = re.sub(r'^(?!(#|$))', str(indent), raw, flags=re.MULTILINE)
     return re.sub(re.escape(eatspace) + r' *', '', raw)
 
 
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 808410d6f1..14f30c228b 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -18,9 +18,8 @@
     c_name,
     gen_endif,
     gen_if,
+    indent,
     mcgen,
-    pop_indent,
-    push_indent,
 )
 from .gen import QAPISchemaModularCVisitor, ifcontext
 from .schema import QAPISchemaObjectType
@@ -69,7 +68,7 @@ def gen_visit_object_members(name, base, members, variants):
     if (visit_optional(v, "%(name)s", &obj->has_%(c_name)s)) {
 ''',
                          name=memb.name, c_name=c_name(memb.name))
-            push_indent()
+            indent.increase()
         ret += mcgen('''
     if (!visit_type_%(c_type)s(v, "%(name)s", &obj->%(c_name)s, errp)) {
         return false;
@@ -78,7 +77,7 @@ def gen_visit_object_members(name, base, members, variants):
                      c_type=memb.type.c_name(), name=memb.name,
                      c_name=c_name(memb.name))
         if memb.optional:
-            pop_indent()
+            indent.decrease()
             ret += mcgen('''
     }
 ''')
-- 
2.26.2


