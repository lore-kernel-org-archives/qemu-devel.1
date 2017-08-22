Received: from eggs.gnu.org ([2001:4830:134:3::10]:49792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk95D-0002sh-LN
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk95B-00063T-7N
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:19:03 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 Aug 2017 15:18:31 +0200
Message-Id: <20170822131832.20191-10-pbonzini@redhat.com>
In-Reply-To: <20170822131832.20191-1-pbonzini@redhat.com>
References: <20170822131832.20191-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 09/10] scsi: add multipath support to
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
Cc: qemu-block@nongnu.org, famz@redhat.com

Proper support of persistent reservation for multipath devices requires
communication with the multipath daemon, so that the reservation is
registered and applied when a path comes up.  The device mapper
utilities provide a library to do so; this patch makes qemu-pr-helper.c
detect multipath devices and, when one is found, delegate the operation
to libmpathpersist.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile              |   3 +
 configure             |  57 ++++++++-
 docs/pr-manager.rst   |  27 +++++
 include/scsi/utils.h  |   6 +
 scsi/qemu-pr-helper.c | 311 +++++++++++++++++++++++++++++++++++++++++++++++++-
 scsi/utils.c          |  15 +++
 6 files changed, 414 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index bfd4f69ecd..f1acaad05b 100644
--- a/Makefile
+++ b/Makefile
@@ -388,6 +388,9 @@ fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal
 fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap
 
 scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+ifdef CONFIG_MPATH
+scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
+endif
 
 qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
diff --git a/configure b/configure
index 772aff18d6..d3c9371f7c 100755
--- a/configure
+++ b/configure
@@ -286,6 +286,7 @@ pixman=""
 sdl=""
 sdlabi=""
 virtfs=""
+mpath=""
 vnc="yes"
 sparse="no"
 vde=""
@@ -948,6 +949,10 @@ for opt do
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
@@ -1491,6 +1496,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   vnc-png         PNG compression for VNC server
   cocoa           Cocoa UI (Mac OS X only)
   virtfs          VirtFS
+  mpath           Multipath persistent reservation passthrough
   xen             xen backend driver support
   xen-pci-passthrough
   brlapi          BrlAPI (Braile)
@@ -3336,6 +3342,29 @@ else
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
@@ -5070,16 +5099,34 @@ if test "$want_tools" = "yes" ; then
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
 
@@ -5326,6 +5373,7 @@ echo "Audio drivers     $audio_drv_list"
 echo "Block whitelist (rw) $block_drv_rw_whitelist"
 echo "Block whitelist (ro) $block_drv_ro_whitelist"
 echo "VirtFS support    $virtfs"
+echo "Multipath support $mpath"
 echo "VNC support       $vnc"
 if test "$vnc" = "yes" ; then
     echo "VNC SASL support  $vnc_sasl"
@@ -5773,6 +5821,9 @@ fi
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
index c12b34f2e5..c626be2c78 100644
--- a/include/scsi/utils.h
+++ b/include/scsi/utils.h
@@ -44,6 +44,8 @@ extern const struct SCSISense sense_code_LUN_NOT_READY;
 extern const struct SCSISense sense_code_NO_MEDIUM;
 /* LUN not ready, medium removal prevented */
 extern const struct SCSISense sense_code_NOT_READY_REMOVAL_PREVENTED;
+/* Medium Error, Unrecoverable Read Error */
+extern const struct SCSISense sense_code_READ_ERROR;
 /* Hardware error, internal target failure */
 extern const struct SCSISense sense_code_TARGET_FAILURE;
 /* Illegal request, invalid command operation code */
@@ -80,6 +82,8 @@ extern const struct SCSISense sense_code_CAPACITY_CHANGED;
 extern const struct SCSISense sense_code_UNIT_ATTENTION_NO_MEDIUM;
 /* Unit attention, Power on, reset or bus device reset occurred */
 extern const struct SCSISense sense_code_RESET;
+/* Unit attention, SCSI Bus Reset */
+extern const struct SCSISense sense_code_SCSI_BUS_RESET;
 /* Unit attention, Medium may have changed*/
 extern const struct SCSISense sense_code_MEDIUM_CHANGED;
 /* Unit attention, Reported LUNs data has changed */
@@ -90,6 +94,8 @@ extern const struct SCSISense sense_code_DEVICE_INTERNAL_RESET;
 extern const struct SCSISense sense_code_WRITE_PROTECTED;
 /* Data Protection, Space Allocation Failed Write Protect */
 extern const struct SCSISense sense_code_SPACE_ALLOC_FAILED;
+/* Aborted Command, LUN Communication Failure */
+extern const struct SCSISense sense_code_LUN_COMM_FAILURE;
 
 #define SENSE_CODE(x) sense_code_ ## x
 
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index d52234af0f..707bb6127b 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -51,6 +51,14 @@
 #include <pwd.h>
 #include <grp.h>
 
+#ifdef CONFIG_MPATH
+#define CONTROL_PATH "/dev/mapper/control"
+#include <libudev.h>
+#include "mpath_cmd.h"
+#include "mpath_persist.h"
+#endif
+
+QEMU_BUILD_BUG_ON(PR_HELPER_DATA_SIZE > MPATH_MAX_PARAM_LEN);
 
 #define PR_OUT_FIXED_PARAM_SIZE 24
 
@@ -60,6 +68,7 @@ static enum { RUNNING, TERMINATE, TERMINATING } state;
 static QIOChannelSocket *server_ioc;
 static int server_watch;
 static int num_active_sockets = 1;
+static int noisy;
 static int verbose;
 
 #ifdef CONFIG_LIBCAP
@@ -162,9 +171,290 @@ static int do_sgio(int fd, const uint8_t *cdb, uint8_t *sense,
     return thread_pool_submit_co(pool, do_sgio_worker, &data);
 }
 
+/* Device mapper interface */
+
+#ifdef CONFIG_MPATH
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
+            return do_sgio(fd, cdb, sense, NULL, 0, SG_DXFER_NONE);
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
+            stl_be_p(&data[0], out->prgeneration);
+            stl_be_p(&data[4], out->additional_length);
+            memcpy(&data[8], out->key_list, MIN(out->additional_length, sz - 8));
+            written = MIN(out->additional_length + 8, sz);
+            break;
+        }
+        case MPATH_PRIN_RCAP_SA: {
+            struct prin_capdescr *out = &resp.prin_descriptor.prin_readcap;
+            stw_be_p(&data[0], out->length);
+            data[2] = out->flags[0];
+            data[3] = out->flags[1];
+            stw_be_p(&data[4], out->pr_type_mask);
+            written = MIN(6, sz);
+            break;
+        }
+        default:
+            scsi_build_sense(sense, SENSE_CODE(INVALID_OPCODE));
+            return CHECK_CONDITION;
+        }
+        assert(written < sz);
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
+    int i, j;
+
+    switch (rq_servact) {
+    case MPATH_PROUT_REG_SA:
+    case MPATH_PROUT_RES_SA:
+    case MPATH_PROUT_REL_SA:
+    case MPATH_PROUT_CLEAR_SA:
+    case MPATH_PROUT_PREE_SA:
+    case MPATH_PROUT_PREE_AB_SA:
+    case MPATH_PROUT_REG_IGN_SA:
+    case MPATH_PROUT_REG_MOV_SA:
+        break;
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
+    for (i = PR_OUT_FIXED_PARAM_SIZE, j = 0; i < sz; ) {
+        struct transportid *id = (struct transportid *) &transportids[j];
+        int len;
+
+        id->format_code = param[i] & 0xc0;
+        id->protocol_id = param[i] & 0x0f;
+        switch (param[i] & 0xcf) {
+        case 0:
+            /* FC transport.  */
+            memcpy(id->n_port_name, &param[i + 8], 8);
+            j += offsetof(struct transportid, n_port_name[8]);
+            i += 24;
+            break;
+        case 3:
+        case 0x43:
+            /* iSCSI transport.  */
+            len = lduw_be_p(&param[i + 2]);
+            if (len > 252 || (len & 3)) {
+                /* For format code 00, the standard says the maximum is 223,
+                 * plus the NUL terminator.  For format code 01 there is no
+                 * maximum length, but libmpathpersist ignores the first byte
+                 * of id->iscsi_name so our maximum is 252.
+                 */
+                goto illegal_req;
+            }
+            if (memchr(&param[i + 4], 0, len) == NULL) {
+                goto illegal_req;
+            }
+            memcpy(id->iscsi_name, &param[i + 2], len + 2);
+            j += offsetof(struct transportid, iscsi_name[len + 2]);
+            i += len + 4;
+            break;
+        case 6:
+            /* SAS transport.  */
+            memcpy(id->sas_address, &param[i + 4], 8);
+            j += offsetof(struct transportid, sas_address[8]);
+            i += 24;
+            break;
+        default:
+        illegal_req:
+            scsi_build_sense(sense, SENSE_CODE(INVALID_PARAM));
+            return CHECK_CONDITION;
+        }
+
+        paramp.trnptid_list[paramp.num_transportid++] = id;
+    }
+
+    r = mpath_persistent_reserve_out(fd, rq_servact, rq_scope, rq_type,
+                                     &paramp, noisy, verbose);
+    return mpath_reconstruct_sense(fd, r, sense);
+}
+#endif
+
 static int do_pr_in(int fd, const uint8_t *cdb, uint8_t *sense,
                     uint8_t *data, int sz)
 {
+#ifdef CONFIG_MPATH
+    if (is_mpath(fd)) {
+        return multipath_pr_in(fd, cdb, sense, data, sz);
+    }
+#endif
+
     return do_sgio(fd, cdb, sense, data, sz,
                    SG_DXFER_FROM_DEV);
 }
@@ -172,6 +462,12 @@ static int do_pr_in(int fd, const uint8_t *cdb, uint8_t *sense,
 static int do_pr_out(int fd, const uint8_t *cdb, uint8_t *sense,
                      const uint8_t *param, int sz)
 {
+#ifdef CONFIG_MPATH
+    if (is_mpath(fd)) {
+        return multipath_pr_out(fd, cdb, sense, param, sz);
+    }
+#endif
+
     return do_sgio(fd, cdb, sense, (uint8_t *)param, sz,
                    SG_DXFER_TO_DEV);
 }
@@ -444,6 +740,11 @@ static int drop_privileges(void)
                      CAP_SYS_RAWIO) < 0) {
         return -1;
     }
+    /* For /dev/mapper/control ioctls */
+    if (capng_update(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
+                     CAP_SYS_ADMIN) < 0) {
+        return -1;
+    }
 
     /* Change user/group id, retaining the capabilities.  Because file descriptors
      * are passed via SCM_RIGHTS, we don't need supplementary groups (and in
@@ -461,7 +762,7 @@ static int drop_privileges(void)
 
 int main(int argc, char **argv)
 {
-    const char *sopt = "hVk:fdT:u:g:q";
+    const char *sopt = "hVk:fdT:u:g:vq";
     struct option lopt[] = {
         { "help", no_argument, NULL, 'h' },
         { "version", no_argument, NULL, 'V' },
@@ -471,10 +772,12 @@ int main(int argc, char **argv)
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
@@ -551,6 +854,9 @@ int main(int argc, char **argv)
         case 'q':
             quiet = 1;
             break;
+        case 'v':
+            ++loglevel;
+            break;
         case 'T':
             g_free(trace_file);
             trace_file = trace_opt_parse(optarg);
@@ -570,7 +876,8 @@ int main(int argc, char **argv)
     }
 
     /* set verbosity */
-    verbose = !quiet;
+    noisy = !quiet && (loglevel >= 3);
+    verbose = quiet ? 0 : MIN(loglevel, 3);
 
     if (!trace_init_backends()) {
         exit(1);
diff --git a/scsi/utils.c b/scsi/utils.c
index eedd5f45b4..b5c0e05408 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -116,6 +116,11 @@ const struct SCSISense sense_code_NOT_READY_REMOVAL_PREVENTED = {
     .key = NOT_READY, .asc = 0x53, .ascq = 0x02
 };
 
+/* Medium Error, Unrecoverable Read Error */
+const struct SCSISense sense_code_READ_ERROR = {
+    .key = MEDIUM_ERROR, .asc = 0x11, .ascq = 0x00
+};
+
 /* Hardware error, internal target failure */
 const struct SCSISense sense_code_TARGET_FAILURE = {
     .key = HARDWARE_ERROR, .asc = 0x44, .ascq = 0x00
@@ -191,6 +196,11 @@ const struct SCSISense sense_code_OVERLAPPED_COMMANDS = {
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
@@ -201,6 +211,11 @@ const struct SCSISense sense_code_RESET = {
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
