Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D518C04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 08:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D951D27D62
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 08:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D951D27D62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59447 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXi9S-00080d-2z
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 04:17:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hXi67-00061o-PA
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hXi66-0006fZ-P3
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:13:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hXi66-0006eb-Jx
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:13:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EEFA181127
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 08:13:37 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-112-59.ams2.redhat.com
	[10.36.112.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CBF7A1B465;
	Mon,  3 Jun 2019 08:13:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 10:13:34 +0200
Message-Id: <20190603081335.8185-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Mon, 03 Jun 2019 08:13:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] qgraph: allow extra_device_opts on contains
 nodes
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
Cc: thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow choosing the bus that the device will be placed on, in case
the machine has more than one.  Otherwise, the bus may not match
the base address of the controller we attach it to.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qos-test.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tests/qos-test.c b/tests/qos-test.c
index ae2fb5de1c..01b2a22c08 100644
--- a/tests/qos-test.c
+++ b/tests/qos-test.c
@@ -340,7 +340,8 @@ static void walk_path(QOSGraphNode *orig_path, int le=
n)
     char **path_vec =3D g_new0(char *, (QOS_PATH_MAX_ELEMENT_SIZE * 2));
     int path_vec_size =3D 0;
=20
-    char *after_cmd =3D NULL, *before_cmd =3D NULL, *after_device =3D NU=
LL;
+    char *after_cmd, *before_cmd, *after_device;
+    GString *after_device_str =3D g_string_new("");
     char *node_name =3D orig_path->name, *path_str;
=20
     GString *cmd_line =3D g_string_new("");
@@ -363,9 +364,8 @@ static void walk_path(QOSGraphNode *orig_path, int le=
n)
         /* append node command line + previous edge command line */
         if (path->command_line && etype =3D=3D QEDGE_CONSUMED_BY) {
             g_string_append(cmd_line, path->command_line);
-            if (after_device) {
-                g_string_append(cmd_line, after_device);
-            }
+            g_string_append(cmd_line, after_device_str->str);
+            g_string_truncate(after_device_str, 0);
         }
=20
         path_vec[path_vec_size++] =3D qos_graph_edge_get_name(path->path=
_edge);
@@ -382,12 +382,15 @@ static void walk_path(QOSGraphNode *orig_path, int =
len)
         if (after_cmd) {
             g_string_append(cmd_line2, after_cmd);
         }
+        if (after_device) {
+            g_string_append(after_device_str, after_device);
+        }
     }
=20
     path_vec[path_vec_size++] =3D NULL;
-    if (after_device) {
-        g_string_append(cmd_line, after_device);
-    }
+    g_string_append(cmd_line, after_device_str->str);
+    g_string_free(after_device_str, true);
+
     g_string_append(cmd_line, cmd_line2->str);
     g_string_free(cmd_line2, true);
=20
--=20
2.21.0


