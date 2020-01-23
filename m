Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30F5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7252467E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsJJy9qf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7252467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucPp-0002TH-5d
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iub9D-0002ZE-Do
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iub97-0005D7-4J
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29711
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iub96-0005Cc-Pw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T+leNIS9nWaI+AOENppBkAOVD/TxTXO5iS/w38ejyRg=;
 b=QsJJy9qfkbWjAmeJP83dYOIsDjyuY8chOhvAwtkOOM7WoqKk0uVdD9q6xtyorsBPPYHiD3
 vvdpemeEBhVm9ZTOMlx0bx+jprlr1fYzOnXd0M+hDX+vY8kYzXNhMCNlxAGWQHIZChI2q4
 MGwf8vOjeGkCIqKGRaF8jxdu/VgcKkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-ARKWtLnXO5aA8TJnzIU7yA-1; Thu, 23 Jan 2020 06:59:32 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EBFA18A6EC2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:32 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2869219C69;
 Thu, 23 Jan 2020 11:59:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/21] multifd: Split multifd code into its own file
Date: Thu, 23 Jan 2020 12:58:27 +0100
Message-Id: <20200123115831.36842-18-quintela@redhat.com>
In-Reply-To: <20200123115831.36842-1-quintela@redhat.com>
References: <20200123115831.36842-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ARKWtLnXO5aA8TJnzIU7yA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/Makefile.objs |   1 +
 migration/migration.c   |   1 +
 migration/multifd.c     | 891 ++++++++++++++++++++++++++++++++++++
 migration/multifd.h     | 139 ++++++
 migration/ram.c         | 980 +---------------------------------------
 migration/ram.h         |   7 -
 6 files changed, 1033 insertions(+), 986 deletions(-)
 create mode 100644 migration/multifd.c
 create mode 100644 migration/multifd.h

diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index a4f3bafd86..d3623d5f9b 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -7,6 +7,7 @@ common-obj-y +=3D qemu-file-channel.o
 common-obj-y +=3D xbzrle.o postcopy-ram.o
 common-obj-y +=3D qjson.o
 common-obj-y +=3D block-dirty-bitmap.o
+common-obj-y +=3D multifd.o
=20
 common-obj-$(CONFIG_RDMA) +=3D rdma.o
=20
diff --git a/migration/migration.c b/migration/migration.c
index ecb56afd50..3501bc3353 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -53,6 +53,7 @@
 #include "monitor/monitor.h"
 #include "net/announce.h"
 #include "qemu/queue.h"
+#include "multifd.h"
=20
 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttli=
ng */
=20
diff --git a/migration/multifd.c b/migration/multifd.c
new file mode 100644
index 0000000000..1875bb3aaa
--- /dev/null
+++ b/migration/multifd.c
@@ -0,0 +1,891 @@
+/*
+ * Multifd common code
+ *
+ * Copyright (c) 2019-2020 Red Hat Inc
+ *
+ * Authors:
+ *  Juan Quintela <quintela@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/rcu.h"
+#include "exec/target_page.h"
+#include "sysemu/sysemu.h"
+#include "exec/ramblock.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "ram.h"
+#include "migration.h"
+#include "socket.h"
+#include "qemu-file.h"
+#include "trace.h"
+#include "multifd.h"
+
+/* Multiple fd's */
+
+#define MULTIFD_MAGIC 0x11223344U
+#define MULTIFD_VERSION 1
+
+typedef struct {
+    uint32_t magic;
+    uint32_t version;
+    unsigned char uuid[16]; /* QemuUUID */
+    uint8_t id;
+    uint8_t unused1[7];     /* Reserved for future use */
+    uint64_t unused2[4];    /* Reserved for future use */
+} __attribute__((packed)) MultiFDInit_t;
+
+static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
+{
+    MultiFDInit_t msg =3D {};
+    int ret;
+
+    msg.magic =3D cpu_to_be32(MULTIFD_MAGIC);
+    msg.version =3D cpu_to_be32(MULTIFD_VERSION);
+    msg.id =3D p->id;
+    memcpy(msg.uuid, &qemu_uuid.data, sizeof(msg.uuid));
+
+    ret =3D qio_channel_write_all(p->c, (char *)&msg, sizeof(msg), errp);
+    if (ret !=3D 0) {
+        return -1;
+    }
+    return 0;
+}
+
+static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
+{
+    MultiFDInit_t msg;
+    int ret;
+
+    ret =3D qio_channel_read_all(c, (char *)&msg, sizeof(msg), errp);
+    if (ret !=3D 0) {
+        return -1;
+    }
+
+    msg.magic =3D be32_to_cpu(msg.magic);
+    msg.version =3D be32_to_cpu(msg.version);
+
+    if (msg.magic !=3D MULTIFD_MAGIC) {
+        error_setg(errp, "multifd: received packet magic %x "
+                   "expected %x", msg.magic, MULTIFD_MAGIC);
+        return -1;
+    }
+
+    if (msg.version !=3D MULTIFD_VERSION) {
+        error_setg(errp, "multifd: received packet version %d "
+                   "expected %d", msg.version, MULTIFD_VERSION);
+        return -1;
+    }
+
+    if (memcmp(msg.uuid, &qemu_uuid, sizeof(qemu_uuid))) {
+        char *uuid =3D qemu_uuid_unparse_strdup(&qemu_uuid);
+        char *msg_uuid =3D qemu_uuid_unparse_strdup((const QemuUUID *)msg.=
uuid);
+
+        error_setg(errp, "multifd: received uuid '%s' and expected "
+                   "uuid '%s' for channel %hhd", msg_uuid, uuid, msg.id);
+        g_free(uuid);
+        g_free(msg_uuid);
+        return -1;
+    }
+
+    if (msg.id > migrate_multifd_channels()) {
+        error_setg(errp, "multifd: received channel version %d "
+                   "expected %d", msg.version, MULTIFD_VERSION);
+        return -1;
+    }
+
+    return msg.id;
+}
+
+static MultiFDPages_t *multifd_pages_init(size_t size)
+{
+    MultiFDPages_t *pages =3D g_new0(MultiFDPages_t, 1);
+
+    pages->allocated =3D size;
+    pages->iov =3D g_new0(struct iovec, size);
+    pages->offset =3D g_new0(ram_addr_t, size);
+
+    return pages;
+}
+
+static void multifd_pages_clear(MultiFDPages_t *pages)
+{
+    pages->used =3D 0;
+    pages->allocated =3D 0;
+    pages->packet_num =3D 0;
+    pages->block =3D NULL;
+    g_free(pages->iov);
+    pages->iov =3D NULL;
+    g_free(pages->offset);
+    pages->offset =3D NULL;
+    g_free(pages);
+}
+
+static void multifd_send_fill_packet(MultiFDSendParams *p)
+{
+    MultiFDPacket_t *packet =3D p->packet;
+    int i;
+
+    packet->flags =3D cpu_to_be32(p->flags);
+    packet->pages_alloc =3D cpu_to_be32(p->pages->allocated);
+    packet->pages_used =3D cpu_to_be32(p->pages->used);
+    packet->next_packet_size =3D cpu_to_be32(p->next_packet_size);
+    packet->packet_num =3D cpu_to_be64(p->packet_num);
+
+    if (p->pages->block) {
+        strncpy(packet->ramblock, p->pages->block->idstr, 256);
+    }
+
+    for (i =3D 0; i < p->pages->used; i++) {
+        /* there are architectures where ram_addr_t is 32 bit */
+        uint64_t temp =3D p->pages->offset[i];
+
+        packet->offset[i] =3D cpu_to_be64(temp);
+    }
+}
+
+static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
+{
+    MultiFDPacket_t *packet =3D p->packet;
+    uint32_t pages_max =3D MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    RAMBlock *block;
+    int i;
+
+    packet->magic =3D be32_to_cpu(packet->magic);
+    if (packet->magic !=3D MULTIFD_MAGIC) {
+        error_setg(errp, "multifd: received packet "
+                   "magic %x and expected magic %x",
+                   packet->magic, MULTIFD_MAGIC);
+        return -1;
+    }
+
+    packet->version =3D be32_to_cpu(packet->version);
+    if (packet->version !=3D MULTIFD_VERSION) {
+        error_setg(errp, "multifd: received packet "
+                   "version %d and expected version %d",
+                   packet->version, MULTIFD_VERSION);
+        return -1;
+    }
+
+    p->flags =3D be32_to_cpu(packet->flags);
+
+    packet->pages_alloc =3D be32_to_cpu(packet->pages_alloc);
+    /*
+     * If we received a packet that is 100 times bigger than expected
+     * just stop migration.  It is a magic number.
+     */
+    if (packet->pages_alloc > pages_max * 100) {
+        error_setg(errp, "multifd: received packet "
+                   "with size %d and expected a maximum size of %d",
+                   packet->pages_alloc, pages_max * 100) ;
+        return -1;
+    }
+    /*
+     * We received a packet that is bigger than expected but inside
+     * reasonable limits (see previous comment).  Just reallocate.
+     */
+    if (packet->pages_alloc > p->pages->allocated) {
+        multifd_pages_clear(p->pages);
+        p->pages =3D multifd_pages_init(packet->pages_alloc);
+    }
+
+    p->pages->used =3D be32_to_cpu(packet->pages_used);
+    if (p->pages->used > packet->pages_alloc) {
+        error_setg(errp, "multifd: received packet "
+                   "with %d pages and expected maximum pages are %d",
+                   p->pages->used, packet->pages_alloc) ;
+        return -1;
+    }
+
+    p->next_packet_size =3D be32_to_cpu(packet->next_packet_size);
+    p->packet_num =3D be64_to_cpu(packet->packet_num);
+
+    if (p->pages->used =3D=3D 0) {
+        return 0;
+    }
+
+    /* make sure that ramblock is 0 terminated */
+    packet->ramblock[255] =3D 0;
+    block =3D qemu_ram_block_by_name(packet->ramblock);
+    if (!block) {
+        error_setg(errp, "multifd: unknown ram block %s",
+                   packet->ramblock);
+        return -1;
+    }
+
+    for (i =3D 0; i < p->pages->used; i++) {
+        uint64_t offset =3D be64_to_cpu(packet->offset[i]);
+
+        if (offset > (block->used_length - qemu_target_page_size())) {
+            error_setg(errp, "multifd: offset too long %" PRIu64
+                       " (max " RAM_ADDR_FMT ")",
+                       offset, block->max_length);
+            return -1;
+        }
+        p->pages->iov[i].iov_base =3D block->host + offset;
+        p->pages->iov[i].iov_len =3D qemu_target_page_size();
+    }
+
+    return 0;
+}
+
+struct {
+    MultiFDSendParams *params;
+    /* array of pages to sent */
+    MultiFDPages_t *pages;
+    /* global number of generated multifd packets */
+    uint64_t packet_num;
+    /* send channels ready */
+    QemuSemaphore channels_ready;
+    /*
+     * Have we already run terminate threads.  There is a race when it
+     * happens that we got one error while we are exiting.
+     * We will use atomic operations.  Only valid values are 0 and 1.
+     */
+    int exiting;
+} *multifd_send_state;
+
+/*
+ * How we use multifd_send_state->pages and channel->pages?
+ *
+ * We create a pages for each channel, and a main one.  Each time that
+ * we need to send a batch of pages we interchange the ones between
+ * multifd_send_state and the channel that is sending it.  There are
+ * two reasons for that:
+ *    - to not have to do so many mallocs during migration
+ *    - to make easier to know what to free at the end of migration
+ *
+ * This way we always know who is the owner of each "pages" struct,
+ * and we don't need any locking.  It belongs to the migration thread
+ * or to the channel thread.  Switching is safe because the migration
+ * thread is using the channel mutex when changing it, and the channel
+ * have to had finish with its own, otherwise pending_job can't be
+ * false.
+ */
+
+static int multifd_send_pages(QEMUFile *f)
+{
+    int i;
+    static int next_channel;
+    MultiFDSendParams *p =3D NULL; /* make happy gcc */
+    MultiFDPages_t *pages =3D multifd_send_state->pages;
+    uint64_t transferred;
+
+    if (atomic_read(&multifd_send_state->exiting)) {
+        return -1;
+    }
+
+    qemu_sem_wait(&multifd_send_state->channels_ready);
+    for (i =3D next_channel;; i =3D (i + 1) % migrate_multifd_channels()) =
{
+        p =3D &multifd_send_state->params[i];
+
+        qemu_mutex_lock(&p->mutex);
+        if (p->quit) {
+            error_report("%s: channel %d has already quit!", __func__, i);
+            qemu_mutex_unlock(&p->mutex);
+            return -1;
+        }
+        if (!p->pending_job) {
+            p->pending_job++;
+            next_channel =3D (i + 1) % migrate_multifd_channels();
+            break;
+        }
+        qemu_mutex_unlock(&p->mutex);
+    }
+    assert(!p->pages->used);
+    assert(!p->pages->block);
+
+    p->packet_num =3D multifd_send_state->packet_num++;
+    multifd_send_state->pages =3D p->pages;
+    p->pages =3D pages;
+    transferred =3D ((uint64_t) pages->used) * qemu_target_page_size()
+                + p->packet_len;
+    qemu_file_update_transfer(f, transferred);
+    ram_counters.multifd_bytes +=3D transferred;
+    ram_counters.transferred +=3D transferred;;
+    qemu_mutex_unlock(&p->mutex);
+    qemu_sem_post(&p->sem);
+
+    return 1;
+}
+
+int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset)
+{
+    MultiFDPages_t *pages =3D multifd_send_state->pages;
+
+    if (!pages->block) {
+        pages->block =3D block;
+    }
+
+    if (pages->block =3D=3D block) {
+        pages->offset[pages->used] =3D offset;
+        pages->iov[pages->used].iov_base =3D block->host + offset;
+        pages->iov[pages->used].iov_len =3D qemu_target_page_size();
+        pages->used++;
+
+        if (pages->used < pages->allocated) {
+            return 1;
+        }
+    }
+
+    if (multifd_send_pages(f) < 0) {
+        return -1;
+    }
+
+    if (pages->block !=3D block) {
+        return  multifd_queue_page(f, block, offset);
+    }
+
+    return 1;
+}
+
+static void multifd_send_terminate_threads(Error *err)
+{
+    int i;
+
+    trace_multifd_send_terminate_threads(err !=3D NULL);
+
+    if (err) {
+        MigrationState *s =3D migrate_get_current();
+        migrate_set_error(s, err);
+        if (s->state =3D=3D MIGRATION_STATUS_SETUP ||
+            s->state =3D=3D MIGRATION_STATUS_PRE_SWITCHOVER ||
+            s->state =3D=3D MIGRATION_STATUS_DEVICE ||
+            s->state =3D=3D MIGRATION_STATUS_ACTIVE) {
+            migrate_set_state(&s->state, s->state,
+                              MIGRATION_STATUS_FAILED);
+        }
+    }
+
+    /*
+     * We don't want to exit each threads twice.  Depending on where
+     * we get the error, or if there are two independent errors in two
+     * threads at the same time, we can end calling this function
+     * twice.
+     */
+    if (atomic_xchg(&multifd_send_state->exiting, 1)) {
+        return;
+    }
+
+    for (i =3D 0; i < migrate_multifd_channels(); i++) {
+        MultiFDSendParams *p =3D &multifd_send_state->params[i];
+
+        qemu_mutex_lock(&p->mutex);
+        p->quit =3D true;
+        qemu_sem_post(&p->sem);
+        qemu_mutex_unlock(&p->mutex);
+    }
+}
+
+void multifd_save_cleanup(void)
+{
+    int i;
+
+    if (!migrate_use_multifd()) {
+        return;
+    }
+    multifd_send_terminate_threads(NULL);
+    for (i =3D 0; i < migrate_multifd_channels(); i++) {
+        MultiFDSendParams *p =3D &multifd_send_state->params[i];
+
+        if (p->running) {
+            qemu_thread_join(&p->thread);
+        }
+    }
+    for (i =3D 0; i < migrate_multifd_channels(); i++) {
+        MultiFDSendParams *p =3D &multifd_send_state->params[i];
+
+        socket_send_channel_destroy(p->c);
+        p->c =3D NULL;
+        qemu_mutex_destroy(&p->mutex);
+        qemu_sem_destroy(&p->sem);
+        qemu_sem_destroy(&p->sem_sync);
+        g_free(p->name);
+        p->name =3D NULL;
+        multifd_pages_clear(p->pages);
+        p->pages =3D NULL;
+        p->packet_len =3D 0;
+        g_free(p->packet);
+        p->packet =3D NULL;
+    }
+    qemu_sem_destroy(&multifd_send_state->channels_ready);
+    g_free(multifd_send_state->params);
+    multifd_send_state->params =3D NULL;
+    multifd_pages_clear(multifd_send_state->pages);
+    multifd_send_state->pages =3D NULL;
+    g_free(multifd_send_state);
+    multifd_send_state =3D NULL;
+}
+
+void multifd_send_sync_main(QEMUFile *f)
+{
+    int i;
+
+    if (!migrate_use_multifd()) {
+        return;
+    }
+    if (multifd_send_state->pages->used) {
+        if (multifd_send_pages(f) < 0) {
+            error_report("%s: multifd_send_pages fail", __func__);
+            return;
+        }
+    }
+    for (i =3D 0; i < migrate_multifd_channels(); i++) {
+        MultiFDSendParams *p =3D &multifd_send_state->params[i];
+
+        trace_multifd_send_sync_main_signal(p->id);
+
+        qemu_mutex_lock(&p->mutex);
+
+        if (p->quit) {
+            error_report("%s: channel %d has already quit", __func__, i);
+            qemu_mutex_unlock(&p->mutex);
+            return;
+        }
+
+        p->packet_num =3D multifd_send_state->packet_num++;
+        p->flags |=3D MULTIFD_FLAG_SYNC;
+        p->pending_job++;
+        qemu_file_update_transfer(f, p->packet_len);
+        ram_counters.multifd_bytes +=3D p->packet_len;
+        ram_counters.transferred +=3D p->packet_len;
+        qemu_mutex_unlock(&p->mutex);
+        qemu_sem_post(&p->sem);
+    }
+    for (i =3D 0; i < migrate_multifd_channels(); i++) {
+        MultiFDSendParams *p =3D &multifd_send_state->params[i];
+
+        trace_multifd_send_sync_main_wait(p->id);
+        qemu_sem_wait(&p->sem_sync);
+    }
+    trace_multifd_send_sync_main(multifd_send_state->packet_num);
+}
+
+static void *multifd_send_thread(void *opaque)
+{
+    MultiFDSendParams *p =3D opaque;
+    Error *local_err =3D NULL;
+    int ret =3D 0;
+    uint32_t flags =3D 0;
+
+    trace_multifd_send_thread_start(p->id);
+    rcu_register_thread();
+
+    if (multifd_send_initial_packet(p, &local_err) < 0) {
+        ret =3D -1;
+        goto out;
+    }
+    /* initial packet */
+    p->num_packets =3D 1;
+
+    while (true) {
+        qemu_sem_wait(&p->sem);
+
+        if (atomic_read(&multifd_send_state->exiting)) {
+            break;
+        }
+        qemu_mutex_lock(&p->mutex);
+
+        if (p->pending_job) {
+            uint32_t used =3D p->pages->used;
+            uint64_t packet_num =3D p->packet_num;
+            flags =3D p->flags;
+
+            p->next_packet_size =3D used * qemu_target_page_size();
+            multifd_send_fill_packet(p);
+            p->flags =3D 0;
+            p->num_packets++;
+            p->num_pages +=3D used;
+            p->pages->used =3D 0;
+            p->pages->block =3D NULL;
+            qemu_mutex_unlock(&p->mutex);
+
+            trace_multifd_send(p->id, packet_num, used, flags,
+                               p->next_packet_size);
+
+            ret =3D qio_channel_write_all(p->c, (void *)p->packet,
+                                        p->packet_len, &local_err);
+            if (ret !=3D 0) {
+                break;
+            }
+
+            if (used) {
+                ret =3D qio_channel_writev_all(p->c, p->pages->iov,
+                                             used, &local_err);
+                if (ret !=3D 0) {
+                    break;
+                }
+            }
+
+            qemu_mutex_lock(&p->mutex);
+            p->pending_job--;
+            qemu_mutex_unlock(&p->mutex);
+
+            if (flags & MULTIFD_FLAG_SYNC) {
+                qemu_sem_post(&p->sem_sync);
+            }
+            qemu_sem_post(&multifd_send_state->channels_ready);
+        } else if (p->quit) {
+            qemu_mutex_unlock(&p->mutex);
+            break;
+        } else {
+            qemu_mutex_unlock(&p->mutex);
+            /* sometimes there are spurious wakeups */
+        }
+    }
+
+out:
+    if (local_err) {
+        trace_multifd_send_error(p->id);
+        multifd_send_terminate_threads(local_err);
+    }
+
+    /*
+     * Error happen, I will exit, but I can't just leave, tell
+     * who pay attention to me.
+     */
+    if (ret !=3D 0) {
+        qemu_sem_post(&p->sem_sync);
+        qemu_sem_post(&multifd_send_state->channels_ready);
+    }
+
+    qemu_mutex_lock(&p->mutex);
+    p->running =3D false;
+    qemu_mutex_unlock(&p->mutex);
+
+    rcu_unregister_thread();
+    trace_multifd_send_thread_end(p->id, p->num_packets, p->num_pages);
+
+    return NULL;
+}
+
+static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
+{
+    MultiFDSendParams *p =3D opaque;
+    QIOChannel *sioc =3D QIO_CHANNEL(qio_task_get_source(task));
+    Error *local_err =3D NULL;
+
+    trace_multifd_new_send_channel_async(p->id);
+    if (qio_task_propagate_error(task, &local_err)) {
+        migrate_set_error(migrate_get_current(), local_err);
+        multifd_save_cleanup();
+    } else {
+        p->c =3D QIO_CHANNEL(sioc);
+        qio_channel_set_delay(p->c, false);
+        p->running =3D true;
+        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
+                           QEMU_THREAD_JOINABLE);
+    }
+}
+
+int multifd_save_setup(Error **errp)
+{
+    int thread_count;
+    uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    uint8_t i;
+
+    if (!migrate_use_multifd()) {
+        return 0;
+    }
+    thread_count =3D migrate_multifd_channels();
+    multifd_send_state =3D g_malloc0(sizeof(*multifd_send_state));
+    multifd_send_state->params =3D g_new0(MultiFDSendParams, thread_count)=
;
+    multifd_send_state->pages =3D multifd_pages_init(page_count);
+    qemu_sem_init(&multifd_send_state->channels_ready, 0);
+    atomic_set(&multifd_send_state->exiting, 0);
+
+    for (i =3D 0; i < thread_count; i++) {
+        MultiFDSendParams *p =3D &multifd_send_state->params[i];
+
+        qemu_mutex_init(&p->mutex);
+        qemu_sem_init(&p->sem, 0);
+        qemu_sem_init(&p->sem_sync, 0);
+        p->quit =3D false;
+        p->pending_job =3D 0;
+        p->id =3D i;
+        p->pages =3D multifd_pages_init(page_count);
+        p->packet_len =3D sizeof(MultiFDPacket_t)
+                      + sizeof(uint64_t) * page_count;
+        p->packet =3D g_malloc0(p->packet_len);
+        p->packet->magic =3D cpu_to_be32(MULTIFD_MAGIC);
+        p->packet->version =3D cpu_to_be32(MULTIFD_VERSION);
+        p->name =3D g_strdup_printf("multifdsend_%d", i);
+        socket_send_channel_create(multifd_new_send_channel_async, p);
+    }
+    return 0;
+}
+
+struct {
+    MultiFDRecvParams *params;
+    /* number of created threads */
+    int count;
+    /* syncs main thread and channels */
+    QemuSemaphore sem_sync;
+    /* global number of generated multifd packets */
+    uint64_t packet_num;
+} *multifd_recv_state;
+
+static void multifd_recv_terminate_threads(Error *err)
+{
+    int i;
+
+    trace_multifd_recv_terminate_threads(err !=3D NULL);
+
+    if (err) {
+        MigrationState *s =3D migrate_get_current();
+        migrate_set_error(s, err);
+        if (s->state =3D=3D MIGRATION_STATUS_SETUP ||
+            s->state =3D=3D MIGRATION_STATUS_ACTIVE) {
+            migrate_set_state(&s->state, s->state,
+                              MIGRATION_STATUS_FAILED);
+        }
+    }
+
+    for (i =3D 0; i < migrate_multifd_channels(); i++) {
+        MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
+
+        qemu_mutex_lock(&p->mutex);
+        p->quit =3D true;
+        /*
+         * We could arrive here for two reasons:
+         *  - normal quit, i.e. everything went fine, just finished
+         *  - error quit: We close the channels so the channel threads
+         *    finish the qio_channel_read_all_eof()
+         */
+        if (p->c) {
+            qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+        }
+        qemu_mutex_unlock(&p->mutex);
+    }
+}
+
+int multifd_load_cleanup(Error **errp)
+{
+    int i;
+    int ret =3D 0;
+
+    if (!migrate_use_multifd()) {
+        return 0;
+    }
+    multifd_recv_terminate_threads(NULL);
+    for (i =3D 0; i < migrate_multifd_channels(); i++) {
+        MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
+
+        if (p->running) {
+            p->quit =3D true;
+            /*
+             * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle co=
de,
+             * however try to wakeup it without harm in cleanup phase.
+             */
+            qemu_sem_post(&p->sem_sync);
+            qemu_thread_join(&p->thread);
+        }
+    }
+    for (i =3D 0; i < migrate_multifd_channels(); i++) {
+        MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
+
+        object_unref(OBJECT(p->c));
+        p->c =3D NULL;
+        qemu_mutex_destroy(&p->mutex);
+        qemu_sem_destroy(&p->sem_sync);
+        g_free(p->name);
+        p->name =3D NULL;
+        multifd_pages_clear(p->pages);
+        p->pages =3D NULL;
+        p->packet_len =3D 0;
+        g_free(p->packet);
+        p->packet =3D NULL;
+    }
+    qemu_sem_destroy(&multifd_recv_state->sem_sync);
+    g_free(multifd_recv_state->params);
+    multifd_recv_state->params =3D NULL;
+    g_free(multifd_recv_state);
+    multifd_recv_state =3D NULL;
+
+    return ret;
+}
+
+void multifd_recv_sync_main(void)
+{
+    int i;
+
+    if (!migrate_use_multifd()) {
+        return;
+    }
+    for (i =3D 0; i < migrate_multifd_channels(); i++) {
+        MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
+
+        trace_multifd_recv_sync_main_wait(p->id);
+        qemu_sem_wait(&multifd_recv_state->sem_sync);
+    }
+    for (i =3D 0; i < migrate_multifd_channels(); i++) {
+        MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
+
+        qemu_mutex_lock(&p->mutex);
+        if (multifd_recv_state->packet_num < p->packet_num) {
+            multifd_recv_state->packet_num =3D p->packet_num;
+        }
+        qemu_mutex_unlock(&p->mutex);
+        trace_multifd_recv_sync_main_signal(p->id);
+        qemu_sem_post(&p->sem_sync);
+    }
+    trace_multifd_recv_sync_main(multifd_recv_state->packet_num);
+}
+
+static void *multifd_recv_thread(void *opaque)
+{
+    MultiFDRecvParams *p =3D opaque;
+    Error *local_err =3D NULL;
+    int ret;
+
+    trace_multifd_recv_thread_start(p->id);
+    rcu_register_thread();
+
+    while (true) {
+        uint32_t used;
+        uint32_t flags;
+
+        if (p->quit) {
+            break;
+        }
+
+        ret =3D qio_channel_read_all_eof(p->c, (void *)p->packet,
+                                       p->packet_len, &local_err);
+        if (ret =3D=3D 0) {   /* EOF */
+            break;
+        }
+        if (ret =3D=3D -1) {   /* Error */
+            break;
+        }
+
+        qemu_mutex_lock(&p->mutex);
+        ret =3D multifd_recv_unfill_packet(p, &local_err);
+        if (ret) {
+            qemu_mutex_unlock(&p->mutex);
+            break;
+        }
+
+        used =3D p->pages->used;
+        flags =3D p->flags;
+        trace_multifd_recv(p->id, p->packet_num, used, flags,
+                           p->next_packet_size);
+        p->num_packets++;
+        p->num_pages +=3D used;
+        qemu_mutex_unlock(&p->mutex);
+
+        if (used) {
+            ret =3D qio_channel_readv_all(p->c, p->pages->iov,
+                                        used, &local_err);
+            if (ret !=3D 0) {
+                break;
+            }
+        }
+
+        if (flags & MULTIFD_FLAG_SYNC) {
+            qemu_sem_post(&multifd_recv_state->sem_sync);
+            qemu_sem_wait(&p->sem_sync);
+        }
+    }
+
+    if (local_err) {
+        multifd_recv_terminate_threads(local_err);
+    }
+    qemu_mutex_lock(&p->mutex);
+    p->running =3D false;
+    qemu_mutex_unlock(&p->mutex);
+
+    rcu_unregister_thread();
+    trace_multifd_recv_thread_end(p->id, p->num_packets, p->num_pages);
+
+    return NULL;
+}
+
+int multifd_load_setup(Error **errp)
+{
+    int thread_count;
+    uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    uint8_t i;
+
+    if (!migrate_use_multifd()) {
+        return 0;
+    }
+    thread_count =3D migrate_multifd_channels();
+    multifd_recv_state =3D g_malloc0(sizeof(*multifd_recv_state));
+    multifd_recv_state->params =3D g_new0(MultiFDRecvParams, thread_count)=
;
+    atomic_set(&multifd_recv_state->count, 0);
+    qemu_sem_init(&multifd_recv_state->sem_sync, 0);
+
+    for (i =3D 0; i < thread_count; i++) {
+        MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
+
+        qemu_mutex_init(&p->mutex);
+        qemu_sem_init(&p->sem_sync, 0);
+        p->quit =3D false;
+        p->id =3D i;
+        p->pages =3D multifd_pages_init(page_count);
+        p->packet_len =3D sizeof(MultiFDPacket_t)
+                      + sizeof(uint64_t) * page_count;
+        p->packet =3D g_malloc0(p->packet_len);
+        p->name =3D g_strdup_printf("multifdrecv_%d", i);
+    }
+    return 0;
+}
+
+bool multifd_recv_all_channels_created(void)
+{
+    int thread_count =3D migrate_multifd_channels();
+
+    if (!migrate_use_multifd()) {
+        return true;
+    }
+
+    return thread_count =3D=3D atomic_read(&multifd_recv_state->count);
+}
+
+/*
+ * Try to receive all multifd channels to get ready for the migration.
+ * - Return true and do not set @errp when correctly receving all channels=
;
+ * - Return false and do not set @errp when correctly receiving the curren=
t one;
+ * - Return false and set @errp when failing to receive the current channe=
l.
+ */
+bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
+{
+    MultiFDRecvParams *p;
+    Error *local_err =3D NULL;
+    int id;
+
+    id =3D multifd_recv_initial_packet(ioc, &local_err);
+    if (id < 0) {
+        multifd_recv_terminate_threads(local_err);
+        error_propagate_prepend(errp, local_err,
+                                "failed to receive packet"
+                                " via multifd channel %d: ",
+                                atomic_read(&multifd_recv_state->count));
+        return false;
+    }
+    trace_multifd_recv_new_channel(id);
+
+    p =3D &multifd_recv_state->params[id];
+    if (p->c !=3D NULL) {
+        error_setg(&local_err, "multifd: received id '%d' already setup'",
+                   id);
+        multifd_recv_terminate_threads(local_err);
+        error_propagate(errp, local_err);
+        return false;
+    }
+    p->c =3D ioc;
+    object_ref(OBJECT(ioc));
+    /* initial packet */
+    p->num_packets =3D 1;
+
+    p->running =3D true;
+    qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
+                       QEMU_THREAD_JOINABLE);
+    atomic_inc(&multifd_recv_state->count);
+    return atomic_read(&multifd_recv_state->count) =3D=3D
+           migrate_multifd_channels();
+}
+
diff --git a/migration/multifd.h b/migration/multifd.h
new file mode 100644
index 0000000000..d8b0205977
--- /dev/null
+++ b/migration/multifd.h
@@ -0,0 +1,139 @@
+/*
+ * Multifd common functions
+ *
+ * Copyright (c) 2019-2020 Red Hat Inc
+ *
+ * Authors:
+ *  Juan Quintela <quintela@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_MIGRATION_MULTIFD_H
+#define QEMU_MIGRATION_MULTIFD_H
+
+int multifd_save_setup(Error **errp);
+void multifd_save_cleanup(void);
+int multifd_load_setup(Error **errp);
+int multifd_load_cleanup(Error **errp);
+bool multifd_recv_all_channels_created(void);
+bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
+void multifd_recv_sync_main(void);
+void multifd_send_sync_main(QEMUFile *f);
+int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset);
+
+#define MULTIFD_FLAG_SYNC (1 << 0)
+
+/* This value needs to be a multiple of qemu_target_page_size() */
+#define MULTIFD_PACKET_SIZE (512 * 1024)
+
+typedef struct {
+    uint32_t magic;
+    uint32_t version;
+    uint32_t flags;
+    /* maximum number of allocated pages */
+    uint32_t pages_alloc;
+    uint32_t pages_used;
+    /* size of the next packet that contains pages */
+    uint32_t next_packet_size;
+    uint64_t packet_num;
+    uint64_t unused[4];    /* Reserved for future use */
+    char ramblock[256];
+    uint64_t offset[];
+} __attribute__((packed)) MultiFDPacket_t;
+
+typedef struct {
+    /* number of used pages */
+    uint32_t used;
+    /* number of allocated pages */
+    uint32_t allocated;
+    /* global number of generated multifd packets */
+    uint64_t packet_num;
+    /* offset of each page */
+    ram_addr_t *offset;
+    /* pointer to each page */
+    struct iovec *iov;
+    RAMBlock *block;
+} MultiFDPages_t;
+
+typedef struct {
+    /* this fields are not changed once the thread is created */
+    /* channel number */
+    uint8_t id;
+    /* channel thread name */
+    char *name;
+    /* channel thread id */
+    QemuThread thread;
+    /* communication channel */
+    QIOChannel *c;
+    /* sem where to wait for more work */
+    QemuSemaphore sem;
+    /* this mutex protects the following parameters */
+    QemuMutex mutex;
+    /* is this channel thread running */
+    bool running;
+    /* should this thread finish */
+    bool quit;
+    /* thread has work to do */
+    int pending_job;
+    /* array of pages to sent */
+    MultiFDPages_t *pages;
+    /* packet allocated len */
+    uint32_t packet_len;
+    /* pointer to the packet */
+    MultiFDPacket_t *packet;
+    /* multifd flags for each packet */
+    uint32_t flags;
+    /* size of the next packet that contains pages */
+    uint32_t next_packet_size;
+    /* global number of generated multifd packets */
+    uint64_t packet_num;
+    /* thread local variables */
+    /* packets sent through this channel */
+    uint64_t num_packets;
+    /* pages sent through this channel */
+    uint64_t num_pages;
+    /* syncs main thread and channels */
+    QemuSemaphore sem_sync;
+}  MultiFDSendParams;
+
+typedef struct {
+    /* this fields are not changed once the thread is created */
+    /* channel number */
+    uint8_t id;
+    /* channel thread name */
+    char *name;
+    /* channel thread id */
+    QemuThread thread;
+    /* communication channel */
+    QIOChannel *c;
+    /* this mutex protects the following parameters */
+    QemuMutex mutex;
+    /* is this channel thread running */
+    bool running;
+    /* should this thread finish */
+    bool quit;
+    /* array of pages to receive */
+    MultiFDPages_t *pages;
+    /* packet allocated len */
+    uint32_t packet_len;
+    /* pointer to the packet */
+    MultiFDPacket_t *packet;
+    /* multifd flags for each packet */
+    uint32_t flags;
+    /* global number of generated multifd packets */
+    uint64_t packet_num;
+    /* thread local variables */
+    /* size of the next packet that contains pages */
+    uint32_t next_packet_size;
+    /* packets sent through this channel */
+    uint64_t num_packets;
+    /* pages sent through this channel */
+    uint64_t num_pages;
+    /* syncs main thread and channels */
+    QemuSemaphore sem_sync;
+} MultiFDRecvParams;
+
+#endif
+
diff --git a/migration/ram.c b/migration/ram.c
index c24b4cc771..ed23ed1c7c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -36,7 +36,6 @@
 #include "xbzrle.h"
 #include "ram.h"
 #include "migration.h"
-#include "socket.h"
 #include "migration/register.h"
 #include "migration/misc.h"
 #include "qemu-file.h"
@@ -53,9 +52,9 @@
 #include "migration/colo.h"
 #include "block.h"
 #include "sysemu/sysemu.h"
-#include "qemu/uuid.h"
 #include "savevm.h"
 #include "qemu/iov.h"
+#include "multifd.h"
=20
 /***********************************************************/
 /* ram save/restore */
@@ -575,983 +574,6 @@ exit:
     return -1;
 }
=20
-/* Multiple fd's */
-
-#define MULTIFD_MAGIC 0x11223344U
-#define MULTIFD_VERSION 1
-
-#define MULTIFD_FLAG_SYNC (1 << 0)
-
-/* This value needs to be a multiple of qemu_target_page_size() */
-#define MULTIFD_PACKET_SIZE (512 * 1024)
-
-typedef struct {
-    uint32_t magic;
-    uint32_t version;
-    unsigned char uuid[16]; /* QemuUUID */
-    uint8_t id;
-    uint8_t unused1[7];     /* Reserved for future use */
-    uint64_t unused2[4];    /* Reserved for future use */
-} __attribute__((packed)) MultiFDInit_t;
-
-typedef struct {
-    uint32_t magic;
-    uint32_t version;
-    uint32_t flags;
-    /* maximum number of allocated pages */
-    uint32_t pages_alloc;
-    uint32_t pages_used;
-    /* size of the next packet that contains pages */
-    uint32_t next_packet_size;
-    uint64_t packet_num;
-    uint64_t unused[4];    /* Reserved for future use */
-    char ramblock[256];
-    uint64_t offset[];
-} __attribute__((packed)) MultiFDPacket_t;
-
-typedef struct {
-    /* number of used pages */
-    uint32_t used;
-    /* number of allocated pages */
-    uint32_t allocated;
-    /* global number of generated multifd packets */
-    uint64_t packet_num;
-    /* offset of each page */
-    ram_addr_t *offset;
-    /* pointer to each page */
-    struct iovec *iov;
-    RAMBlock *block;
-} MultiFDPages_t;
-
-typedef struct {
-    /* this fields are not changed once the thread is created */
-    /* channel number */
-    uint8_t id;
-    /* channel thread name */
-    char *name;
-    /* channel thread id */
-    QemuThread thread;
-    /* communication channel */
-    QIOChannel *c;
-    /* sem where to wait for more work */
-    QemuSemaphore sem;
-    /* this mutex protects the following parameters */
-    QemuMutex mutex;
-    /* is this channel thread running */
-    bool running;
-    /* should this thread finish */
-    bool quit;
-    /* thread has work to do */
-    int pending_job;
-    /* array of pages to sent */
-    MultiFDPages_t *pages;
-    /* packet allocated len */
-    uint32_t packet_len;
-    /* pointer to the packet */
-    MultiFDPacket_t *packet;
-    /* multifd flags for each packet */
-    uint32_t flags;
-    /* size of the next packet that contains pages */
-    uint32_t next_packet_size;
-    /* global number of generated multifd packets */
-    uint64_t packet_num;
-    /* thread local variables */
-    /* packets sent through this channel */
-    uint64_t num_packets;
-    /* pages sent through this channel */
-    uint64_t num_pages;
-    /* syncs main thread and channels */
-    QemuSemaphore sem_sync;
-}  MultiFDSendParams;
-
-typedef struct {
-    /* this fields are not changed once the thread is created */
-    /* channel number */
-    uint8_t id;
-    /* channel thread name */
-    char *name;
-    /* channel thread id */
-    QemuThread thread;
-    /* communication channel */
-    QIOChannel *c;
-    /* this mutex protects the following parameters */
-    QemuMutex mutex;
-    /* is this channel thread running */
-    bool running;
-    /* should this thread finish */
-    bool quit;
-    /* array of pages to receive */
-    MultiFDPages_t *pages;
-    /* packet allocated len */
-    uint32_t packet_len;
-    /* pointer to the packet */
-    MultiFDPacket_t *packet;
-    /* multifd flags for each packet */
-    uint32_t flags;
-    /* global number of generated multifd packets */
-    uint64_t packet_num;
-    /* thread local variables */
-    /* size of the next packet that contains pages */
-    uint32_t next_packet_size;
-    /* packets sent through this channel */
-    uint64_t num_packets;
-    /* pages sent through this channel */
-    uint64_t num_pages;
-    /* syncs main thread and channels */
-    QemuSemaphore sem_sync;
-} MultiFDRecvParams;
-
-static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
-{
-    MultiFDInit_t msg =3D {};
-    int ret;
-
-    msg.magic =3D cpu_to_be32(MULTIFD_MAGIC);
-    msg.version =3D cpu_to_be32(MULTIFD_VERSION);
-    msg.id =3D p->id;
-    memcpy(msg.uuid, &qemu_uuid.data, sizeof(msg.uuid));
-
-    ret =3D qio_channel_write_all(p->c, (char *)&msg, sizeof(msg), errp);
-    if (ret !=3D 0) {
-        return -1;
-    }
-    return 0;
-}
-
-static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
-{
-    MultiFDInit_t msg;
-    int ret;
-
-    ret =3D qio_channel_read_all(c, (char *)&msg, sizeof(msg), errp);
-    if (ret !=3D 0) {
-        return -1;
-    }
-
-    msg.magic =3D be32_to_cpu(msg.magic);
-    msg.version =3D be32_to_cpu(msg.version);
-
-    if (msg.magic !=3D MULTIFD_MAGIC) {
-        error_setg(errp, "multifd: received packet magic %x "
-                   "expected %x", msg.magic, MULTIFD_MAGIC);
-        return -1;
-    }
-
-    if (msg.version !=3D MULTIFD_VERSION) {
-        error_setg(errp, "multifd: received packet version %d "
-                   "expected %d", msg.version, MULTIFD_VERSION);
-        return -1;
-    }
-
-    if (memcmp(msg.uuid, &qemu_uuid, sizeof(qemu_uuid))) {
-        char *uuid =3D qemu_uuid_unparse_strdup(&qemu_uuid);
-        char *msg_uuid =3D qemu_uuid_unparse_strdup((const QemuUUID *)msg.=
uuid);
-
-        error_setg(errp, "multifd: received uuid '%s' and expected "
-                   "uuid '%s' for channel %hhd", msg_uuid, uuid, msg.id);
-        g_free(uuid);
-        g_free(msg_uuid);
-        return -1;
-    }
-
-    if (msg.id > migrate_multifd_channels()) {
-        error_setg(errp, "multifd: received channel version %d "
-                   "expected %d", msg.version, MULTIFD_VERSION);
-        return -1;
-    }
-
-    return msg.id;
-}
-
-static MultiFDPages_t *multifd_pages_init(size_t size)
-{
-    MultiFDPages_t *pages =3D g_new0(MultiFDPages_t, 1);
-
-    pages->allocated =3D size;
-    pages->iov =3D g_new0(struct iovec, size);
-    pages->offset =3D g_new0(ram_addr_t, size);
-
-    return pages;
-}
-
-static void multifd_pages_clear(MultiFDPages_t *pages)
-{
-    pages->used =3D 0;
-    pages->allocated =3D 0;
-    pages->packet_num =3D 0;
-    pages->block =3D NULL;
-    g_free(pages->iov);
-    pages->iov =3D NULL;
-    g_free(pages->offset);
-    pages->offset =3D NULL;
-    g_free(pages);
-}
-
-static void multifd_send_fill_packet(MultiFDSendParams *p)
-{
-    MultiFDPacket_t *packet =3D p->packet;
-    int i;
-
-    packet->flags =3D cpu_to_be32(p->flags);
-    packet->pages_alloc =3D cpu_to_be32(p->pages->allocated);
-    packet->pages_used =3D cpu_to_be32(p->pages->used);
-    packet->next_packet_size =3D cpu_to_be32(p->next_packet_size);
-    packet->packet_num =3D cpu_to_be64(p->packet_num);
-
-    if (p->pages->block) {
-        strncpy(packet->ramblock, p->pages->block->idstr, 256);
-    }
-
-    for (i =3D 0; i < p->pages->used; i++) {
-        /* there are architectures where ram_addr_t is 32 bit */
-        uint64_t temp =3D p->pages->offset[i];
-
-        packet->offset[i] =3D cpu_to_be64(temp);
-    }
-}
-
-static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
-{
-    MultiFDPacket_t *packet =3D p->packet;
-    uint32_t pages_max =3D MULTIFD_PACKET_SIZE / qemu_target_page_size();
-    RAMBlock *block;
-    int i;
-
-    packet->magic =3D be32_to_cpu(packet->magic);
-    if (packet->magic !=3D MULTIFD_MAGIC) {
-        error_setg(errp, "multifd: received packet "
-                   "magic %x and expected magic %x",
-                   packet->magic, MULTIFD_MAGIC);
-        return -1;
-    }
-
-    packet->version =3D be32_to_cpu(packet->version);
-    if (packet->version !=3D MULTIFD_VERSION) {
-        error_setg(errp, "multifd: received packet "
-                   "version %d and expected version %d",
-                   packet->version, MULTIFD_VERSION);
-        return -1;
-    }
-
-    p->flags =3D be32_to_cpu(packet->flags);
-
-    packet->pages_alloc =3D be32_to_cpu(packet->pages_alloc);
-    /*
-     * If we received a packet that is 100 times bigger than expected
-     * just stop migration.  It is a magic number.
-     */
-    if (packet->pages_alloc > pages_max * 100) {
-        error_setg(errp, "multifd: received packet "
-                   "with size %d and expected a maximum size of %d",
-                   packet->pages_alloc, pages_max * 100) ;
-        return -1;
-    }
-    /*
-     * We received a packet that is bigger than expected but inside
-     * reasonable limits (see previous comment).  Just reallocate.
-     */
-    if (packet->pages_alloc > p->pages->allocated) {
-        multifd_pages_clear(p->pages);
-        p->pages =3D multifd_pages_init(packet->pages_alloc);
-    }
-
-    p->pages->used =3D be32_to_cpu(packet->pages_used);
-    if (p->pages->used > packet->pages_alloc) {
-        error_setg(errp, "multifd: received packet "
-                   "with %d pages and expected maximum pages are %d",
-                   p->pages->used, packet->pages_alloc) ;
-        return -1;
-    }
-
-    p->next_packet_size =3D be32_to_cpu(packet->next_packet_size);
-    p->packet_num =3D be64_to_cpu(packet->packet_num);
-
-    if (p->pages->used =3D=3D 0) {
-        return 0;
-    }
-
-    /* make sure that ramblock is 0 terminated */
-    packet->ramblock[255] =3D 0;
-    block =3D qemu_ram_block_by_name(packet->ramblock);
-    if (!block) {
-        error_setg(errp, "multifd: unknown ram block %s",
-                   packet->ramblock);
-        return -1;
-    }
-
-    for (i =3D 0; i < p->pages->used; i++) {
-        uint64_t offset =3D be64_to_cpu(packet->offset[i]);
-
-        if (offset > (block->used_length - qemu_target_page_size())) {
-            error_setg(errp, "multifd: offset too long %" PRIu64
-                       " (max " RAM_ADDR_FMT ")",
-                       offset, block->max_length);
-            return -1;
-        }
-        p->pages->iov[i].iov_base =3D block->host + offset;
-        p->pages->iov[i].iov_len =3D qemu_target_page_size();
-    }
-
-    return 0;
-}
-
-struct {
-    MultiFDSendParams *params;
-    /* array of pages to sent */
-    MultiFDPages_t *pages;
-    /* global number of generated multifd packets */
-    uint64_t packet_num;
-    /* send channels ready */
-    QemuSemaphore channels_ready;
-    /*
-     * Have we already run terminate threads.  There is a race when it
-     * happens that we got one error while we are exiting.
-     * We will use atomic operations.  Only valid values are 0 and 1.
-     */
-    int exiting;
-} *multifd_send_state;
-
-/*
- * How we use multifd_send_state->pages and channel->pages?
- *
- * We create a pages for each channel, and a main one.  Each time that
- * we need to send a batch of pages we interchange the ones between
- * multifd_send_state and the channel that is sending it.  There are
- * two reasons for that:
- *    - to not have to do so many mallocs during migration
- *    - to make easier to know what to free at the end of migration
- *
- * This way we always know who is the owner of each "pages" struct,
- * and we don't need any locking.  It belongs to the migration thread
- * or to the channel thread.  Switching is safe because the migration
- * thread is using the channel mutex when changing it, and the channel
- * have to had finish with its own, otherwise pending_job can't be
- * false.
- */
-
-static int multifd_send_pages(QEMUFile *f)
-{
-    int i;
-    static int next_channel;
-    MultiFDSendParams *p =3D NULL; /* make happy gcc */
-    MultiFDPages_t *pages =3D multifd_send_state->pages;
-    uint64_t transferred;
-
-    if (atomic_read(&multifd_send_state->exiting)) {
-        return -1;
-    }
-
-    qemu_sem_wait(&multifd_send_state->channels_ready);
-    for (i =3D next_channel;; i =3D (i + 1) % migrate_multifd_channels()) =
{
-        p =3D &multifd_send_state->params[i];
-
-        qemu_mutex_lock(&p->mutex);
-        if (p->quit) {
-            error_report("%s: channel %d has already quit!", __func__, i);
-            qemu_mutex_unlock(&p->mutex);
-            return -1;
-        }
-        if (!p->pending_job) {
-            p->pending_job++;
-            next_channel =3D (i + 1) % migrate_multifd_channels();
-            break;
-        }
-        qemu_mutex_unlock(&p->mutex);
-    }
-    assert(!p->pages->used);
-    assert(!p->pages->block);
-
-    p->packet_num =3D multifd_send_state->packet_num++;
-    multifd_send_state->pages =3D p->pages;
-    p->pages =3D pages;
-    transferred =3D ((uint64_t) pages->used) * qemu_target_page_size()
-                + p->packet_len;
-    qemu_file_update_transfer(f, transferred);
-    ram_counters.multifd_bytes +=3D transferred;
-    ram_counters.transferred +=3D transferred;;
-    qemu_mutex_unlock(&p->mutex);
-    qemu_sem_post(&p->sem);
-
-    return 1;
-}
-
-static int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t off=
set)
-{
-    MultiFDPages_t *pages =3D multifd_send_state->pages;
-
-    if (!pages->block) {
-        pages->block =3D block;
-    }
-
-    if (pages->block =3D=3D block) {
-        pages->offset[pages->used] =3D offset;
-        pages->iov[pages->used].iov_base =3D block->host + offset;
-        pages->iov[pages->used].iov_len =3D qemu_target_page_size();
-        pages->used++;
-
-        if (pages->used < pages->allocated) {
-            return 1;
-        }
-    }
-
-    if (multifd_send_pages(f) < 0) {
-        return -1;
-    }
-
-    if (pages->block !=3D block) {
-        return  multifd_queue_page(f, block, offset);
-    }
-
-    return 1;
-}
-
-static void multifd_send_terminate_threads(Error *err)
-{
-    int i;
-
-    trace_multifd_send_terminate_threads(err !=3D NULL);
-
-    if (err) {
-        MigrationState *s =3D migrate_get_current();
-        migrate_set_error(s, err);
-        if (s->state =3D=3D MIGRATION_STATUS_SETUP ||
-            s->state =3D=3D MIGRATION_STATUS_PRE_SWITCHOVER ||
-            s->state =3D=3D MIGRATION_STATUS_DEVICE ||
-            s->state =3D=3D MIGRATION_STATUS_ACTIVE) {
-            migrate_set_state(&s->state, s->state,
-                              MIGRATION_STATUS_FAILED);
-        }
-    }
-
-    /*
-     * We don't want to exit each threads twice.  Depending on where
-     * we get the error, or if there are two independent errors in two
-     * threads at the same time, we can end calling this function
-     * twice.
-     */
-    if (atomic_xchg(&multifd_send_state->exiting, 1)) {
-        return;
-    }
-
-    for (i =3D 0; i < migrate_multifd_channels(); i++) {
-        MultiFDSendParams *p =3D &multifd_send_state->params[i];
-
-        qemu_mutex_lock(&p->mutex);
-        p->quit =3D true;
-        qemu_sem_post(&p->sem);
-        qemu_mutex_unlock(&p->mutex);
-    }
-}
-
-void multifd_save_cleanup(void)
-{
-    int i;
-
-    if (!migrate_use_multifd()) {
-        return;
-    }
-    multifd_send_terminate_threads(NULL);
-    for (i =3D 0; i < migrate_multifd_channels(); i++) {
-        MultiFDSendParams *p =3D &multifd_send_state->params[i];
-
-        if (p->running) {
-            qemu_thread_join(&p->thread);
-        }
-    }
-    for (i =3D 0; i < migrate_multifd_channels(); i++) {
-        MultiFDSendParams *p =3D &multifd_send_state->params[i];
-
-        socket_send_channel_destroy(p->c);
-        p->c =3D NULL;
-        qemu_mutex_destroy(&p->mutex);
-        qemu_sem_destroy(&p->sem);
-        qemu_sem_destroy(&p->sem_sync);
-        g_free(p->name);
-        p->name =3D NULL;
-        multifd_pages_clear(p->pages);
-        p->pages =3D NULL;
-        p->packet_len =3D 0;
-        g_free(p->packet);
-        p->packet =3D NULL;
-    }
-    qemu_sem_destroy(&multifd_send_state->channels_ready);
-    g_free(multifd_send_state->params);
-    multifd_send_state->params =3D NULL;
-    multifd_pages_clear(multifd_send_state->pages);
-    multifd_send_state->pages =3D NULL;
-    g_free(multifd_send_state);
-    multifd_send_state =3D NULL;
-}
-
-static void multifd_send_sync_main(QEMUFile *f)
-{
-    int i;
-
-    if (!migrate_use_multifd()) {
-        return;
-    }
-    if (multifd_send_state->pages->used) {
-        if (multifd_send_pages(f) < 0) {
-            error_report("%s: multifd_send_pages fail", __func__);
-            return;
-        }
-    }
-    for (i =3D 0; i < migrate_multifd_channels(); i++) {
-        MultiFDSendParams *p =3D &multifd_send_state->params[i];
-
-        trace_multifd_send_sync_main_signal(p->id);
-
-        qemu_mutex_lock(&p->mutex);
-
-        if (p->quit) {
-            error_report("%s: channel %d has already quit", __func__, i);
-            qemu_mutex_unlock(&p->mutex);
-            return;
-        }
-
-        p->packet_num =3D multifd_send_state->packet_num++;
-        p->flags |=3D MULTIFD_FLAG_SYNC;
-        p->pending_job++;
-        qemu_file_update_transfer(f, p->packet_len);
-        ram_counters.multifd_bytes +=3D p->packet_len;
-        ram_counters.transferred +=3D p->packet_len;
-        qemu_mutex_unlock(&p->mutex);
-        qemu_sem_post(&p->sem);
-    }
-    for (i =3D 0; i < migrate_multifd_channels(); i++) {
-        MultiFDSendParams *p =3D &multifd_send_state->params[i];
-
-        trace_multifd_send_sync_main_wait(p->id);
-        qemu_sem_wait(&p->sem_sync);
-    }
-    trace_multifd_send_sync_main(multifd_send_state->packet_num);
-}
-
-static void *multifd_send_thread(void *opaque)
-{
-    MultiFDSendParams *p =3D opaque;
-    Error *local_err =3D NULL;
-    int ret =3D 0;
-    uint32_t flags =3D 0;
-
-    trace_multifd_send_thread_start(p->id);
-    rcu_register_thread();
-
-    if (multifd_send_initial_packet(p, &local_err) < 0) {
-        ret =3D -1;
-        goto out;
-    }
-    /* initial packet */
-    p->num_packets =3D 1;
-
-    while (true) {
-        qemu_sem_wait(&p->sem);
-
-        if (atomic_read(&multifd_send_state->exiting)) {
-            break;
-        }
-        qemu_mutex_lock(&p->mutex);
-
-        if (p->pending_job) {
-            uint32_t used =3D p->pages->used;
-            uint64_t packet_num =3D p->packet_num;
-            flags =3D p->flags;
-
-            p->next_packet_size =3D used * qemu_target_page_size();
-            multifd_send_fill_packet(p);
-            p->flags =3D 0;
-            p->num_packets++;
-            p->num_pages +=3D used;
-            p->pages->used =3D 0;
-            p->pages->block =3D NULL;
-            qemu_mutex_unlock(&p->mutex);
-
-            trace_multifd_send(p->id, packet_num, used, flags,
-                               p->next_packet_size);
-
-            ret =3D qio_channel_write_all(p->c, (void *)p->packet,
-                                        p->packet_len, &local_err);
-            if (ret !=3D 0) {
-                break;
-            }
-
-            if (used) {
-                ret =3D qio_channel_writev_all(p->c, p->pages->iov,
-                                             used, &local_err);
-                if (ret !=3D 0) {
-                    break;
-                }
-            }
-
-            qemu_mutex_lock(&p->mutex);
-            p->pending_job--;
-            qemu_mutex_unlock(&p->mutex);
-
-            if (flags & MULTIFD_FLAG_SYNC) {
-                qemu_sem_post(&p->sem_sync);
-            }
-            qemu_sem_post(&multifd_send_state->channels_ready);
-        } else if (p->quit) {
-            qemu_mutex_unlock(&p->mutex);
-            break;
-        } else {
-            qemu_mutex_unlock(&p->mutex);
-            /* sometimes there are spurious wakeups */
-        }
-    }
-
-out:
-    if (local_err) {
-        trace_multifd_send_error(p->id);
-        multifd_send_terminate_threads(local_err);
-    }
-
-    /*
-     * Error happen, I will exit, but I can't just leave, tell
-     * who pay attention to me.
-     */
-    if (ret !=3D 0) {
-        qemu_sem_post(&p->sem_sync);
-        qemu_sem_post(&multifd_send_state->channels_ready);
-    }
-
-    qemu_mutex_lock(&p->mutex);
-    p->running =3D false;
-    qemu_mutex_unlock(&p->mutex);
-
-    rcu_unregister_thread();
-    trace_multifd_send_thread_end(p->id, p->num_packets, p->num_pages);
-
-    return NULL;
-}
-
-static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
-{
-    MultiFDSendParams *p =3D opaque;
-    QIOChannel *sioc =3D QIO_CHANNEL(qio_task_get_source(task));
-    Error *local_err =3D NULL;
-
-    trace_multifd_new_send_channel_async(p->id);
-    if (qio_task_propagate_error(task, &local_err)) {
-        migrate_set_error(migrate_get_current(), local_err);
-        multifd_save_cleanup();
-    } else {
-        p->c =3D QIO_CHANNEL(sioc);
-        qio_channel_set_delay(p->c, false);
-        p->running =3D true;
-        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
-                           QEMU_THREAD_JOINABLE);
-    }
-}
-
-int multifd_save_setup(Error **errp)
-{
-    int thread_count;
-    uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size();
-    uint8_t i;
-
-    if (!migrate_use_multifd()) {
-        return 0;
-    }
-    thread_count =3D migrate_multifd_channels();
-    multifd_send_state =3D g_malloc0(sizeof(*multifd_send_state));
-    multifd_send_state->params =3D g_new0(MultiFDSendParams, thread_count)=
;
-    multifd_send_state->pages =3D multifd_pages_init(page_count);
-    qemu_sem_init(&multifd_send_state->channels_ready, 0);
-    atomic_set(&multifd_send_state->exiting, 0);
-
-    for (i =3D 0; i < thread_count; i++) {
-        MultiFDSendParams *p =3D &multifd_send_state->params[i];
-
-        qemu_mutex_init(&p->mutex);
-        qemu_sem_init(&p->sem, 0);
-        qemu_sem_init(&p->sem_sync, 0);
-        p->quit =3D false;
-        p->pending_job =3D 0;
-        p->id =3D i;
-        p->pages =3D multifd_pages_init(page_count);
-        p->packet_len =3D sizeof(MultiFDPacket_t)
-                      + sizeof(uint64_t) * page_count;
-        p->packet =3D g_malloc0(p->packet_len);
-        p->packet->magic =3D cpu_to_be32(MULTIFD_MAGIC);
-        p->packet->version =3D cpu_to_be32(MULTIFD_VERSION);
-        p->name =3D g_strdup_printf("multifdsend_%d", i);
-        socket_send_channel_create(multifd_new_send_channel_async, p);
-    }
-    return 0;
-}
-
-struct {
-    MultiFDRecvParams *params;
-    /* number of created threads */
-    int count;
-    /* syncs main thread and channels */
-    QemuSemaphore sem_sync;
-    /* global number of generated multifd packets */
-    uint64_t packet_num;
-} *multifd_recv_state;
-
-static void multifd_recv_terminate_threads(Error *err)
-{
-    int i;
-
-    trace_multifd_recv_terminate_threads(err !=3D NULL);
-
-    if (err) {
-        MigrationState *s =3D migrate_get_current();
-        migrate_set_error(s, err);
-        if (s->state =3D=3D MIGRATION_STATUS_SETUP ||
-            s->state =3D=3D MIGRATION_STATUS_ACTIVE) {
-            migrate_set_state(&s->state, s->state,
-                              MIGRATION_STATUS_FAILED);
-        }
-    }
-
-    for (i =3D 0; i < migrate_multifd_channels(); i++) {
-        MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
-
-        qemu_mutex_lock(&p->mutex);
-        p->quit =3D true;
-        /*
-         * We could arrive here for two reasons:
-         *  - normal quit, i.e. everything went fine, just finished
-         *  - error quit: We close the channels so the channel threads
-         *    finish the qio_channel_read_all_eof()
-         */
-        if (p->c) {
-            qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
-        }
-        qemu_mutex_unlock(&p->mutex);
-    }
-}
-
-int multifd_load_cleanup(Error **errp)
-{
-    int i;
-    int ret =3D 0;
-
-    if (!migrate_use_multifd()) {
-        return 0;
-    }
-    multifd_recv_terminate_threads(NULL);
-    for (i =3D 0; i < migrate_multifd_channels(); i++) {
-        MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
-
-        if (p->running) {
-            p->quit =3D true;
-            /*
-             * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle co=
de,
-             * however try to wakeup it without harm in cleanup phase.
-             */
-            qemu_sem_post(&p->sem_sync);
-            qemu_thread_join(&p->thread);
-        }
-    }
-    for (i =3D 0; i < migrate_multifd_channels(); i++) {
-        MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
-
-        object_unref(OBJECT(p->c));
-        p->c =3D NULL;
-        qemu_mutex_destroy(&p->mutex);
-        qemu_sem_destroy(&p->sem_sync);
-        g_free(p->name);
-        p->name =3D NULL;
-        multifd_pages_clear(p->pages);
-        p->pages =3D NULL;
-        p->packet_len =3D 0;
-        g_free(p->packet);
-        p->packet =3D NULL;
-    }
-    qemu_sem_destroy(&multifd_recv_state->sem_sync);
-    g_free(multifd_recv_state->params);
-    multifd_recv_state->params =3D NULL;
-    g_free(multifd_recv_state);
-    multifd_recv_state =3D NULL;
-
-    return ret;
-}
-
-static void multifd_recv_sync_main(void)
-{
-    int i;
-
-    if (!migrate_use_multifd()) {
-        return;
-    }
-    for (i =3D 0; i < migrate_multifd_channels(); i++) {
-        MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
-
-        trace_multifd_recv_sync_main_wait(p->id);
-        qemu_sem_wait(&multifd_recv_state->sem_sync);
-    }
-    for (i =3D 0; i < migrate_multifd_channels(); i++) {
-        MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
-
-        qemu_mutex_lock(&p->mutex);
-        if (multifd_recv_state->packet_num < p->packet_num) {
-            multifd_recv_state->packet_num =3D p->packet_num;
-        }
-        qemu_mutex_unlock(&p->mutex);
-        trace_multifd_recv_sync_main_signal(p->id);
-        qemu_sem_post(&p->sem_sync);
-    }
-    trace_multifd_recv_sync_main(multifd_recv_state->packet_num);
-}
-
-static void *multifd_recv_thread(void *opaque)
-{
-    MultiFDRecvParams *p =3D opaque;
-    Error *local_err =3D NULL;
-    int ret;
-
-    trace_multifd_recv_thread_start(p->id);
-    rcu_register_thread();
-
-    while (true) {
-        uint32_t used;
-        uint32_t flags;
-
-        if (p->quit) {
-            break;
-        }
-
-        ret =3D qio_channel_read_all_eof(p->c, (void *)p->packet,
-                                       p->packet_len, &local_err);
-        if (ret =3D=3D 0) {   /* EOF */
-            break;
-        }
-        if (ret =3D=3D -1) {   /* Error */
-            break;
-        }
-
-        qemu_mutex_lock(&p->mutex);
-        ret =3D multifd_recv_unfill_packet(p, &local_err);
-        if (ret) {
-            qemu_mutex_unlock(&p->mutex);
-            break;
-        }
-
-        used =3D p->pages->used;
-        flags =3D p->flags;
-        trace_multifd_recv(p->id, p->packet_num, used, flags,
-                           p->next_packet_size);
-        p->num_packets++;
-        p->num_pages +=3D used;
-        qemu_mutex_unlock(&p->mutex);
-
-        if (used) {
-            ret =3D qio_channel_readv_all(p->c, p->pages->iov,
-                                        used, &local_err);
-            if (ret !=3D 0) {
-                break;
-            }
-        }
-
-        if (flags & MULTIFD_FLAG_SYNC) {
-            qemu_sem_post(&multifd_recv_state->sem_sync);
-            qemu_sem_wait(&p->sem_sync);
-        }
-    }
-
-    if (local_err) {
-        multifd_recv_terminate_threads(local_err);
-    }
-    qemu_mutex_lock(&p->mutex);
-    p->running =3D false;
-    qemu_mutex_unlock(&p->mutex);
-
-    rcu_unregister_thread();
-    trace_multifd_recv_thread_end(p->id, p->num_packets, p->num_pages);
-
-    return NULL;
-}
-
-int multifd_load_setup(Error **errp)
-{
-    int thread_count;
-    uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size();
-    uint8_t i;
-
-    if (!migrate_use_multifd()) {
-        return 0;
-    }
-    thread_count =3D migrate_multifd_channels();
-    multifd_recv_state =3D g_malloc0(sizeof(*multifd_recv_state));
-    multifd_recv_state->params =3D g_new0(MultiFDRecvParams, thread_count)=
;
-    atomic_set(&multifd_recv_state->count, 0);
-    qemu_sem_init(&multifd_recv_state->sem_sync, 0);
-
-    for (i =3D 0; i < thread_count; i++) {
-        MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
-
-        qemu_mutex_init(&p->mutex);
-        qemu_sem_init(&p->sem_sync, 0);
-        p->quit =3D false;
-        p->id =3D i;
-        p->pages =3D multifd_pages_init(page_count);
-        p->packet_len =3D sizeof(MultiFDPacket_t)
-                      + sizeof(uint64_t) * page_count;
-        p->packet =3D g_malloc0(p->packet_len);
-        p->name =3D g_strdup_printf("multifdrecv_%d", i);
-    }
-    return 0;
-}
-
-bool multifd_recv_all_channels_created(void)
-{
-    int thread_count =3D migrate_multifd_channels();
-
-    if (!migrate_use_multifd()) {
-        return true;
-    }
-
-    return thread_count =3D=3D atomic_read(&multifd_recv_state->count);
-}
-
-/*
- * Try to receive all multifd channels to get ready for the migration.
- * - Return true and do not set @errp when correctly receving all channels=
;
- * - Return false and do not set @errp when correctly receiving the curren=
t one;
- * - Return false and set @errp when failing to receive the current channe=
l.
- */
-bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
-{
-    MultiFDRecvParams *p;
-    Error *local_err =3D NULL;
-    int id;
-
-    id =3D multifd_recv_initial_packet(ioc, &local_err);
-    if (id < 0) {
-        multifd_recv_terminate_threads(local_err);
-        error_propagate_prepend(errp, local_err,
-                                "failed to receive packet"
-                                " via multifd channel %d: ",
-                                atomic_read(&multifd_recv_state->count));
-        return false;
-    }
-    trace_multifd_recv_new_channel(id);
-
-    p =3D &multifd_recv_state->params[id];
-    if (p->c !=3D NULL) {
-        error_setg(&local_err, "multifd: received id '%d' already setup'",
-                   id);
-        multifd_recv_terminate_threads(local_err);
-        error_propagate(errp, local_err);
-        return false;
-    }
-    p->c =3D ioc;
-    object_ref(OBJECT(ioc));
-    /* initial packet */
-    p->num_packets =3D 1;
-
-    p->running =3D true;
-    qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
-                       QEMU_THREAD_JOINABLE);
-    atomic_inc(&multifd_recv_state->count);
-    return atomic_read(&multifd_recv_state->count) =3D=3D
-           migrate_multifd_channels();
-}
-
 /**
  * save_page_header: write page header to wire
  *
diff --git a/migration/ram.h b/migration/ram.h
index 42be471d52..a553d40751 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -41,13 +41,6 @@ int xbzrle_cache_resize(int64_t new_size, Error **errp);
 uint64_t ram_bytes_remaining(void);
 uint64_t ram_bytes_total(void);
=20
-int multifd_save_setup(Error **errp);
-void multifd_save_cleanup(void);
-int multifd_load_setup(Error **errp);
-int multifd_load_cleanup(Error **errp);
-bool multifd_recv_all_channels_created(void);
-bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
-
 uint64_t ram_pagesize_summary(void);
 int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t =
len);
 void acct_update_position(QEMUFile *f, size_t size, bool zero);
--=20
2.24.1


