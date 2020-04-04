Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68277C2BA16
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 12:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2845A206E9
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 12:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXp0jE+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2845A206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKhtR-00067m-8r
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 08:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jKhqb-00025G-SM
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 08:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jKhqa-00037V-CF
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 08:24:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52289
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jKhqa-00034H-81
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 08:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586003063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yaUQGMTUul9I2XZ/qHlJVTWpznqCJBLPf50RX7914W0=;
 b=SXp0jE+560+hLdLQrgtooFNlfRejYO9bppMqVa+x2ogVrVhl1/tGYCXdo0u8F8OFxEtWRJ
 T5ncuX5LgBc1kq4JOMwhHqwNol+7zZSJxEPtk/VU/MeNTxFLVS0bQuaAIL9DD7VgKakA3b
 CMZ5CqCD5RkZjXWaeJQ9LvQ66qkgOlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-LiE7BIKrPT6udWT9FWDomQ-1; Sat, 04 Apr 2020 08:24:19 -0400
X-MC-Unique: LiE7BIKrPT6udWT9FWDomQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AC778017CE;
 Sat,  4 Apr 2020 12:24:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-152.ams2.redhat.com
 [10.36.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6C3B19C4F;
 Sat,  4 Apr 2020 12:24:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5C18511385C8; Sat,  4 Apr 2020 14:24:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] scripts/coccinelle: add error-use-after-free.cocci
Date: Sat,  4 Apr 2020 14:24:14 +0200
Message-Id: <20200404122416.1837-2-armbru@redhat.com>
In-Reply-To: <20200404122416.1837-1-armbru@redhat.com>
References: <20200404122416.1837-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add script to find and fix trivial use-after-free of Error objects.
How to use:
spatch --sp-file scripts/coccinelle/error-use-after-free.cocci \
 --macro-file scripts/cocci-macro-file.h --in-place \
 --no-show-diff ( FILES... | --use-gitgrep . )

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200324153630.11882-2-vsementsov@virtuozzo.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Pastos in commit message and comment fixed, globbing in MAINTAINERS
expanded]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/coccinelle/error-use-after-free.cocci | 52 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 57 insertions(+)
 create mode 100644 scripts/coccinelle/error-use-after-free.cocci

diff --git a/scripts/coccinelle/error-use-after-free.cocci b/scripts/coccin=
elle/error-use-after-free.cocci
new file mode 100644
index 0000000000..72ae9fdebf
--- /dev/null
+++ b/scripts/coccinelle/error-use-after-free.cocci
@@ -0,0 +1,52 @@
+// Find and fix trivial use-after-free of Error objects
+//
+// Copyright (c) 2020 Virtuozzo International GmbH.
+//
+// This program is free software; you can redistribute it and/or
+// modify it under the terms of the GNU General Public License as
+// published by the Free Software Foundation; either version 2 of the
+// License, or (at your option) any later version.
+//
+// This program is distributed in the hope that it will be useful,
+// but WITHOUT ANY WARRANTY; without even the implied warranty of
+// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+// GNU General Public License for more details.
+//
+// You should have received a copy of the GNU General Public License
+// along with this program.  If not, see
+// <http://www.gnu.org/licenses/>.
+//
+// How to use:
+// spatch --sp-file scripts/coccinelle/error-use-after-free.cocci \
+//  --macro-file scripts/cocci-macro-file.h --in-place \
+//  --no-show-diff ( FILES... | --use-gitgrep . )
+
+@ exists@
+identifier fn, fn2;
+expression err;
+@@
+
+ fn(...)
+ {
+     <...
+(
+     error_free(err);
++    err =3D NULL;
+|
+     error_report_err(err);
++    err =3D NULL;
+|
+     error_reportf_err(err, ...);
++    err =3D NULL;
+|
+     warn_report_err(err);
++    err =3D NULL;
+|
+     warn_reportf_err(err, ...);
++    err =3D NULL;
+)
+     ... when !=3D err =3D NULL
+         when !=3D exit(...)
+     fn2(..., err, ...)
+     ...>
+ }
diff --git a/MAINTAINERS b/MAINTAINERS
index 7cb53ec138..9d156d73b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2053,6 +2053,11 @@ F: include/qemu/error-report.h
 F: qapi/error.json
 F: util/error.c
 F: util/qemu-error.c
+F: scripts/coccinelle/err-bad-newline.cocci
+F: scripts/coccinelle/error-use-after-free.cocci
+F: scripts/coccinelle/error_propagate_null.cocci
+F: scripts/coccinelle/remove_local_err.cocci
+F: scripts/coccinelle/use-error_fatal.cocci
=20
 GDB stub
 M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
--=20
2.21.1


