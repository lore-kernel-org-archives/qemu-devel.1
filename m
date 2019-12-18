Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586D3C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214CE24691
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6JFKmBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214CE24691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUY0-0007pR-Pz
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihUWP-0005wE-Gg
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihUWN-0002P3-K3
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40332
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihUWN-0002NT-GR
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576657046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=762Vx2LMJUF0HARuDCs9/bQDEvW9w9fDjGoV8Fkl8cI=;
 b=W6JFKmBCKKnLVX8o66LbEjodbn5tFtnBCUt15EtIKaL9R0JOtDAmURCkfOxJRFdOSMe6q1
 50YyFsdmt6GAFIHA7tQYZ0d146Rpbc5evepM9Bz34bhRcb+qW4KOSvAoOgidEdfDX3N64W
 a9IwhgN56sSvrqdJ0xpBa4CBu5iUYZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-rXvlsSR2OUW9I-uLqfIKnw-1; Wed, 18 Dec 2019 03:17:23 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01D5D800D50
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 08:17:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7E485C28D
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 08:17:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 531A811385EE; Wed, 18 Dec 2019 09:17:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/35] error: Fix -msg timestamp default
Date: Wed, 18 Dec 2019 09:16:47 +0100
Message-Id: <20191218081721.23520-2-armbru@redhat.com>
In-Reply-To: <20191218081721.23520-1-armbru@redhat.com>
References: <20191218081721.23520-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: rXvlsSR2OUW9I-uLqfIKnw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

-msg parameter "timestamp" defaults to "off" if you don't specify msg,
and to "on" if you do.  Messed up right in commit 5e2ac51917 "add
timestamp to error_report()".  Mostly harmless, because "timestamp" is
the only parameter, so "if you do" is "-msg ''", which nobody does.

Change the default to "off" no matter what.

While there, rename enable_timestamp_msg to error_with_timestamp, and
polish documentation.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191010081508.8978-1-armbru@redhat.com>
---
 include/qemu/error-report.h |  3 ++-
 util/qemu-error.c           |  6 ++++--
 vl.c                        |  2 +-
 qemu-options.hx             | 10 +++++++---
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 00d069b20f..87532d8596 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -73,6 +73,7 @@ void error_init(const char *argv0);
     })
=20
 const char *error_get_progname(void);
-extern bool enable_timestamp_msg;
+
+extern bool error_with_timestamp;
=20
 #endif
diff --git a/util/qemu-error.c b/util/qemu-error.c
index f373f3b3b0..dac7c7dc50 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -24,6 +24,9 @@ typedef enum {
     REPORT_TYPE_INFO,
 } report_type;
=20
+/* Prepend timestamp to messages */
+bool error_with_timestamp;
+
 int error_printf(const char *fmt, ...)
 {
     va_list ap;
@@ -191,7 +194,6 @@ static void print_loc(void)
     }
 }
=20
-bool enable_timestamp_msg;
 /*
  * Print a message to current monitor if we have one, else to stderr.
  * @report_type is the type of message: error, warning or informational.
@@ -204,7 +206,7 @@ static void vreport(report_type type, const char *fmt, =
va_list ap)
     GTimeVal tv;
     gchar *timestr;
=20
-    if (enable_timestamp_msg && !cur_mon) {
+    if (error_with_timestamp && !cur_mon) {
         g_get_current_time(&tv);
         timestr =3D g_time_val_to_iso8601(&tv);
         error_printf("%s ", timestr);
diff --git a/vl.c b/vl.c
index 94508300c3..908a9e1d1e 100644
--- a/vl.c
+++ b/vl.c
@@ -1139,7 +1139,7 @@ static void realtime_init(void)
=20
 static void configure_msg(QemuOpts *opts)
 {
-    enable_timestamp_msg =3D qemu_opt_get_bool(opts, "timestamp", true);
+    error_with_timestamp =3D qemu_opt_get_bool(opts, "timestamp", false);
 }
=20
=20
diff --git a/qemu-options.hx b/qemu-options.hx
index c63e794b64..b2cb1debe6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4167,13 +4167,17 @@ DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_=
I386)
=20
 DEF("msg", HAS_ARG, QEMU_OPTION_msg,
     "-msg timestamp[=3Don|off]\n"
-    "                change the format of messages\n"
-    "                on|off controls leading timestamps (default:on)\n",
+    "                control error message format\n"
+    "                timestamp=3Don enables timestamps (default: off)\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -msg timestamp[=3Don|off]
 @findex -msg
-prepend a timestamp to each log message.(default:on)
+Control error message format.
+@table @option
+@item timestamp=3Don|off
+Prefix messages with a timestamp.  Default is off.
+@end table
 ETEXI
=20
 DEF("dump-vmstate", HAS_ARG, QEMU_OPTION_dump_vmstate,
--=20
2.21.0


