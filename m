Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF78CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E7421897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E7421897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLN2D-0007Ho-Sy
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 03:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iLMvP-0000RS-ME
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iLMvO-0007fH-KI
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:43:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5281)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iLMvO-0007et-EU
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:43:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9EFC4307B190;
 Fri, 18 Oct 2019 07:43:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F32B5D9CC;
 Fri, 18 Oct 2019 07:43:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 81DEE11384A8; Fri, 18 Oct 2019 09:43:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/7] qapi: Don't suppress doc generation without pragma
 doc-required
Date: Fri, 18 Oct 2019 09:43:39 +0200
Message-Id: <20191018074345.24034-2-armbru@redhat.com>
In-Reply-To: <20191018074345.24034-1-armbru@redhat.com>
References: <20191018074345.24034-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 18 Oct 2019 07:43:49 +0000 (UTC)
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
Cc: kwolf@redhat.com, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit bc52d03ff5 "qapi: Make doc comments optional where we don't
need them" made scripts/qapi2texi.py fail[*] unless the schema had
pragma 'doc-required': true.  The stated reason was inability to cope
with incomplete documentation.

When commit fb0bc835e5 "qapi-gen: New common driver for code and doc
generators" folded scripts/qapi2texi.py into scripts/qapi-gen.py, it
turned the failure into silent suppression.

The doc generator can cope with incomplete documentation now.  I don't
know since when, or what the problem was, or even whether it ever
existed.

Drop the silent suppression.

[*] The fail part was broken, fixed in commit e8ba07ea9a.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/doc.py    | 2 --
 tests/Makefile.include | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 5fc0fc7e06..693cc4486b 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -283,8 +283,6 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaV=
isitor):
=20
=20
 def gen_doc(schema, output_dir, prefix):
-    if not qapi.common.doc_required:
-        return
     vis =3D QAPISchemaGenDocVisitor(prefix)
     vis.visit_begin(schema)
     for doc in schema.docs:
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3543451ed3..214fbd941c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -609,6 +609,7 @@ tests/test-qapi-gen-timestamp: \
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o tests -p "test-" $<, \
 		"GEN","$(@:%-timestamp=3D%)")
+	@rm -f tests/test-qapi-doc.texi
 	@>$@
=20
 tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-=
good.json $(qapi-py)
--=20
2.21.0


