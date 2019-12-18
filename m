Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCE5C2D0D1
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD13B24650
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i88lRVvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD13B24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUoC-0004fJ-E2
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihUWX-00061x-3Y
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihUWU-0002XB-Rm
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32015
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihUWT-0002Us-F6
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576657052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eb/1E4SQ+zuRjF2JbD755tOvo1a7Jww6246JnRA8vRw=;
 b=i88lRVvBO3Kr0JSURvnXeaMPkyBuBp6BowUS+9+pYmfk99M2XNOvLbBCzq66EZW1Lzjh2D
 PG/Pyov45rGFvpxDrC9AtxNDz+jzmgXRMnuKB1WjAGfxPAv0/Zr7H1gCPi165YN6BQJkgy
 NRJUCpNjFc0DsY31UfI6qLwn1oO0cYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-Xp6_Y0TWMFyrw5gh27XpVQ-1; Wed, 18 Dec 2019 03:17:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FF2BDB2A;
 Wed, 18 Dec 2019 08:17:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B2AD26DD7;
 Wed, 18 Dec 2019 08:17:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BAB5B113642A; Wed, 18 Dec 2019 09:17:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 26/35] qga: rename Error ** parameter to more common errp
Date: Wed, 18 Dec 2019 09:17:12 +0100
Message-Id: <20191218081721.23520-27-armbru@redhat.com>
In-Reply-To: <20191218081721.23520-1-armbru@redhat.com>
References: <20191218081721.23520-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Xp6_Y0TWMFyrw5gh27XpVQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20191205174635.18758-13-vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/commands-posix.c |  2 +-
 qga/commands-win32.c |  2 +-
 qga/commands.c       | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 10d818c3b2..93474ff770 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2794,7 +2794,7 @@ static double ga_get_login_time(struct utmpx *user_in=
fo)
     return seconds + useconds;
 }
=20
-GuestUserList *qmp_guest_get_users(Error **err)
+GuestUserList *qmp_guest_get_users(Error **errp)
 {
     GHashTable *cache =3D NULL;
     GuestUserList *head =3D NULL, *cur_item =3D NULL;
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 55ba5b263a..2461fd19bf 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1946,7 +1946,7 @@ typedef struct _GA_WTSINFOA {
=20
 } GA_WTSINFOA;
=20
-GuestUserList *qmp_guest_get_users(Error **err)
+GuestUserList *qmp_guest_get_users(Error **errp)
 {
 #define QGA_NANOSECONDS 10000000
=20
diff --git a/qga/commands.c b/qga/commands.c
index 0c7d1385c2..43c323cead 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -143,7 +143,7 @@ static GuestExecInfo *guest_exec_info_find(int64_t pid_=
numeric)
     return NULL;
 }
=20
-GuestExecStatus *qmp_guest_exec_status(int64_t pid, Error **err)
+GuestExecStatus *qmp_guest_exec_status(int64_t pid, Error **errp)
 {
     GuestExecInfo *gei;
     GuestExecStatus *ges;
@@ -152,7 +152,7 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid, Err=
or **err)
=20
     gei =3D guest_exec_info_find(pid);
     if (gei =3D=3D NULL) {
-        error_setg(err, QERR_INVALID_PARAMETER, "pid");
+        error_setg(errp, QERR_INVALID_PARAMETER, "pid");
         return NULL;
     }
=20
@@ -385,7 +385,7 @@ GuestExec *qmp_guest_exec(const char *path,
                        bool has_env, strList *env,
                        bool has_input_data, const char *input_data,
                        bool has_capture_output, bool capture_output,
-                       Error **err)
+                       Error **errp)
 {
     GPid pid;
     GuestExec *ge =3D NULL;
@@ -405,7 +405,7 @@ GuestExec *qmp_guest_exec(const char *path,
     arglist.next =3D has_arg ? arg : NULL;
=20
     if (has_input_data) {
-        input =3D qbase64_decode(input_data, -1, &ninput, err);
+        input =3D qbase64_decode(input_data, -1, &ninput, errp);
         if (!input) {
             return NULL;
         }
@@ -424,7 +424,7 @@ GuestExec *qmp_guest_exec(const char *path,
             guest_exec_task_setup, NULL, &pid, has_input_data ? &in_fd : N=
ULL,
             has_output ? &out_fd : NULL, has_output ? &err_fd : NULL, &ger=
r);
     if (!ret) {
-        error_setg(err, QERR_QGA_COMMAND_FAILED, gerr->message);
+        error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr->message);
         g_error_free(gerr);
         goto done;
     }
@@ -499,7 +499,7 @@ int ga_parse_whence(GuestFileWhence *whence, Error **er=
rp)
     return -1;
 }
=20
-GuestHostName *qmp_guest_get_host_name(Error **err)
+GuestHostName *qmp_guest_get_host_name(Error **errp)
 {
     GuestHostName *result =3D NULL;
     gchar const *hostname =3D g_get_host_name();
--=20
2.21.0


