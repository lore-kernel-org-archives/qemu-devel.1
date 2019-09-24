Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27B3C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B42B220872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42B220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iClFx-00078w-HK
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCks2-0000GL-FD
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCkry-0001Us-4T
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56527)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCkrx-0001UI-Lp
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B5127A26675;
 Tue, 24 Sep 2019 13:28:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 050E95D9DC;
 Tue, 24 Sep 2019 13:28:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AE9A01136423; Tue, 24 Sep 2019 15:28:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/25] qapi: Improve reporting of missing documentation comment
Date: Tue, 24 Sep 2019 15:28:28 +0200
Message-Id: <20190924132830.15835-24-armbru@redhat.com>
In-Reply-To: <20190924132830.15835-1-armbru@redhat.com>
References: <20190924132830.15835-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 24 Sep 2019 13:28:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Have check_exprs() check this later, so the error message gains an "in
definition line".  Tweak the error message.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py            | 18 ++++++++----------
 tests/qapi-schema/doc-missing.err |  3 ++-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 018e58bc50..29b75345bb 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -925,10 +925,6 @@ def check_exprs(exprs):
         if 'include' in expr:
             continue
=20
-        if not doc and doc_required:
-            raise QAPISemError(info,
-                               "definition missing documentation comment=
")
-
         if 'enum' in expr:
             meta =3D 'enum'
         elif 'union' in expr:
@@ -949,9 +945,14 @@ def check_exprs(exprs):
         info.set_defn(meta, name)
         check_defn_name_str(name, info, meta)
=20
-        if doc and doc.symbol !=3D name:
-            raise QAPISemError(
-                info, "documentation comment is for '%s'" % doc.symbol)
+        if doc:
+            if doc.symbol !=3D name:
+                raise QAPISemError(
+                    info, "documentation comment is for '%s'" % doc.symb=
ol)
+            doc.check_expr(expr)
+        elif doc_required:
+            raise QAPISemError(info,
+                               "documentation comment required")
=20
         if meta =3D=3D 'enum':
             check_keys(expr, info, meta,
@@ -996,9 +997,6 @@ def check_exprs(exprs):
         check_if(expr, info)
         check_flags(expr, info)
=20
-        if doc:
-            doc.check_expr(expr)
-
     return exprs
=20
=20
diff --git a/tests/qapi-schema/doc-missing.err b/tests/qapi-schema/doc-mi=
ssing.err
index 08c827931a..7fbf54ff65 100644
--- a/tests/qapi-schema/doc-missing.err
+++ b/tests/qapi-schema/doc-missing.err
@@ -1 +1,2 @@
-tests/qapi-schema/doc-missing.json:5: definition missing documentation c=
omment
+tests/qapi-schema/doc-missing.json: In command 'undocumented':
+tests/qapi-schema/doc-missing.json:5: documentation comment required
--=20
2.21.0


