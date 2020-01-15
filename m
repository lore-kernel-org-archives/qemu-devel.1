Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A29C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D384207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhsOGmm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D384207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irhkF-0008NW-Of
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 07:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1irhi4-0006M3-Uc
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1irhi0-0001zl-CC
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:23:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45640
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1irhi0-0001zV-97
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579091019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2EAeYqTyCbwl3YPJB4hEw/0vE5BAWZVoxyjV4F867KA=;
 b=MhsOGmm8ckwsUvushA2LIZxHPu+VRXNax2C8w+fNiI6UjRcrRoCOGlGWv8H3kRRe0TN3qo
 smkuP2ZPyjK+xuom1FLUk9Og7Uqcl8kXCQ4QCKIee7JZ2mo8uupwf75JoJDgcxHsNOx5OM
 mDeyIgaH5o3XgjpQ3czP02yuWIvdSRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-dRnEF75vM5-o3Htu6-zNaw-1; Wed, 15 Jan 2020 07:23:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBDA218B5F77;
 Wed, 15 Jan 2020 12:23:37 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-87.ams2.redhat.com [10.36.117.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DB855C1D6;
 Wed, 15 Jan 2020 12:23:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] vl: Initialise main loop earlier
Date: Wed, 15 Jan 2020 13:23:24 +0100
Message-Id: <20200115122326.26393-3-kwolf@redhat.com>
In-Reply-To: <20200115122326.26393-1-kwolf@redhat.com>
References: <20200115122326.26393-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: dRnEF75vM5-o3Htu6-zNaw-1
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 marcandre.lureau@gmail.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to be able to use qemu_aio_context in the monitor
initialisation.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 vl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/vl.c b/vl.c
index 86474a55c9..4c79a00857 100644
--- a/vl.c
+++ b/vl.c
@@ -2903,6 +2903,11 @@ int main(int argc, char **argv, char **envp)
     runstate_init();
     precopy_infrastructure_init();
     postcopy_infrastructure_init();
+
+    if (qemu_init_main_loop(&main_loop_err)) {
+        error_report_err(main_loop_err);
+        exit(1);
+    }
     monitor_init_globals();
=20
     if (qcrypto_init(&err) < 0) {
@@ -3817,11 +3822,6 @@ int main(int argc, char **argv, char **envp)
     qemu_unlink_pidfile_notifier.notify =3D qemu_unlink_pidfile;
     qemu_add_exit_notifier(&qemu_unlink_pidfile_notifier);
=20
-    if (qemu_init_main_loop(&main_loop_err)) {
-        error_report_err(main_loop_err);
-        exit(1);
-    }
-
 #ifdef CONFIG_SECCOMP
     olist =3D qemu_find_opts_err("sandbox", NULL);
     if (olist) {
--=20
2.20.1


