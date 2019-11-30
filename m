Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5075C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 19:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B06AC2073C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 19:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISXPvnlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06AC2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib8iy-0003qq-52
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 14:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ib8ds-0006Th-Ql
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:43:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ib8dq-00058h-Pi
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:42:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59410
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ib8do-00055W-Qi
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575142972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KAnozijQnJ7jZgrp+o4jADOZ48ZvoJvjxYWiOwhxZ0o=;
 b=ISXPvnloOKBjC9rFPB2U2jeYnXhECgCo46BCZ7kaGV3XOvJSYebU451MBEtdTzVpFpJXvO
 3QtKgMsKughv/lBz4dz8uUtyv2x7JCP2hgFYwfiImuBgGpGHm1YeG2/XANzoVcwtJZz9R+
 TdhEBfXtsmjzTk585RCsrHfgyqWcSfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-n9TnEU-QOACEPD7fGMN2dQ-1; Sat, 30 Nov 2019 14:42:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B44D2DB21;
 Sat, 30 Nov 2019 19:42:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 875F9600C1;
 Sat, 30 Nov 2019 19:42:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C9EF11366DF; Sat, 30 Nov 2019 20:42:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/21] tests: Clean up initialization of Error *err variables
Date: Sat, 30 Nov 2019 20:42:26 +0100
Message-Id: <20191130194240.10517-8-armbru@redhat.com>
In-Reply-To: <20191130194240.10517-1-armbru@redhat.com>
References: <20191130194240.10517-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: n9TnEU-QOACEPD7fGMN2dQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: vsementsov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Declaring a local Error *err without initializer looks suspicious.
Fuse the declaration with the initialization to avoid that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qobject-output-visitor.c | 8 ++++----
 tests/test-string-output-visitor.c  | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-outpu=
t-visitor.c
index 3e993e5ba8..d7761ebf84 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -145,10 +145,10 @@ static void test_visitor_out_enum_errors(TestOutputVi=
sitorData *data,
                                          const void *unused)
 {
     EnumOne i, bad_values[] =3D { ENUM_ONE__MAX, -1 };
-    Error *err;
=20
     for (i =3D 0; i < ARRAY_SIZE(bad_values) ; i++) {
-        err =3D NULL;
+        Error *err =3D NULL;
+
         visit_type_EnumOne(data->ov, "unused", &bad_values[i], &err);
         error_free_or_abort(&err);
         visitor_reset(data);
@@ -240,11 +240,11 @@ static void test_visitor_out_struct_errors(TestOutput=
VisitorData *data,
     EnumOne bad_values[] =3D { ENUM_ONE__MAX, -1 };
     UserDefOne u =3D {0};
     UserDefOne *pu =3D &u;
-    Error *err;
     int i;
=20
     for (i =3D 0; i < ARRAY_SIZE(bad_values) ; i++) {
-        err =3D NULL;
+        Error *err =3D NULL;
+
         u.has_enum1 =3D true;
         u.enum1 =3D bad_values[i];
         visit_type_UserDefOne(data->ov, "unused", &pu, &err);
diff --git a/tests/test-string-output-visitor.c b/tests/test-string-output-=
visitor.c
index 02766c0f65..1be1540767 100644
--- a/tests/test-string-output-visitor.c
+++ b/tests/test-string-output-visitor.c
@@ -207,10 +207,10 @@ static void test_visitor_out_enum_errors(TestOutputVi=
sitorData *data,
                                          const void *unused)
 {
     EnumOne i, bad_values[] =3D { ENUM_ONE__MAX, -1 };
-    Error *err;
=20
     for (i =3D 0; i < ARRAY_SIZE(bad_values) ; i++) {
-        err =3D NULL;
+        Error *err =3D NULL;
+
         visit_type_EnumOne(data->ov, "unused", &bad_values[i], &err);
         error_free_or_abort(&err);
     }
--=20
2.21.0


