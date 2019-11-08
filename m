Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5D7FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447102178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5XVukSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447102178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT1kU-0002ex-Cr
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iT1jb-0001gO-GM
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:43:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iT1jZ-0005fD-GU
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:43:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25294
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iT1jZ-0005dM-8W
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573209795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kMyqVRM3UWErEQticxD6dIm7dGL9ogW9+QW/bxZfxTI=;
 b=X5XVukSi2GMpSR+UIIKwYghXhjncJOzxPS9+LqrK3h7gJ6PpQy3f8VPTlsyGOP89yaKE2k
 52uPSmLJZj7wrd31uRBOVoTXx1lQQqWnDPkaxvx9y6i+5OAQOXCJteCtxCB8uqgSB1jV6V
 88Ejr4ET0iah8zt4sY/SeyY+FX1tyGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-yWXY-qO4MOeQV8vME1RcyQ-1; Fri, 08 Nov 2019 05:43:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89359107ACC3;
 Fri,  8 Nov 2019 10:43:12 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 841301001DF2;
 Fri,  8 Nov 2019 10:43:11 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, alex.bennee@linaro.org,
 thuth@redhat.com
Subject: [PATCH] tests/migration: Print some debug on bad status
Date: Fri,  8 Nov 2019 10:43:07 +0000
Message-Id: <20191108104307.125020-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: yWXY-qO4MOeQV8vME1RcyQ-1
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

We're seeing occasional asserts in 'wait_for_migraiton_fail', that
I can't reliably reproduce, and where the cores don't have any useful
state.  Print the 'status' out, so we can see which unexpected state
we're ending up in.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/migration-test.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 59f291c654..ac780dffda 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -899,8 +899,13 @@ static void wait_for_migration_fail(QTestState *from, =
bool allow_active)
=20
     do {
         status =3D migrate_query_status(from);
-        g_assert(!strcmp(status, "setup") || !strcmp(status, "failed") ||
-                 (allow_active && !strcmp(status, "active")));
+        bool result =3D !strcmp(status, "setup") || !strcmp(status, "faile=
d") ||
+                 (allow_active && !strcmp(status, "active"));
+        if (!result) {
+            fprintf(stderr, "%s: unexpected status status=3D%s allow_activ=
e=3D%d\n",
+                    __func__, status, allow_active);
+        }
+        g_assert(result);
         failed =3D !strcmp(status, "failed");
         g_free(status);
     } while (!failed);
--=20
2.23.0


