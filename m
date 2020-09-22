Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADA4C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B7E208A9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIAt0TlL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B7E208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqV4-0006ea-7E
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpgK-0007pS-QZ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpgI-0006fN-L3
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600809513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=owOd+IHrwp7CTurkjFWXGVSBt7zqxNx6craqYA4lOD0=;
 b=DIAt0TlLw6/qVXE+Zpw9IZGfTJPTMxovB7WmIgVOEIA9sRfjzxb7KXdblr/dASf+U6+CWX
 4G4Isj/4/CBDn+dp7exoBZFd+82M0ct3mdnYrnZdKQnBzaJN6symubm9LS7wgWjtllY8ON
 nhPBu/UmwcS8MY+ZzzYdvCAe1OioEzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-LSDa1xIlPLGoj8MoFKo4LQ-1; Tue, 22 Sep 2020 17:18:17 -0400
X-MC-Unique: LSDa1xIlPLGoj8MoFKo4LQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1A9481CBE9;
 Tue, 22 Sep 2020 21:18:16 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7D835DE50;
 Tue, 22 Sep 2020 21:18:15 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 08/14] qapi/doc.py: Add generic texi_member callback
Date: Tue, 22 Sep 2020 17:17:56 -0400
Message-Id: <20200922211802.4083666-9-jsnow@redhat.com>
In-Reply-To: <20200922211802.4083666-1-jsnow@redhat.com>
References: <20200922211802.4083666-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can just use the same callback and dispatch based on type, which
removes the need to type the callback, add downcast assertions, or use
less-specific types in the specialized generators.

---

This patch is optional, it's just demonstrating a different way to
handle the callback typing -- by eliminating the callback.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/doc.py | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 43943575da..74d017f60e 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -5,7 +5,7 @@
 """This script produces the documentation of a qapi schema in texinfo format"""
 
 import re
-from typing import Callable, List, Optional
+from typing import List, Optional
 
 from .gen import QAPIGenDoc
 from .parser import QAPIDoc
@@ -150,24 +150,17 @@ def texi_if(ifcond: Optional[List[str]],
     return '%s@b{If:} @code{%s}%s' % (prefix, ', '.join(ifcond), suffix)
 
 
-TexiMemberCallback = Callable[[QAPISchemaMember, str, str], str]
-
-
-def texi_enum_value(value: QAPISchemaMember,
-                    desc: str,
-                    suffix: str) -> str:
+def texi_enum_value(value: QAPISchemaEnumMember,
+                    desc: str, suffix: str) -> str:
     """Format a table of members item for an enumeration value"""
-    assert isinstance(value, QAPISchemaEnumMember)
     assert suffix == '', "Ignored suffix for texi_enum_value"
     return '@item @code{%s}\n%s%s' % (
         value.name, desc, texi_if(value.ifcond, prefix='@*'))
 
 
-def texi_member(member: QAPISchemaMember,
-                desc: str,
-                suffix: str) -> str:
+def texi_object_member(member: QAPISchemaObjectTypeMember,
+                       desc: str, suffix: str) -> str:
     """Format a table of members item for an object type member"""
-    assert isinstance(member, QAPISchemaObjectTypeMember)
     typ = member.type.doc_type()
     membertype = ': ' + typ if typ else ''
     return '@item @code{%s%s}%s%s\n%s%s' % (
@@ -176,11 +169,20 @@ def texi_member(member: QAPISchemaMember,
         suffix, desc, texi_if(member.ifcond, prefix='@*'))
 
 
+def texi_member(member: QAPISchemaMember, desc: str, suffix: str) -> str:
+    """Format a table of members item for an arbitrary member type"""
+
+    if isinstance(member, QAPISchemaObjectTypeMember):
+        return texi_object_member(member, desc, suffix)
+    if isinstance(member, QAPISchemaEnumMember):
+        return texi_enum_value(member, desc, suffix)
+    raise Exception(f"Unhandled member type {type(member).__name__}")
+
+
 def texi_members(doc: QAPIDoc,
                  what: str,
                  base: Optional[QAPISchemaObjectType] = None,
-                 variants: Optional[QAPISchemaVariants] = None,
-                 member_func: TexiMemberCallback = texi_member) -> str:
+                 variants: Optional[QAPISchemaVariants] = None) -> str:
     """Format the table of members"""
     items = ''
     for section in doc.args.values():
@@ -198,7 +200,7 @@ def texi_members(doc: QAPIDoc,
         if desc is None:
             desc = 'Not documented\n'
 
-        items += member_func(section.member, desc, '')
+        items += texi_member(section.member, desc, '')
     if base:
         items += '@item The members of @code{%s}\n' % base.doc_type()
     if variants:
@@ -208,7 +210,7 @@ def texi_members(doc: QAPIDoc,
             if v.type.is_implicit():
                 assert not v.type.base and not v.type.variants
                 for m in v.type.local_members:
-                    items += member_func(m, '', when)
+                    items += texi_member(m, '', when)
             else:
                 items += '@item The members of @code{%s}%s\n' % (
                     v.type.doc_type(), when)
@@ -288,8 +290,7 @@ def visit_enum_type(self,
                         prefix: Optional[str]) -> None:
         doc = self.cur_doc
         self._gen.add(texi_type('Enum', doc, ifcond,
-                                texi_members(doc, 'Values',
-                                             member_func=texi_enum_value)))
+                                texi_members(doc, 'Values')))
 
     def visit_object_type(self,
                           name: str,
-- 
2.26.2


