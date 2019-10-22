Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29B0C47E49
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 07:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF16218AE
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 07:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVyYi/pg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF16218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMp37-0004eh-A1
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 03:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iMp1j-0002jB-KF
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iMp1i-0005sC-57
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:56:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44403
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iMp1h-0005q4-V2
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571730980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=21Uw3xmpy8gvkdLi9ac9wyAHac+w6H5WUaJtMdh+330=;
 b=VVyYi/pg2rcfBNkVVTNFK+4j8KHew89WIc6wkeVbnRXyNS7BkEFePNTxdWtfGPtPsjj1rp
 E8W3f/LzjhTYJ2tlQCes3FHIKKp4suIfPM0H/mlKH9BYWG8Pjdz1ieViEytEqd1K/IyvAf
 ODorHK51ZFcS3LIaBnPSBQ0dtl8/1bs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-7jB4B0KQNkyY_cTOLeDqMA-1; Tue, 22 Oct 2019 03:56:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5492F107AD33
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 07:56:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F13F960C5D;
 Tue, 22 Oct 2019 07:56:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 681671133034; Tue, 22 Oct 2019 09:56:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/12] qapi: Store pragma state in QAPISourceInfo,
 not global state
Date: Tue, 22 Oct 2019 09:56:05 +0200
Message-Id: <20191022075615.956-3-armbru@redhat.com>
In-Reply-To: <20191022075615.956-1-armbru@redhat.com>
References: <20191022075615.956-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 7jB4B0KQNkyY_cTOLeDqMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The frontend can't be run more than once due to its global state.
A future commit will want to do that.

Recent commit "qapi: Move context-sensitive checking to the proper
place" got rid of many global variables already, but pragma state is
still stored in global variables (that's why a pragma directive's
scope is the complete schema).

Move the pragma state to QAPISourceInfo.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20191018074345.24034-3-armbru@redhat.com>
---
 scripts/qapi/common.py | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d6e00c80ea..5abab44302 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -21,25 +21,28 @@ import string
 import sys
 from collections import OrderedDict
=20
-# Are documentation comments required?
-doc_required =3D False
-
-# Whitelist of commands allowed to return a non-dictionary
-returns_whitelist =3D []
-
-# Whitelist of entities allowed to violate case conventions
-name_case_whitelist =3D []
-
=20
 #
 # Parsing the schema into expressions
 #
=20
+
+class QAPISchemaPragma(object):
+    def __init__(self):
+        # Are documentation comments required?
+        self.doc_required =3D False
+        # Whitelist of commands allowed to return a non-dictionary
+        self.returns_whitelist =3D []
+        # Whitelist of entities allowed to violate case conventions
+        self.name_case_whitelist =3D []
+
+
 class QAPISourceInfo(object):
     def __init__(self, fname, line, parent):
         self.fname =3D fname
         self.line =3D line
         self.parent =3D parent
+        self.pragma =3D parent.pragma if parent else QAPISchemaPragma()
         self.defn_meta =3D None
         self.defn_name =3D None
=20
@@ -486,26 +489,25 @@ class QAPISchemaParser(object):
         return QAPISchemaParser(incl_fname, previously_included, info)
=20
     def _pragma(self, name, value, info):
-        global doc_required, returns_whitelist, name_case_whitelist
         if name =3D=3D 'doc-required':
             if not isinstance(value, bool):
                 raise QAPISemError(info,
                                    "pragma 'doc-required' must be boolean"=
)
-            doc_required =3D value
+            info.pragma.doc_required =3D value
         elif name =3D=3D 'returns-whitelist':
             if (not isinstance(value, list)
                     or any([not isinstance(elt, str) for elt in value])):
                 raise QAPISemError(
                     info,
                     "pragma returns-whitelist must be a list of strings")
-            returns_whitelist =3D value
+            info.pragma.returns_whitelist =3D value
         elif name =3D=3D 'name-case-whitelist':
             if (not isinstance(value, list)
                     or any([not isinstance(elt, str) for elt in value])):
                 raise QAPISemError(
                     info,
                     "pragma name-case-whitelist must be a list of strings"=
)
-            name_case_whitelist =3D value
+            info.pragma.name_case_whitelist =3D value
         else:
             raise QAPISemError(info, "unknown pragma '%s'" % name)
=20
@@ -757,7 +759,7 @@ def check_type(value, info, source,
         raise QAPISemError(info,
                            "%s should be an object or type name" % source)
=20
-    permit_upper =3D allow_dict in name_case_whitelist
+    permit_upper =3D allow_dict in info.pragma.name_case_whitelist
=20
     # value is a dictionary, check that each member is okay
     for (key, arg) in value.items():
@@ -840,7 +842,7 @@ def check_enum(expr, info):
     if prefix is not None and not isinstance(prefix, str):
         raise QAPISemError(info, "'prefix' must be a string")
=20
-    permit_upper =3D name in name_case_whitelist
+    permit_upper =3D name in info.pragma.name_case_whitelist
=20
     for member in members:
         source =3D "'data' member"
@@ -968,7 +970,7 @@ def check_exprs(exprs):
                 raise QAPISemError(
                     info, "documentation comment is for '%s'" % doc.symbol=
)
             doc.check_expr(expr)
-        elif doc_required:
+        elif info.pragma.doc_required:
             raise QAPISemError(info,
                                "documentation comment required")
=20
@@ -1690,7 +1692,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         if self._ret_type_name:
             self.ret_type =3D schema.resolve_type(
                 self._ret_type_name, self.info, "command's 'returns'")
-            if self.name not in returns_whitelist:
+            if self.name not in self.info.pragma.returns_whitelist:
                 if not (isinstance(self.ret_type, QAPISchemaObjectType)
                         or (isinstance(self.ret_type, QAPISchemaArrayType)
                             and isinstance(self.ret_type.element_type,
--=20
2.21.0


