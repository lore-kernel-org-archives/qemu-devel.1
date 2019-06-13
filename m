Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A47C46477
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D92621721
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D92621721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41544 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbSgg-0006KH-Hx
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 12:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60379)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hbRlp-00013z-I7
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hbRln-0004Fo-II
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:36:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hbRlU-00041M-Df; Thu, 13 Jun 2019 11:35:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9D7362EF16E;
 Thu, 13 Jun 2019 15:35:34 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-246.ams2.redhat.com
 [10.36.116.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16AAF60C7F;
 Thu, 13 Jun 2019 15:35:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 17:34:05 +0200
Message-Id: <20190613153405.24769-16-kwolf@redhat.com>
In-Reply-To: <20190613153405.24769-1-kwolf@redhat.com>
References: <20190613153405.24769-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 13 Jun 2019 15:35:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 15/15] vl: Deprecate -mon pretty=... for HMP
 monitors
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
Cc: kwolf@redhat.com, berrange@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The -mon pretty=3Don|off switch of the -mon option applies only the QMP
monitors. It used to be silently ignored for HMP. Deprecate this
combination so that we can make it an error in future versions.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 vl.c                 | 10 +++++++++-
 qemu-deprecated.texi |  6 ++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 32daa434eb..99a56b5556 100644
--- a/vl.c
+++ b/vl.c
@@ -2317,6 +2317,10 @@ static int mon_init_func(void *opaque, QemuOpts *o=
pts, Error **errp)
         return -1;
     }
=20
+    if (!qmp && qemu_opt_get(opts, "pretty")) {
+        warn_report("'pretty' is deprecated for HMP monitors, it has no =
effect "
+                    "and will be removed in future versions");
+    }
     if (qemu_opt_get_bool(opts, "pretty", 0)) {
         pretty =3D true;
     }
@@ -2362,7 +2366,11 @@ static void monitor_parse(const char *optarg, cons=
t char *mode, bool pretty)
     opts =3D qemu_opts_create(qemu_find_opts("mon"), label, 1, &error_fa=
tal);
     qemu_opt_set(opts, "mode", mode, &error_abort);
     qemu_opt_set(opts, "chardev", label, &error_abort);
-    qemu_opt_set_bool(opts, "pretty", pretty, &error_abort);
+    if (!strcmp(mode, "control")) {
+        qemu_opt_set_bool(opts, "pretty", pretty, &error_abort);
+    } else {
+        assert(pretty =3D=3D false);
+    }
     monitor_device_index++;
 }
=20
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 50292d820b..df04f2840b 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -72,6 +72,12 @@ backend settings instead of environment variables.  To=
 ease migration to
 the new format, the ``-audiodev-help'' option can be used to convert
 the current values of the environment variables to ``-audiodev'' options=
.
=20
+@subsection -mon ...,control=3Dreadline,pretty=3Don|off (since 4.1)
+
+The @code{pretty=3Don|off} switch has no effect for HMP monitors, but is
+silently ignored. Using the switch with HMP monitors will become an
+error in the future.
+
 @subsection -realtime (since 4.1)
=20
 The @code{-realtime mlock=3Don|off} argument has been replaced by the
--=20
2.20.1


