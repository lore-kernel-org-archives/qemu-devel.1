Received: from eggs.gnu.org ([2001:4830:134:3::10]:38020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fMPMo-0006wu-11
	for qemu-devel@nongnu.org; Fri, 25 May 2018 22:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fMPMk-0001aJ-TX
	for qemu-devel@nongnu.org; Fri, 25 May 2018 22:55:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33580
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fMPMk-0001Zh-H0
	for qemu-devel@nongnu.org; Fri, 25 May 2018 22:55:34 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4Q2s3nh080741
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:55:33 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2j6xq7rsa0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:55:33 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 25 May 2018 22:55:32 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 25 May 2018 22:55:17 -0400
In-Reply-To: <20180526025520.3298441-1-stefanb@linux.vnet.ibm.com>
References: <20180526025520.3298441-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180526025520.3298441-2-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v4 1/4] tpm: extend TPM emulator with state
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Extend the TPM emulator backend device with state migration support.

The external TPM emulator 'swtpm' provides a protocol over
its control channel to retrieve its state blobs. We implement
functions for getting and setting the different state blobs.
In case the setting of the state blobs fails, we return a
negative errno code to fail the start of the VM.

Since we have an external TPM emulator, we need to make sure
that we do not migrate the state for as long as it is busy
processing a request. We need to wait for notification that
the request has completed processing.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_emulator.c | 323 ++++++++++++++++++++++++++++++++++++++++++++=
++++--
 hw/tpm/trace-events   |   8 +-
 2 files changed, 319 insertions(+), 12 deletions(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 6418ef0831..10bc20dbec 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -4,7 +4,7 @@
  *  Copyright (c) 2017 Intel Corporation
  *  Author: Amarnath Valluri <amarnath.valluri@intel.com>
  *
- *  Copyright (c) 2010 - 2013 IBM Corporation
+ *  Copyright (c) 2010 - 2013, 2018 IBM Corporation
  *  Authors:
  *    Stefan Berger <stefanb@us.ibm.com>
  *
@@ -49,6 +49,19 @@
 #define TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(S, cap) (((S)->caps & (cap)) =3D=
=3D (cap))
=20
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
=20
@@ -64,6 +77,8 @@ typedef struct TPMEmulator {
=20
     unsigned int established_flag:1;
     unsigned int established_flag_cached:1;
+
+    TPMBlobBuffers state_blobs;
 } TPMEmulator;
=20
=20
@@ -293,7 +308,8 @@ static int tpm_emulator_set_buffer_size(TPMBackend *t=
b,
     return 0;
 }
=20
-static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize)
+static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffer=
size,
+                                     bool is_resume)
 {
     TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
     ptm_init init =3D {
@@ -301,12 +317,17 @@ static int tpm_emulator_startup_tpm(TPMBackend *tb,=
 size_t buffersize)
     };
     ptm_res res;
=20
+    trace_tpm_emulator_startup_tpm_resume(is_resume, buffersize);
+
     if (buffersize !=3D 0 &&
         tpm_emulator_set_buffer_size(tb, buffersize, NULL) < 0) {
         goto err_exit;
     }
=20
-    trace_tpm_emulator_startup_tpm();
+    if (is_resume) {
+        init.u.req.init_flags |=3D cpu_to_be32(PTM_INIT_FLAG_DELETE_VOLA=
TILE);
+    }
+
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_INIT, &init, sizeof(init),
                              sizeof(init)) < 0) {
         error_report("tpm-emulator: could not send INIT: %s",
@@ -325,6 +346,11 @@ err_exit:
     return -1;
 }
=20
+static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize)
+{
+    return tpm_emulator_startup_tpm_resume(tb, buffersize, false);
+}
+
 static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
 {
     TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
@@ -423,16 +449,21 @@ static size_t tpm_emulator_get_buffer_size(TPMBacke=
nd *tb)
 static int tpm_emulator_block_migration(TPMEmulator *tpm_emu)
 {
     Error *err =3D NULL;
+    ptm_cap caps =3D PTM_CAP_GET_STATEBLOB | PTM_CAP_SET_STATEBLOB |
+                   PTM_CAP_STOP;
=20
-    error_setg(&tpm_emu->migration_blocker,
-               "Migration disabled: TPM emulator not yet migratable");
-    migrate_add_blocker(tpm_emu->migration_blocker, &err);
-    if (err) {
-        error_report_err(err);
-        error_free(tpm_emu->migration_blocker);
-        tpm_emu->migration_blocker =3D NULL;
+    if (!TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(tpm_emu, caps)) {
+        error_setg(&tpm_emu->migration_blocker,
+                   "Migration disabled: TPM emulator does not support "
+                   "migration");
+        migrate_add_blocker(tpm_emu->migration_blocker, &err);
+        if (err) {
+            error_report_err(err);
+            error_free(tpm_emu->migration_blocker);
+            tpm_emu->migration_blocker =3D NULL;
=20
-        return -1;
+            return -1;
+        }
     }
=20
     return 0;
@@ -570,6 +601,267 @@ static const QemuOptDesc tpm_emulator_cmdline_opts[=
] =3D {
     { /* end of list */ },
 };
=20
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
+    pgs.u.req.state_flags =3D cpu_to_be32(PTM_STATE_FLAG_DECRYPTED);
+    pgs.u.req.type =3D cpu_to_be32(type);
+    pgs.u.req.offset =3D 0;
+
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_STATEBLOB,
+                             &pgs, sizeof(pgs.u.req),
+                             offsetof(ptm_getstate, u.resp.data)) < 0) {
+        error_report("tpm-emulator: could not get state blob type %d : %=
s",
+                     type, strerror(errno));
+        return -1;
+    }
+
+    res =3D be32_to_cpu(pgs.u.resp.tpm_result);
+    if (res !=3D 0 && (res & 0x800) =3D=3D 0) {
+        error_report("tpm-emulator: Getting the stateblob (type %d) fail=
ed "
+                     "with a TPM error 0x%x", type, res);
+        return -1;
+    }
+
+    totlength =3D be32_to_cpu(pgs.u.resp.totlength);
+    length =3D be32_to_cpu(pgs.u.resp.length);
+    if (totlength !=3D length) {
+        error_report("tpm-emulator: Expecting to read %u bytes "
+                     "but would get %u", totlength, length);
+        return -1;
+    }
+
+    *flags =3D be32_to_cpu(pgs.u.resp.state_flags);
+
+    if (totlength > 0) {
+        tsb->buffer =3D g_try_malloc(totlength);
+        if (!tsb->buffer) {
+            error_report("tpm-emulator: Out of memory allocating %u byte=
s",
+                         totlength);
+            return -1;
+        }
+
+        n =3D qemu_chr_fe_read_all(&tpm_emu->ctrl_chr, tsb->buffer, totl=
ength);
+        if (n !=3D totlength) {
+            error_report("tpm-emulator: Could not read stateblob (type %=
d); "
+                         "expected %u bytes, got %zd",
+                         type, totlength, n);
+            return -1;
+        }
+    }
+    tsb->size =3D totlength;
+
+    trace_tpm_emulator_get_state_blob(type, tsb->size, *flags);
+
+    return 0;
+}
+
+static int tpm_emulator_get_state_blobs(TPMEmulator *tpm_emu)
+{
+    TPMBlobBuffers *state_blobs =3D &tpm_emu->state_blobs;
+
+    if (tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT,
+                                    &state_blobs->permanent,
+                                    &state_blobs->permanent_flags) < 0 |=
|
+        tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_VOLATILE,
+                                    &state_blobs->volatil,
+                                    &state_blobs->volatil_flags) < 0 ||
+        tpm_emulator_get_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE,
+                                    &state_blobs->savestate,
+                                    &state_blobs->savestate_flags) < 0) =
{
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
+ * @tsb: TPMSizedBuffer containing the TPM state blob
+ * @flags: Flags describing the (encryption) state of the TPM state blob
+ */
+static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
+                                       uint32_t type,
+                                       TPMSizedBuffer *tsb,
+                                       uint32_t flags)
+{
+    ssize_t n;
+    ptm_setstate pss;
+    ptm_res tpm_result;
+
+    if (tsb->size =3D=3D 0) {
+        return 0;
+    }
+
+    pss =3D (ptm_setstate) {
+        .u.req.state_flags =3D cpu_to_be32(flags),
+        .u.req.type =3D cpu_to_be32(type),
+        .u.req.length =3D cpu_to_be32(tsb->size),
+    };
+
+    /* write the header only */
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_STATEBLOB, &pss,
+                             offsetof(ptm_setstate, u.req.data), 0) < 0)=
 {
+        error_report("tpm-emulator: could not set state blob type %d : %=
s",
+                     type, strerror(errno));
+        return -1;
+    }
+
+    /* now the body */
+    n =3D qemu_chr_fe_write_all(&tpm_emu->ctrl_chr, tsb->buffer, tsb->si=
ze);
+    if (n !=3D tsb->size) {
+        error_report("tpm-emulator: Writing the stateblob (type %d) "
+                     "failed; could not write %u bytes, but only %zd",
+                     type, tsb->size, n);
+        return -1;
+    }
+
+    /* now get the result */
+    n =3D qemu_chr_fe_read_all(&tpm_emu->ctrl_chr,
+                             (uint8_t *)&pss, sizeof(pss.u.resp));
+    if (n !=3D sizeof(pss.u.resp)) {
+        error_report("tpm-emulator: Reading response from writing stateb=
lob "
+                     "(type %d) failed; expected %zu bytes, got %zd", ty=
pe,
+                     sizeof(pss.u.resp), n);
+        return -1;
+    }
+
+    tpm_result =3D be32_to_cpu(pss.u.resp.tpm_result);
+    if (tpm_result !=3D 0) {
+        error_report("tpm-emulator: Setting the stateblob (type %d) fail=
ed "
+                     "with a TPM error 0x%x", type, tpm_result);
+        return -1;
+    }
+
+    trace_tpm_emulator_set_state_blob(type, tsb->size, flags);
+
+    return 0;
+}
+
+/*
+ * Set all the TPM state blobs.
+ *
+ * Returns a negative errno code in case of error.
+ */
+static int tpm_emulator_set_state_blobs(TPMBackend *tb)
+{
+    TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
+    TPMBlobBuffers *state_blobs =3D &tpm_emu->state_blobs;
+
+    trace_tpm_emulator_set_state_blobs();
+
+    if (tpm_emulator_stop_tpm(tb) < 0) {
+        trace_tpm_emulator_set_state_blobs_error("Could not stop TPM");
+        return -EIO;
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
+        return -EIO;
+    }
+
+    trace_tpm_emulator_set_state_blobs_done();
+
+    return 0;
+}
+
+static int tpm_emulator_pre_save(void *opaque)
+{
+    TPMBackend *tb =3D opaque;
+    TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
+
+    trace_tpm_emulator_pre_save();
+
+    tpm_backend_finish_sync(tb);
+
+    /* get the state blobs from the TPM */
+    return tpm_emulator_get_state_blobs(tpm_emu);
+}
+
+/*
+ * Load the TPM state blobs into the TPM.
+ *
+ * Returns negative errno codes in case of error.
+ */
+static int tpm_emulator_post_load(void *opaque, int version_id)
+{
+    TPMBackend *tb =3D opaque;
+    int ret;
+
+    ret =3D tpm_emulator_set_state_blobs(tb);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (tpm_emulator_startup_tpm_resume(tb, 0, true) < 0) {
+        return -EIO;
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_tpm_emulator =3D {
+    .name =3D "tpm-emulator",
+    .version_id =3D 0,
+    .pre_save =3D tpm_emulator_pre_save,
+    .post_load =3D tpm_emulator_post_load,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(state_blobs.permanent_flags, TPMEmulator),
+        VMSTATE_UINT32(state_blobs.permanent.size, TPMEmulator),
+        VMSTATE_VBUFFER_ALLOC_UINT32(state_blobs.permanent.buffer,
+                                     TPMEmulator, 0, 0,
+                                     state_blobs.permanent.size),
+
+        VMSTATE_UINT32(state_blobs.volatil_flags, TPMEmulator),
+        VMSTATE_UINT32(state_blobs.volatil.size, TPMEmulator),
+        VMSTATE_VBUFFER_ALLOC_UINT32(state_blobs.volatil.buffer,
+                                     TPMEmulator, 0, 0,
+                                     state_blobs.volatil.size),
+
+        VMSTATE_UINT32(state_blobs.savestate_flags, TPMEmulator),
+        VMSTATE_UINT32(state_blobs.savestate.size, TPMEmulator),
+        VMSTATE_VBUFFER_ALLOC_UINT32(state_blobs.savestate.buffer,
+                                     TPMEmulator, 0, 0,
+                                     state_blobs.savestate.size),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void tpm_emulator_inst_init(Object *obj)
 {
     TPMEmulator *tpm_emu =3D TPM_EMULATOR(obj);
@@ -579,6 +871,8 @@ static void tpm_emulator_inst_init(Object *obj)
     tpm_emu->options =3D g_new0(TPMEmulatorOptions, 1);
     tpm_emu->cur_locty_number =3D ~0;
     qemu_mutex_init(&tpm_emu->mutex);
+
+    vmstate_register(NULL, -1, &vmstate_tpm_emulator, obj);
 }
=20
 /*
@@ -600,6 +894,7 @@ static void tpm_emulator_shutdown(TPMEmulator *tpm_em=
u)
 static void tpm_emulator_inst_finalize(Object *obj)
 {
     TPMEmulator *tpm_emu =3D TPM_EMULATOR(obj);
+    TPMBlobBuffers *state_blobs =3D &tpm_emu->state_blobs;
=20
     tpm_emulator_shutdown(tpm_emu);
=20
@@ -614,7 +909,13 @@ static void tpm_emulator_inst_finalize(Object *obj)
         error_free(tpm_emu->migration_blocker);
     }
=20
+    tpm_sized_buffer_reset(&state_blobs->volatil);
+    tpm_sized_buffer_reset(&state_blobs->permanent);
+    tpm_sized_buffer_reset(&state_blobs->savestate);
+
     qemu_mutex_destroy(&tpm_emu->mutex);
+
+    vmstate_unregister(NULL, &vmstate_tpm_emulator, obj);
 }
=20
 static void tpm_emulator_class_init(ObjectClass *klass, void *data)
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 9a65384088..c5bfbf1d4b 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -20,13 +20,19 @@ tpm_emulator_set_locality(uint8_t locty) "setting loc=
ality to %d"
 tpm_emulator_handle_request(void) "processing TPM command"
 tpm_emulator_probe_caps(uint64_t caps) "capabilities: 0x%"PRIx64
 tpm_emulator_set_buffer_size(uint32_t buffersize, uint32_t minsize, uint=
32_t maxsize) "buffer size: %u, min: %u, max: %u"
-tpm_emulator_startup_tpm(void) "startup"
+tpm_emulator_startup_tpm_resume(bool is_resume, size_t buffersize) "is_r=
esume: %d, buffer size: %zu"
 tpm_emulator_get_tpm_established_flag(uint8_t flag) "got established fla=
g: %d"
 tpm_emulator_cancel_cmd_not_supt(void) "Backend does not support CANCEL_=
TPM_CMD"
 tpm_emulator_handle_device_opts_tpm12(void) "TPM Version 1.2"
 tpm_emulator_handle_device_opts_tpm2(void) "TPM Version 2"
 tpm_emulator_handle_device_opts_unspec(void) "TPM Version Unspecified"
 tpm_emulator_handle_device_opts_startup_error(void) "Startup error"
+tpm_emulator_get_state_blob(uint8_t type, uint32_t size, uint32_t flags)=
 "got state blob type %d, %u bytes, flags 0x%08x"
+tpm_emulator_set_state_blob(uint8_t type, uint32_t size, uint32_t flags)=
 "set state blob type %d, %u bytes, flags 0x%08x"
+tpm_emulator_set_state_blobs(void) "setting state blobs"
+tpm_emulator_set_state_blobs_error(const char *msg) "error while setting=
 state blobs: %s"
+tpm_emulator_set_state_blobs_done(void) "Done setting state blobs"
+tpm_emulator_pre_save(void) ""
 tpm_emulator_inst_init(void) ""
=20
 # hw/tpm/tpm_tis.c
--=20
2.14.3
