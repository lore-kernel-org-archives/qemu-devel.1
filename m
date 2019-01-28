Received: from eggs.gnu.org ([209.51.188.92]:52649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goAKG-00007l-Iq
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goAKA-0004er-NJ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:04:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1goAKA-0004Hq-4v
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:03:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF997138229
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 17:03:42 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 28 Jan 2019 17:03:20 +0000
Message-Id: <20190128170321.16936-9-dgilbert@redhat.com>
In-Reply-To: <20190128170321.16936-1-dgilbert@redhat.com>
References: <20190128170321.16936-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 8/9] hmp: Add hmp_announce_self
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, eblake@redhat.com, armbru@redhat.com, berrange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add an HMP command to trigger self annocements.
Unlike the QMP command (which takes a set of parameters), the HMP
command reuses the set of parameters used for migration.

Signend-off-by: Vladislav Yasevich <vyasevic@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands.hx  | 14 ++++++++++++++
 hmp.c            |  5 +++++
 hmp.h            |  1 +
 tests/test-hmp.c |  1 +
 4 files changed, 21 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index ba71558c25..9f812bc63b 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -928,6 +928,20 @@ Bug: can screw up when the buffer contains invalid U=
TF-8 sequences,
 NUL characters, after the ring buffer lost data, and when reading
 stops because the size limit is reached.
=20
+ETEXI
+
+    {
+        .name       =3D "announce_self",
+        .args_type  =3D "",
+        .params     =3D "",
+        .help       =3D "Trigger GARP/RARP announcements",
+        .cmd        =3D hmp_announce_self,
+    },
+
+STEXI
+@item announce_self
+@findex announce_self
+Trigger GARP/RARP announcements.
 ETEXI
=20
     {
diff --git a/hmp.c b/hmp.c
index 319f5134cd..ccaa817ecd 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1570,6 +1570,11 @@ void hmp_info_snapshots(Monitor *mon, const QDict =
*qdict)
=20
 }
=20
+void hmp_announce_self(Monitor *mon, const QDict *qdict)
+{
+    qmp_announce_self(migrate_announce_params(), NULL);
+}
+
 void hmp_migrate_cancel(Monitor *mon, const QDict *qdict)
 {
     qmp_migrate_cancel(NULL);
diff --git a/hmp.h b/hmp.h
index 5f1addcca2..e0f32f04d3 100644
--- a/hmp.h
+++ b/hmp.h
@@ -46,6 +46,7 @@ void hmp_sync_profile(Monitor *mon, const QDict *qdict)=
;
 void hmp_system_reset(Monitor *mon, const QDict *qdict);
 void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
 void hmp_exit_preconfig(Monitor *mon, const QDict *qdict);
+void hmp_announce_self(Monitor *mon, const QDict *qdict);
 void hmp_cpu(Monitor *mon, const QDict *qdict);
 void hmp_memsave(Monitor *mon, const QDict *qdict);
 void hmp_pmemsave(Monitor *mon, const QDict *qdict);
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 1a3a9c5099..8c49d2fdf1 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -20,6 +20,7 @@
 static int verbose;
=20
 static const char *hmp_cmds[] =3D {
+    "announce_self",
     "boot_set ndc",
     "chardev-add null,id=3Dtestchardev1",
     "chardev-send-break testchardev1",
--=20
2.20.1
