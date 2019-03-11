Received: from eggs.gnu.org ([209.51.188.92]:35850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6T-0000BB-Ha
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6S-0004g8-8R
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6Q-0004da-Ah
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CEF1BE6A8B
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E6045DD74
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:56 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:36 +0100
Message-Id: <20190311220843.4026-21-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-1-armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/27] vl: Improve legibility of BlockdevOptions
 queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Give the queue head type a name: BlockdevOptionsQueue.

Rename the queue entry type from BlockdevOptions_queue to
BlockdevOptionsQueueEntry.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190308131445.17502-6-armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 vl.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/vl.c b/vl.c
index 22609af3a4..ef7f8c36b6 100644
--- a/vl.c
+++ b/vl.c
@@ -1191,6 +1191,14 @@ static void default_drive(int enable, int snapshot=
, BlockInterfaceType type,
=20
 }
=20
+typedef struct BlockdevOptionsQueueEntry {
+    BlockdevOptions *bdo;
+    Location loc;
+    QSIMPLEQ_ENTRY(BlockdevOptionsQueueEntry) entry;
+} BlockdevOptionsQueueEntry;
+
+typedef QSIMPLEQ_HEAD(, BlockdevOptionsQueueEntry) BlockdevOptionsQueue;
+
 static QemuOptsList qemu_smp_opts =3D {
     .name =3D "smp-opts",
     .implied_opt_name =3D "cpus",
@@ -2971,13 +2979,7 @@ int main(int argc, char **argv, char **envp)
     Error *err =3D NULL;
     bool list_data_dirs =3D false;
     char *dir, **dirs;
-    typedef struct BlockdevOptions_queue {
-        BlockdevOptions *bdo;
-        Location loc;
-        QSIMPLEQ_ENTRY(BlockdevOptions_queue) entry;
-    } BlockdevOptions_queue;
-    QSIMPLEQ_HEAD(, BlockdevOptions_queue) bdo_queue
-        =3D QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
+    BlockdevOptionsQueue bdo_queue =3D QSIMPLEQ_HEAD_INITIALIZER(bdo_que=
ue);
=20
     module_call_init(MODULE_INIT_TRACE);
=20
@@ -3101,12 +3103,12 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_blockdev:
                 {
                     Visitor *v;
-                    BlockdevOptions_queue *bdo;
+                    BlockdevOptionsQueueEntry *bdo;
=20
                     v =3D qobject_input_visitor_new_str(optarg, "driver"=
,
                                                       &error_fatal);
=20
-                    bdo =3D g_new(BlockdevOptions_queue, 1);
+                    bdo =3D g_new(BlockdevOptionsQueueEntry, 1);
                     visit_type_BlockdevOptions(v, NULL, &bdo->bdo,
                                                &error_fatal);
                     visit_free(v);
@@ -4366,7 +4368,7 @@ int main(int argc, char **argv, char **envp)
=20
     /* open the virtual block devices */
     while (!QSIMPLEQ_EMPTY(&bdo_queue)) {
-        BlockdevOptions_queue *bdo =3D QSIMPLEQ_FIRST(&bdo_queue);
+        BlockdevOptionsQueueEntry *bdo =3D QSIMPLEQ_FIRST(&bdo_queue);
=20
         QSIMPLEQ_REMOVE_HEAD(&bdo_queue, entry);
         loc_push_restore(&bdo->loc);
--=20
2.17.2
