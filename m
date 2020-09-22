Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A65C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F8B2076E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiVOknDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F8B2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKr0h-00082Z-GG
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqtA-0004wt-U9
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58850
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqt8-0007iN-1M
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4dgNQxVwXkzMulCoNr1J2aB5uELtE4y8VKAcE/Muug4=;
 b=JiVOknDnvaRDeFpfKdC3MUOaPp8reIIzuGhraqe3KCPll1TCP6YYAmHaGHtwnA+qpS5MTk
 6NDX2zvVTDqdapYmcmW6oGT2CZFnzTRFBiaQJoStcz7QBLW6DWrzjDA24QiDHlTsJXC7Sk
 xmKSKDknD/WtitUHQtjk+deEQIWtjY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-bE5mKJEqNAyELENuwlOvsw-1; Tue, 22 Sep 2020 18:35:49 -0400
X-MC-Unique: bE5mKJEqNAyELENuwlOvsw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 248D41005E64;
 Tue, 22 Sep 2020 22:35:48 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9DF960BF4;
 Tue, 22 Sep 2020 22:35:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 19/26] qapi/parser.py: add parent argument
Date: Tue, 22 Sep 2020 18:35:18 -0400
Message-Id: <20200922223525.4085762-20-jsnow@redhat.com>
In-Reply-To: <20200922223525.4085762-1-jsnow@redhat.com>
References: <20200922223525.4085762-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 17:00:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of passing previously_included and info separately, we can pass
the parent parser itself. This cuts down on the number of parameters to
pass when creating a parser; and makes it easier to add new shared data
members between parent and child.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 77067b2f5d..fa0ddad922 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -68,26 +68,23 @@ class QAPISchemaParser:
     """
     Performs parsing of a QAPI schema source file.
 
-    :param fname: Path to the source file
-    :param previously_included: Set of absolute paths of previously included
-                                source files; these will not be parsed again.
-    :param incl_info: QAPISourceInfo for the parent document;
-                      Can be None for the parent document.
+    :param fname:  Path to the source file
+    :param parent: Parent parser, if this is an included file.
     """
-    def __init__(self,
-                 fname: str,
-                 previously_included: Optional[Set[str]] = None,
-                 incl_info: Optional[QAPISourceInfo] = None):
+    def __init__(self, fname: str,
+                 parent: Optional['QAPISchemaParser'] = None):
         self._fname = fname
-        self._included = previously_included or set()
+        self._included: Set[str] = parent._included if parent else set()
         self._included.add(os.path.abspath(self._fname))
+        parent_info = parent.info if parent else None
 
         # Lexer state (see `accept` for details):
         self.tok: Optional[str] = None
         self.pos = 0
         self.cursor = 0
         self.val: Optional[Union[bool, str]] = None
-        self.info = QAPISourceInfo(self._fname, parent=incl_info)
+        self.info: QAPISourceInfo = QAPISourceInfo(self._fname,
+                                                   parent=parent_info)
         self.line_pos = 0
 
         # Parser output:
@@ -100,11 +97,11 @@ def __init__(self,
                 self.src = fp.read()
         except IOError as e:
             msg = "can't read {kind:s} file '{fname:s}': {errmsg:s}".format(
-                kind='include' if incl_info else 'schema',
+                kind='include' if parent else 'schema',
                 fname=self._fname,
                 errmsg=e.strerror
             )
-            context = incl_info or self.info
+            context = parent_info if parent_info else self.info
             raise QAPIParseError(context, msg) from e
         self._parse()
 
@@ -193,7 +190,7 @@ def _include(self, include: str,
         if incl_abs_fname in self._included:
             return None
 
-        return QAPISchemaParser(incl_fname, self._included, self.info)
+        return QAPISchemaParser(incl_fname, self)
 
     def accept(self, skip_comment: bool = True) -> None:
         """
-- 
2.26.2


