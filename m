Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41B8C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 08:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8126208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 08:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8126208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iITcA-00081i-T8
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 04:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iITbS-0007WX-77
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 04:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iITbO-0001gV-0m
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 04:15:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53680)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iITbN-0001dC-Od
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 04:15:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D920B18021A5;
 Thu, 10 Oct 2019 08:15:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7230600C4;
 Thu, 10 Oct 2019 08:15:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 28B401138619; Thu, 10 Oct 2019 10:15:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] error: Fix -msg timestamp default
Date: Thu, 10 Oct 2019 10:15:08 +0200
Message-Id: <20191010081508.8978-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Thu, 10 Oct 2019 08:15:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: pbonzini@redhat.com, msmarduch@digitalocean.com
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
---
I stumbled over this during review of Mario's "[PATCHv2 0/2] log guest
name and memory error type AO, AR for MCEs", which see.

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
@@ -204,7 +206,7 @@ static void vreport(report_type type, const char *fmt=
, va_list ap)
     GTimeVal tv;
     gchar *timestr;
=20
-    if (enable_timestamp_msg && !cur_mon) {
+    if (error_with_timestamp && !cur_mon) {
         g_get_current_time(&tv);
         timestr =3D g_time_val_to_iso8601(&tv);
         error_printf("%s ", timestr);
diff --git a/vl.c b/vl.c
index 002bf4919e..b8e4c11f02 100644
--- a/vl.c
+++ b/vl.c
@@ -1262,7 +1262,7 @@ static void realtime_init(void)
=20
 static void configure_msg(QemuOpts *opts)
 {
-    enable_timestamp_msg =3D qemu_opt_get_bool(opts, "timestamp", true);
+    error_with_timestamp =3D qemu_opt_get_bool(opts, "timestamp", false)=
;
 }
=20
=20
diff --git a/qemu-options.hx b/qemu-options.hx
index 2a04ca6ac5..158244da0f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4165,13 +4165,17 @@ DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARC=
H_I386)
=20
 DEF("msg", HAS_ARG, QEMU_OPTION_msg,
     "-msg timestamp[=3Don|off]\n"
-    "                change the format of messages\n"
-    "                on|off controls leading timestamps (default:on)\n",
+    "                control error message format\n"
+    "                timestamp=3Don enables timestamps (default: off)\n"=
,
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


