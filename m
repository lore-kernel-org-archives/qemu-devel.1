Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FE2C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A1021582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/mQBGqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A1021582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihOlc-0002tG-5L
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 21:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ihOeo-00032X-FZ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ihOem-0005nz-H8
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21843
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ihOel-0005mc-U0
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576634503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JCF79OgkifHXkDZ6UIDSsQbkPYWximap7jUWIkoikGY=;
 b=g/mQBGqVjN7AU7GZau2PD7WqGQfod28jZf7gHUj2UXbAvohM8R1JP0XMSx7Se/xNeuG52V
 T0dcKTmUGDuHyrB5KBCS+hMSCwarxx+OzaccuXJH1hK7coe9gMTvWbrLb8Hf2DWihTcLwX
 FIevqRxEWsMrWynisxt0GXSDLA6wuGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-RadDFdAPPACTLQ1MIch5EA-1; Tue, 17 Dec 2019 21:01:41 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CD3C1809A2A
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 02:01:41 +0000 (UTC)
Received: from secure.mitica (ovpn-116-32.ams2.redhat.com [10.36.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D523819C58;
 Wed, 18 Dec 2019 02:01:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/10] migration: Make no compression operations into its
 own structure
Date: Wed, 18 Dec 2019 03:01:16 +0100
Message-Id: <20191218020119.3776-8-quintela@redhat.com>
In-Reply-To: <20191218020119.3776-1-quintela@redhat.com>
References: <20191218020119.3776-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: RadDFdAPPACTLQ1MIch5EA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It will be used later.

Signed-off-by: Juan Quintela <quintela@redhat.com>

---
Move setup of ->ops helper to proper place (wei)
Rename s/none/nocomp/ (dave)
Introduce MULTIFD_FLAG_NOCOMP
---
 migration/migration.c |   9 ++
 migration/migration.h |   1 +
 migration/ram.c       | 194 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 196 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 93c6ed10a6..56203eb536 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2213,6 +2213,15 @@ int migrate_multifd_channels(void)
     return s->parameters.multifd_channels;
 }
=20
+int migrate_multifd_method(void)
+{
+    MigrationState *s;
+
+    s =3D migrate_get_current();
+
+    return s->parameters.multifd_compress;
+}
+
 int migrate_use_xbzrle(void)
 {
     MigrationState *s;
diff --git a/migration/migration.h b/migration/migration.h
index 545f283ae7..d3ea45e25a 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -299,6 +299,7 @@ bool migrate_auto_converge(void);
 bool migrate_use_multifd(void);
 bool migrate_pause_before_switchover(void);
 int migrate_multifd_channels(void);
+int migrate_multifd_method(void);
=20
 int migrate_use_xbzrle(void);
 int64_t migrate_xbzrle_cache_size(void);
diff --git a/migration/ram.c b/migration/ram.c
index fcf50e648a..10661e03ae 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -44,6 +44,7 @@
 #include "page_cache.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qapi-types-migration.h"
 #include "qapi/qapi-events-migration.h"
 #include "qapi/qmp/qerror.h"
 #include "trace.h"
@@ -581,6 +582,7 @@ exit:
 #define MULTIFD_VERSION 1
=20
 #define MULTIFD_FLAG_SYNC (1 << 0)
+#define MULTIFD_FLAG_NOCOMP (1 << 1)
=20
 /* This value needs to be a multiple of qemu_target_page_size() */
 #define MULTIFD_PACKET_SIZE (512 * 1024)
@@ -662,6 +664,8 @@ typedef struct {
     uint64_t num_pages;
     /* syncs main thread and channels */
     QemuSemaphore sem_sync;
+    /* used for compression methods */
+    void *data;
 }  MultiFDSendParams;
=20
 typedef struct {
@@ -699,8 +703,153 @@ typedef struct {
     uint64_t num_pages;
     /* syncs main thread and channels */
     QemuSemaphore sem_sync;
+    /* used for de-compression methods */
+    void *data;
 } MultiFDRecvParams;
=20
+typedef struct {
+    /* Setup for sending side */
+    int (*send_setup)(MultiFDSendParams *p, Error **errp);
+    /* Cleanup for sending side */
+    void (*send_cleanup)(MultiFDSendParams *p, Error **errp);
+    /* Prepare the send packet */
+    int (*send_prepare)(MultiFDSendParams *p, uint32_t used, Error **errp)=
;
+    /* Write the send packet */
+    int (*send_write)(MultiFDSendParams *p, uint32_t used, Error **errp);
+    /* Setup for receiving side */
+    int (*recv_setup)(MultiFDRecvParams *p, Error **errp);
+    /* Cleanup for receiving side */
+    void (*recv_cleanup)(MultiFDRecvParams *p);
+    /* Read all pages */
+    int (*recv_pages)(MultiFDRecvParams *p, uint32_t used, Error **errp);
+} MultiFDMethods;
+
+/* Multifd without compression */
+
+/**
+ * nocomp_send_setup: setup send side
+ *
+ * For no compression this function does nothing.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
+{
+    return 0;
+}
+
+/**
+ * nocomp_send_cleanup: cleanup send side
+ *
+ * For no compression this function does nothing.
+ *
+ * @p: Params for the channel that we are using
+ */
+static void nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
+{
+    return;
+}
+
+/**
+ * nocomp_send_prepare: prepare date to be able to send
+ *
+ * For no compression we just have to calculate the size of the
+ * packet.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @used: number of pages used
+ * @errp: pointer to an error
+ */
+static int nocomp_send_prepare(MultiFDSendParams *p, uint32_t used,
+                               Error **errp)
+{
+    p->next_packet_size =3D used * qemu_target_page_size();
+    p->flags |=3D MULTIFD_FLAG_NOCOMP;
+    return 0;
+}
+
+/**
+ * nocomp_send_write: do the actual write of the data
+ *
+ * For no compression we just have to write the data.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @used: number of pages used
+ * @errp: pointer to an error
+ */
+static int nocomp_send_write(MultiFDSendParams *p, uint32_t used, Error **=
errp)
+{
+    return qio_channel_writev_all(p->c, p->pages->iov, used, errp);
+}
+
+/**
+ * nocomp_recv_setup: setup receive side
+ *
+ * For no compression this function does nothing.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int nocomp_recv_setup(MultiFDRecvParams *p, Error **errp)
+{
+    return 0;
+}
+
+/**
+ * nocomp_recv_cleanup: setup receive side
+ *
+ * For no compression this function does nothing.
+ *
+ * @p: Params for the channel that we are using
+ */
+static void nocomp_recv_cleanup(MultiFDRecvParams *p)
+{
+}
+
+/**
+ * nocomp_recv_pages: read the data from the channel into actual pages
+ *
+ * For no compression we just need to read things into the correct place.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @used: number of pages used
+ * @errp: pointer to an error
+ */
+static int nocomp_recv_pages(MultiFDRecvParams *p, uint32_t used, Error **=
errp)
+{
+    if (p->flags !=3D MULTIFD_FLAG_NOCOMP) {
+        error_setg(errp, "multifd %d: flags received %x flags expected %x"=
,
+                   p->id, MULTIFD_FLAG_NOCOMP, p->flags);
+        return -1;
+    }
+    return qio_channel_readv_all(p->c, p->pages->iov, used, errp);
+}
+
+static MultiFDMethods multifd_nocomp_ops =3D {
+    .send_setup =3D nocomp_send_setup,
+    .send_cleanup =3D nocomp_send_cleanup,
+    .send_prepare =3D nocomp_send_prepare,
+    .send_write =3D nocomp_send_write,
+    .recv_setup =3D nocomp_recv_setup,
+    .recv_cleanup =3D nocomp_recv_cleanup,
+    .recv_pages =3D nocomp_recv_pages
+};
+
+static MultiFDMethods *multifd_ops[MULTIFD_COMPRESS__MAX] =3D {
+    [MULTIFD_COMPRESS_NONE] =3D &multifd_nocomp_ops,
+};
+
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
 {
     MultiFDInit_t msg;
@@ -898,6 +1047,8 @@ struct {
     uint64_t packet_num;
     /* send channels ready */
     QemuSemaphore channels_ready;
+    /* multifd ops */
+    MultiFDMethods *ops;
 } *multifd_send_state;
=20
 /*
@@ -1027,6 +1178,7 @@ void multifd_save_cleanup(void)
     multifd_send_terminate_threads(NULL);
     for (i =3D 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p =3D &multifd_send_state->params[i];
+        Error *local_err =3D NULL;
=20
         if (p->running) {
             qemu_thread_join(&p->thread);
@@ -1043,6 +1195,10 @@ void multifd_save_cleanup(void)
         p->packet_len =3D 0;
         g_free(p->packet);
         p->packet =3D NULL;
+        multifd_send_state->ops->send_cleanup(p, &local_err);
+        if (local_err) {
+            migrate_set_error(migrate_get_current(), local_err);
+        }
     }
     qemu_sem_destroy(&multifd_send_state->channels_ready);
     g_free(multifd_send_state->params);
@@ -1123,7 +1279,14 @@ static void *multifd_send_thread(void *opaque)
             uint64_t packet_num =3D p->packet_num;
             flags =3D p->flags;
=20
-            p->next_packet_size =3D used * qemu_target_page_size();
+            if (used) {
+                ret =3D multifd_send_state->ops->send_prepare(p, used,
+                                                            &local_err);
+                if (ret !=3D 0) {
+                    qemu_mutex_unlock(&p->mutex);
+                    break;
+                }
+            }
             multifd_send_fill_packet(p);
             p->flags =3D 0;
             p->num_packets++;
@@ -1140,8 +1303,7 @@ static void *multifd_send_thread(void *opaque)
             }
=20
             if (used) {
-                ret =3D qio_channel_writev_all(p->c, p->pages->iov,
-                                             used, &local_err);
+                ret =3D multifd_send_state->ops->send_write(p, used, &loca=
l_err);
                 if (ret !=3D 0) {
                     break;
                 }
@@ -1212,6 +1374,7 @@ int multifd_save_setup(Error **errp)
 {
     int thread_count;
     uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    int ret =3D 0;
     uint8_t i;
=20
     if (!migrate_use_multifd()) {
@@ -1222,9 +1385,11 @@ int multifd_save_setup(Error **errp)
     multifd_send_state->params =3D g_new0(MultiFDSendParams, thread_count)=
;
     multifd_send_state->pages =3D multifd_pages_init(page_count);
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
+    multifd_send_state->ops =3D multifd_ops[migrate_multifd_method()];
=20
     for (i =3D 0; i < thread_count; i++) {
         MultiFDSendParams *p =3D &multifd_send_state->params[i];
+        int res;
=20
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
@@ -1240,8 +1405,12 @@ int multifd_save_setup(Error **errp)
         p->packet->version =3D cpu_to_be32(MULTIFD_VERSION);
         p->name =3D g_strdup_printf("multifdsend_%d", i);
         socket_send_channel_create(multifd_new_send_channel_async, p);
+        res =3D multifd_send_state->ops->send_setup(p, errp);
+        if (ret =3D=3D 0) {
+            ret =3D res;
+        }
     }
-    return 0;
+    return ret;
 }
=20
 struct {
@@ -1252,6 +1421,8 @@ struct {
     QemuSemaphore sem_sync;
     /* global number of generated multifd packets */
     uint64_t packet_num;
+    /* multifd ops */
+    MultiFDMethods *ops;
 } *multifd_recv_state;
=20
 static void multifd_recv_terminate_threads(Error *err)
@@ -1287,7 +1458,6 @@ static void multifd_recv_terminate_threads(Error *err=
)
 int multifd_load_cleanup(Error **errp)
 {
     int i;
-    int ret =3D 0;
=20
     if (!migrate_use_multifd()) {
         return 0;
@@ -1316,6 +1486,7 @@ int multifd_load_cleanup(Error **errp)
         p->packet_len =3D 0;
         g_free(p->packet);
         p->packet =3D NULL;
+        multifd_recv_state->ops->recv_cleanup(p);
     }
     qemu_sem_destroy(&multifd_recv_state->sem_sync);
     g_free(multifd_recv_state->params);
@@ -1323,7 +1494,7 @@ int multifd_load_cleanup(Error **errp)
     g_free(multifd_recv_state);
     multifd_recv_state =3D NULL;
=20
-    return ret;
+    return 0;
 }
=20
 static void multifd_recv_sync_main(void)
@@ -1388,6 +1559,8 @@ static void *multifd_recv_thread(void *opaque)
=20
         used =3D p->pages->used;
         flags =3D p->flags;
+        /* recv methods don't know how to handle the SYNC flag */
+        p->flags &=3D ~MULTIFD_FLAG_SYNC;
         trace_multifd_recv(p->id, p->packet_num, used, flags,
                            p->next_packet_size);
         p->num_packets++;
@@ -1395,8 +1568,7 @@ static void *multifd_recv_thread(void *opaque)
         qemu_mutex_unlock(&p->mutex);
=20
         if (used) {
-            ret =3D qio_channel_readv_all(p->c, p->pages->iov,
-                                        used, &local_err);
+            ret =3D multifd_recv_state->ops->recv_pages(p, used, &local_er=
r);
             if (ret !=3D 0) {
                 break;
             }
@@ -1435,9 +1607,11 @@ int multifd_load_setup(Error **errp)
     multifd_recv_state->params =3D g_new0(MultiFDRecvParams, thread_count)=
;
     atomic_set(&multifd_recv_state->count, 0);
     qemu_sem_init(&multifd_recv_state->sem_sync, 0);
+    multifd_recv_state->ops =3D multifd_ops[migrate_multifd_method()];
=20
     for (i =3D 0; i < thread_count; i++) {
         MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
+        int ret;
=20
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem_sync, 0);
@@ -1448,6 +1622,10 @@ int multifd_load_setup(Error **errp)
                       + sizeof(ram_addr_t) * page_count;
         p->packet =3D g_malloc0(p->packet_len);
         p->name =3D g_strdup_printf("multifdrecv_%d", i);
+        ret =3D multifd_recv_state->ops->recv_setup(p, errp);
+        if (ret !=3D 0) {
+            return ret;
+        }
     }
     return 0;
 }
--=20
2.23.0


