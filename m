Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URG_BIZ,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB56CA9EAE
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 03:34:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC002086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 03:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC002086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN7PU-0001VL-Nt
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 23:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cenjiahui@huawei.com>) id 1iN7ON-0000el-0T
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 23:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cenjiahui@huawei.com>) id 1iN7OK-0000EB-Va
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 23:32:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:32892 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cenjiahui@huawei.com>)
 id 1iN7OK-0000D7-DG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 23:32:56 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D1D555B6479760B75487;
 Wed, 23 Oct 2019 11:32:48 +0800 (CST)
Received: from localhost (10.173.220.89) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 11:32:39 +0800
From: cenjiahui <cenjiahui@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH 3/3] migration/multifd: fix potential wrong acception order of
 IOChannel
Date: Wed, 23 Oct 2019 11:32:14 +0800
Message-ID: <20191023033214.31592-3-cenjiahui@huawei.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191023033214.31592-1-cenjiahui@huawei.com>
References: <20191023033214.31592-1-cenjiahui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.220.89]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: fangying1@huawei.com, Jiahui Cen <cenjiahui@huawei.com>,
 qemu-devel@nongnu.org, peterx@redhat.com, zhouyibo3@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jiahui Cen <cenjiahui@huawei.com>

Multifd assumes the migration thread IOChannel is always established befo=
re
the multifd IOChannels, but this assumption will be broken in many situat=
ions
like network packet loss.

For example:
Step1: Source (migration thread IOChannel)  --SYN-->  Destination
Step2: Source (migration thread IOChannel)  <--SYNACK  Destination
Step3: Source (migration thread IOChannel, lost) --ACK-->X  Destination
Step4: Source (multifd IOChannel) --SYN-->    Destination
Step5: Source (multifd IOChannel) <--SYNACK   Destination
Step6: Source (multifd IOChannel, ESTABLISHED) --ACK-->  Destination
Step7: Destination accepts multifd IOChannel
Step8: Source (migration thread IOChannel, ESTABLISHED) -ACK,DATA->  Dest=
ination
Step9: Destination accepts migration thread IOChannel

The above situation can be reproduced by creating a weak network environm=
ent,
such as "tc qdisc add dev eth0 root netem loss 50%". The wrong acception =
order
will cause magic check failure and thus lead to migration failure.

This patch fixes this issue by sending a migration IOChannel initial pack=
et with
a unique id when using multifd migration. Since the multifd IOChannels wi=
ll also
send initial packets, the destination can judge whether the processing IO=
Channel
belongs to multifd by checking the id in the initial packet. This mechani=
sm can
ensure that different IOChannels will go to correct branches in our test.

Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 migration/channel.c   |  9 +++++++++
 migration/migration.c | 49 ++++++++++++++++++++++++---------------------=
----
 migration/migration.h |  3 +++
 migration/ram.c       | 38 +++++++++++++-------------------------
 migration/ram.h       |  3 ++-
 migration/socket.c    |  7 +++++++
 6 files changed, 58 insertions(+), 51 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 20e4c8e..7462181 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -82,6 +82,15 @@ void migration_channel_connect(MigrationState *s,
                 return;
             }
         } else {
+            if (migrate_use_multifd()) {
+                /* multifd migration cannot distinguish migration IOChan=
nel
+                 * from multifd IOChannels, so we need to send an initia=
l packet
+                 * to show it is migration IOChannel
+                 */
+                migration_send_initial_packet(ioc,
+                                              migrate_multifd_channels()=
,
+                                              &error);
+            }
             QEMUFile *f =3D qemu_fopen_channel_output(ioc);
=20
             qemu_mutex_lock(&s->qemu_file_lock);
diff --git a/migration/migration.c b/migration/migration.c
index 3febd0f..3da2baf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -521,12 +521,6 @@ static void migration_incoming_setup(QEMUFile *f)
 {
     MigrationIncomingState *mis =3D migration_incoming_get_current();
=20
-    if (multifd_load_setup() !=3D 0) {
-        /* We haven't been able to create multifd threads
-           nothing better to do */
-        exit(EXIT_FAILURE);
-    }
-
     if (!mis->from_src_file) {
         mis->from_src_file =3D f;
     }
@@ -584,36 +578,41 @@ void migration_fd_process_incoming(QEMUFile *f)
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
 {
     MigrationIncomingState *mis =3D migration_incoming_get_current();
-    bool start_migration;
-
-    if (!mis->from_src_file) {
-        /* The first connection (multifd may have multiple) */
-        QEMUFile *f =3D qemu_fopen_channel_input(ioc);
+    Error *local_err =3D NULL;
+    int id =3D 0;
=20
-        /* If it's a recovery, we're done */
-        if (postcopy_try_recover(f)) {
-            return;
-        }
+    if (migrate_use_multifd()) {
+        id =3D migration_recv_initial_packet(ioc, &local_err);
+    }
+    if (!migrate_use_multifd() || id =3D=3D migrate_multifd_channels()) =
{
+        if (!mis->from_src_file) {
+            /* The migration connection (multifd may have multiple) */
+            QEMUFile *f =3D qemu_fopen_channel_input(ioc);
=20
-        migration_incoming_setup(f);
+            /* If it's a recovery, we're done */
+            if (postcopy_try_recover(f)) {
+                return;
+            }
=20
-        /*
-         * Common migration only needs one channel, so we can start
-         * right now.  Multifd needs more than one channel, we wait.
-         */
-        start_migration =3D !migrate_use_multifd();
-    } else {
-        Error *local_err =3D NULL;
+            migration_incoming_setup(f);
+        }
+    } else if (id >=3D 0) {
         /* Multiple connections */
         assert(migrate_use_multifd());
-        start_migration =3D multifd_recv_new_channel(ioc, &local_err);
+        multifd_recv_new_channel(ioc, id, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
         }
+    } else {
+        /* Bad connections */
+        multifd_recv_terminate_threads(local_err);
+        error_propagate(errp, local_err);
+        return;
     }
=20
-    if (start_migration) {
+    /* Once we have all the channels we need, we can start migration */
+    if (migration_has_all_channels()) {
         migration_incoming_process();
     }
 }
diff --git a/migration/migration.h b/migration/migration.h
index 4f2fe19..ba8caa4 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -339,4 +339,7 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, =
void *opaque);
 void migration_make_urgent_request(void);
 void migration_consume_urgent_request(void);
=20
+int migration_send_initial_packet(QIOChannel *c, uint8_t id, Error **err=
p);
+int migration_recv_initial_packet(QIOChannel *c, Error **errp);
+
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index 24a8906..2220875 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -593,7 +593,7 @@ typedef struct {
     uint8_t id;
     uint8_t unused1[7];     /* Reserved for future use */
     uint64_t unused2[4];    /* Reserved for future use */
-} __attribute__((packed)) MultiFDInit_t;
+} __attribute__((packed)) MigrationInit_t;
=20
 typedef struct {
     uint32_t magic;
@@ -702,26 +702,26 @@ typedef struct {
     QemuSemaphore sem_sync;
 } MultiFDRecvParams;
=20
-static int multifd_send_initial_packet(MultiFDSendParams *p, Error **err=
p)
+int migration_send_initial_packet(QIOChannel *c, uint8_t id, Error **err=
p)
 {
-    MultiFDInit_t msg;
+    MigrationInit_t msg;
     int ret;
=20
     msg.magic =3D cpu_to_be32(MULTIFD_MAGIC);
     msg.version =3D cpu_to_be32(MULTIFD_VERSION);
-    msg.id =3D p->id;
+    msg.id =3D id;
     memcpy(msg.uuid, &qemu_uuid.data, sizeof(msg.uuid));
=20
-    ret =3D qio_channel_write_all(p->c, (char *)&msg, sizeof(msg), errp)=
;
+    ret =3D qio_channel_write_all(c, (char *)&msg, sizeof(msg), errp);
     if (ret !=3D 0) {
         return -1;
     }
     return 0;
 }
=20
-static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
+int migration_recv_initial_packet(QIOChannel *c, Error **errp)
 {
-    MultiFDInit_t msg;
+    MigrationInit_t msg;
     int ret;
=20
     ret =3D qio_channel_read_all(c, (char *)&msg, sizeof(msg), errp);
@@ -756,8 +756,8 @@ static int multifd_recv_initial_packet(QIOChannel *c,=
 Error **errp)
     }
=20
     if (msg.id > migrate_multifd_channels()) {
-        error_setg(errp, "multifd: received channel version %d "
-                   "expected %d", msg.version, MULTIFD_VERSION);
+        error_setg(errp, "multifd: received channel id %d "
+                   "expected [0-%d]", msg.id, migrate_multifd_channels()=
);
         return -1;
     }
=20
@@ -1112,7 +1112,7 @@ static void *multifd_send_thread(void *opaque)
     trace_multifd_send_thread_start(p->id);
     rcu_register_thread();
=20
-    if (multifd_send_initial_packet(p, &local_err) < 0) {
+    if (migration_send_initial_packet(p->c, p->id, &local_err) < 0) {
         ret =3D -1;
         goto out;
     }
@@ -1259,7 +1259,7 @@ struct {
     uint64_t packet_num;
 } *multifd_recv_state;
=20
-static void multifd_recv_terminate_threads(Error *err)
+void multifd_recv_terminate_threads(Error *err)
 {
     int i;
=20
@@ -1480,21 +1480,11 @@ bool multifd_recv_all_channels_created(void)
  * - Return false and do not set @errp when correctly receiving the curr=
ent one;
  * - Return false and set @errp when failing to receive the current chan=
nel.
  */
-bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
+void multifd_recv_new_channel(QIOChannel *ioc, int id, Error **errp)
 {
     MultiFDRecvParams *p;
     Error *local_err =3D NULL;
-    int id;
=20
-    id =3D multifd_recv_initial_packet(ioc, &local_err);
-    if (id < 0) {
-        multifd_recv_terminate_threads(local_err);
-        error_propagate_prepend(errp, local_err,
-                                "failed to receive packet"
-                                " via multifd channel %d: ",
-                                atomic_read(&multifd_recv_state->count))=
;
-        return false;
-    }
     trace_multifd_recv_new_channel(id);
=20
     p =3D &multifd_recv_state->params[id];
@@ -1503,7 +1493,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Erro=
r **errp)
                    id);
         multifd_recv_terminate_threads(local_err);
         error_propagate(errp, local_err);
-        return false;
+        return;
     }
     p->c =3D ioc;
     object_ref(OBJECT(ioc));
@@ -1514,8 +1504,6 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Erro=
r **errp)
     qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
                        QEMU_THREAD_JOINABLE);
     atomic_inc(&multifd_recv_state->count);
-    return atomic_read(&multifd_recv_state->count) =3D=3D
-           migrate_multifd_channels();
 }
=20
 /**
diff --git a/migration/ram.h b/migration/ram.h
index bd0eee7..a788ff0 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -46,7 +46,8 @@ void multifd_save_cleanup(void);
 int multifd_load_setup(void);
 int multifd_load_cleanup(Error **errp);
 bool multifd_recv_all_channels_created(void);
-bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
+void multifd_recv_new_channel(QIOChannel *ioc, int id, Error **errp);
+void multifd_recv_terminate_threads(Error *err);
=20
 uint64_t ram_pagesize_summary(void);
 int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_=
t len);
diff --git a/migration/socket.c b/migration/socket.c
index 97c9efd..f3bd80d 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -22,6 +22,7 @@
 #include "channel.h"
 #include "socket.h"
 #include "migration.h"
+#include "ram.h"
 #include "qemu-file.h"
 #include "io/channel-socket.h"
 #include "io/net-listener.h"
@@ -186,6 +187,12 @@ static void socket_start_incoming_migration(SocketAd=
dress *saddr,
         num =3D migrate_multifd_channels();
     }
=20
+    if (multifd_load_setup() !=3D 0) {
+        /* We haven't been able to create multifd threads
+           nothing better to do */
+        exit(EXIT_FAILURE);
+    }
+
     if (qio_net_listener_open_sync(listener, saddr, num, errp) < 0) {
         object_unref(OBJECT(listener));
         return;
--=20
1.8.3.1



