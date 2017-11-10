Received: from eggs.gnu.org ([2001:4830:134:3::10]:33106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2i-00040h-P3
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2d-0005Bv-V2
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eDA2d-00059u-KT
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:19 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAAEB800119364
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:18 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e5b5bqjjm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:18 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 10 Nov 2017 07:12:17 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 09:11:51 -0500
In-Reply-To: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510323112-2207-13-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 12/13] tpm: extend TPM emulator with state
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Cc: amarnath.valluri@intel.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Extend the TPM emulator backend device with state migration support.

The external TPM emulator 'swtpm' provides a protocol over
its control channel to retrieve its state blobs. We implement
functions for getting and setting the different state blobs.

Since we have an external TPM emulator, we need to make sure
that we do not migrate the state for as long as it is busy
processing a request. We need to wait for notification that
the request has completed processing.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_emulator.c | 303 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 293 insertions(+), 10 deletions(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 3ae8bf6..f05753f 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -61,6 +61,19 @@
 #define TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(S, cap) (((S)->caps & (cap)) == (cap))
 
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
     Error *migration_blocker;
 
     QemuMutex mutex;
+
+    TPMBlobBuffers state_blobs;
 } TPMEmulator;
 
 
@@ -315,18 +330,24 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
     return 0;
 }
 
-static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize)
+static int _tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize,
+                                     bool is_resume)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     ptm_init init;
     ptm_res res;
 
+    DPRINTF("%s   is_resume: %d", __func__, is_resume);
+
     if (buffersize != 0 &&
         tpm_emulator_set_buffer_size(tb, buffersize, NULL) < 0) {
         goto err_exit;
     }
 
-    DPRINTF("%s", __func__);
+    if (is_resume) {
+        init.u.req.init_flags = cpu_to_be32(PTM_INIT_FLAG_DELETE_VOLATILE);
+    }
+
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_INIT, &init, sizeof(init),
                              sizeof(init)) < 0) {
         error_report("tpm-emulator: could not send INIT: %s",
@@ -345,6 +366,11 @@ err_exit:
     return -1;
 }
 
+static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize)
+{
+    return _tpm_emulator_startup_tpm(tb, buffersize, false);
+}
+
 static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
@@ -435,16 +461,21 @@ static size_t tpm_emulator_get_buffer_size(TPMBackend *tb)
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
@@ -573,6 +604,253 @@ static const QemuOptDesc tpm_emulator_cmdline_opts[] = {
     { /* end of list */ },
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
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_STATEBLOB,
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
+                                    &state_blobs->permanent_flags) < 0 ||
+        tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_VOLATILE,
+                                    &state_blobs->volatil,
+                                    &state_blobs->volatil_flags) < 0 ||
+        tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE,
+                                    &state_blobs->savestate,
+                                    &state_blobs->savestate_flags) < 0) {
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
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_STATEBLOB, &pss,
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
+static int tpm_emulator_set_state_blobs(TPMBackend *tb)
+{
+    TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
+    TPMBlobBuffers *state_blobs = &tpm_emu->state_blobs;
+
+    DPRINTF("%s: %d", __func__, __LINE__);
+
+    if (tpm_emulator_stop_tpm(tb) < 0) {
+        return -1;
+    }
+
+    if (tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT,
+                                    &state_blobs->permanent,
+                                    state_blobs->permanent_flags) < 0 ||
+        tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_VOLATILE,
+                                    &state_blobs->volatil,
+                                    state_blobs->volatil_flags) < 0 ||
+        tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE,
+                                    &state_blobs->savestate,
+                                    state_blobs->savestate_flags) < 0) {
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
+    if (tpm_emulator_set_state_blobs(tb) < 0) {
+        return 1;
+    }
+
+    return _tpm_emulator_startup_tpm(tb, 0, true);
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
@@ -580,7 +858,10 @@ static void tpm_emulator_inst_init(Object *obj)
     DPRINTF("%s", __func__);
     tpm_emu->options = g_new0(TPMEmulatorOptions, 1);
     tpm_emu->cur_locty_number = ~0;
+
     qemu_mutex_init(&tpm_emu->mutex);
+
+    vmstate_register(NULL, -1, &vmstate_tpm_emulator, obj);
 }
 
 /*
@@ -617,6 +898,8 @@ static void tpm_emulator_inst_finalize(Object *obj)
     }
 
     qemu_mutex_destroy(&tpm_emu->mutex);
+
+    vmstate_unregister(NULL, &vmstate_tpm_emulator, obj);
 }
 
 static void tpm_emulator_class_init(ObjectClass *klass, void *data)
-- 
2.5.5
