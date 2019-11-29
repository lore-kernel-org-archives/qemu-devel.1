Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25E0C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B27217BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hjr8wtMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B27217BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadu8-00061e-UN
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iad3z-0001RF-JU
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iad3t-0004DN-6n
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:59:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49727
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iad3s-000408-0L
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575021577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NuFJtOeLCF+ZRD2qYbBHzg3Tz1iz/6vPD326Ir0gOQQ=;
 b=hjr8wtMNLYmb3USKVnmvpossY6nPte1cEqV3kh3fQU1XqEy0V/HZmRPOp1aK42JTx1+JN5
 o34U+4aDiptZ3L6hDhcODKsrv2zdyurE5aT9uzrLw/6tmpE/xWvDg87QtpxNl0QqV2yLUz
 TwWAAGmmhGxvzN5ExlZGIlt1/MTszlo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-76w3fbA0OFK-8QpARZ5gFg-1; Fri, 29 Nov 2019 04:59:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59FF310054E3;
 Fri, 29 Nov 2019 09:59:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25F0360BE2;
 Fri, 29 Nov 2019 09:59:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A9A611138606; Fri, 29 Nov 2019 10:59:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/6] Makefile: Make Makefile depend on generated qga files, too
Date: Fri, 29 Nov 2019 10:59:27 +0100
Message-Id: <20191129095927.17382-1-armbru@redhat.com>
In-Reply-To: <20191120182551.23795-1-armbru@redhat.com>
References: <20191120182551.23795-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 76w3fbA0OFK-8QpARZ5gFg-1
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
Cc: pbonzini@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Generated .h need to be generated before compiling any .c using them.
To know which .h a .c uses, we need to compile it.

Since commit 4115852bb0 "build: do not sprinkle around
GENERATED_HEADERS dependencies", we break this circular dependency the
simple & stupid way: the generated headers are a prerequisite of
Makefile, which causes Make to generate them first, then start over.

Except for qga we still use the older method of making all its .o
summarily depend on all its generated .h (commit 016c77ad62 "Makefile:
add missing deps on $(GENERATED_HEADERS)").

Add qga's generated files to generated-files-y to get rid of this
exception.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 Makefile | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 8dad949483..d4138343cd 100644
--- a/Makefile
+++ b/Makefile
@@ -130,6 +130,15 @@ GENERATED_QAPI_FILES +=3D qapi/qapi-doc.texi
=20
 generated-files-y +=3D $(GENERATED_QAPI_FILES)
=20
+GENERATED_QGA_FILES :=3D qga-qapi-types.c qga-qapi-types.h
+GENERATED_QGA_FILES +=3D qga-qapi-visit.c qga-qapi-visit.h
+GENERATED_QGA_FILES +=3D qga-qapi-commands.h qga-qapi-commands.c
+GENERATED_QGA_FILES +=3D qga-qapi-init-commands.h qga-qapi-init-commands.c
+GENERATED_QGA_FILES +=3D qga-qapi-doc.texi
+GENERATED_QGA_FILES :=3D $(addprefix qga/qapi-generated/, $(GENERATED_QGA_=
FILES))
+
+generated-files-y +=3D $(GENERATED_QGA_FILES)
+
 generated-files-y +=3D trace/generated-tcg-tracers.h
=20
 generated-files-y +=3D trace/generated-helpers-wrappers.h
@@ -608,12 +617,7 @@ $(SRC_PATH)/scripts/qapi/types.py \
 $(SRC_PATH)/scripts/qapi/visit.py \
 $(SRC_PATH)/scripts/qapi-gen.py
=20
-qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h \
-qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h \
-qga/qapi-generated/qga-qapi-commands.h qga/qapi-generated/qga-qapi-command=
s.c \
-qga/qapi-generated/qga-qapi-init-commands.h qga/qapi-generated/qga-qapi-in=
it-commands.c \
-qga/qapi-generated/qga-qapi-doc.texi: \
-qga/qapi-generated/qapi-gen-timestamp ;
+$(GENERATED_QGA_FILES): qga/qapi-generated/qapi-gen-timestamp ;
 qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(=
qapi-py)
 =09$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
 =09=09-o qga/qapi-generated -p "qga-" $<, \
@@ -630,9 +634,6 @@ qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
 =09=09"GEN","$(@:%-timestamp=3D%)")
 =09@>$@
=20
-QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-vi=
sit.h qga-qapi-commands.h qga-qapi-init-commands.h)
-$(qga-obj-y): $(QGALIB_GEN)
-
 qemu-ga$(EXESUF): $(qga-obj-y) $(COMMON_LDADDS)
 =09$(call LINK, $^)
=20
@@ -722,7 +723,7 @@ clean: recurse-clean
 =09rm -f trace/generated-tracers-dtrace.h*
 =09rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 =09rm -f qapi-gen-timestamp
-=09rm -rf qga/qapi-generated
+=09rm -f qga/qapi-generated/qapi-gen-timestamp
 =09rm -f config-all-devices.mak
=20
 VERSION ?=3D $(shell cat VERSION)
--=20
2.21.0


