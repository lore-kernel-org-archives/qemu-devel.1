Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2DDC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F087C20717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRzwO3Kl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F087C20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUhr-0005G2-Hn
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihUWX-00061v-2M
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihUWU-0002WT-Hp
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40986
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihUWT-0002Rj-9t
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576657050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwVgQiqUas/9oZI843AIMDOvEyABlfBpXV+9isyvvAE=;
 b=CRzwO3KlYQ9UPxitFNjZy2/DKfsAHmf7pSwiar0ryrwXeTVs8wpFnykoQeVa+SG3oD1SSc
 lBOBkRj9Kk4iBVXPnylCx/EKxT9XSkSh65a33eG7UJlP5M3Oxxv1c61PzxhIIpNC1JtYBo
 sdnb38PyO7VYzRQJ3fDNw+UaE6jEtD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-mlMcEDwwMy-m1LzNcVaO8g-1; Wed, 18 Dec 2019 03:17:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F32131854331;
 Wed, 18 Dec 2019 08:17:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C79E160C84;
 Wed, 18 Dec 2019 08:17:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 90A881136420; Wed, 18 Dec 2019 09:17:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 16/35] error: make Error **errp const where it is appropriate
Date: Wed, 18 Dec 2019 09:17:02 +0100
Message-Id: <20191218081721.23520-17-armbru@redhat.com>
In-Reply-To: <20191218081721.23520-1-armbru@redhat.com>
References: <20191218081721.23520-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: mlMcEDwwMy-m1LzNcVaO8g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Mostly, Error ** is for returning error from the function, so the
callee sets it. However these three functions get already filled errp
parameter. They don't change the pointer itself, only change the
internal state of referenced Error object. So we can make it
Error *const * errp, to stress the behavior. It will also help
coccinelle script (in future) to distinguish such cases from common
errp usage.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20191205174635.18758-4-vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message typo fixed]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/error.h | 6 +++---
 util/error.c         | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 3f95141a01..ad5b6e896d 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -233,13 +233,13 @@ void error_propagate_prepend(Error **dst_errp, Error =
*local_err,
  * Prepend some text to @errp's human-readable error message.
  * The text is made by formatting @fmt, @ap like vprintf().
  */
-void error_vprepend(Error **errp, const char *fmt, va_list ap);
+void error_vprepend(Error *const *errp, const char *fmt, va_list ap);
=20
 /*
  * Prepend some text to @errp's human-readable error message.
  * The text is made by formatting @fmt, ... like printf().
  */
-void error_prepend(Error **errp, const char *fmt, ...)
+void error_prepend(Error *const *errp, const char *fmt, ...)
     GCC_FMT_ATTR(2, 3);
=20
 /*
@@ -256,7 +256,7 @@ void error_prepend(Error **errp, const char *fmt, ...)
  * May be called multiple times.  The resulting hint should end with a
  * newline.
  */
-void error_append_hint(Error **errp, const char *fmt, ...)
+void error_append_hint(Error *const *errp, const char *fmt, ...)
     GCC_FMT_ATTR(2, 3);
=20
 /*
diff --git a/util/error.c b/util/error.c
index d4532ce318..b6c89d1412 100644
--- a/util/error.c
+++ b/util/error.c
@@ -121,7 +121,7 @@ void error_setg_file_open_internal(Error **errp,
                               "Could not open '%s'", filename);
 }
=20
-void error_vprepend(Error **errp, const char *fmt, va_list ap)
+void error_vprepend(Error *const *errp, const char *fmt, va_list ap)
 {
     GString *newmsg;
=20
@@ -136,7 +136,7 @@ void error_vprepend(Error **errp, const char *fmt, va_l=
ist ap)
     (*errp)->msg =3D g_string_free(newmsg, 0);
 }
=20
-void error_prepend(Error **errp, const char *fmt, ...)
+void error_prepend(Error *const *errp, const char *fmt, ...)
 {
     va_list ap;
=20
@@ -145,7 +145,7 @@ void error_prepend(Error **errp, const char *fmt, ...)
     va_end(ap);
 }
=20
-void error_append_hint(Error **errp, const char *fmt, ...)
+void error_append_hint(Error *const *errp, const char *fmt, ...)
 {
     va_list ap;
     int saved_errno =3D errno;
--=20
2.21.0


