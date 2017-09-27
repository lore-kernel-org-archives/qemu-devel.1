Received: from eggs.gnu.org ([2001:4830:134:3::10]:39040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dxBHW-0000FM-0E
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dxBHN-0001YS-8b
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:17:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:10314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1dxBHM-0001Xn-Me
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:17:29 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Wed, 27 Sep 2017 15:18:07 +0300
Message-Id: <1506514687-30506-1-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <CAJ+F1CKrNWcJhpsyxa8ENKfJzaSi=wz5-s+LV06K8o7xUsgdeA@mail.gmail.com>
References: <CAJ+F1CKrNWcJhpsyxa8ENKfJzaSi=wz5-s+LV06K8o7xUsgdeA@mail.gmail.com>
Subject: [Qemu-devel] [PATCH v8 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Amarnath Valluri <amarnath.valluri@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This change introduces a new TPM backend driver that can communicate with
swtpm(software TPM emulator) using unix domain socket interface. QEMU talks to
TPM emulator using QEMU's socket-based chardev backend device.

Swtpm uses two Unix sockets for communications, one for plain TPM commands and
responses, and one for out-of-band control messages. QEMU passes data socket to
be used over the control channel.

The swtpm and associated tools can be found here:
    https://github.com/stefanberger/swtpm

The swtpm's control channel protocol specification can be found here:
    https://github.com/stefanberger/swtpm/wiki/Control-Channel-Specification

Usage:
    # setup TPM state directory
    mkdir /tmp/mytpm
    chown -R tss:root /tmp/mytpm
    /usr/bin/swtpm_setup --tpm-state /tmp/mytpm --createek

    # Ask qemu to use TPM emulator with given tpm state directory
    qemu-system-x86_64 \
        [...] \
        -chardev socket,id=chrtpm,path=/tmp/swtpm-sock \
        -tpmdev emulator,id=tpm0,chardev=chrtpm \
        -device tpm-tis,tpmdev=tpm0 \
        [...]

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
---
 configure             |  13 +-
 hmp.c                 |   5 +
 hw/tpm/Makefile.objs  |   1 +
 hw/tpm/tpm_emulator.c | 613 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/tpm/tpm_ioctl.h    | 246 ++++++++++++++++++++
 qapi/tpm.json         |  21 +-
 qemu-options.hx       |  22 +-
 vl.c                  |   1 +
 8 files changed, 915 insertions(+), 7 deletions(-)
 create mode 100644 hw/tpm/tpm_emulator.c
 create mode 100644 hw/tpm/tpm_ioctl.h

diff --git a/configure b/configure
index cb0f7ed..a1b956e 100755
--- a/configure
+++ b/configure
@@ -3467,6 +3467,12 @@ else
   tpm_passthrough=no
 fi
 
+# TPM emulator is for all posix systems
+if test "$mingw32" != "yes"; then
+  tpm_emulator=$tpm
+else
+  tpm_emulator=no
+fi
 ##########################################
 # attr probe
 
@@ -5359,6 +5365,7 @@ echo "gcov enabled      $gcov"
 echo "TPM support       $tpm"
 echo "libssh2 support   $libssh2"
 echo "TPM passthrough   $tpm_passthrough"
+echo "TPM emulator      $tpm_emulator"
 echo "QOM debugging     $qom_cast_debug"
 echo "Live block migration $live_block_migration"
 echo "lzo support       $lzo"
@@ -5937,12 +5944,16 @@ if test "$live_block_migration" = "yes" ; then
   echo "CONFIG_LIVE_BLOCK_MIGRATION=y" >> $config_host_mak
 fi
 
-# TPM passthrough support?
 if test "$tpm" = "yes"; then
   echo 'CONFIG_TPM=$(CONFIG_SOFTMMU)' >> $config_host_mak
+  # TPM passthrough support?
   if test "$tpm_passthrough" = "yes"; then
     echo "CONFIG_TPM_PASSTHROUGH=y" >> $config_host_mak
   fi
+  # TPM emulator support?
+  if test "$tpm_emulator" = "yes"; then
+    echo "CONFIG_TPM_EMULATOR=y" >> $config_host_mak
+  fi
 fi
 
 echo "TRACE_BACKENDS=$trace_backends" >> $config_host_mak
diff --git a/hmp.c b/hmp.c
index 0fb2bc7..9cd8179 100644
--- a/hmp.c
+++ b/hmp.c
@@ -994,6 +994,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
     Error *err = NULL;
     unsigned int c = 0;
     TPMPassthroughOptions *tpo;
+    TPMEmulatorOptions *teo;
 
     info_list = qmp_query_tpm(&err);
     if (err) {
@@ -1023,6 +1024,10 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
                            tpo->has_cancel_path ? ",cancel-path=" : "",
                            tpo->has_cancel_path ? tpo->cancel_path : "");
             break;
+        case TPM_TYPE_OPTIONS_KIND_EMULATOR:
+            teo = ti->options->u.emulator.data;
+            monitor_printf(mon, ",chardev=%s", teo->chardev);
+            break;
         case TPM_TYPE_OPTIONS_KIND__MAX:
             break;
         }
diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
index 64cecc3..41f0b7a 100644
--- a/hw/tpm/Makefile.objs
+++ b/hw/tpm/Makefile.objs
@@ -1,2 +1,3 @@
 common-obj-$(CONFIG_TPM_TIS) += tpm_tis.o
 common-obj-$(CONFIG_TPM_PASSTHROUGH) += tpm_passthrough.o tpm_util.o
+common-obj-$(CONFIG_TPM_EMULATOR) += tpm_emulator.o tpm_util.o
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
new file mode 100644
index 0000000..f7ad0a7
--- /dev/null
+++ b/hw/tpm/tpm_emulator.c
@@ -0,0 +1,613 @@
+/*
+ *  Emulator TPM driver
+ *
+ *  Copyright (c) 2017 Intel Corporation
+ *  Author: Amarnath Valluri <amarnath.valluri@intel.com>
+ *
+ *  Copyright (c) 2010 - 2013 IBM Corporation
+ *  Authors:
+ *    Stefan Berger <stefanb@us.ibm.com>
+ *
+ *  Copyright (C) 2011 IAIK, Graz University of Technology
+ *    Author: Andreas Niederl
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/sockets.h"
+#include "io/channel-socket.h"
+#include "sysemu/tpm_backend.h"
+#include "tpm_int.h"
+#include "hw/hw.h"
+#include "hw/i386/pc.h"
+#include "tpm_util.h"
+#include "tpm_ioctl.h"
+#include "migration/blocker.h"
+#include "qapi/error.h"
+#include "qapi/clone-visitor.h"
+#include "chardev/char-fe.h"
+
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <stdio.h>
+
+#define DEBUG_TPM 0
+
+#define DPRINTF(fmt, ...) do { \
+    if (DEBUG_TPM) { \
+        fprintf(stderr, "tpm-emulator:"fmt"\n", ## __VA_ARGS__); \
+    } \
+} while (0)
+
+#define TYPE_TPM_EMULATOR "tpm-emulator"
+#define TPM_EMULATOR(obj) \
+    OBJECT_CHECK(TPMEmulator, (obj), TYPE_TPM_EMULATOR)
+
+#define TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(S, cap) (((S)->caps & (cap)) == (cap))
+
+static const TPMDriverOps tpm_emulator_driver;
+
+/* data structures */
+typedef struct TPMEmulator {
+    TPMBackend parent;
+
+    TPMEmulatorOptions *options;
+    CharBackend ctrl_chr;
+    QIOChannel *data_ioc;
+    TPMVersion tpm_version;
+    ptm_cap caps; /* capabilities of the TPM */
+    uint8_t cur_locty_number; /* last set locality */
+    QemuMutex state_lock;
+    Error *migration_blocker;
+} TPMEmulator;
+
+
+static int tpm_emulator_ctrlcmd(CharBackend *dev, unsigned long cmd, void *msg,
+                                size_t msg_len_in, size_t msg_len_out)
+{
+    uint32_t cmd_no = cpu_to_be32(cmd);
+    ssize_t n = sizeof(uint32_t) + msg_len_in;
+    uint8_t *buf = NULL;
+
+    buf = g_alloca(n);
+    memcpy(buf, &cmd_no, sizeof(cmd_no));
+    memcpy(buf + sizeof(cmd_no), msg, msg_len_in);
+
+    n = qemu_chr_fe_write_all(dev, buf, n);
+    if (n <= 0) {
+        return -1;
+    }
+
+    /* return if no reply expected */
+    if (msg_len_out <= 0) {
+        return 0;
+    }
+
+    n = qemu_chr_fe_read_all(dev, msg, msg_len_out);
+    if (n < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
+                                     const uint8_t *in, uint32_t in_len,
+                                     uint8_t *out, uint32_t out_len,
+                                     bool *selftest_done)
+{
+    ssize_t ret;
+    bool is_selftest = false;
+    const struct tpm_resp_hdr *hdr = NULL;
+    Error *err = NULL;
+
+    if (selftest_done) {
+        *selftest_done = false;
+        is_selftest = tpm_util_is_selftest(in, in_len);
+    }
+
+    ret = qio_channel_write_all(tpm_emu->data_ioc, (char *)in, in_len, &err);
+    if (ret != 0) {
+        if (err) {
+            error_prepend(&err, "tpm-emulator: error while transmitting data:");
+        } else {
+            error_report("tpm-emulator: Unknown error while transmitting data");
+        }
+
+        goto err_exit;
+    }
+
+    ret = qio_channel_read(tpm_emu->data_ioc, (char *)out, out_len, &err);
+    if (ret < 0) {
+        if (err) {
+            error_prepend(&err, "tpm-emulator: error while reading data:");
+        } else {
+            error_report("tpm-emulator: Unknown error while reading data");
+        }
+    } else if (ret >= sizeof(*hdr)) {
+        hdr = (struct tpm_resp_hdr *)out;
+    }
+
+    if (!hdr || be32_to_cpu(hdr->len) != ret) {
+        error_report("tpm-emulator: received invalid response "
+                     "packet from TPM with length :%ld", ret);
+        ret = -1;
+        goto err_exit;
+    }
+
+    if (is_selftest) {
+        *selftest_done = (be32_to_cpu(hdr->errcode) == 0);
+    }
+
+    return 0;
+
+err_exit:
+    if (ret < 0) {
+        tpm_util_write_fatal_error_response(out, out_len);
+    }
+
+    return ret;
+}
+
+static int tpm_emulator_set_locality(TPMEmulator *tpm_emu, uint8_t locty_number)
+{
+    ptm_loc loc;
+
+    DPRINTF("%s : locality: 0x%x", __func__, locty_number);
+
+    if (tpm_emu->cur_locty_number == locty_number) {
+        return 0;
+    }
+
+    DPRINTF("setting locality : 0x%x", locty_number);
+    loc.u.req.loc = locty_number;
+    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_SET_LOCALITY, &loc,
+                             sizeof(loc), sizeof(loc)) < 0) {
+        error_report("tpm-emulator: could not set locality : %s",
+                     strerror(errno));
+        return -1;
+    }
+
+    loc.u.resp.tpm_result = be32_to_cpu(loc.u.resp.tpm_result);
+    if (loc.u.resp.tpm_result != 0) {
+        error_report("tpm-emulator: TPM result for set locality : 0x%x",
+                     loc.u.resp.tpm_result);
+        return -1;
+    }
+
+    tpm_emu->cur_locty_number = locty_number;
+
+    return 0;
+}
+
+static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd cmd)
+{
+    TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
+    TPMLocality *locty = NULL;
+    bool selftest_done = false;
+
+    DPRINTF("processing command type %d", cmd);
+
+    switch (cmd) {
+    case TPM_BACKEND_CMD_PROCESS_CMD:
+        qemu_mutex_lock(&tpm_emu->state_lock);
+        locty = tb->tpm_state->locty_data;
+        if (tpm_emulator_set_locality(tpm_emu,
+                                      tb->tpm_state->locty_number) < 0) {
+            tpm_util_write_fatal_error_response(locty->r_buffer.buffer,
+                                                locty->r_buffer.size);
+        } else {
+            tpm_emulator_unix_tx_bufs(tpm_emu, locty->w_buffer.buffer,
+                                              locty->w_offset,
+                                              locty->r_buffer.buffer,
+                                              locty->r_buffer.size,
+                                              &selftest_done);
+        }
+
+        tb->recv_data_callback(tb->tpm_state, tb->tpm_state->locty_number,
+                               selftest_done);
+        qemu_mutex_unlock(&tpm_emu->state_lock);
+
+        break;
+    case TPM_BACKEND_CMD_INIT:
+    case TPM_BACKEND_CMD_END:
+    case TPM_BACKEND_CMD_TPM_RESET:
+        /* nothing to do */
+        break;
+    }
+}
+
+static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
+{
+    DPRINTF("%s", __func__);
+    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_GET_CAPABILITY,
+                         &tpm_emu->caps, 0, sizeof(tpm_emu->caps)) < 0) {
+        error_report("tpm-emulator: probing failed : %s", strerror(errno));
+        return -1;
+    }
+
+    tpm_emu->caps = be64_to_cpu(tpm_emu->caps);
+
+    DPRINTF("capbilities : 0x%lx", tpm_emu->caps);
+
+    return 0;
+}
+
+static int tpm_emulator_check_caps(TPMEmulator *tpm_emu)
+{
+    ptm_cap caps = 0;
+    const char *tpm = NULL;
+
+    /* check for min. required capabilities */
+    switch (tpm_emu->tpm_version) {
+    case TPM_VERSION_1_2:
+        caps = PTM_CAP_INIT | PTM_CAP_SHUTDOWN | PTM_CAP_GET_TPMESTABLISHED |
+               PTM_CAP_SET_LOCALITY | PTM_CAP_SET_DATAFD;
+        tpm = "1.2";
+        break;
+    case TPM_VERSION_2_0:
+        caps = PTM_CAP_INIT | PTM_CAP_SHUTDOWN | PTM_CAP_GET_TPMESTABLISHED |
+               PTM_CAP_SET_LOCALITY | PTM_CAP_RESET_TPMESTABLISHED |
+               PTM_CAP_SET_DATAFD;
+        tpm = "2";
+        break;
+    case TPM_VERSION_UNSPEC:
+        error_report("tpm-emulator: TPM version has not been set");
+        return -1;
+    }
+
+    if (!TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(tpm_emu, caps)) {
+        error_report("tpm-emulator: TPM does not implement minimum set of "
+                     "required capabilities for TPM %s (0x%x)", tpm, (int)caps);
+        return -1;
+    }
+
+    return 0;
+}
+
+static int tpm_emulator_startup_tpm(TPMBackend *tb)
+{
+    TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
+    ptm_init init;
+    ptm_res res;
+
+    DPRINTF("%s", __func__);
+    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_INIT, &init, sizeof(init),
+                         sizeof(init)) < 0) {
+        error_report("tpm-emulator: could not send INIT: %s",
+                     strerror(errno));
+        goto err_exit;
+    }
+
+    res = be32_to_cpu(init.u.resp.tpm_result);
+    if (res) {
+        error_report("tpm-emulator: TPM result for CMD_INIT: 0x%x", res);
+        goto err_exit;
+    }
+    return 0;
+
+err_exit:
+    return -1;
+}
+
+static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
+{
+    TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
+    ptm_est est;
+
+    DPRINTF("%s", __func__);
+    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_GET_TPMESTABLISHED, &est,
+                             0, sizeof(est)) < 0) {
+        error_report("tpm-emulator: Could not get the TPM established flag: %s",
+                     strerror(errno));
+        return false;
+    }
+    DPRINTF("established flag: %0x", est.u.resp.bit);
+
+    return (est.u.resp.bit != 0);
+}
+
+static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
+                                                   uint8_t locty)
+{
+    TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
+    ptm_reset_est reset_est;
+    ptm_res res;
+
+    /* only a TPM 2.0 will support this */
+    if (tpm_emu->tpm_version != TPM_VERSION_2_0) {
+        return 0;
+    }
+
+    reset_est.u.req.loc = tpm_emu->cur_locty_number;
+    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_RESET_TPMESTABLISHED,
+                             &reset_est, sizeof(reset_est),
+                             sizeof(reset_est)) < 0) {
+        error_report("tpm-emulator: Could not reset the establishment bit: %s",
+                     strerror(errno));
+        return -1;
+    }
+
+    res = be32_to_cpu(reset_est.u.resp.tpm_result);
+    if (res) {
+        error_report("tpm-emulator: TPM result for rest establixhed flag: 0x%x",
+                     res);
+        return -1;
+    }
+
+    return 0;
+}
+
+static void tpm_emulator_cancel_cmd(TPMBackend *tb)
+{
+    TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
+    ptm_res res;
+
+    if (!TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(tpm_emu, PTM_CAP_CANCEL_TPM_CMD)) {
+        DPRINTF("Backend does not support CANCEL_TPM_CMD");
+        return;
+    }
+
+    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_CANCEL_TPM_CMD, &res, 0,
+                             sizeof(res)) < 0) {
+        error_report("tpm-emulator: Could not cancel command: %s",
+                     strerror(errno));
+    } else if (res != 0) {
+        error_report("tpm-emulator: Failed to cancel TPM: 0x%x",
+                     be32_to_cpu(res));
+    }
+}
+
+static TPMVersion tpm_emulator_get_tpm_version(TPMBackend *tb)
+{
+    TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
+
+    return tpm_emu->tpm_version;
+}
+
+static int tpm_emulator_block_migration(TPMEmulator *tpm_emu)
+{
+    Error *err = NULL;
+
+    error_setg(&tpm_emu->migration_blocker,
+               "Migration disabled: TPM emulator not yet migratable");
+    migrate_add_blocker(tpm_emu->migration_blocker, &err);
+    if (err) {
+        error_report_err(err);
+        error_free(tpm_emu->migration_blocker);
+        tpm_emu->migration_blocker = NULL;
+
+        return -1;
+    }
+
+    return 0;
+}
+
+static int tpm_emulator_prepare_data_fd(TPMEmulator *tpm_emu)
+{
+    ptm_res res;
+    Error *err = NULL;
+    int fds[2] = { -1, -1 };
+
+    if (socketpair(AF_UNIX, SOCK_SEQPACKET, 0, fds) < 0) {
+        error_report("tpm-emulator: Failed to create socketpair");
+        return -1;
+    }
+
+    qemu_chr_fe_set_msgfds(&tpm_emu->ctrl_chr, fds + 1, 1);
+
+    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_SET_DATAFD, &res, 0,
+                    sizeof(res)) || res != 0) {
+        error_report("tpm-emulator: Failed to send CMD_SET_DATAFD: %s",
+                     strerror(errno));
+        goto err_exit;
+    }
+
+    tpm_emu->data_ioc = QIO_CHANNEL(qio_channel_socket_new_fd(fds[0], &err));
+    if (err) {
+        error_prepend(&err, "tpm-emulator: Failed to create io channel: ");
+        goto err_exit;
+    }
+
+    closesocket(fds[1]);
+
+    return 0;
+
+err_exit:
+    closesocket(fds[0]);
+    closesocket(fds[1]);
+    return -1;
+}
+
+static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_emu, QemuOpts *opts)
+{
+    const char *value;
+
+    value = qemu_opt_get(opts, "chardev");
+    if (value) {
+        Error *err = NULL;
+        Chardev *dev = qemu_chr_find(value);
+
+        if (!dev) {
+            error_report("tpm-emulator: tpm chardev '%s' not found.", value);
+            goto err;
+        }
+
+        if (!qemu_chr_fe_init(&tpm_emu->ctrl_chr, dev, &err)) {
+            error_prepend(&err, "tpm-emulator: No valid chardev found at '%s':",
+                          value);
+            goto err;
+        }
+
+        tpm_emu->options->chardev = g_strdup(value);
+    }
+
+    if (tpm_emulator_prepare_data_fd(tpm_emu) < 0) {
+        goto err;
+    }
+
+    /* FIXME: tpm_util_test_tpmdev() accepts only on socket fd, as it also used
+     * by passthrough driver, which not yet using GIOChannel.
+     */
+    if (tpm_util_test_tpmdev(QIO_CHANNEL_SOCKET(tpm_emu->data_ioc)->fd,
+                             &tpm_emu->tpm_version)) {
+        error_report("'%s' is not emulating TPM device. Error: %s",
+                      tpm_emu->options->chardev, strerror(errno));
+        goto err;
+    }
+
+    DPRINTF("TPM Version %s", tpm_emu->tpm_version == TPM_VERSION_1_2 ? "1.2" :
+            (tpm_emu->tpm_version == TPM_VERSION_2_0 ?  "2.0" : "Unspecified"));
+
+    if (tpm_emulator_probe_caps(tpm_emu) ||
+        tpm_emulator_check_caps(tpm_emu)) {
+        goto err;
+    }
+
+    return tpm_emulator_block_migration(tpm_emu);
+
+err:
+    DPRINTF("Startup error");
+    return -1;
+}
+
+static TPMBackend *tpm_emulator_create(QemuOpts *opts, const char *id)
+{
+    TPMBackend *tb = TPM_BACKEND(object_new(TYPE_TPM_EMULATOR));
+
+    tb->id = g_strdup(id);
+
+    if (tpm_emulator_handle_device_opts(TPM_EMULATOR(tb), opts)) {
+        goto err_exit;
+    }
+
+    return tb;
+
+err_exit:
+    object_unref(OBJECT(tb));
+
+    return NULL;
+}
+
+static TpmTypeOptions *tpm_emulator_get_tpm_options(TPMBackend *tb)
+{
+    TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
+    TpmTypeOptions *options = g_new0(TpmTypeOptions, 1);
+
+    options->type = TPM_TYPE_OPTIONS_KIND_EMULATOR;
+    options->u.emulator.data = QAPI_CLONE(TPMEmulatorOptions, tpm_emu->options);
+
+    return options;
+}
+
+static const QemuOptDesc tpm_emulator_cmdline_opts[] = {
+    TPM_STANDARD_CMDLINE_OPTS,
+    {
+        .name = "chardev",
+        .type = QEMU_OPT_STRING,
+        .help = "Character device to use for out-of-band control messages",
+    },
+    { /* end of list */ },
+};
+
+static const TPMDriverOps tpm_emulator_driver = {
+    .type                     = TPM_TYPE_EMULATOR,
+    .opts                     = tpm_emulator_cmdline_opts,
+    .desc                     = "TPM emulator backend driver",
+
+    .create                   = tpm_emulator_create,
+    .startup_tpm              = tpm_emulator_startup_tpm,
+    .cancel_cmd               = tpm_emulator_cancel_cmd,
+    .get_tpm_established_flag = tpm_emulator_get_tpm_established_flag,
+    .reset_tpm_established_flag = tpm_emulator_reset_tpm_established_flag,
+    .get_tpm_version          = tpm_emulator_get_tpm_version,
+    .get_tpm_options          = tpm_emulator_get_tpm_options,
+};
+
+static void tpm_emulator_inst_init(Object *obj)
+{
+    TPMEmulator *tpm_emu = TPM_EMULATOR(obj);
+
+    DPRINTF("%s", __func__);
+    tpm_emu->options = g_new0(TPMEmulatorOptions, 1);
+    tpm_emu->cur_locty_number = ~0;
+    qemu_mutex_init(&tpm_emu->state_lock);
+}
+
+/*
+ * Gracefully shut down the external TPM
+ */
+static void tpm_emulator_shutdown(TPMEmulator *tpm_emu)
+{
+    ptm_res res;
+
+    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_SHUTDOWN, &res, 0,
+                             sizeof(res)) < 0) {
+        error_report("tpm-emulator: Could not cleanly shutdown the TPM: %s",
+                     strerror(errno));
+    } else if (res != 0) {
+        error_report("tpm-emulator: TPM result for sutdown: 0x%x",
+                     be32_to_cpu(res));
+    }
+}
+
+static void tpm_emulator_inst_finalize(Object *obj)
+{
+    TPMEmulator *tpm_emu = TPM_EMULATOR(obj);
+
+    tpm_emulator_shutdown(tpm_emu);
+
+    if (tpm_emu->data_ioc) {
+        qio_channel_close(tpm_emu->data_ioc, NULL);
+    }
+
+    qemu_chr_fe_deinit(&tpm_emu->ctrl_chr, false);
+
+    if (tpm_emu->options) {
+        qapi_free_TPMEmulatorOptions(tpm_emu->options);
+    }
+
+    if (tpm_emu->migration_blocker) {
+        migrate_del_blocker(tpm_emu->migration_blocker);
+        error_free(tpm_emu->migration_blocker);
+    }
+}
+
+static void tpm_emulator_class_init(ObjectClass *klass, void *data)
+{
+    TPMBackendClass *tbc = TPM_BACKEND_CLASS(klass);
+    tbc->ops = &tpm_emulator_driver;
+    tbc->handle_request = tpm_emulator_handle_request;
+}
+
+static const TypeInfo tpm_emulator_info = {
+    .name = TYPE_TPM_EMULATOR,
+    .parent = TYPE_TPM_BACKEND,
+    .instance_size = sizeof(TPMEmulator),
+    .class_init = tpm_emulator_class_init,
+    .instance_init = tpm_emulator_inst_init,
+    .instance_finalize = tpm_emulator_inst_finalize,
+};
+
+static void tpm_emulator_register(void)
+{
+    type_register_static(&tpm_emulator_info);
+    tpm_register_driver(&tpm_emulator_driver);
+}
+
+type_init(tpm_emulator_register)
diff --git a/hw/tpm/tpm_ioctl.h b/hw/tpm/tpm_ioctl.h
new file mode 100644
index 0000000..33564b1
--- /dev/null
+++ b/hw/tpm/tpm_ioctl.h
@@ -0,0 +1,246 @@
+/*
+ * tpm_ioctl.h
+ *
+ * (c) Copyright IBM Corporation 2014, 2015.
+ *
+ * This file is licensed under the terms of the 3-clause BSD license
+ */
+#ifndef _TPM_IOCTL_H_
+#define _TPM_IOCTL_H_
+
+#include <stdint.h>
+#include <sys/uio.h>
+#include <sys/types.h>
+#include <sys/ioctl.h>
+
+/*
+ * Every response from a command involving a TPM command execution must hold
+ * the ptm_res as the first element.
+ * ptm_res corresponds to the error code of a command executed by the TPM.
+ */
+
+typedef uint32_t ptm_res;
+
+/* PTM_GET_TPMESTABLISHED: get the establishment bit */
+struct ptm_est {
+    union {
+        struct {
+            ptm_res tpm_result;
+            unsigned char bit; /* TPM established bit */
+        } resp; /* response */
+    } u;
+};
+
+/* PTM_RESET_TPMESTABLISHED: reset establishment bit */
+struct ptm_reset_est {
+    union {
+        struct {
+            uint8_t loc; /* locality to use */
+        } req; /* request */
+        struct {
+            ptm_res tpm_result;
+        } resp; /* response */
+    } u;
+};
+
+/* PTM_INIT */
+struct ptm_init {
+    union {
+        struct {
+            uint32_t init_flags; /* see definitions below */
+        } req; /* request */
+        struct {
+            ptm_res tpm_result;
+        } resp; /* response */
+    } u;
+};
+
+/* above init_flags */
+#define PTM_INIT_FLAG_DELETE_VOLATILE (1 << 0)
+    /* delete volatile state file after reading it */
+
+/* PTM_SET_LOCALITY */
+struct ptm_loc {
+    union {
+        struct {
+            uint8_t loc; /* locality to set */
+        } req; /* request */
+        struct {
+            ptm_res tpm_result;
+        } resp; /* response */
+    } u;
+};
+
+/* PTM_HASH_DATA: hash given data */
+struct ptm_hdata {
+    union {
+        struct {
+            uint32_t length;
+            uint8_t data[4096];
+        } req; /* request */
+        struct {
+            ptm_res tpm_result;
+        } resp; /* response */
+    } u;
+};
+
+/*
+ * size of the TPM state blob to transfer; x86_64 can handle 8k,
+ * ppc64le only ~7k; keep the response below a 4k page size
+ */
+#define PTM_STATE_BLOB_SIZE (3 * 1024)
+
+/*
+ * The following is the data structure to get state blobs from the TPM.
+ * If the size of the state blob exceeds the PTM_STATE_BLOB_SIZE, multiple reads
+ * with this ioctl and with adjusted offset are necessary. All bytes
+ * must be transferred and the transfer is done once the last byte has been
+ * returned.
+ * It is possible to use the read() interface for reading the data; however, the
+ * first bytes of the state blob will be part of the response to the ioctl(); a
+ * subsequent read() is only necessary if the total length (totlength) exceeds
+ * the number of received bytes. seek() is not supported.
+ */
+struct ptm_getstate {
+    union {
+        struct {
+            uint32_t state_flags; /* may be: PTM_STATE_FLAG_DECRYPTED */
+            uint32_t type;        /* which blob to pull */
+            uint32_t offset;      /* offset from where to read */
+        } req; /* request */
+        struct {
+            ptm_res tpm_result;
+            uint32_t state_flags; /* may be: PTM_STATE_FLAG_ENCRYPTED */
+            uint32_t totlength;   /* total length that will be transferred */
+            uint32_t length;      /* number of bytes in following buffer */
+            uint8_t  data[PTM_STATE_BLOB_SIZE];
+        } resp; /* response */
+    } u;
+};
+
+/* TPM state blob types */
+#define PTM_BLOB_TYPE_PERMANENT  1
+#define PTM_BLOB_TYPE_VOLATILE   2
+#define PTM_BLOB_TYPE_SAVESTATE  3
+
+/* state_flags above : */
+#define PTM_STATE_FLAG_DECRYPTED     1 /* on input:  get decrypted state */
+#define PTM_STATE_FLAG_ENCRYPTED     2 /* on output: state is encrypted */
+
+/*
+ * The following is the data structure to set state blobs in the TPM.
+ * If the size of the state blob exceeds the PTM_STATE_BLOB_SIZE, multiple
+ * 'writes' using this ioctl are necessary. The last packet is indicated
+ * by the length being smaller than the PTM_STATE_BLOB_SIZE.
+ * The very first packet may have a length indicator of '0' enabling
+ * a write() with all the bytes from a buffer. If the write() interface
+ * is used, a final ioctl with a non-full buffer must be made to indicate
+ * that all data were transferred (a write with 0 bytes would not work).
+ */
+struct ptm_setstate {
+    union {
+        struct {
+            uint32_t state_flags; /* may be PTM_STATE_FLAG_ENCRYPTED */
+            uint32_t type;        /* which blob to set */
+            uint32_t length;      /* length of the data;
+                                     use 0 on the first packet to
+                                     transfer using write() */
+            uint8_t data[PTM_STATE_BLOB_SIZE];
+        } req; /* request */
+        struct {
+            ptm_res tpm_result;
+        } resp; /* response */
+    } u;
+};
+
+/*
+ * PTM_GET_CONFIG: Data structure to get runtime configuration information
+ * such as which keys are applied.
+ */
+struct ptm_getconfig {
+    union {
+        struct {
+            ptm_res tpm_result;
+            uint32_t flags;
+        } resp; /* response */
+    } u;
+};
+
+#define PTM_CONFIG_FLAG_FILE_KEY        0x1
+#define PTM_CONFIG_FLAG_MIGRATION_KEY   0x2
+
+
+typedef uint64_t ptm_cap;
+typedef struct ptm_est ptm_est;
+typedef struct ptm_reset_est ptm_reset_est;
+typedef struct ptm_loc ptm_loc;
+typedef struct ptm_hdata ptm_hdata;
+typedef struct ptm_init ptm_init;
+typedef struct ptm_getstate ptm_getstate;
+typedef struct ptm_setstate ptm_setstate;
+typedef struct ptm_getconfig ptm_getconfig;
+
+/* capability flags returned by PTM_GET_CAPABILITY */
+#define PTM_CAP_INIT               (1)
+#define PTM_CAP_SHUTDOWN           (1 << 1)
+#define PTM_CAP_GET_TPMESTABLISHED (1 << 2)
+#define PTM_CAP_SET_LOCALITY       (1 << 3)
+#define PTM_CAP_HASHING            (1 << 4)
+#define PTM_CAP_CANCEL_TPM_CMD     (1 << 5)
+#define PTM_CAP_STORE_VOLATILE     (1 << 6)
+#define PTM_CAP_RESET_TPMESTABLISHED (1 << 7)
+#define PTM_CAP_GET_STATEBLOB      (1 << 8)
+#define PTM_CAP_SET_STATEBLOB      (1 << 9)
+#define PTM_CAP_STOP               (1 << 10)
+#define PTM_CAP_GET_CONFIG         (1 << 11)
+#define PTM_CAP_SET_DATAFD         (1 << 12)
+
+enum {
+    PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),
+    PTM_INIT               = _IOWR('P', 1, ptm_init),
+    PTM_SHUTDOWN           = _IOR('P', 2, ptm_res),
+    PTM_GET_TPMESTABLISHED = _IOR('P', 3, ptm_est),
+    PTM_SET_LOCALITY       = _IOWR('P', 4, ptm_loc),
+    PTM_HASH_START         = _IOR('P', 5, ptm_res),
+    PTM_HASH_DATA          = _IOWR('P', 6, ptm_hdata),
+    PTM_HASH_END           = _IOR('P', 7, ptm_res),
+    PTM_CANCEL_TPM_CMD     = _IOR('P', 8, ptm_res),
+    PTM_STORE_VOLATILE     = _IOR('P', 9, ptm_res),
+    PTM_RESET_TPMESTABLISHED = _IOWR('P', 10, ptm_reset_est),
+    PTM_GET_STATEBLOB      = _IOWR('P', 11, ptm_getstate),
+    PTM_SET_STATEBLOB      = _IOWR('P', 12, ptm_setstate),
+    PTM_STOP               = _IOR('P', 13, ptm_res),
+    PTM_GET_CONFIG         = _IOR('P', 14, ptm_getconfig),
+    PTM_SET_DATAFD         = _IOR('P', 15, ptm_res),
+};
+
+/*
+ * Commands used by the non-CUSE TPMs
+ *
+ * All messages container big-endian data.
+ *
+ * The return messages only contain the 'resp' part of the unions
+ * in the data structures above. Besides that the limits in the
+ * buffers above (ptm_hdata:u.req.data and ptm_get_state:u.resp.data
+ * and ptm_set_state:u.req.data) are 0xffffffff.
+ */
+enum {
+    CMD_GET_CAPABILITY = 1,
+    CMD_INIT,
+    CMD_SHUTDOWN,
+    CMD_GET_TPMESTABLISHED,
+    CMD_SET_LOCALITY,
+    CMD_HASH_START,
+    CMD_HASH_DATA,
+    CMD_HASH_END,
+    CMD_CANCEL_TPM_CMD,
+    CMD_STORE_VOLATILE,
+    CMD_RESET_TPMESTABLISHED,
+    CMD_GET_STATEBLOB,
+    CMD_SET_STATEBLOB,
+    CMD_STOP,
+    CMD_GET_CONFIG,
+    CMD_SET_DATAFD
+};
+
+#endif /* _TPM_IOCTL_H */
diff --git a/qapi/tpm.json b/qapi/tpm.json
index e8b2d8d..7093f26 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -39,10 +39,12 @@
 # An enumeration of TPM types
 #
 # @passthrough: TPM passthrough type
+# @emulator: Software Emulator TPM type
+#            Since: 2.11
 #
 # Since: 1.5
 ##
-{ 'enum': 'TpmType', 'data': [ 'passthrough' ] }
+{ 'enum': 'TpmType', 'data': [ 'passthrough', 'emulator' ] }
 
 ##
 # @query-tpm-types:
@@ -56,7 +58,7 @@
 # Example:
 #
 # -> { "execute": "query-tpm-types" }
-# <- { "return": [ "passthrough" ] }
+# <- { "return": [ "passthrough", "emulator" ] }
 #
 ##
 { 'command': 'query-tpm-types', 'returns': ['TpmType'] }
@@ -77,16 +79,29 @@
                                              '*cancel-path' : 'str'} }
 
 ##
+# @TPMEmulatorOptions:
+#
+# Information about the TPM emulator type
+#
+# @chardev: Name of a unix socket chardev
+#
+# Since: 2.11
+##
+{ 'struct': 'TPMEmulatorOptions', 'data': { 'chardev' : 'str' } }
+
+##
 # @TpmTypeOptions:
 #
 # A union referencing different TPM backend types' configuration options
 #
 # @type: 'passthrough' The configuration options for the TPM passthrough type
+#        'emulator' The configuration options for TPM emulator backend type
 #
 # Since: 1.5
 ##
 { 'union': 'TpmTypeOptions',
-   'data': { 'passthrough' : 'TPMPassthroughOptions' } }
+   'data': { 'passthrough' : 'TPMPassthroughOptions',
+             'emulator': 'TPMEmulatorOptions' } }
 
 ##
 # @TPMInfo:
diff --git a/qemu-options.hx b/qemu-options.hx
index 77859a2..846b3fc 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3121,7 +3121,9 @@ DEF("tpmdev", HAS_ARG, QEMU_OPTION_tpmdev, \
     "-tpmdev passthrough,id=id[,path=path][,cancel-path=path]\n"
     "                use path to provide path to a character device; default is /dev/tpm0\n"
     "                use cancel-path to provide path to TPM's cancel sysfs entry; if\n"
-    "                not provided it will be searched for in /sys/class/misc/tpm?/device\n",
+    "                not provided it will be searched for in /sys/class/misc/tpm?/device\n"
+    "-tpmdev emulator,id=id,chardev=dev\n"
+    "                configure the TPM device using chardev backend\n",
     QEMU_ARCH_ALL)
 STEXI
 
@@ -3130,8 +3132,8 @@ The general form of a TPM device option is:
 
 @item -tpmdev @var{backend} ,id=@var{id} [,@var{options}]
 @findex -tpmdev
-Backend type must be:
-@option{passthrough}.
+Backend type must be either one of the following:
+@option{passthrough}, @option{emulator}.
 
 The specific backend type will determine the applicable options.
 The @code{-tpmdev} option creates the TPM backend and requires a
@@ -3181,6 +3183,20 @@ To create a passthrough TPM use the following two options:
 Note that the @code{-tpmdev} id is @code{tpm0} and is referenced by
 @code{tpmdev=tpm0} in the device option.
 
+@item -tpmdev emulator, id=@var{id}, chardev=@var{dev}
+
+(Linux-host only) Enable access to a TPM emulator using Unix domain socket based
+chardev backend.
+
+@option{chardev} specifies the unique ID of a character device backend that provides connection to the software TPM server.
+
+To create a TPM emulator backend device with chardev socket backend:
+@example
+
+-chardev socket,id=chrtpm,path=/tmp/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis,tpmdev=tpm0
+
+@end example
+
 @end table
 
 ETEXI
diff --git a/vl.c b/vl.c
index 9bb5058..ed86209 100644
--- a/vl.c
+++ b/vl.c
@@ -4893,6 +4893,7 @@ int main(int argc, char **argv, char **envp)
     res_free();
 
     /* vhost-user must be cleaned up before chardevs.  */
+    tpm_cleanup();
     net_cleanup();
     audio_cleanup();
     monitor_cleanup();
-- 
2.7.4
