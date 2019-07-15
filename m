Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE72C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 19:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 896B020665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 19:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896B020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn6QP-0001n1-NS
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 15:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40327)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hn6Pg-00070v-LQ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hn6Pe-00042g-NN
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:13:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hn6Pe-00041o-IA
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:13:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DF0DC308A958;
 Mon, 15 Jul 2019 19:13:24 +0000 (UTC)
Received: from localhost (ovpn-112-18.ams2.redhat.com [10.36.112.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AC625B681;
 Mon, 15 Jul 2019 19:13:18 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 23:09:59 +0400
Message-Id: <20190715191001.1188-19-marcandre.lureau@redhat.com>
In-Reply-To: <20190715191001.1188-1-marcandre.lureau@redhat.com>
References: <20190715191001.1188-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 15 Jul 2019 19:13:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 18/20] monitor: start making
 qmp_human_monitor_command() asynchronous
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This prepares the work for HMP commands to be asynchronous.

Start making QMP human-monitor-command asynchronous, although
QmpReturn is used synchronously on error or after
handle_hmp_command().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor/misc.c | 14 ++++++++------
 qapi/misc.json |  3 ++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/monitor/misc.c b/monitor/misc.c
index a23c1b8ba4..0645667e1b 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -115,8 +115,8 @@ static QLIST_HEAD(, MonFdset) mon_fdsets;
=20
 static HMPCommand hmp_info_cmds[];
=20
-char *qmp_human_monitor_command(const char *command_line, bool has_cpu_i=
ndex,
-                                int64_t cpu_index, Error **errp)
+void qmp_human_monitor_command(const char *command_line, bool has_cpu_in=
dex,
+                               int64_t cpu_index, QmpReturn *qret)
 {
     char *output =3D NULL;
     Monitor *old_mon;
@@ -130,15 +130,15 @@ char *qmp_human_monitor_command(const char *command=
_line, bool has_cpu_index,
     if (has_cpu_index) {
         int ret =3D monitor_set_cpu(cpu_index);
         if (ret < 0) {
-            cur_mon =3D old_mon;
-            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
+            Error *err =3D NULL;
+            error_setg(&err, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
                        "a CPU number");
+            qmp_return_error(qret, err);
             goto out;
         }
     }
=20
     handle_hmp_command(&hmp, command_line);
-    cur_mon =3D old_mon;
=20
     qemu_mutex_lock(&hmp.common.mon_lock);
     if (qstring_get_length(hmp.common.outbuf) > 0) {
@@ -148,9 +148,11 @@ char *qmp_human_monitor_command(const char *command_=
line, bool has_cpu_index,
     }
     qemu_mutex_unlock(&hmp.common.mon_lock);
=20
+    qmp_human_monitor_command_return(qret, output);
+
 out:
+    cur_mon =3D old_mon;
     monitor_data_destroy(&hmp.common);
-    return output;
 }
=20
 /**
diff --git a/qapi/misc.json b/qapi/misc.json
index a7fba7230c..8c6ca46b8b 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1047,7 +1047,8 @@
 ##
 { 'command': 'human-monitor-command',
   'data': {'command-line': 'str', '*cpu-index': 'int'},
-  'returns': 'str' }
+  'returns': 'str',
+  'async': true }
=20
 ##
 # @change:
--=20
2.22.0.428.g6d5b264208


