Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF41C2D0E3
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 22:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2D220B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 22:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/qmoZ1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2D220B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIJmJ-0001sh-Vb
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 18:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdN-0006ji-2L
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:41:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdH-0002e7-M2
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600209662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RlAkE9kUDll+q9FsJF+IR9C8l5y0+4+kpYdf5/twi0U=;
 b=Y/qmoZ1KQzN17/w3o1jKjDAR+F2nH1IMBtsSHxRgS9A34AVd5VDdys/xrzBjcKrltvraTA
 yZ9YICCZWWdcFhgCKmUrx+teOG/1TUftgP6zxKr+IKzpn2LQK0VbSzHPE5NjHL8OR01x5A
 7qCfG5iEBfF4G0prkI92kVyVWjdNwLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-F9vyMH9pP2i1nZs6E7WRIw-1; Tue, 15 Sep 2020 18:40:59 -0400
X-MC-Unique: F9vyMH9pP2i1nZs6E7WRIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAEC98B5DED;
 Tue, 15 Sep 2020 22:40:51 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B10C781C43;
 Tue, 15 Sep 2020 22:40:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 09/37] qapi/common.py: Add indent manager
Date: Tue, 15 Sep 2020 18:39:59 -0400
Message-Id: <20200915224027.2529813-10-jsnow@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
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
---
 scripts/qapi/common.py | 50 +++++++++++++++++++++++++++++-------------
 scripts/qapi/visit.py  |  7 +++---
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 4fb265a8bf..87d87b95e5 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -93,33 +93,53 @@ def c_name(name, protect=True):
 pointer_suffix = ' *' + eatspace
 
 
-def genindent(count):
-    ret = ''
-    for _ in range(count):
-        ret += ' '
-    return ret
+class Indent:
+    """
+    Indent-level management.
 
+    :param initial: Initial value, default 0.
+    """
+    def __init__(self, initial: int = 0) -> None:
+        self._level = initial
 
-indent_level = 0
+    def __int__(self) -> int:
+        """Return the indent as an integer."""
+        return self._level
 
+    def __repr__(self) -> str:
+        return "{}({:d})".format(type(self).__name__, self._level)
 
-def push_indent(indent_amount=4):
-    global indent_level
-    indent_level += indent_amount
+    def __str__(self) -> str:
+        """Return the indent as a string."""
+        return ' ' * self._level
 
+    def __bool__(self) -> bool:
+        """True when there is a non-zero indent."""
+        return bool(self._level)
 
-def pop_indent(indent_amount=4):
-    global indent_level
-    indent_level -= indent_amount
+    def push(self, amount: int = 4) -> int:
+        """Push `amount` spaces onto the indent, default four."""
+        self._level += amount
+        return self._level
+
+    def pop(self, amount: int = 4) -> int:
+        """Pop `amount` spaces off of the indent, default four."""
+        if self._level < amount:
+            raise ArithmeticError(
+                "Can't pop {:d} spaces from {:s}".format(amount, repr(self)))
+        self._level -= amount
+        return self._level
+
+
+INDENT = Indent(0)
 
 
 # Generate @code with @kwds interpolated.
 # Obey indent_level, and strip eatspace.
 def cgen(code, **kwds):
     raw = code % kwds
-    if indent_level:
-        indent = genindent(indent_level)
-        raw, _ = re.subn(r'^(?!(#|$))', indent, raw, flags=re.MULTILINE)
+    if INDENT:
+        raw, _ = re.subn(r'^(?!(#|$))', str(INDENT), raw, flags=re.MULTILINE)
     return re.sub(re.escape(eatspace) + r' *', '', raw)
 
 
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 31bf46e7f7..66ce3dc52e 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -19,8 +19,7 @@
     gen_endif,
     gen_if,
     mcgen,
-    pop_indent,
-    push_indent,
+    INDENT,
 )
 from .gen import QAPISchemaModularCVisitor, ifcontext
 from .schema import QAPISchemaObjectType
@@ -68,7 +67,7 @@ def gen_visit_object_members(name, base, members, variants):
     if (visit_optional(v, "%(name)s", &obj->has_%(c_name)s)) {
 ''',
                          name=memb.name, c_name=c_name(memb.name))
-            push_indent()
+            INDENT.push()
         ret += mcgen('''
     if (!visit_type_%(c_type)s(v, "%(name)s", &obj->%(c_name)s, errp)) {
         return false;
@@ -77,7 +76,7 @@ def gen_visit_object_members(name, base, members, variants):
                      c_type=memb.type.c_name(), name=memb.name,
                      c_name=c_name(memb.name))
         if memb.optional:
-            pop_indent()
+            INDENT.pop()
             ret += mcgen('''
     }
 ''')
-- 
2.26.2


