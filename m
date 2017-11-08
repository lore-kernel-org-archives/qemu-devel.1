Received: from eggs.gnu.org ([2001:4830:134:3::10]:36801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCVcD-0000e6-Re
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCVcA-0000UW-QQ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:02:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eCVcA-0000TJ-HB
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:02:18 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA8J1hG9115020
	for <qemu-devel@nongnu.org>; Wed, 8 Nov 2017 14:02:13 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e45t6pfr1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 14:02:12 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 8 Nov 2017 12:02:11 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed,  8 Nov 2017 14:01:58 -0500
In-Reply-To: <1510167719-4357-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510167719-4357-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510167719-4357-5-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 4/5] tpm: tpm_emulator: get and set buffer
 size of device
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

Convert the tpm_emulator backend to get the current buffer size
of the external device and set it to the buffer size that the
frontend (TIS) requests.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c               |  4 +--
 hw/tpm/tpm_emulator.c        | 79 +++++++++++++++++++++++++++++++++++++++++---
 hw/tpm/tpm_ioctl.h           | 28 +++++++++++++++-
 hw/tpm/tpm_tis.c             |  6 ++--
 include/sysemu/tpm_backend.h |  6 ++--
 5 files changed, 111 insertions(+), 12 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index cb49185..91222c5 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -68,7 +68,7 @@ int tpm_backend_init(TPMBackend *s, TPMIf *tpmif, Error **errp)
     return 0;
 }
 
-int tpm_backend_startup_tpm(TPMBackend *s)
+int tpm_backend_startup_tpm(TPMBackend *s, size_t buffersize)
 {
     int res = 0;
     TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
@@ -79,7 +79,7 @@ int tpm_backend_startup_tpm(TPMBackend *s)
     s->thread_pool = g_thread_pool_new(tpm_backend_worker_thread, s, 1, TRUE,
                                        NULL);
 
-    res = k->startup_tpm ? k->startup_tpm(s) : 0;
+    res = k->startup_tpm ? k->startup_tpm(s, buffersize) : 0;
 
     s->had_startup_error = (res != 0);
 
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 44a769d..3ae8bf6 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -232,13 +232,14 @@ static int tpm_emulator_check_caps(TPMEmulator *tpm_emu)
     switch (tpm_emu->tpm_version) {
     case TPM_VERSION_1_2:
         caps = PTM_CAP_INIT | PTM_CAP_SHUTDOWN | PTM_CAP_GET_TPMESTABLISHED |
-               PTM_CAP_SET_LOCALITY | PTM_CAP_SET_DATAFD;
+               PTM_CAP_SET_LOCALITY | PTM_CAP_SET_DATAFD | PTM_CAP_STOP |
+               PTM_CAP_SET_BUFFERSIZE;
         tpm = "1.2";
         break;
     case TPM_VERSION_2_0:
         caps = PTM_CAP_INIT | PTM_CAP_SHUTDOWN | PTM_CAP_GET_TPMESTABLISHED |
                PTM_CAP_SET_LOCALITY | PTM_CAP_RESET_TPMESTABLISHED |
-               PTM_CAP_SET_DATAFD;
+               PTM_CAP_SET_DATAFD | PTM_CAP_STOP | PTM_CAP_SET_BUFFERSIZE;
         tpm = "2";
         break;
     case TPM_VERSION_UNSPEC:
@@ -255,12 +256,76 @@ static int tpm_emulator_check_caps(TPMEmulator *tpm_emu)
     return 0;
 }
 
-static int tpm_emulator_startup_tpm(TPMBackend *tb)
+static int tpm_emulator_stop_tpm(TPMBackend *tb)
+{
+    TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
+    ptm_res res;
+
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_STOP, &res, 0, sizeof(res)) < 0) {
+        error_report("tpm-emulator: Could not stop TPM: %s",
+                     strerror(errno));
+        return -1;
+    }
+
+    res = be32_to_cpu(res);
+    if (res) {
+        error_report("tpm-emulator: TPM result for CMD_STOP: 0x%x", res);
+        return -1;
+    }
+
+    return 0;
+}
+
+static int tpm_emulator_set_buffer_size(TPMBackend *tb,
+                                        size_t wanted_size,
+                                        size_t *actual_size)
+{
+    TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
+    ptm_setbuffersize psbs;
+
+    if (tpm_emulator_stop_tpm(tb) < 0) {
+        return -1;
+    }
+
+    psbs.u.req.buffersize = cpu_to_be32(wanted_size);
+
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_BUFFERSIZE, &psbs,
+                             sizeof(psbs.u.req), sizeof(psbs.u.resp)) < 0) {
+        error_report("tpm-emulator: Could not set buffer size: %s",
+                     strerror(errno));
+        return -1;
+    }
+
+    psbs.u.resp.tpm_result = be32_to_cpu(psbs.u.resp.tpm_result);
+    if (psbs.u.resp.tpm_result != 0) {
+        error_report("tpm-emulator: TPM result for set buffer size : 0x%x",
+                     psbs.u.resp.tpm_result);
+        return -1;
+    }
+
+    if (actual_size) {
+        *actual_size = be32_to_cpu(psbs.u.resp.buffersize);
+    }
+
+    DPRINTF("buffer size: %u, min: %u, max: %u\n",
+            be32_to_cpu(psbs.u.resp.buffersize),
+            be32_to_cpu(psbs.u.resp.minsize),
+            be32_to_cpu(psbs.u.resp.maxsize));
+
+    return 0;
+}
+
+static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     ptm_init init;
     ptm_res res;
 
+    if (buffersize != 0 &&
+        tpm_emulator_set_buffer_size(tb, buffersize, NULL) < 0) {
+        goto err_exit;
+    }
+
     DPRINTF("%s", __func__);
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_INIT, &init, sizeof(init),
                              sizeof(init)) < 0) {
@@ -358,7 +423,13 @@ static TPMVersion tpm_emulator_get_tpm_version(TPMBackend *tb)
 
 static size_t tpm_emulator_get_buffer_size(TPMBackend *tb)
 {
-    return 4096;
+    size_t actual_size;
+
+    if (tpm_emulator_set_buffer_size(tb, 0, &actual_size) < 0) {
+        return 4096;
+    }
+
+    return actual_size;
 }
 
 static int tpm_emulator_block_migration(TPMEmulator *tpm_emu)
diff --git a/hw/tpm/tpm_ioctl.h b/hw/tpm/tpm_ioctl.h
index 33564b1..54c8d34 100644
--- a/hw/tpm/tpm_ioctl.h
+++ b/hw/tpm/tpm_ioctl.h
@@ -169,6 +169,28 @@ struct ptm_getconfig {
 #define PTM_CONFIG_FLAG_FILE_KEY        0x1
 #define PTM_CONFIG_FLAG_MIGRATION_KEY   0x2
 
+/*
+ * PTM_SET_BUFFERSIZE: Set the buffer size to be used by the TPM.
+ * A 0 on input queries for the current buffer size. Any other
+ * number will try to set the buffer size. The returned number is
+ * the buffer size that will be used, which can be larger than the
+ * requested one, if it was below the minimum, or smaller than the
+ * requested one, if it was above the maximum.
+ */
+struct ptm_setbuffersize {
+    union {
+        struct {
+            uint32_t buffersize; /* 0 to query for current buffer size */
+        } req; /* request */
+        struct {
+            ptm_res tpm_result;
+            uint32_t buffersize; /* buffer size in use */
+            uint32_t minsize; /* min. supported buffer size */
+            uint32_t maxsize; /* max. supported buffer size */
+        } resp; /* response */
+    } u;
+};
+
 
 typedef uint64_t ptm_cap;
 typedef struct ptm_est ptm_est;
@@ -179,6 +201,7 @@ typedef struct ptm_init ptm_init;
 typedef struct ptm_getstate ptm_getstate;
 typedef struct ptm_setstate ptm_setstate;
 typedef struct ptm_getconfig ptm_getconfig;
+typedef struct ptm_setbuffersize ptm_setbuffersize;
 
 /* capability flags returned by PTM_GET_CAPABILITY */
 #define PTM_CAP_INIT               (1)
@@ -194,6 +217,7 @@ typedef struct ptm_getconfig ptm_getconfig;
 #define PTM_CAP_STOP               (1 << 10)
 #define PTM_CAP_GET_CONFIG         (1 << 11)
 #define PTM_CAP_SET_DATAFD         (1 << 12)
+#define PTM_CAP_SET_BUFFERSIZE     (1 << 13)
 
 enum {
     PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),
@@ -212,6 +236,7 @@ enum {
     PTM_STOP               = _IOR('P', 13, ptm_res),
     PTM_GET_CONFIG         = _IOR('P', 14, ptm_getconfig),
     PTM_SET_DATAFD         = _IOR('P', 15, ptm_res),
+    PTM_SET_BUFFERSIZE     = _IOWR('P', 16, ptm_setbuffersize),
 };
 
 /*
@@ -240,7 +265,8 @@ enum {
     CMD_SET_STATEBLOB,
     CMD_STOP,
     CMD_GET_CONFIG,
-    CMD_SET_DATAFD
+    CMD_SET_DATAFD,
+    CMD_SET_BUFFERSIZE,
 };
 
 #endif /* _TPM_IOCTL_H */
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index a1c8323..dd43630 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -974,9 +974,9 @@ static const MemoryRegionOps tpm_tis_memory_ops = {
     },
 };
 
-static int tpm_tis_do_startup_tpm(TPMState *s)
+static int tpm_tis_do_startup_tpm(TPMState *s, uint32_t buffersize)
 {
-    return tpm_backend_startup_tpm(s->be_driver);
+    return tpm_backend_startup_tpm(s->be_driver, buffersize);
 }
 
 static void tpm_tis_realloc_buffer(TPMSizedBuffer *sb,
@@ -1040,7 +1040,7 @@ static void tpm_tis_reset(DeviceState *dev)
         tpm_tis_realloc_buffer(&s->loc[c].r_buffer, s->be_buffer_size);
     }
 
-    tpm_tis_do_startup_tpm(s);
+    tpm_tis_do_startup_tpm(s, 0);
 }
 
 static const VMStateDescription vmstate_tpm_tis = {
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 7c98b61..0d6c994 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -66,7 +66,7 @@ struct TPMBackendClass {
     TPMBackend *(*create)(QemuOpts *opts);
 
     /* start up the TPM on the backend - optional */
-    int (*startup_tpm)(TPMBackend *t);
+    int (*startup_tpm)(TPMBackend *t, size_t buffersize);
 
     /* optional */
     void (*reset)(TPMBackend *t);
@@ -112,10 +112,12 @@ int tpm_backend_init(TPMBackend *s, TPMIf *tpmif, Error **errp);
 /**
  * tpm_backend_startup_tpm:
  * @s: the backend whose TPM support is to be started
+ * @buffersize: the buffer size the TPM is supposed to use,
+ *              0 to leave it as-is
  *
  * Returns 0 on success.
  */
-int tpm_backend_startup_tpm(TPMBackend *s);
+int tpm_backend_startup_tpm(TPMBackend *s, size_t buffersize);
 
 /**
  * tpm_backend_had_startup_error:
-- 
2.5.5
