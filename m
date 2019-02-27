Received: from eggs.gnu.org ([209.51.188.92]:45837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gyzCO-00014l-NF
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:24:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gyzCN-0000Z3-DQ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:24:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gyzCM-0000Wo-U8
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:24:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D5F93B77E
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 13:24:28 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 27 Feb 2019 13:24:12 +0000
Message-Id: <20190227132413.13213-9-dgilbert@redhat.com>
In-Reply-To: <20190227132413.13213-1-dgilbert@redhat.com>
References: <20190227132413.13213-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 8/9] hmp: Add hmp_announce_self
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com
Cc: quintela@redhat.com, armbru@redhat.com, thuth@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add an HMP command to trigger self annocements.
Unlike the QMP command (which takes a set of parameters), the HMP
command reuses the set of parameters used for migration.

Signend-off-by: Vladislav Yasevich <vyasevic@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hmp-commands.hx  | 16 ++++++++++++++++
 hmp.c            |  5 +++++
 hmp.h            |  1 +
 tests/test-hmp.c |  1 +
 4 files changed, 23 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index ba71558c25..0648b1efa3 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -928,6 +928,22 @@ Bug: can screw up when the buffer contains invalid U=
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
+Trigger a round of GARP/RARP broadcasts; this is useful for explicitly u=
pdating the
+network infrastructure after a reconfiguration or some forms of migratio=
n.
+The timings of the round are set by the migration announce parameters.
 ETEXI
=20
     {
diff --git a/hmp.c b/hmp.c
index f3db0bf5a2..5f13b16e24 100644
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
