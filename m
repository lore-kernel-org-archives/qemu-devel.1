Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2DBC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52755206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7HfsM4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52755206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXUhV-0004mg-94
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 13:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iXUfw-0003Dy-Un
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iXUfu-00083U-Uz
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:26:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25576
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iXUfu-00082y-IG
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574274357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UhxbdU+S7+qS6h7wqv20wlXA0Br46p9VJroRXrgVT2g=;
 b=A7HfsM4zOsYvEQeLZyWe3CEDJ1yU+/kpZViN03/kiXalEpW0IkeTx6DP1PpKutfw9z3KHy
 EWnLmsd884936Z7NrLnkkd6cgueuUc6t7YSOKMNCsplQMaJayX002VXbMzQ6qQY9MES8iB
 PQSZqqcBms0IevMHXa3Sj9/kORuUv+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385--6IDFDFcP6WI6yt2WxwFjg-1; Wed, 20 Nov 2019 13:25:54 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64542801E76;
 Wed, 20 Nov 2019 18:25:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFDEE5ED39;
 Wed, 20 Nov 2019 18:25:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A74011366CC; Wed, 20 Nov 2019 19:25:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] tests/Makefile.include: Fix missing
 test-qapi-emit-events.[ch]
Date: Wed, 20 Nov 2019 19:25:47 +0100
Message-Id: <20191120182551.23795-3-armbru@redhat.com>
In-Reply-To: <20191120182551.23795-1-armbru@redhat.com>
References: <20191120182551.23795-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: -6IDFDFcP6WI6yt2WxwFjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: mdroth@linux.vnet.ibm.com, kwolf@pond.sub.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 5d75648b56 "qapi: Generate QAPIEvent stuff into separate files"
added tests/test-qapi-emit-events.[ch] to the set of generated files,
but neglected to update tests/.gitignore and tests/Makefile.include.
Commit a0af8cee3c "tests/.gitignore: ignore test-qapi-emit-events.[ch]
for in-tree builds" fixed the former.  Now fix the latter.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/Makefile.include | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8566f5f119..75b377d1a9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -503,6 +503,7 @@ generated-files-y +=3D tests/test-qapi-visit-sub-sub-mo=
dule.h
 generated-files-y +=3D tests/test-qapi-commands.h
 generated-files-y +=3D tests/include/test-qapi-commands-sub-module.h
 generated-files-y +=3D tests/test-qapi-commands-sub-sub-module.h
+generated-files-y +=3D tests/test-qapi-emit-events.h
 generated-files-y +=3D tests/test-qapi-events.h
 generated-files-y +=3D tests/include/test-qapi-events-sub-module.h
 generated-files-y +=3D tests/test-qapi-events-sub-sub-module.h
@@ -610,6 +611,7 @@ tests/include/test-qapi-commands-sub-module.h \
 tests/include/test-qapi-commands-sub-module.c \
 tests/test-qapi-commands-sub-sub-module.h \
 tests/test-qapi-commands-sub-sub-module.c \
+tests/test-qapi-emit-events.c tests/test-qapi-emit-events.h \
 tests/test-qapi-events.c tests/test-qapi-events.h \
 tests/include/test-qapi-events-sub-module.c \
 tests/include/test-qapi-events-sub-module.h \
@@ -637,7 +639,7 @@ tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests=
/qapi-schema/doc-good.jso
=20
 tests/test-string-output-visitor$(EXESUF): tests/test-string-output-visito=
r.o $(test-qapi-obj-y)
 tests/test-string-input-visitor$(EXESUF): tests/test-string-input-visitor.=
o $(test-qapi-obj-y)
-tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qapi-obj-y) t=
ests/test-qapi-events.o
+tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qapi-obj-y) t=
ests/test-qapi-emit-events.o tests/test-qapi-events.o
 tests/test-qobject-output-visitor$(EXESUF): tests/test-qobject-output-visi=
tor.o $(test-qapi-obj-y)
 tests/test-clone-visitor$(EXESUF): tests/test-clone-visitor.o $(test-qapi-=
obj-y)
 tests/test-qobject-input-visitor$(EXESUF): tests/test-qobject-input-visito=
r.o $(test-qapi-obj-y)
--=20
2.21.0


