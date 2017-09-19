Received: from eggs.gnu.org ([2001:4830:134:3::10]:45337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duFhz-00049s-J5
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duFhv-0004cN-Cl
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:24:51 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 12:24:33 +0200
Message-Id: <20170919102434.21147-4-pbonzini@redhat.com>
In-Reply-To: <20170919102434.21147-1-pbonzini@redhat.com>
References: <20170919102434.21147-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] scsi: add multipath support to
 qemu-pr-helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

Proper support of persistent reservation for multipath devices requires
communication with the multipath daemon, so that the reservation is
registered and applied when a path comes up.  The device mapper
utilities provide a library to do so; this patch makes qemu-pr-helper.c
detect multipath devices and, when one is found, delegate the operation
to libmpathpersist.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
v1->v2: moved dm_init/multipath_pr_init to this patch
        drop CAP_SYS_ADMIN if multipath not compiled in
        simplify buffer size handling in multipath PERSISTENT RESERVE IN
        block REGISTER AND MOVE operation for multipath PERSISTENT RESERVE OUT
        fixed transport id handling in multipath PERSISTENT RESERVE OUT

 Makefile              |   3 +
 configure             |  57 ++++++++-
 docs/pr-manager.rst   |  27 ++++
 include/scsi/utils.h  |   4 +
 scsi/qemu-pr-helper.c | 346 +++++++++++++++++++++++++++++++++++++++++++++++++-
 scsi/utils.c          |  10 ++
 6 files changed, 441 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 51503ee8ad..39ec5112b6 100644
--- a/Makefile
+++ b/Makefile
@@ -377,6 +377,9 @@ fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal
 fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap
 
 scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+ifdef CONFIG_MPATH
+scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
+endif
 
 qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
diff --git a/configure b/configure
index fba27cf0fc..bea343c701 100755
--- a/configure
+++ b/configure
@@ -290,6 +290,7 @@ netmap="no"
 sdl=""
 sdlabi=""
 virtfs=""
+mpath=""
 vnc="yes"
 sparse="no"
 vde=""
@@ -936,6 +937,10 @@ for opt do
   ;;
   --enable-virtfs) virtfs="yes"
   ;;
+  --disable-mpath) mpath="no"
+  ;;
+  --enable-mpath) mpath="yes"
+  ;;
   --disable-vnc) vnc="no"
   ;;
   --enable-vnc) vnc="yes"
@@ -1479,6 +1484,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   vnc-png         PNG compression for VNC server
   cocoa           Cocoa UI (Mac OS X only)
   virtfs          VirtFS
+  mpath           Multipath persistent reservation passthrough
   xen             xen backend driver support
   xen-pci-passthrough
   brlapi          BrlAPI (Braile)
@@ -3300,6 +3306,29 @@ else
 fi
 
 ##########################################
+# libmpathpersist probe
+
+if test "$mpath" != "no" ; then
+  cat > $TMPC <<EOF
+#include <libudev.h>
+#include <mpath_persist.h>
+unsigned mpath_mx_alloc_len = 1024;
+int logsink;
+int main(void) {
+    struct udev *udev = udev_new();
+    mpath_lib_init(udev);
+}
+EOF
+  if compile_prog "" "-ludev -lmultipath -lmpathpersist" ; then
+    mpathpersist=yes
+  else
+    mpathpersist=no
+  fi
+else
+  mpathpersist=no
+fi
+
+##########################################
 # libcap probe
 
 if test "$cap" != "no" ; then
@@ -5034,16 +5063,34 @@ if test "$want_tools" = "yes" ; then
   fi
 fi
 if test "$softmmu" = yes ; then
-  if test "$virtfs" != no ; then
-    if test "$cap" = yes && test "$linux" = yes && test "$attr" = yes ; then
+  if test "$linux" = yes; then
+    if test "$virtfs" != no && test "$cap" = yes && test "$attr" = yes ; then
       virtfs=yes
       tools="$tools fsdev/virtfs-proxy-helper\$(EXESUF)"
     else
       if test "$virtfs" = yes; then
-        error_exit "VirtFS is supported only on Linux and requires libcap devel and libattr devel"
+        error_exit "VirtFS requires libcap devel and libattr devel"
       fi
       virtfs=no
     fi
+    if test "$mpath" != no && test "$mpathpersist" = yes ; then
+      mpath=yes
+      tools="$tools mpath/qemu-mpath-helper\$(EXESUF)"
+    else
+      if test "$mpath" = yes; then
+        error_exit "Multipath requires libmpathpersist devel"
+      fi
+      mpath=no
+    fi
+  else
+    if test "$virtfs" = yes; then
+      error_exit "VirtFS is supported only on Linux"
+    fi
+    virtfs=no
+    if test "$mpath" = yes; then
+      error_exit "Multipath is supported only on Linux"
+    fi
+    mpath=no
   fi
 fi
 
@@ -5289,6 +5336,7 @@ echo "Audio drivers     $audio_drv_list"
 echo "Block whitelist (rw) $block_drv_rw_whitelist"
 echo "Block whitelist (ro) $block_drv_ro_whitelist"
 echo "VirtFS support    $virtfs"
+echo "Multipath support $mpath"
 echo "VNC support       $vnc"
 if test "$vnc" = "yes" ; then
     echo "VNC SASL support  $vnc_sasl"
@@ -5732,6 +5780,9 @@ fi
 if test "$virtfs" = "yes" ; then
   echo "CONFIG_VIRTFS=y" >> $config_host_mak
 fi
+if test "$mpath" = "yes" ; then
+  echo "CONFIG_MPATH=y" >> $config_host_mak
+fi
 if test "$vhost_scsi" = "yes" ; then
   echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
 fi
diff --git a/docs/pr-manager.rst b/docs/pr-manager.rst
index 7107e59fb8..9b1de198b1 100644
--- a/docs/pr-manager.rst
+++ b/docs/pr-manager.rst
@@ -60,6 +60,7 @@ system service and supports the following option:
 
 -d, --daemon              run in the background
 -q, --quiet               decrease verbosity
+-v, --verbose             increase verbosity
 -f, --pidfile=path        PID file when running as a daemon
 -k, --socket=path         path to the socket
 -T, --trace=trace-opts    tracing options
@@ -82,3 +83,29 @@ its operation.  To do this, add the following options:
 
 -u, --user=user           user to drop privileges to
 -g, --group=group         group to drop privileges to
+
+---------------------------------------------
+Multipath devices and persistent reservations
+---------------------------------------------
+
+Proper support of persistent reservation for multipath devices requires
+communication with the multipath daemon, so that the reservation is
+registered and applied when a path is newly discovered or becomes online
+again.  :command:`qemu-pr-helper` can do this if the ``libmpathpersist``
+library was available on the system at build time.
+
+As of August 2017, a reservation key must be specified in ``multipath.conf``
+for ``multipathd`` to check for persistent reservation for newly
+discovered paths or reinstated paths.  The attribute can be added
+to the ``defaults`` section or the ``multipaths`` section; for example::
+
+    multipaths {
+        multipath {
+            wwid   XXXXXXXXXXXXXXXX
+            alias      yellow
+            reservation_key  0x123abc
+        }
+    }
+
+Linking :program:`qemu-pr-helper` to ``libmpathpersist`` does not impede
+its usage on regular SCSI devices.
diff --git a/include/scsi/utils.h b/include/scsi/utils.h
index d301b31768..00a4bdb080 100644
--- a/include/scsi/utils.h
+++ b/include/scsi/utils.h
@@ -72,10 +72,14 @@ extern const struct SCSISense sense_code_IO_ERROR;
 extern const struct SCSISense sense_code_I_T_NEXUS_LOSS;
 /* Command aborted, Logical Unit failure */
 extern const struct SCSISense sense_code_LUN_FAILURE;
+/* Command aborted, LUN Communication failure */
+extern const struct SCSISense sense_code_LUN_COMM_FAILURE;
 /* Command aborted, Overlapped Commands Attempted */
 extern const struct SCSISense sense_code_OVERLAPPED_COMMANDS;
 /* LUN not ready, Capacity data has changed */
 extern const struct SCSISense sense_code_CAPACITY_CHANGED;
+/* Unit attention, SCSI bus reset */
+extern const struct SCSISense sense_code_SCSI_BUS_RESET;
 /* LUN not ready, Medium not present */
 extern const struct SCSISense sense_code_UNIT_ATTENTION_NO_MEDIUM;
 /* Unit attention, Power on, reset or bus device reset occurred */
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 9662ede753..3f08ab12b4 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -30,6 +30,12 @@
 #include <pwd.h>
 #include <grp.h>
 
+#ifdef CONFIG_MPATH
+#include <libudev.h>
+#include <mpath_cmd.h>
+#include <mpath_persist.h>
+#endif
+
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/cutils.h"
@@ -60,6 +66,7 @@ static enum { RUNNING, TERMINATE, TERMINATING } state;
 static QIOChannelSocket *server_ioc;
 static int server_watch;
 static int num_active_sockets = 1;
+static int noisy;
 static int verbose;
 
 #ifdef CONFIG_LIBCAP
@@ -171,9 +178,316 @@ static int do_sgio(int fd, const uint8_t *cdb, uint8_t *sense,
     return r;
 }
 
+/* Device mapper interface */
+
+#ifdef CONFIG_MPATH
+#define CONTROL_PATH "/dev/mapper/control"
+
+typedef struct DMData {
+    struct dm_ioctl dm;
+    uint8_t data[1024];
+} DMData;
+
+static int control_fd;
+
+static void *dm_ioctl(int ioc, struct dm_ioctl *dm)
+{
+    static DMData d;
+    memcpy(&d.dm, dm, sizeof(d.dm));
+    QEMU_BUILD_BUG_ON(sizeof(d.data) < sizeof(struct dm_target_spec));
+
+    d.dm.version[0] = DM_VERSION_MAJOR;
+    d.dm.version[1] = 0;
+    d.dm.version[2] = 0;
+    d.dm.data_size = 1024;
+    d.dm.data_start = offsetof(DMData, data);
+    if (ioctl(control_fd, ioc, &d) < 0) {
+        return NULL;
+    }
+    memcpy(dm, &d.dm, sizeof(d.dm));
+    return &d.data;
+}
+
+static void *dm_dev_ioctl(int fd, int ioc, struct dm_ioctl *dm)
+{
+    struct stat st;
+    int r;
+
+    r = fstat(fd, &st);
+    if (r < 0) {
+        perror("fstat");
+        exit(1);
+    }
+
+    dm->dev = st.st_rdev;
+    return dm_ioctl(ioc, dm);
+}
+
+static void dm_init(void)
+{
+    control_fd = open(CONTROL_PATH, O_RDWR);
+    if (control_fd < 0) {
+        perror("Cannot open " CONTROL_PATH);
+        exit(1);
+    }
+    struct dm_ioctl dm = { 0 };
+    if (!dm_ioctl(DM_VERSION, &dm)) {
+        perror("ioctl");
+        exit(1);
+    }
+    if (dm.version[0] != DM_VERSION_MAJOR) {
+        fprintf(stderr, "Unsupported device mapper interface");
+        exit(1);
+    }
+}
+
+/* Variables required by libmultipath and libmpathpersist.  */
+QEMU_BUILD_BUG_ON(PR_HELPER_DATA_SIZE > MPATH_MAX_PARAM_LEN);
+unsigned mpath_mx_alloc_len = PR_HELPER_DATA_SIZE;
+int logsink;
+
+static void multipath_pr_init(void)
+{
+    static struct udev *udev;
+
+    udev = udev_new();
+    mpath_lib_init(udev);
+}
+
+static int is_mpath(int fd)
+{
+    struct dm_ioctl dm = { .flags = DM_NOFLUSH_FLAG };
+    struct dm_target_spec *tgt;
+
+    tgt = dm_dev_ioctl(fd, DM_TABLE_STATUS, &dm);
+    if (!tgt) {
+        if (errno == ENXIO) {
+            return 0;
+        }
+        perror("ioctl");
+        exit(EXIT_FAILURE);
+    }
+    return !strncmp(tgt->target_type, "multipath", DM_MAX_TYPE_NAME);
+}
+
+static int mpath_reconstruct_sense(int fd, int r, uint8_t *sense)
+{
+    switch (r) {
+    case MPATH_PR_SUCCESS:
+        return GOOD;
+    case MPATH_PR_SENSE_NOT_READY:
+    case MPATH_PR_SENSE_MEDIUM_ERROR:
+    case MPATH_PR_SENSE_HARDWARE_ERROR:
+    case MPATH_PR_SENSE_ABORTED_COMMAND:
+        {
+            /* libmpathpersist ate the exact sense.  Try to find it by
+             * issuing TEST UNIT READY.
+             */
+            uint8_t cdb[6] = { TEST_UNIT_READY };
+            int sz = 0;
+            return do_sgio(fd, cdb, sense, NULL, &sz, SG_DXFER_NONE);
+        }
+
+    case MPATH_PR_SENSE_UNIT_ATTENTION:
+        /* Congratulations libmpathpersist, you ruined the Unit Attention...
+         * Return a heavyweight one.
+         */
+        scsi_build_sense(sense, SENSE_CODE(SCSI_BUS_RESET));
+        return CHECK_CONDITION;
+    case MPATH_PR_SENSE_INVALID_OP:
+        /* Only one valid sense.  */
+        scsi_build_sense(sense, SENSE_CODE(INVALID_OPCODE));
+        return CHECK_CONDITION;
+    case MPATH_PR_ILLEGAL_REQ:
+        /* Guess.  */
+        scsi_build_sense(sense, SENSE_CODE(INVALID_PARAM));
+        return CHECK_CONDITION;
+    case MPATH_PR_NO_SENSE:
+        scsi_build_sense(sense, SENSE_CODE(NO_SENSE));
+        return CHECK_CONDITION;
+
+    case MPATH_PR_RESERV_CONFLICT:
+        return RESERVATION_CONFLICT;
+
+    case MPATH_PR_OTHER:
+    default:
+        scsi_build_sense(sense, SENSE_CODE(LUN_COMM_FAILURE));
+        return CHECK_CONDITION;
+    }
+}
+
+static int multipath_pr_in(int fd, const uint8_t *cdb, uint8_t *sense,
+                           uint8_t *data, int sz)
+{
+    int rq_servact = cdb[1];
+    struct prin_resp resp;
+    size_t written;
+    int r;
+
+    switch (rq_servact) {
+    case MPATH_PRIN_RKEY_SA:
+    case MPATH_PRIN_RRES_SA:
+    case MPATH_PRIN_RCAP_SA:
+        break;
+    case MPATH_PRIN_RFSTAT_SA:
+        /* Nobody implements it anyway, so bail out. */
+    default:
+        /* Cannot parse any other output.  */
+        scsi_build_sense(sense, SENSE_CODE(INVALID_FIELD));
+        return CHECK_CONDITION;
+    }
+
+    r = mpath_persistent_reserve_in(fd, rq_servact, &resp, noisy, verbose);
+    if (r == MPATH_PR_SUCCESS) {
+        switch (rq_servact) {
+        case MPATH_PRIN_RKEY_SA:
+        case MPATH_PRIN_RRES_SA: {
+            struct prin_readdescr *out = &resp.prin_descriptor.prin_readkeys;
+            assert(sz >= 8);
+            written = MIN(out->additional_length + 8, sz);
+            stl_be_p(&data[0], out->prgeneration);
+            stl_be_p(&data[4], out->additional_length);
+            memcpy(&data[8], out->key_list, written - 8);
+            break;
+        }
+        case MPATH_PRIN_RCAP_SA: {
+            struct prin_capdescr *out = &resp.prin_descriptor.prin_readcap;
+            assert(sz >= 6);
+            written = 6;
+            stw_be_p(&data[0], out->length);
+            data[2] = out->flags[0];
+            data[3] = out->flags[1];
+            stw_be_p(&data[4], out->pr_type_mask);
+            break;
+        }
+        default:
+            scsi_build_sense(sense, SENSE_CODE(INVALID_OPCODE));
+            return CHECK_CONDITION;
+        }
+        assert(written <= sz);
+        memset(data + written, 0, sz - written);
+    }
+
+    return mpath_reconstruct_sense(fd, r, sense);
+}
+
+static int multipath_pr_out(int fd, const uint8_t *cdb, uint8_t *sense,
+                            const uint8_t *param, int sz)
+{
+    int rq_servact = cdb[1];
+    int rq_scope = cdb[2] >> 4;
+    int rq_type = cdb[2] & 0xf;
+    struct prout_param_descriptor paramp;
+    char transportids[PR_HELPER_DATA_SIZE];
+    int r;
+
+    switch (rq_servact) {
+    case MPATH_PROUT_REG_SA:
+    case MPATH_PROUT_RES_SA:
+    case MPATH_PROUT_REL_SA:
+    case MPATH_PROUT_CLEAR_SA:
+    case MPATH_PROUT_PREE_SA:
+    case MPATH_PROUT_PREE_AB_SA:
+    case MPATH_PROUT_REG_IGN_SA:
+        break;
+    case MPATH_PROUT_REG_MOV_SA:
+        /* Not supported by struct prout_param_descriptor.  */
+    default:
+        /* Cannot parse any other input.  */
+        scsi_build_sense(sense, SENSE_CODE(INVALID_FIELD));
+        return CHECK_CONDITION;
+    }
+
+    /* Convert input data, especially transport IDs, to the structs
+     * used by libmpathpersist (which, of course, will immediately
+     * do the opposite).
+     */
+    memset(&paramp, 0, sizeof(paramp));
+    memcpy(&paramp.key, &param[0], 8);
+    memcpy(&paramp.sa_key, &param[8], 8);
+    paramp.sa_flags = param[10];
+    if (sz > PR_OUT_FIXED_PARAM_SIZE) {
+        size_t transportid_len;
+        int i, j;
+        if (sz < PR_OUT_FIXED_PARAM_SIZE + 4) {
+            scsi_build_sense(sense, SENSE_CODE(INVALID_PARAM_LEN));
+            return CHECK_CONDITION;
+        }
+        transportid_len = ldl_be_p(&param[24]) + PR_OUT_FIXED_PARAM_SIZE + 4;
+        if (transportid_len > sz) {
+            scsi_build_sense(sense, SENSE_CODE(INVALID_PARAM));
+            return CHECK_CONDITION;
+        }
+        for (i = PR_OUT_FIXED_PARAM_SIZE + 4, j = 0; i < transportid_len; ) {
+            struct transportid *id = (struct transportid *) &transportids[j];
+            int len;
+
+            id->format_code = param[i] & 0xc0;
+            id->protocol_id = param[i] & 0x0f;
+            switch (param[i] & 0xcf) {
+            case 0:
+                /* FC transport.  */
+                if (i + 24 > transportid_len) {
+                    goto illegal_req;
+                }
+                memcpy(id->n_port_name, &param[i + 8], 8);
+                j += offsetof(struct transportid, n_port_name[8]);
+                i += 24;
+                break;
+            case 3:
+            case 0x43:
+                /* iSCSI transport.  */
+                len = lduw_be_p(&param[i + 2]);
+                if (len > 252 || (len & 3) || i + len + 4 > transportid_len) {
+                    /* For format code 00, the standard says the maximum is 223
+                     * plus the NUL terminator.  For format code 01 there is no
+                     * maximum length, but libmpathpersist ignores the first
+                     * byte of id->iscsi_name so our maximum is 252.
+                     */
+                    goto illegal_req;
+                }
+                if (memchr(&param[i + 4], 0, len) == NULL) {
+                    goto illegal_req;
+                }
+                memcpy(id->iscsi_name, &param[i + 2], len + 2);
+                j += offsetof(struct transportid, iscsi_name[len + 2]);
+                i += len + 4;
+                break;
+            case 6:
+                /* SAS transport.  */
+                if (i + 24 > transportid_len) {
+                    goto illegal_req;
+                }
+                memcpy(id->sas_address, &param[i + 4], 8);
+                j += offsetof(struct transportid, sas_address[8]);
+                i += 24;
+                break;
+            default:
+            illegal_req:
+                scsi_build_sense(sense, SENSE_CODE(INVALID_PARAM));
+                return CHECK_CONDITION;
+            }
+
+            paramp.trnptid_list[paramp.num_transportid++] = id;
+        }
+    }
+
+    r = mpath_persistent_reserve_out(fd, rq_servact, rq_scope, rq_type,
+                                     &paramp, noisy, verbose);
+    return mpath_reconstruct_sense(fd, r, sense);
+}
+#endif
+
 static int do_pr_in(int fd, const uint8_t *cdb, uint8_t *sense,
                     uint8_t *data, int *resp_sz)
 {
+#ifdef CONFIG_MPATH
+    if (is_mpath(fd)) {
+        /* multipath_pr_in fills the whole input buffer.  */
+        return multipath_pr_in(fd, cdb, sense, data, *resp_sz);
+    }
+#endif
+
     return do_sgio(fd, cdb, sense, data, resp_sz,
                    SG_DXFER_FROM_DEV);
 }
@@ -181,7 +495,14 @@ static int do_pr_in(int fd, const uint8_t *cdb, uint8_t *sense,
 static int do_pr_out(int fd, const uint8_t *cdb, uint8_t *sense,
                      const uint8_t *param, int sz)
 {
-    int resp_sz = sz;
+    int resp_sz;
+#ifdef CONFIG_MPATH
+    if (is_mpath(fd)) {
+        return multipath_pr_out(fd, cdb, sense, param, sz);
+    }
+#endif
+
+    resp_sz = sz;
     return do_sgio(fd, cdb, sense, (uint8_t *)param, &resp_sz,
                    SG_DXFER_TO_DEV);
 }
@@ -491,6 +812,14 @@ static int drop_privileges(void)
         return -1;
     }
 
+#ifdef CONFIG_MPATH
+    /* For /dev/mapper/control ioctls */
+    if (capng_update(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
+                     CAP_SYS_ADMIN) < 0) {
+        return -1;
+    }
+#endif
+
     /* Change user/group id, retaining the capabilities.  Because file descriptors
      * are passed via SCM_RIGHTS, we don't need supplementary groups (and in
      * fact the helper can run as "nobody").
@@ -507,7 +836,7 @@ static int drop_privileges(void)
 
 int main(int argc, char **argv)
 {
-    const char *sopt = "hVk:fdT:u:g:q";
+    const char *sopt = "hVk:fdT:u:g:vq";
     struct option lopt[] = {
         { "help", no_argument, NULL, 'h' },
         { "version", no_argument, NULL, 'V' },
@@ -517,10 +846,12 @@ int main(int argc, char **argv)
         { "trace", required_argument, NULL, 'T' },
         { "user", required_argument, NULL, 'u' },
         { "group", required_argument, NULL, 'g' },
+        { "verbose", no_argument, NULL, 'v' },
         { "quiet", no_argument, NULL, 'q' },
         { NULL, 0, NULL, 0 }
     };
     int opt_ind = 0;
+    int loglevel = 1;
     int quiet = 0;
     char ch;
     Error *local_err = NULL;
@@ -597,6 +928,9 @@ int main(int argc, char **argv)
         case 'q':
             quiet = 1;
             break;
+        case 'v':
+            ++loglevel;
+            break;
         case 'T':
             g_free(trace_file);
             trace_file = trace_opt_parse(optarg);
@@ -616,7 +950,8 @@ int main(int argc, char **argv)
     }
 
     /* set verbosity */
-    verbose = !quiet;
+    noisy = !quiet && (loglevel >= 3);
+    verbose = quiet ? 0 : MIN(loglevel, 3);
 
     if (!trace_init_backends()) {
         exit(EXIT_FAILURE);
@@ -624,6 +959,11 @@ int main(int argc, char **argv)
     trace_init_file(trace_file);
     qemu_set_log(LOG_TRACE);
 
+#ifdef CONFIG_MPATH
+    dm_init();
+    multipath_pr_init();
+#endif
+
     socket_activation = check_socket_activation();
     if (socket_activation == 0) {
         SocketAddress saddr = {
diff --git a/scsi/utils.c b/scsi/utils.c
index fab60bdf20..5684951b12 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -206,6 +206,11 @@ const struct SCSISense sense_code_OVERLAPPED_COMMANDS = {
     .key = ABORTED_COMMAND, .asc = 0x4e, .ascq = 0x00
 };
 
+/* Command aborted, LUN Communication Failure */
+const struct SCSISense sense_code_LUN_COMM_FAILURE = {
+    .key = ABORTED_COMMAND, .asc = 0x08, .ascq = 0x00
+};
+
 /* Unit attention, Capacity data has changed */
 const struct SCSISense sense_code_CAPACITY_CHANGED = {
     .key = UNIT_ATTENTION, .asc = 0x2a, .ascq = 0x09
@@ -216,6 +221,11 @@ const struct SCSISense sense_code_RESET = {
     .key = UNIT_ATTENTION, .asc = 0x29, .ascq = 0x00
 };
 
+/* Unit attention, SCSI bus reset */
+const struct SCSISense sense_code_SCSI_BUS_RESET = {
+    .key = UNIT_ATTENTION, .asc = 0x29, .ascq = 0x02
+};
+
 /* Unit attention, No medium */
 const struct SCSISense sense_code_UNIT_ATTENTION_NO_MEDIUM = {
     .key = UNIT_ATTENTION, .asc = 0x3a, .ascq = 0x00
-- 
2.13.5
