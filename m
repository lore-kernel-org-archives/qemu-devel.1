Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B02C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1778220883
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1778220883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45887 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDta8-0007VT-A9
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:26:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLk-0003Uk-TB
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLk-0005Cf-02
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtLj-0005C0-Jt
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D50ABC05E14C;
	Tue,  9 Apr 2019 16:11:50 +0000 (UTC)
Received: from localhost (ovpn-112-27.ams2.redhat.com [10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 576C917CFB;
	Tue,  9 Apr 2019 16:11:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 18:10:07 +0200
Message-Id: <20190409161009.6322-19-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 09 Apr 2019 16:11:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 18/20] monitor: start making
 qmp_human_monitor_command() asynchronous
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
	Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409161007.GqBIIP8fqhBsCy2o6Dchf01uiKGjX60qK8AYrtJJRL4@z>

This prepares the work for HMP commands to be asynchronous.

Start making QMP human-monitor-command asynchronous, although
QmpReturn is used synchronously on error or after
handle_hmp_command().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/misc.json |  3 ++-
 monitor.c      | 14 ++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 8b3ca4fdd3..f8fd4824fb 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1344,7 +1344,8 @@
 ##
 { 'command': 'human-monitor-command',
   'data': {'command-line': 'str', '*cpu-index': 'int'},
-  'returns': 'str' }
+  'returns': 'str',
+  'async': true }
=20
 ##
 # @ObjectPropertyInfo:
diff --git a/monitor.c b/monitor.c
index 76bc2f8c7c..477ccd852d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -743,8 +743,8 @@ static void monitor_data_destroy(Monitor *mon)
     g_queue_free(mon->qmp.qmp_requests);
 }
=20
-char *qmp_human_monitor_command(const char *command_line, bool has_cpu_i=
ndex,
-                                int64_t cpu_index, Error **errp)
+void qmp_human_monitor_command(const char *command_line, bool has_cpu_in=
dex,
+                               int64_t cpu_index, QmpReturn *qret)
 {
     char *output =3D NULL;
     Monitor *old_mon, hmp;
@@ -757,15 +757,15 @@ char *qmp_human_monitor_command(const char *command=
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
     qemu_mutex_lock(&hmp.mon_lock);
     if (qstring_get_length(hmp.outbuf) > 0) {
@@ -775,9 +775,11 @@ char *qmp_human_monitor_command(const char *command_=
line, bool has_cpu_index,
     }
     qemu_mutex_unlock(&hmp.mon_lock);
=20
+    qmp_human_monitor_command_return(qret, output);
+
 out:
+    cur_mon =3D old_mon;
     monitor_data_destroy(&hmp);
-    return output;
 }
=20
 static int compare_cmd(const char *name, const char *list)
--=20
2.21.0.196.g041f5ea1cf


