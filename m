Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36BBC4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 18:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9321920866
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 18:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9321920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEHoZ-0001nb-5O
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 14:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iEHdB-0008Sq-Pk
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iEHd6-0003yo-VA
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46886)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iEHd6-0003vO-HG
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD62C20FC
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2019 18:39:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E2A3600F8;
 Sat, 28 Sep 2019 18:39:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6D1AA1138408; Sat, 28 Sep 2019 20:39:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/27] qapi: Improve reporting of invalid 'if' errors
Date: Sat, 28 Sep 2019 20:39:26 +0200
Message-Id: <20190928183934.12459-20-armbru@redhat.com>
In-Reply-To: <20190928183934.12459-1-armbru@redhat.com>
References: <20190928183934.12459-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Sat, 28 Sep 2019 18:39:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move check_if() from check_keys() to check_exprs() and call it later,
so its error messages gain an "in definition" line.

Checking values in a function named check_keys() is unclean anyway.
The original sin was commit 0545f6b887 "qapi: Better error messages
for bad expressions", which checks the value of key 'name'.  More
sinning in commit 2cbf09925a "qapi: More rigorous checking for type
safety bypass", commit c818408e44 "qapi: Implement boxed types for
commands/events", and commit 967c885108 "qapi: add 'if' to top-level
expressions".  This commit does penance for the latter.  The next
commits will do penance for the others.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190927134639.4284-19-armbru@redhat.com>
---
 scripts/qapi/common.py                  | 4 ++--
 tests/qapi-schema/bad-if-empty-list.err | 1 +
 tests/qapi-schema/bad-if-empty.err      | 1 +
 tests/qapi-schema/bad-if-list.err       | 1 +
 tests/qapi-schema/bad-if.err            | 1 +
 5 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 2e1d8158d6..8f96974f85 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -925,8 +925,6 @@ def check_keys(expr, info, meta, required, optional=3D=
[]):
             raise QAPISemError(info,
                                "'%s' of %s '%s' should only use true val=
ue"
                                % (key, meta, name))
-        if key =3D=3D 'if':
-            check_if(expr, info)
=20
=20
 def normalize_enum(expr):
@@ -1028,6 +1026,8 @@ def check_exprs(exprs):
         else:
             assert False, 'unexpected meta type'
=20
+        check_if(expr, info)
+
         if doc:
             doc.check_expr(expr)
=20
diff --git a/tests/qapi-schema/bad-if-empty-list.err b/tests/qapi-schema/=
bad-if-empty-list.err
index 75fe6497bc..2218c9279b 100644
--- a/tests/qapi-schema/bad-if-empty-list.err
+++ b/tests/qapi-schema/bad-if-empty-list.err
@@ -1 +1,2 @@
+tests/qapi-schema/bad-if-empty-list.json: In struct 'TestIfStruct':
 tests/qapi-schema/bad-if-empty-list.json:2: 'if' condition [] is useless
diff --git a/tests/qapi-schema/bad-if-empty.err b/tests/qapi-schema/bad-i=
f-empty.err
index 358bdc3e51..a3fdb3009d 100644
--- a/tests/qapi-schema/bad-if-empty.err
+++ b/tests/qapi-schema/bad-if-empty.err
@@ -1 +1,2 @@
+tests/qapi-schema/bad-if-empty.json: In struct 'TestIfStruct':
 tests/qapi-schema/bad-if-empty.json:2: 'if' condition '' makes no sense
diff --git a/tests/qapi-schema/bad-if-list.err b/tests/qapi-schema/bad-if=
-list.err
index 53af099083..e03bf0fc3a 100644
--- a/tests/qapi-schema/bad-if-list.err
+++ b/tests/qapi-schema/bad-if-list.err
@@ -1 +1,2 @@
+tests/qapi-schema/bad-if-list.json: In struct 'TestIfStruct':
 tests/qapi-schema/bad-if-list.json:2: 'if' condition ' ' makes no sense
diff --git a/tests/qapi-schema/bad-if.err b/tests/qapi-schema/bad-if.err
index c2e3f5f44c..190216c109 100644
--- a/tests/qapi-schema/bad-if.err
+++ b/tests/qapi-schema/bad-if.err
@@ -1 +1,2 @@
+tests/qapi-schema/bad-if.json: In struct 'TestIfStruct':
 tests/qapi-schema/bad-if.json:2: 'if' condition must be a string or a li=
st of strings
--=20
2.21.0


