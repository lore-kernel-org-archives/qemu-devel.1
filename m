Received: from eggs.gnu.org ([2001:4830:134:3::10]:34279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2OhT-0003WA-94
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 17:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2OhO-0003gC-9O
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 17:37:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e2OhN-0003fF-T4
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 17:37:54 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9BLbWYG145836
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 17:37:48 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dhs4a5wtg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 17:37:48 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 11 Oct 2017 17:37:47 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 11 Oct 2017 17:37:31 -0400
In-Reply-To: <1507757851-12580-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507757851-12580-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1507757851-12580-5-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 4/4] tpm: extend TPM emulator and TIS with
 state migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Extend the TPM emulator and TPM TIS interface with state
migration support.

The external TPM emulator 'swtpm' provides a protocol over
its control channel to retrieve its state blobs. We implement
functions for getting and setting the different state blobs.

Since we have an external TPM emulator, we need to make sure
that we do not migrate the state for as long as it is busy
processing a request. We need to wait for notification that
the request has completed processing.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c               |   9 ++
 hw/tpm/tpm_emulator.c        | 310 +++++++++++++++++++++++++++++++++++++++++--
 hw/tpm/tpm_tis.c             | 138 ++++++++++++++++++-
 hw/tpm/tpm_tis.h             |   2 +
 hw/tpm/tpm_util.c            |   7 +
 hw/tpm/tpm_util.h            |   2 +
 include/sysemu/tpm_backend.h |   8 ++
 7 files changed, 465 insertions(+), 11 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index 334836b..be35ee2 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -68,6 +68,15 @@ void tpm_backend_cmd_completed(TPMBackend *s)
     qemu_mutex_unlock(&s->state_lock);
 }
 
+void tpm_backend_wait_cmd_completed(TPMBackend *s)
+{
+    qemu_mutex_lock(&s->state_lock);
+    if (s->tpm_busy) {
+        qemu_cond_wait(&s->cmd_complete, &s->state_lock);
+    }
+    qemu_mutex_unlock(&s->state_lock);
+}
+
 int tpm_backend_startup_tpm(TPMBackend *s)
 {
     int res = 0;
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 556b8c8..3cafc55 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -63,6 +63,19 @@
 static const TPMDriverOps tpm_emulator_driver;
 
 /* data structures */
+
+/* blobs from the TPM; part of VM state when migrating */
+typedef struct TPMBlobBuffers {
+    uint32_t permanent_flags;
+    TPMSizedBuffer permanent;
+
+    uint32_t volatil_flags;
+    TPMSizedBuffer volatil;
+
+    uint32_t savestate_flags;
+    TPMSizedBuffer savestate;
+} TPMBlobBuffers;
+
 typedef struct TPMEmulator {
     TPMBackend parent;
 
@@ -73,6 +86,8 @@ typedef struct TPMEmulator {
     ptm_cap caps; /* capabilities of the TPM */
     uint8_t cur_locty_number; /* last set locality */
     Error *migration_blocker;
+
+    TPMBlobBuffers state_blobs;
 } TPMEmulator;
 
 
@@ -260,13 +275,18 @@ static int tpm_emulator_check_caps(TPMEmulator *tpm_emu)
     return 0;
 }
 
-static int tpm_emulator_startup_tpm(TPMBackend *tb)
+static int _tpm_emulator_startup_tpm(TPMBackend *tb, bool is_resume)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     ptm_init init;
     ptm_res res;
 
-    DPRINTF("%s", __func__);
+    DPRINTF("%s   is_resume: %d", __func__, is_resume);
+
+    if (is_resume) {
+        init.u.req.init_flags = cpu_to_be32(PTM_INIT_FLAG_DELETE_VOLATILE);
+    }
+
     if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_INIT, &init, sizeof(init),
                          sizeof(init)) < 0) {
         error_report("tpm-emulator: could not send INIT: %s",
@@ -285,6 +305,11 @@ err_exit:
     return -1;
 }
 
+static int tpm_emulator_startup_tpm(TPMBackend *tb)
+{
+    return _tpm_emulator_startup_tpm(tb, false);
+}
+
 static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
@@ -363,16 +388,21 @@ static TPMVersion tpm_emulator_get_tpm_version(TPMBackend *tb)
 static int tpm_emulator_block_migration(TPMEmulator *tpm_emu)
 {
     Error *err = NULL;
+    ptm_cap caps = PTM_CAP_GET_STATEBLOB | PTM_CAP_SET_STATEBLOB |
+                   PTM_CAP_STOP;
 
-    error_setg(&tpm_emu->migration_blocker,
-               "Migration disabled: TPM emulator not yet migratable");
-    migrate_add_blocker(tpm_emu->migration_blocker, &err);
-    if (err) {
-        error_report_err(err);
-        error_free(tpm_emu->migration_blocker);
-        tpm_emu->migration_blocker = NULL;
+    if (!TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(tpm_emu, caps)) {
+        error_setg(&tpm_emu->migration_blocker,
+                   "Migration disabled: TPM emulator does not support "
+                   "migration");
+        migrate_add_blocker(tpm_emu->migration_blocker, &err);
+        if (err) {
+            error_report_err(err);
+            error_free(tpm_emu->migration_blocker);
+            tpm_emu->migration_blocker = NULL;
 
-        return -1;
+            return -1;
+        }
     }
 
     return 0;
@@ -521,13 +551,271 @@ static const TPMDriverOps tpm_emulator_driver = {
     .get_tpm_options          = tpm_emulator_get_tpm_options,
 };
 
+/*
+ * Transfer a TPM state blob from the TPM into a provided buffer.
+ *
+ * @tpm_emu: TPMEmulator
+ * @type: the type of blob to transfer
+ * @tsb: the TPMSizeBuffer to fill with the blob
+ * @flags: the flags to return to the caller
+ */
+static int tpm_emulator_get_state_blob(TPMEmulator *tpm_emu,
+                                       uint8_t type,
+                                       TPMSizedBuffer *tsb,
+                                       uint32_t *flags)
+{
+    ptm_getstate pgs;
+    ptm_res res;
+    ssize_t n;
+    uint32_t totlength, length;
+
+    tpm_sized_buffer_reset(tsb);
+
+    pgs.u.req.state_flags = cpu_to_be32(PTM_STATE_FLAG_DECRYPTED);
+    pgs.u.req.type = cpu_to_be32(type);
+    pgs.u.req.offset = 0;
+
+    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_GET_STATEBLOB,
+                             &pgs, sizeof(pgs.u.req),
+                             offsetof(ptm_getstate, u.resp.data)) < 0) {
+        error_report("tpm-emulator: could not get state blob type %d : %s",
+                     type, strerror(errno));
+        return -1;
+    }
+
+    res = be32_to_cpu(pgs.u.resp.tpm_result);
+    if (res != 0 && (res & 0x800) == 0) {
+        error_report("tpm-emulator: Getting the stateblob (type %d) failed "
+                     "with a TPM error 0x%x", type, res);
+        return -1;
+    }
+
+    totlength = be32_to_cpu(pgs.u.resp.totlength);
+    if (totlength >= 32 * 1024) {
+        error_report("tpm-emulator: TPM state blob (type %d) with %d bytes "
+                     "too large to read", type, totlength);
+        return -1;
+    }
+
+    length = be32_to_cpu(pgs.u.resp.length);
+    if (totlength != length) {
+        error_report("tpm-emulator: Expecting to read %u bytes "
+                     "but would get %u", totlength, length);
+        return -1;
+    }
+
+    *flags = be32_to_cpu(pgs.u.resp.state_flags);
+
+    tsb->buffer = g_malloc(totlength);
+
+    n = qemu_chr_fe_read_all(&tpm_emu->ctrl_chr, tsb->buffer, totlength);
+    if (n != totlength) {
+        error_report("tpm-emulator: Could not read stateblob (type %d) : %s",
+                     type, strerror(errno));
+        return -1;
+    }
+    tsb->size = totlength;
+
+    DPRINTF("got state blob type %d, %d bytes, flags 0x%08x\n",
+            type, tsb->size, *flags);
+
+    return 0;
+}
+
+static int tpm_emulator_get_state_blobs(TPMEmulator *tpm_emu)
+{
+    TPMBlobBuffers *state_blobs = &tpm_emu->state_blobs;
+
+    if (tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT,
+                                    &state_blobs->permanent,
+                                    &state_blobs->permanent_flags) ||
+        tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_VOLATILE,
+                                    &state_blobs->volatil,
+                                    &state_blobs->volatil_flags) ||
+        tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE,
+                                    &state_blobs->savestate,
+                                    &state_blobs->savestate_flags)) {
+        goto err_exit;
+    }
+
+    return 0;
+
+ err_exit:
+    tpm_sized_buffer_reset(&state_blobs->volatil);
+    tpm_sized_buffer_reset(&state_blobs->permanent);
+    tpm_sized_buffer_reset(&state_blobs->savestate);
+
+    return -1;
+}
+
+/*
+ * Transfer a TPM state blob to the TPM emulator.
+ *
+ * @tpm_emu: TPMEmulator
+ * @type: the type of TPM state blob to transfer
+ * @tsb: TPMSizeBuffer containing the TPM state blob
+ * @flags: Flags describing the (encryption) state of the TPM state blob
+ */
+static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
+                                       uint32_t type,
+                                       TPMSizedBuffer *tsb,
+                                       uint32_t flags)
+{
+    uint32_t offset = 0;
+    ssize_t n;
+    ptm_setstate pss;
+    ptm_res tpm_result;
+
+    if (tsb->size == 0) {
+        return 0;
+    }
+
+    pss = (ptm_setstate) {
+        .u.req.state_flags = cpu_to_be32(flags),
+        .u.req.type = cpu_to_be32(type),
+        .u.req.length = cpu_to_be32(tsb->size),
+    };
+
+    /* write the header only */
+    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_SET_STATEBLOB,
+                             &pss,
+                             offsetof(ptm_setstate, u.req.data), 0) < 0) {
+        error_report("tpm-emulator: could not set state blob type %d : %s",
+                     type, strerror(errno));
+        return -1;
+    }
+
+    /* now the body */
+    n = qemu_chr_fe_write_all(&tpm_emu->ctrl_chr,
+                              &tsb->buffer[offset], tsb->size);
+    if (n != tsb->size) {
+        error_report("tpm-emulator: Writing the stateblob (type %d) "
+                     "failed: %s", type, strerror(errno));
+        return -1;
+    }
+
+    /* now get the result */
+    n = qemu_chr_fe_read_all(&tpm_emu->ctrl_chr,
+                             (uint8_t *)&pss, sizeof(pss.u.resp));
+    if (n != sizeof(pss.u.resp)) {
+        error_report("tpm-emulator: Reading response from writing stateblob "
+                     "(type %d) failed: %s", type, strerror(errno));
+        return -1;
+    }
+
+    tpm_result = be32_to_cpu(pss.u.resp.tpm_result);
+    if (tpm_result != 0) {
+        error_report("tpm-emulator: Setting the stateblob (type %d) failed "
+                     "with a TPM error 0x%x", type, tpm_result);
+        return -1;
+    }
+
+    DPRINTF("set the state blob type %d, %d bytes, flags 0x%08x\n",
+            type, tsb->size, flags);
+
+    return 0;
+}
+
+static int tpm_emulator_set_state_blobs(TPMEmulator *tpm_emu)
+{
+    ptm_res res;
+    TPMBlobBuffers *state_blobs = &tpm_emu->state_blobs;
+
+    DPRINTF("%s: %d", __func__, __LINE__);
+
+    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_STOP, &res, 0,
+                             sizeof(res)) < 0) {
+        error_report("tpm-emulator: could not send STOP: %s",
+                     strerror(errno));
+        return -1;
+    } else if (res != 0) {
+        error_report("tpm-emulator: Failed to stop TPM: 0x%x",
+                     be32_to_cpu(res));
+        return -1;
+    }
+
+    if (tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT,
+                                    &state_blobs->permanent,
+                                    state_blobs->permanent_flags) ||
+        tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_VOLATILE,
+                                    &state_blobs->volatil,
+                                    state_blobs->volatil_flags) ||
+        tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE,
+                                    &state_blobs->savestate,
+                                    state_blobs->savestate_flags)) {
+        return -1;
+    }
+
+    DPRINTF("DONE SETTING STATEBLOBS");
+
+    return 0;
+}
+
+static int tpm_emulator_pre_save(void *opaque)
+{
+    TPMBackend *tb = opaque;
+    TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
+
+    DPRINTF("%s", __func__);
+
+    tpm_backend_wait_cmd_completed(tb);
+
+    /* get the state blobs from the TPM */
+    return tpm_emulator_get_state_blobs(tpm_emu);
+}
+
+static int tpm_emulator_post_load(void *opaque,
+                                  int version_id __attribute__((unused)))
+{
+    TPMBackend *tb = opaque;
+
+    if (tpm_emulator_set_state_blobs(TPM_EMULATOR(tb))) {
+        return 1;
+    }
+
+    return _tpm_emulator_startup_tpm(tb, true);
+}
+
+static const VMStateDescription vmstate_tpm_emulator = {
+    .name = "tpm-emulator",
+    .version_id = 1,
+    .minimum_version_id = 0,
+    .minimum_version_id_old = 0,
+    .pre_save = tpm_emulator_pre_save,
+    .post_load = tpm_emulator_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(state_blobs.permanent_flags, TPMEmulator),
+        VMSTATE_UINT32(state_blobs.permanent.size, TPMEmulator),
+        VMSTATE_VBUFFER_ALLOC_UINT32(state_blobs.permanent.buffer,
+                                     TPMEmulator, 1, 0,
+                                     state_blobs.permanent.size),
+
+        VMSTATE_UINT32(state_blobs.volatil_flags, TPMEmulator),
+        VMSTATE_UINT32(state_blobs.volatil.size, TPMEmulator),
+        VMSTATE_VBUFFER_ALLOC_UINT32(state_blobs.volatil.buffer,
+                                     TPMEmulator, 1, 0,
+                                     state_blobs.volatil.size),
+
+        VMSTATE_UINT32(state_blobs.savestate_flags, TPMEmulator),
+        VMSTATE_UINT32(state_blobs.savestate.size, TPMEmulator),
+        VMSTATE_VBUFFER_ALLOC_UINT32(state_blobs.savestate.buffer,
+                                     TPMEmulator, 1, 0,
+                                     state_blobs.savestate.size),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void tpm_emulator_inst_init(Object *obj)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(obj);
 
     DPRINTF("%s", __func__);
+
     tpm_emu->options = g_new0(TPMEmulatorOptions, 1);
     tpm_emu->cur_locty_number = ~0;
+
+    vmstate_register(NULL, -1, &vmstate_tpm_emulator, obj);
 }
 
 /*
@@ -563,6 +851,8 @@ static void tpm_emulator_inst_finalize(Object *obj)
         migrate_del_blocker(tpm_emu->migration_blocker);
         error_free(tpm_emu->migration_blocker);
     }
+
+    vmstate_unregister(NULL, &vmstate_tpm_emulator, obj);
 }
 
 static void tpm_emulator_class_init(ObjectClass *klass, void *data)
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index b9b9a2f..1b23129 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -367,6 +367,8 @@ static void tpm_tis_receive_bh(void *opaque)
     TPMTISEmuState *tis = &s->s.tis;
     uint8_t locty = s->locty_number;
 
+    tis->bh_scheduled = false;
+
     qemu_mutex_lock(&s->state_lock);
 
     tpm_tis_sts_set(&tis->loc[locty],
@@ -416,6 +418,8 @@ static void tpm_tis_receive_cb(TPMState *s, uint8_t locty,
     qemu_mutex_unlock(&s->state_lock);
 
     qemu_bh_schedule(tis->bh);
+
+    tis->bh_scheduled = true;
 }
 
 /*
@@ -1041,9 +1045,141 @@ static void tpm_tis_reset(DeviceState *dev)
     tpm_tis_do_startup_tpm(s);
 }
 
+/* persistent state handling */
+
+static int tpm_tis_pre_save(void *opaque)
+{
+    TPMState *s = opaque;
+    TPMTISEmuState *tis = &s->s.tis;
+    uint8_t locty = tis->active_locty;
+
+    DPRINTF("tpm_tis: suspend: locty = %d : r_offset = %d, w_offset = %d\n",
+            locty, tis->loc[0].r_offset, tis->loc[0].w_offset);
+#ifdef DEBUG_TIS
+    tpm_tis_dump_state(opaque, 0);
+#endif
+
+    qemu_mutex_lock(&s->state_lock);
+
+    /* wait for outstanding request to complete */
+    if (TPM_TIS_IS_VALID_LOCTY(locty) &&
+        tis->loc[locty].state == TPM_TIS_STATE_EXECUTION) {
+        /*
+         * If we get here when the bh is scheduled but did not run,
+         * we won't get notified...
+         */
+        if (!tis->bh_scheduled) {
+            /* backend thread to notify us */
+            qemu_cond_wait(&s->cmd_complete, &s->state_lock);
+        }
+        if (tis->loc[locty].state == TPM_TIS_STATE_EXECUTION) {
+            /* bottom half did not run - run its function */
+            qemu_mutex_unlock(&s->state_lock);
+            tpm_tis_receive_bh(opaque);
+            qemu_mutex_lock(&s->state_lock);
+        }
+    }
+
+    qemu_mutex_unlock(&s->state_lock);
+
+    /* copy current active read or write buffer into the buffer
+       written to disk */
+    if (TPM_TIS_IS_VALID_LOCTY(locty)) {
+        switch (tis->loc[locty].state) {
+        case TPM_TIS_STATE_RECEPTION:
+            memcpy(tis->buf,
+                   tis->loc[locty].w_buffer.buffer,
+                   MIN(sizeof(tis->buf),
+                       tis->loc[locty].w_buffer.size));
+            tis->offset = tis->loc[locty].w_offset;
+        break;
+        case TPM_TIS_STATE_COMPLETION:
+            memcpy(tis->buf,
+                   tis->loc[locty].r_buffer.buffer,
+                   MIN(sizeof(tis->buf),
+                       tis->loc[locty].r_buffer.size));
+            tis->offset = tis->loc[locty].r_offset;
+        break;
+        default:
+            /* leak nothing */
+            memset(tis->buf, 0x0, sizeof(tis->buf));
+        break;
+        }
+    }
+
+    return 0;
+}
+
+static int tpm_tis_post_load(void *opaque,
+                             int version_id __attribute__((unused)))
+{
+    TPMState *s = opaque;
+    TPMTISEmuState *tis = &s->s.tis;
+
+    uint8_t locty = tis->active_locty;
+
+    if (TPM_TIS_IS_VALID_LOCTY(locty)) {
+        switch (tis->loc[locty].state) {
+        case TPM_TIS_STATE_RECEPTION:
+            memcpy(tis->loc[locty].w_buffer.buffer,
+                   tis->buf,
+                   MIN(sizeof(tis->buf),
+                       tis->loc[locty].w_buffer.size));
+            tis->loc[locty].w_offset = tis->offset;
+        break;
+        case TPM_TIS_STATE_COMPLETION:
+            memcpy(tis->loc[locty].r_buffer.buffer,
+                   tis->buf,
+                   MIN(sizeof(tis->buf),
+                       tis->loc[locty].r_buffer.size));
+            tis->loc[locty].r_offset = tis->offset;
+        break;
+        default:
+        break;
+        }
+    }
+
+    DPRINTF("tpm_tis: resume : locty = %d : r_offset = %d, w_offset = %d\n",
+            locty, tis->loc[0].r_offset, tis->loc[0].w_offset);
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_locty = {
+    .name = "loc",
+    .version_id = 1,
+    .minimum_version_id = 0,
+    .minimum_version_id_old = 0,
+    .fields      = (VMStateField[]) {
+        VMSTATE_UINT32(state, TPMLocality),
+        VMSTATE_UINT32(inte, TPMLocality),
+        VMSTATE_UINT32(ints, TPMLocality),
+        VMSTATE_UINT8(access, TPMLocality),
+        VMSTATE_UINT32(sts, TPMLocality),
+        VMSTATE_UINT32(iface_id, TPMLocality),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
 static const VMStateDescription vmstate_tpm_tis = {
     .name = "tpm",
-    .unmigratable = 1,
+    .version_id = 1,
+    .minimum_version_id = 0,
+    .minimum_version_id_old = 0,
+    .pre_save  = tpm_tis_pre_save,
+    .post_load = tpm_tis_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(s.tis.offset, TPMState),
+        VMSTATE_BUFFER(s.tis.buf, TPMState),
+        VMSTATE_UINT8(s.tis.active_locty, TPMState),
+        VMSTATE_UINT8(s.tis.aborting_locty, TPMState),
+        VMSTATE_UINT8(s.tis.next_locty, TPMState),
+
+        VMSTATE_STRUCT_ARRAY(s.tis.loc, TPMState, TPM_TIS_NUM_LOCALITIES, 1,
+                             vmstate_locty, TPMLocality),
+
+        VMSTATE_END_OF_LIST()
+    }
 };
 
 static Property tpm_tis_properties[] = {
diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
index a1df41f..b7fc0ea 100644
--- a/hw/tpm/tpm_tis.h
+++ b/hw/tpm/tpm_tis.h
@@ -54,6 +54,8 @@ typedef struct TPMLocality {
 
 typedef struct TPMTISEmuState {
     QEMUBH *bh;
+    bool bh_scheduled; /* bh scheduled but did not run yet */
+
     uint32_t offset;
     uint8_t buf[TPM_TIS_BUFFER_MAX];
 
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index 1129155..f496e39 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -150,3 +150,10 @@ int tpm_util_test_tpmdev(int tpm_fd, TPMVersion *tpm_version)
 
     return 1;
 }
+
+void tpm_sized_buffer_reset(TPMSizedBuffer *tsb)
+{
+    g_free(tsb->buffer);
+    tsb->buffer = NULL;
+    tsb->size = 0;
+}
diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
index 2f7c961..d394cb6 100644
--- a/hw/tpm/tpm_util.h
+++ b/hw/tpm/tpm_util.h
@@ -30,4 +30,6 @@ bool tpm_util_is_selftest(const uint8_t *in, uint32_t in_len);
 
 int tpm_util_test_tpmdev(int tpm_fd, TPMVersion *tpm_version);
 
+void tpm_sized_buffer_reset(TPMSizedBuffer *tsb);
+
 #endif /* TPM_TPM_UTIL_H */
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index cdc4742..250d763 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -227,6 +227,14 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s);
  */
 void tpm_backend_cmd_completed(TPMBackend *s);
 
+/**
+ * tpm_backend_wait_cmd_completed:
+ * @s: the backend
+ *
+ * Wait the backend to not be busy anymore
+ */
+void tpm_backend_wait_cmd_completed(TPMBackend *s);
+
 TPMBackend *qemu_find_tpm(const char *id);
 
 const TPMDriverOps *tpm_get_backend_driver(const char *type);
-- 
2.5.5
