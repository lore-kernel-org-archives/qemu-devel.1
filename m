Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C7FECE58D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 609A52070B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609A52070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHS9v-0002zD-Gy
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 08:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iHRrw-0003Sp-Gg
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iHRrt-0005O8-WB
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:12:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57484)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iHRrq-0005MZ-1J; Mon, 07 Oct 2019 08:11:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3D7EA4E926;
 Mon,  7 Oct 2019 12:11:57 +0000 (UTC)
Received: from localhost (unknown [10.36.118.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1E9410013A1;
 Mon,  7 Oct 2019 12:11:55 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/16] block/io_uring: adds fd registration
Date: Mon,  7 Oct 2019 13:09:37 +0100
Message-Id: <20191007120937.5862-17-stefanha@redhat.com>
In-Reply-To: <20191007120937.5862-1-stefanha@redhat.com>
References: <20191007120937.5862-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 07 Oct 2019 12:11:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: oleksandr@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@mail.ru>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

File descriptor registration eliminates the need to get file descriptors
for each request on the host kernel side.  The host kernel keeps
references to a set of files that were registered by the application.
These files can be quickly accessed by index instead of a traditional
file descriptor number.

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v10:
 * Add io_uring_register_files() return value to trace_luring_fd_register=
()
 * Fix indentation in luring_fd_unregister()
 * Set s->fd_reg.fd_array to NULL after g_free() to avoid dangling pointe=
rs
 * Simplify fd registration code
 * Add luring_fd_unregister() and call it from file-posix.c to prevent
   fd leaks
 * Add trace_luring_fd_unregister() trace event
---
 include/block/raw-aio.h |   1 +
 block/file-posix.c      |  18 +++++
 block/io_uring.c        | 150 +++++++++++++++++++++++++++++++++++++++-
 block/trace-events      |   2 +
 4 files changed, 170 insertions(+), 1 deletion(-)

diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index 251b10d273..5fe6481bc4 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -68,6 +68,7 @@ void luring_detach_aio_context(LuringState *s, AioConte=
xt *old_context);
 void luring_attach_aio_context(LuringState *s, AioContext *new_context);
 void luring_io_plug(BlockDriverState *bs, LuringState *s);
 void luring_io_unplug(BlockDriverState *bs, LuringState *s);
+void luring_fd_unregister(LuringState *s, int fd);
 #endif
=20
 #ifdef _WIN32
diff --git a/block/file-posix.c b/block/file-posix.c
index 264c44fc3f..604b5427c3 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2010,6 +2010,20 @@ static int raw_co_flush_to_disk(BlockDriverState *=
bs)
     return raw_thread_pool_submit(bs, handle_aiocb_flush, &acb);
 }
=20
+static void raw_aio_detach_aio_context(BlockDriverState *bs)
+{
+#ifdef CONFIG_LINUX_IO_URING
+    BDRVRawState *s =3D bs->opaque;
+
+    if (s->fd >=3D 0 && s->use_linux_io_uring) {
+        LuringState *luring;
+
+        luring =3D aio_get_linux_io_uring(bdrv_get_aio_context(bs));
+        luring_fd_unregister(luring, s->fd);
+    }
+#endif
+}
+
 static void raw_aio_attach_aio_context(BlockDriverState *bs,
                                        AioContext *new_context)
 {
@@ -2994,6 +3008,7 @@ BlockDriver bdrv_file =3D {
     .bdrv_refresh_limits =3D raw_refresh_limits,
     .bdrv_io_plug =3D raw_aio_plug,
     .bdrv_io_unplug =3D raw_aio_unplug,
+    .bdrv_detach_aio_context =3D raw_aio_detach_aio_context,
     .bdrv_attach_aio_context =3D raw_aio_attach_aio_context,
=20
     .bdrv_co_truncate =3D raw_co_truncate,
@@ -3470,6 +3485,7 @@ static BlockDriver bdrv_host_device =3D {
     .bdrv_refresh_limits =3D raw_refresh_limits,
     .bdrv_io_plug =3D raw_aio_plug,
     .bdrv_io_unplug =3D raw_aio_unplug,
+    .bdrv_detach_aio_context =3D raw_aio_detach_aio_context,
     .bdrv_attach_aio_context =3D raw_aio_attach_aio_context,
=20
     .bdrv_co_truncate       =3D raw_co_truncate,
@@ -3594,6 +3610,7 @@ static BlockDriver bdrv_host_cdrom =3D {
     .bdrv_refresh_limits =3D raw_refresh_limits,
     .bdrv_io_plug =3D raw_aio_plug,
     .bdrv_io_unplug =3D raw_aio_unplug,
+    .bdrv_detach_aio_context =3D raw_aio_detach_aio_context,
     .bdrv_attach_aio_context =3D raw_aio_attach_aio_context,
=20
     .bdrv_co_truncate    =3D raw_co_truncate,
@@ -3726,6 +3743,7 @@ static BlockDriver bdrv_host_cdrom =3D {
     .bdrv_refresh_limits =3D raw_refresh_limits,
     .bdrv_io_plug =3D raw_aio_plug,
     .bdrv_io_unplug =3D raw_aio_unplug,
+    .bdrv_detach_aio_context =3D raw_aio_detach_aio_context,
     .bdrv_attach_aio_context =3D raw_aio_attach_aio_context,
=20
     .bdrv_co_truncate    =3D raw_co_truncate,
diff --git a/block/io_uring.c b/block/io_uring.c
index 56892fd1ab..4d6e50ce19 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -46,10 +46,16 @@ typedef struct LuringQueue {
     QSIMPLEQ_HEAD(, LuringAIOCB) submit_queue;
 } LuringQueue;
=20
+typedef struct LuringFd {
+    int *fd_array;
+    GHashTable *fd_lookup;
+} LuringFd;
+
 typedef struct LuringState {
     AioContext *aio_context;
=20
     struct io_uring ring;
+    LuringFd fd_reg;
=20
     /* io queue for submit at batch.  Protected by AioContext lock. */
     LuringQueue io_q;
@@ -298,6 +304,136 @@ static void ioq_init(LuringQueue *io_q)
     io_q->blocked =3D false;
 }
=20
+/**
+ * luring_fd_unregister:
+ *
+ * Remove a file descriptor from the registered fds list.  This is a slo=
w
+ * operation because all registered fds are refreshed, but this function=
 should
+ * not be called often anyway.
+ *
+ * Only call this function while there are no requests in flight.
+ */
+void luring_fd_unregister(LuringState *s, int fd)
+{
+    LuringFd *fd_reg =3D &s->fd_reg;
+    void *value;
+    int idx;
+    int ret;
+    int nr;
+    int i;
+
+    if (!g_hash_table_lookup_extended(fd_reg->fd_lookup, GINT_TO_POINTER=
(fd),
+                                      NULL, &value)) {
+        return;
+    }
+
+    ret =3D io_uring_unregister_files(&s->ring);
+    if (ret < 0) {
+        return;
+    }
+
+    idx =3D GPOINTER_TO_INT(value);
+    nr =3D g_hash_table_size(fd_reg->fd_lookup) - 1; /* minus this fd */
+
+    trace_luring_fd_unregister(s, fd, idx);
+
+    memmove(&fd_reg->fd_array[idx], &fd_reg->fd_array[idx + 1], nr - idx=
);
+
+    /* Rebuild hash table */
+    g_hash_table_remove_all(fd_reg->fd_lookup);
+    for (i =3D 0; i < nr; i++) {
+        g_hash_table_insert(fd_reg->fd_lookup,
+                            GINT_TO_POINTER(fd_reg->fd_array[i]),
+                            GINT_TO_POINTER(i));
+    }
+
+    io_uring_register_files(&s->ring, fd_reg->fd_array, nr);
+}
+
+/**
+ * luring_fd_register:
+ *
+ * Register file descriptors, see luring_fd_lookup
+ */
+static int luring_fd_register(struct io_uring *ring, LuringFd *fd_reg, i=
nt fd)
+{
+    int ret, nr;
+    GHashTable *lookup =3D fd_reg->fd_lookup;
+    nr =3D g_hash_table_size(lookup);
+
+    /* If adding new, API requires older registrations to be removed */
+    if (nr) {
+        /*
+         * See linux b19062a56726, register needs the ring mutex, any
+         * submission in progress will complete before unregistering beg=
ins
+         * and new ones will have to wait.
+         */
+        ret =3D io_uring_unregister_files(ring);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    fd_reg->fd_array =3D g_realloc_n(fd_reg->fd_array, nr + 1, sizeof(in=
t));
+    fd_reg->fd_array[nr] =3D fd;
+
+    g_hash_table_insert(lookup, GINT_TO_POINTER(fd), GINT_TO_POINTER(nr)=
);
+    ret =3D io_uring_register_files(ring, fd_reg->fd_array, nr + 1);
+    trace_luring_fd_register(fd, nr, ret);
+    if (ret < 0) {
+        /* Leave fd_array[] alone, fd will be overwritten next time anyw=
ay */
+        g_hash_table_remove(lookup, GINT_TO_POINTER(fd));
+        return ret;
+    }
+    return nr;
+}
+
+/**
+ * luring_fd_init:
+ *
+ * Initialize file descriptors
+ */
+static void luring_fd_init(LuringState *s)
+{
+    s->fd_reg.fd_lookup =3D g_hash_table_new(g_direct_hash, g_direct_equ=
al);
+}
+
+/**
+ * luring_fd_cleanup:
+ *
+ * Unregisters file descriptors, TODO: error handling
+ */
+static void luring_fd_cleanup(LuringState *s)
+{
+    io_uring_unregister_files(&s->ring);
+    g_hash_table_unref(s->fd_reg.fd_lookup);
+    g_free(s->fd_reg.fd_array);
+    s->fd_reg.fd_array =3D NULL;
+}
+
+/**
+ * luring_fd_lookup:
+ *
+ * Used to lookup fd index in registered array at submission time
+ * If the lookup table has not been created or the fd is not in the tabl=
e,
+ * the fd is registered.
+ *
+ * If registration errors, this function returns -errno.
+ *
+ * Unregistering is done in luring_detach_aio_context().
+ */
+static int luring_fd_lookup(LuringState *s, int fd)
+{
+    void *index;
+
+    if (g_hash_table_lookup_extended(s->fd_reg.fd_lookup, GINT_TO_POINTE=
R(fd),
+                                     NULL, &index)) {
+        return GPOINTER_TO_INT(index);
+    }
+
+    return luring_fd_register(&s->ring, &s->fd_reg, fd);
+}
+
 void luring_io_plug(BlockDriverState *bs, LuringState *s)
 {
     trace_luring_io_plug(s);
@@ -329,9 +465,14 @@ void luring_io_unplug(BlockDriverState *bs, LuringSt=
ate *s)
 static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *=
s,
                             uint64_t offset, int type)
 {
-    int ret;
+    int ret, fd_index;
     struct io_uring_sqe *sqes =3D &luringcb->sqeq;
=20
+    fd_index =3D luring_fd_lookup(s, fd);
+    if (fd_index >=3D 0) {
+        fd =3D fd_index;
+    }
+
     switch (type) {
     case QEMU_AIO_WRITE:
         io_uring_prep_writev(sqes, fd, luringcb->qiov->iov,
@@ -349,7 +490,11 @@ static int luring_do_submit(int fd, LuringAIOCB *lur=
ingcb, LuringState *s,
                         __func__, type);
         abort();
     }
+
     io_uring_sqe_set_data(sqes, luringcb);
+    if (fd_index >=3D 0) {
+        io_uring_sqe_set_flags(sqes, IOSQE_FIXED_FILE);
+    }
=20
     QSIMPLEQ_INSERT_TAIL(&s->io_q.submit_queue, luringcb, next);
     s->io_q.in_queue++;
@@ -375,6 +520,7 @@ int coroutine_fn luring_co_submit(BlockDriverState *b=
s, LuringState *s, int fd,
         .qiov       =3D qiov,
         .is_read    =3D (type =3D=3D QEMU_AIO_READ),
     };
+
     trace_luring_co_submit(bs, s, &luringcb, fd, offset, qiov ? qiov->si=
ze : 0,
                            type);
     ret =3D luring_do_submit(fd, &luringcb, s, offset, type);
@@ -391,6 +537,7 @@ int coroutine_fn luring_co_submit(BlockDriverState *b=
s, LuringState *s, int fd,
=20
 void luring_detach_aio_context(LuringState *s, AioContext *old_context)
 {
+    luring_fd_cleanup(s);
     aio_set_fd_handler(old_context, s->ring.ring_fd, false, NULL, NULL, =
NULL,
                        s);
     qemu_bh_delete(s->completion_bh);
@@ -403,6 +550,7 @@ void luring_attach_aio_context(LuringState *s, AioCon=
text *new_context)
     s->completion_bh =3D aio_bh_new(new_context, qemu_luring_completion_=
bh, s);
     aio_set_fd_handler(s->aio_context, s->ring.ring_fd, false,
                        qemu_luring_completion_cb, NULL, qemu_luring_poll=
_cb, s);
+    luring_fd_init(s);
 }
=20
 LuringState *luring_init(Error **errp)
diff --git a/block/trace-events b/block/trace-events
index 2e3a9851b6..6a19cc00b7 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -72,6 +72,8 @@ luring_co_submit(void *bs, void *s, void *luringcb, int=
 fd, uint64_t offset, siz
 luring_process_completion(void *s, void *aiocb, int ret) "LuringState %p=
 luringcb %p ret %d"
 luring_io_uring_submit(void *s, int ret) "LuringState %p ret %d"
 luring_resubmit_short_read(void *s, void *luringcb, int nread) "LuringSt=
ate %p luringcb %p nread %d"
+luring_fd_register(int fd, int index, int ret) "fd %d index %d ret %d"
+luring_fd_unregister(void *s, int fd, int index) "LuringState %p fd %d i=
ndex %d"
=20
 # qcow2.c
 qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offse=
t 0x%" PRIx64 " bytes %d"
--=20
2.21.0


