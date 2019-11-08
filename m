Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF41FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D50F2178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZg0z+49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D50F2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT64w-0007mF-84
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5qY-00084N-Lj
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5qX-0007KH-Ja
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:06:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58922
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iT5qX-0007K8-G3
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573225605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8COIJESeTAOSHPsFPA7tx+V+NQP3cSzWSMBW9wKxKRE=;
 b=RZg0z+49IchjJ332ztKvaZcLctcWL5rJSyUKvaz73uNdUA0AbDa46UNrI+Fq9pqBkAMxgM
 /3aDtCGTQ83NnlkBjUA9LUBc0V4hysAbps+WLB743mS7WP3Hw13MkB+HUcYtMkY1AvKISS
 Bc6e0Yz8nPqCCeou2D820VjKv9bgGOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-B34aZhinPSCwpmVUNoN-pw-1; Fri, 08 Nov 2019 10:06:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0C44107ACC4
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 15:06:42 +0000 (UTC)
Received: from localhost (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 423AD6084E;
 Fri,  8 Nov 2019 15:06:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 23/25] monitor: start making qmp_human_monitor_command()
 asynchronous
Date: Fri,  8 Nov 2019 19:01:21 +0400
Message-Id: <20191108150123.12213-24-marcandre.lureau@redhat.com>
In-Reply-To: <20191108150123.12213-1-marcandre.lureau@redhat.com>
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: B34aZhinPSCwpmVUNoN-pw-1
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 armbru@redhat.com, kraxel@redhat.com
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
index bb33ca73cf..3617f855f5 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -115,8 +115,8 @@ static QLIST_HEAD(, MonFdset) mon_fdsets;
=20
 static HMPCommand hmp_info_cmds[];
=20
-char *qmp_human_monitor_command(const char *command_line, bool has_cpu_ind=
ex,
-                                int64_t cpu_index, Error **errp)
+void qmp_human_monitor_command(const char *command_line, bool has_cpu_inde=
x,
+                               int64_t cpu_index, QmpReturn *qret)
 {
     char *output =3D NULL;
     Monitor *old_mon;
@@ -130,15 +130,15 @@ char *qmp_human_monitor_command(const char *command_l=
ine, bool has_cpu_index,
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
@@ -148,9 +148,11 @@ char *qmp_human_monitor_command(const char *command_li=
ne, bool has_cpu_index,
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
index 33b94e3589..15a8bc0d0d 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1054,7 +1054,8 @@
 { 'command': 'human-monitor-command',
   'data': {'command-line': 'str', '*cpu-index': 'int'},
   'returns': 'str',
-  'features': [ 'savevm-monitor-nodes' ] }
+  'features': [ 'savevm-monitor-nodes' ],
+  'async': true }
=20
 ##
 # @change:
--=20
2.24.0


