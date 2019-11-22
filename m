Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04755C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0DD520637
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeA5fkRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DD520637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY3yE-0001qm-Ui
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 03:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iY3s5-0002yK-8x
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iY3rz-00007h-Oo
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:00:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55858
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iY3rx-00006b-PN
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574409644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MuSq9iiujh0gUMipQQgmryW+wdqp2u+B8YzVdrLvwVo=;
 b=EeA5fkRCOqbU7mIqpohX+Wk8YNN0h5lD+Etd7F9n1xk2jyCjIfMrkGzYwlfiD/0FC780q0
 6bjyNIfWAuwfecYlKHVD8mFBEuuirBz4n2kaBQGimoTegdiOBqMkDMULXZtHFGaubk4LRi
 3GFd9Pw2fms5AcL71l/562iTX2o6MBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-NrROnIlyPFGHrE8PUpNcuA-1; Fri, 22 Nov 2019 03:00:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B5F1801E58;
 Fri, 22 Nov 2019 08:00:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 143536E713;
 Fri, 22 Nov 2019 08:00:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8C44B11385C7; Fri, 22 Nov 2019 09:00:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] migration: Fix incorrect integer->float conversion
 caught by clang
Date: Fri, 22 Nov 2019 09:00:38 +0100
Message-Id: <20191122080039.12771-2-armbru@redhat.com>
In-Reply-To: <20191122080039.12771-1-armbru@redhat.com>
References: <20191122080039.12771-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: NrROnIlyPFGHrE8PUpNcuA-1
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
Cc: Fangrui Song <i@maskray.me>, richard.henderson@linaro.org,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Fangrui Song <i@maskray.me>

Clang does not like qmp_migrate_set_downtime()'s code to clamp double
@value to 0..INT64_MAX:

    qemu/migration/migration.c:2038:24: error: implicit conversion from 'lo=
ng' to 'double' changes value from 9223372036854775807 to 92233720368547758=
08 [-Werror,-Wimplicit-int-float-conversion]

The warning will be enabled by default in clang 10. It is not
available for clang <=3D 9.

The clamp is actually useless; @value is checked to be within
0..MAX_MIGRATE_DOWNTIME_SECONDS immediately before.  Delete it.

While there, make the conversion from double to int64_t explicit.

Signed-off-by: Fangrui Song <i@maskray.me>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Patch split, commit message improved]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/migration.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 354ad072fa..09b150663f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2035,11 +2035,10 @@ void qmp_migrate_set_downtime(double value, Error *=
*errp)
     }
=20
     value *=3D 1000; /* Convert to milliseconds */
-    value =3D MAX(0, MIN(INT64_MAX, value));
=20
     MigrateSetParameters p =3D {
         .has_downtime_limit =3D true,
-        .downtime_limit =3D value,
+        .downtime_limit =3D (int64_t)value,
     };
=20
     qmp_migrate_set_parameters(&p, errp);
--=20
2.21.0


