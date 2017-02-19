Received: from eggs.gnu.org ([2001:4830:134:3::10]:53168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cfa18-00007o-Cl
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 17:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cfa14-00024h-2s
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 17:31:42 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1cfa13-00024H-OR
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 17:31:38 -0500
Received: by mail-pg0-x242.google.com with SMTP id v184so10389380pgv.1
	for <qemu-devel@nongnu.org>; Sun, 19 Feb 2017 14:31:37 -0800 (PST)
From: Ashish Mittal <ashmit602@gmail.com>
Date: Sun, 19 Feb 2017 14:30:53 -0800
Message-Id: <1487543454-20373-1-git-send-email-Ashish.Mittal@veritas.com>
Subject: [Qemu-devel] [PATCH v9 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com, jcody@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, stefanha@gmail.com, jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com, Nitin.Jerath@veritas.com, peter.maydell@linaro.org, rakesh.ranjan@veritas.com, venkatesha.mg@veritas.com
Cc: Ketan.Nilangekar@veritas.com, Abhijit.Dey@veritas.com, Ashish Mittal <Ashish.Mittal@veritas.com>

Source code for the qnio library that this code loads can be downloaded from:
https://github.com/VeritasHyperScale/libqnio.git

Sample command line using JSON syntax:
./x86_64-softmmu/qemu-system-x86_64 -name instance-00000008 -S -vnc 0.0.0.0:0
-k en-us -vga cirrus -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x5
-msg timestamp=on
'json:{"driver":"vxhs","vdisk-id":"c3e9095a-a5ee-4dce-afeb-2a59fb387410",
"server":{"host":"172.172.17.4","port":"9999"}}'

Sample command line using URI syntax:
qemu-img convert -f raw -O raw -n
/var/lib/nova/instances/_base/0c5eacd5ebea5ed914b6a3e7b18f1ce734c386ad
vxhs://192.168.0.1:9999/c6718f6b-0401-441d-a8c3-1f0064d75ee0

Signed-off-by: Ashish Mittal <Ashish.Mittal@veritas.com>
---

v9 changelog:
(1) Fixes for all the review comments from v8. I have left the definition
    of VXHS_UUID_DEF unchanged pending a better suggestion.
(2) qcow2 tests now pass on the vxhs test server.
(3) Packaging changes for libvxhs will be checked in to the git repo soon.
(4) I have not moved extern QemuUUID qemu_uuid to a separate header file.

v8 changelog:
(1) Security implementation for libqnio present in branch 'securify'.
    Please use 'securify' branch for building libqnio and testing
    with this patch.
(2) Renamed libqnio to libvxhs.
(3) Pass instance ID to libvxhs for SSL authentication.

v7 changelog:
(1) IO failover code has moved out to the libqnio library.
(2) Fixes for issues reported by Stefan on v6.
(3) Incorporated the QEMUBH patch provided by Stefan.
    This is a replacement for the pipe mechanism used earlier.
(4) Fixes to the buffer overflows reported in libqnio.
(5) Input validations in vxhs.c to prevent any buffer overflows for 
    arguments passed to libqnio.

v6 changelog:
(1) Added qemu-iotests for VxHS as a new patch in the series.
(2) Replaced release version from 2.8 to 2.9 in block-core.json.

v5 changelog:
(1) Incorporated v4 review comments.

v4 changelog:
(1) Incorporated v3 review comments on QAPI changes.
(2) Added refcounting for device open/close.
    Free library resources on last device close.

v3 changelog:
(1) Added QAPI schema for the VxHS driver.

v2 changelog:
(1) Changes done in response to v1 comments.

 block/Makefile.objs  |   2 +
 block/trace-events   |  16 ++
 block/vxhs.c         | 527 +++++++++++++++++++++++++++++++++++++++++++++++++++
 configure            |  40 ++++
 qapi/block-core.json |  20 +-
 5 files changed, 603 insertions(+), 2 deletions(-)
 create mode 100644 block/vxhs.c

diff --git a/block/Makefile.objs b/block/Makefile.objs
index c6bd14e..75675b4 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -19,6 +19,7 @@ block-obj-$(CONFIG_LIBNFS) += nfs.o
 block-obj-$(CONFIG_CURL) += curl.o
 block-obj-$(CONFIG_RBD) += rbd.o
 block-obj-$(CONFIG_GLUSTERFS) += gluster.o
+block-obj-$(CONFIG_VXHS) += vxhs.o
 block-obj-$(CONFIG_ARCHIPELAGO) += archipelago.o
 block-obj-$(CONFIG_LIBSSH2) += ssh.o
 block-obj-y += accounting.o dirty-bitmap.o
@@ -39,6 +40,7 @@ rbd.o-cflags       := $(RBD_CFLAGS)
 rbd.o-libs         := $(RBD_LIBS)
 gluster.o-cflags   := $(GLUSTERFS_CFLAGS)
 gluster.o-libs     := $(GLUSTERFS_LIBS)
+vxhs.o-libs        := $(VXHS_LIBS)
 ssh.o-cflags       := $(LIBSSH2_CFLAGS)
 ssh.o-libs         := $(LIBSSH2_LIBS)
 archipelago.o-libs := $(ARCHIPELAGO_LIBS)
diff --git a/block/trace-events b/block/trace-events
index 0bc5c0a..f193079 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -110,3 +110,19 @@ qed_aio_write_data(void *s, void *acb, int ret, uint64_t offset, size_t len) "s
 qed_aio_write_prefill(void *s, void *acb, uint64_t start, size_t len, uint64_t offset) "s %p acb %p start %"PRIu64" len %zu offset %"PRIu64
 qed_aio_write_postfill(void *s, void *acb, uint64_t start, size_t len, uint64_t offset) "s %p acb %p start %"PRIu64" len %zu offset %"PRIu64
 qed_aio_write_main(void *s, void *acb, int ret, uint64_t offset, size_t len) "s %p acb %p ret %d offset %"PRIu64" len %zu"
+
+# block/vxhs.c
+vxhs_iio_callback(int error) "ctx is NULL: error %d"
+vxhs_iio_callback_chnfail(int err, int error) "QNIO channel failed, no i/o %d, %d"
+vxhs_iio_callback_unknwn(int opcode, int err) "unexpected opcode %d, errno %d"
+vxhs_aio_rw_invalid(int req) "Invalid I/O request iodir %d"
+vxhs_aio_rw_ioerr(char *guid, int iodir, uint64_t size, uint64_t off, void *acb, int ret, int err) "IO ERROR (vDisk %s) FOR : Read/Write = %d size = %lu offset = %lu ACB = %p. Error = %d, errno = %d"
+vxhs_get_vdisk_stat_err(char *guid, int ret, int err) "vDisk (%s) stat ioctl failed, ret = %d, errno = %d"
+vxhs_get_vdisk_stat(char *vdisk_guid, uint64_t vdisk_size) "vDisk %s stat ioctl returned size %lu"
+vxhs_complete_aio(void *acb, uint64_t ret) "aio failed acb %p ret %ld"
+vxhs_parse_uri_filename(const char *filename) "URI passed via bdrv_parse_filename %s"
+vxhs_open_vdiskid(const char *vdisk_id) "Opening vdisk-id %s"
+vxhs_open_hostinfo(char *of_vsa_addr, int port) "Adding host %s:%d to BDRVVXHSState"
+vxhs_open_iio_open(const char *host) "Failed to connect to storage agent on host %s"
+vxhs_parse_uri_hostinfo(char *host, int port) "Host: IP %s, Port %d"
+vxhs_close(char *vdisk_guid) "Closing vdisk %s"
diff --git a/block/vxhs.c b/block/vxhs.c
new file mode 100644
index 0000000..4f0633e
--- /dev/null
+++ b/block/vxhs.c
@@ -0,0 +1,527 @@
+/*
+ * QEMU Block driver for Veritas HyperScale (VxHS)
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include <qnio/qnio_api.h>
+#include <sys/param.h>
+#include "block/block_int.h"
+#include "qapi/qmp/qerror.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qstring.h"
+#include "trace.h"
+#include "qemu/uri.h"
+#include "qapi/error.h"
+#include "qemu/uuid.h"
+
+#define VXHS_OPT_FILENAME           "filename"
+#define VXHS_OPT_VDISK_ID           "vdisk-id"
+#define VXHS_OPT_SERVER             "server"
+#define VXHS_OPT_HOST               "host"
+#define VXHS_OPT_PORT               "port"
+#define VXHS_UUID_DEF "12345678-1234-1234-1234-123456789012"
+
+QemuUUID qemu_uuid __attribute__ ((weak));
+
+static uint32_t vxhs_ref;
+
+typedef enum {
+    VDISK_AIO_READ,
+    VDISK_AIO_WRITE,
+} VDISKAIOCmd;
+
+/*
+ * HyperScale AIO callbacks structure
+ */
+typedef struct VXHSAIOCB {
+    BlockAIOCB common;
+    int err;
+    QEMUIOVector *qiov;
+} VXHSAIOCB;
+
+typedef struct VXHSvDiskHostsInfo {
+    void *dev_handle; /* Device handle */
+    char *host; /* Host name or IP */
+    int port; /* Host's port number */
+} VXHSvDiskHostsInfo;
+
+/*
+ * Structure per vDisk maintained for state
+ */
+typedef struct BDRVVXHSState {
+    VXHSvDiskHostsInfo vdisk_hostinfo; /* Per host info */
+    char *vdisk_guid;
+} BDRVVXHSState;
+
+static void vxhs_complete_aio_bh(void *opaque)
+{
+    VXHSAIOCB *acb = opaque;
+    BlockCompletionFunc *cb = acb->common.cb;
+    void *cb_opaque = acb->common.opaque;
+    int ret = 0;
+
+    if (acb->err != 0) {
+        trace_vxhs_complete_aio(acb, acb->err);
+        ret = (-EIO);
+    }
+
+    qemu_aio_unref(acb);
+    cb(cb_opaque, ret);
+}
+
+/*
+ * Called from a libqnio thread
+ */
+static void vxhs_iio_callback(void *ctx, uint32_t opcode, uint32_t error)
+{
+    VXHSAIOCB *acb = NULL;
+
+    switch (opcode) {
+    case IRP_READ_REQUEST:
+    case IRP_WRITE_REQUEST:
+
+        /*
+         * ctx is VXHSAIOCB*
+         * ctx is NULL if error is QNIOERROR_CHANNEL_HUP
+         */
+        if (ctx) {
+            acb = ctx;
+        } else {
+            trace_vxhs_iio_callback(error);
+            goto out;
+        }
+
+        if (error) {
+            if (!acb->err) {
+                acb->err = error;
+            }
+            trace_vxhs_iio_callback(error);
+        }
+
+        aio_bh_schedule_oneshot(bdrv_get_aio_context(acb->common.bs),
+                                vxhs_complete_aio_bh, acb);
+        break;
+
+    default:
+        if (error == QNIOERROR_HUP) {
+            /*
+             * Channel failed, spontaneous notification,
+             * not in response to I/O
+             */
+            trace_vxhs_iio_callback_chnfail(error, errno);
+        } else {
+            trace_vxhs_iio_callback_unknwn(opcode, error);
+        }
+        break;
+    }
+out:
+    return;
+}
+
+static QemuOptsList runtime_opts = {
+    .name = "vxhs",
+    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
+    .desc = {
+        {
+            .name = VXHS_OPT_FILENAME,
+            .type = QEMU_OPT_STRING,
+            .help = "URI to the Veritas HyperScale image",
+        },
+        {
+            .name = VXHS_OPT_VDISK_ID,
+            .type = QEMU_OPT_STRING,
+            .help = "UUID of the VxHS vdisk",
+        },
+        { /* end of list */ }
+    },
+};
+
+static QemuOptsList runtime_tcp_opts = {
+    .name = "vxhs_tcp",
+    .head = QTAILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),
+    .desc = {
+        {
+            .name = VXHS_OPT_HOST,
+            .type = QEMU_OPT_STRING,
+            .help = "host address (ipv4 addresses)",
+        },
+        {
+            .name = VXHS_OPT_PORT,
+            .type = QEMU_OPT_NUMBER,
+            .help = "port number on which VxHSD is listening (default 9999)",
+            .def_value_str = "9999"
+        },
+        { /* end of list */ }
+    },
+};
+
+/*
+ * Parse the incoming URI and populate *options with the host information.
+ * URI syntax has the limitation of supporting only one host info.
+ * To pass multiple host information, use the JSON syntax.
+ */
+static int vxhs_parse_uri(const char *filename, QDict *options)
+{
+    URI *uri = NULL;
+    char *hoststr, *portstr;
+    char *port;
+    int ret = 0;
+
+    trace_vxhs_parse_uri_filename(filename);
+    uri = uri_parse(filename);
+    if (!uri || !uri->server || !uri->path) {
+        uri_free(uri);
+        return -EINVAL;
+    }
+
+    hoststr = g_strdup(VXHS_OPT_SERVER".host");
+    qdict_put(options, hoststr, qstring_from_str(uri->server));
+    g_free(hoststr);
+
+    portstr = g_strdup(VXHS_OPT_SERVER".port");
+    if (uri->port) {
+        port = g_strdup_printf("%d", uri->port);
+        qdict_put(options, portstr, qstring_from_str(port));
+        g_free(port);
+    }
+    g_free(portstr);
+
+    if (strstr(uri->path, "vxhs") == NULL) {
+        qdict_put(options, "vdisk-id", qstring_from_str(uri->path));
+    }
+
+    trace_vxhs_parse_uri_hostinfo(uri->server, uri->port);
+    uri_free(uri);
+
+    return ret;
+}
+
+static void vxhs_parse_filename(const char *filename, QDict *options,
+                                Error **errp)
+{
+    if (qdict_haskey(options, "vdisk-id") || qdict_haskey(options, "server")) {
+        error_setg(errp, "vdisk-id/server and a file name may not be specified "
+                         "at the same time");
+        return;
+    }
+
+    if (strstr(filename, "://")) {
+        int ret = vxhs_parse_uri(filename, options);
+        if (ret < 0) {
+            error_setg(errp, "Invalid URI. URI should be of the form "
+                       "  vxhs://<host_ip>:<port>/<vdisk-id>");
+        }
+    }
+}
+
+static int vxhs_init_and_ref(void)
+{
+    if (vxhs_ref == 0) {
+        char out[UUID_FMT_LEN + 1];
+        if (qemu_uuid_is_null(&qemu_uuid)) {
+            if (iio_init(QNIO_VERSION, vxhs_iio_callback, VXHS_UUID_DEF)) {
+                return -ENODEV;
+            }
+        } else {
+            qemu_uuid_unparse(&qemu_uuid, out);
+            if (iio_init(QNIO_VERSION, vxhs_iio_callback, out)) {
+                return -ENODEV;
+            }
+        }
+    }
+    vxhs_ref++;
+    return 0;
+}
+
+static void vxhs_unref(void)
+{
+    if (vxhs_ref && --vxhs_ref == 0) {
+        iio_fini();
+    }
+}
+
+static int vxhs_open(BlockDriverState *bs, QDict *options,
+                     int bdrv_flags, Error **errp)
+{
+    BDRVVXHSState *s = bs->opaque;
+    void *dev_handlep = NULL;
+    QDict *backing_options = NULL;
+    QemuOpts *opts, *tcp_opts;
+    char *of_vsa_addr = NULL;
+    Error *local_err = NULL;
+    const char *vdisk_id_opt;
+    const char *server_host_opt;
+    char *str = NULL;
+    int ret = 0;
+
+    ret = vxhs_init_and_ref();
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* Create opts info from runtime_opts and runtime_tcp_opts list */
+    opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
+    tcp_opts = qemu_opts_create(&runtime_tcp_opts, NULL, 0, &error_abort);
+
+    qemu_opts_absorb_qdict(opts, options, &local_err);
+    if (local_err) {
+        ret = -EINVAL;
+        goto out;
+    }
+
+    /* vdisk-id is the disk UUID */
+    vdisk_id_opt = qemu_opt_get(opts, VXHS_OPT_VDISK_ID);
+    if (!vdisk_id_opt) {
+        error_setg(&local_err, QERR_MISSING_PARAMETER, VXHS_OPT_VDISK_ID);
+        ret = -EINVAL;
+        goto out;
+    }
+
+    /* vdisk-id may contain a leading '/' */
+    if (strlen(vdisk_id_opt) > UUID_FMT_LEN + 1) {
+        error_setg(&local_err, "vdisk-id cannot be more than %d characters",
+                   UUID_FMT_LEN);
+        ret = -EINVAL;
+        goto out;
+    }
+
+    s->vdisk_guid = g_strdup(vdisk_id_opt);
+    trace_vxhs_open_vdiskid(vdisk_id_opt);
+
+    /* get the 'server.' arguments */
+    str = g_strdup_printf(VXHS_OPT_SERVER".");
+    qdict_extract_subqdict(options, &backing_options, str);
+
+    qemu_opts_absorb_qdict(tcp_opts, backing_options, &local_err);
+    if (local_err) {
+        qdict_del(backing_options, str);
+        ret = -EINVAL;
+        goto out;
+    }
+
+    server_host_opt = qemu_opt_get(tcp_opts, VXHS_OPT_HOST);
+    if (!server_host_opt) {
+        error_setg(&local_err, QERR_MISSING_PARAMETER,
+                   VXHS_OPT_SERVER"."VXHS_OPT_HOST);
+        qdict_del(backing_options, str);
+        ret = -EINVAL;
+        goto out;
+    }
+
+    if (strlen(server_host_opt) > MAXHOSTNAMELEN) {
+        error_setg(&local_err, "server.host cannot be more than %d characters",
+                   MAXHOSTNAMELEN);
+        qdict_del(backing_options, str);
+        ret = -EINVAL;
+        goto out;
+    }
+
+    s->vdisk_hostinfo.host = g_strdup(server_host_opt);
+
+    s->vdisk_hostinfo.port = g_ascii_strtoll(qemu_opt_get(tcp_opts,
+                                                          VXHS_OPT_PORT),
+                                                          NULL, 0);
+
+    trace_vxhs_open_hostinfo(s->vdisk_hostinfo.host,
+                         s->vdisk_hostinfo.port);
+
+    /* free the 'server.' entries allocated by previous call to
+     * qdict_extract_subqdict()
+     */
+    qdict_del(backing_options, str);
+
+    of_vsa_addr = g_strdup_printf("of://%s:%d",
+                                s->vdisk_hostinfo.host,
+                                s->vdisk_hostinfo.port);
+
+    /*
+     * Open qnio channel to storage agent if not opened before.
+     */
+    dev_handlep = iio_open(of_vsa_addr, s->vdisk_guid, 0);
+    if (dev_handlep == NULL) {
+        trace_vxhs_open_iio_open(of_vsa_addr);
+        ret = -ENODEV;
+        goto out;
+    }
+    s->vdisk_hostinfo.dev_handle = dev_handlep;
+
+out:
+    g_free(str);
+    g_free(of_vsa_addr);
+    QDECREF(backing_options);
+    qemu_opts_del(tcp_opts);
+    qemu_opts_del(opts);
+
+    if (ret < 0) {
+        vxhs_unref();
+        error_propagate(errp, local_err);
+        g_free(s->vdisk_hostinfo.host);
+        g_free(s->vdisk_guid);
+        s->vdisk_guid = NULL;
+        errno = -ret;
+    }
+
+    return ret;
+}
+
+static const AIOCBInfo vxhs_aiocb_info = {
+    .aiocb_size = sizeof(VXHSAIOCB)
+};
+
+/*
+ * This allocates QEMU-VXHS callback for each IO
+ * and is passed to QNIO. When QNIO completes the work,
+ * it will be passed back through the callback.
+ */
+static BlockAIOCB *vxhs_aio_rw(BlockDriverState *bs, int64_t sector_num,
+                               QEMUIOVector *qiov, int nb_sectors,
+                               BlockCompletionFunc *cb, void *opaque,
+                               VDISKAIOCmd iodir)
+{
+    VXHSAIOCB *acb = NULL;
+    BDRVVXHSState *s = bs->opaque;
+    size_t size;
+    uint64_t offset;
+    int iio_flags = 0;
+    int ret = 0;
+    void *dev_handle = s->vdisk_hostinfo.dev_handle;
+
+    offset = sector_num * BDRV_SECTOR_SIZE;
+    size = nb_sectors * BDRV_SECTOR_SIZE;
+    acb = qemu_aio_get(&vxhs_aiocb_info, bs, cb, opaque);
+
+    /*
+     * Initialize VXHSAIOCB.
+     */
+    acb->err = 0;
+    acb->qiov = qiov;
+
+    iio_flags = IIO_FLAG_ASYNC;
+
+    switch (iodir) {
+    case VDISK_AIO_WRITE:
+            ret = iio_writev(dev_handle, acb, qiov->iov, qiov->niov,
+                             offset, (uint64_t)size, iio_flags);
+            break;
+    case VDISK_AIO_READ:
+            ret = iio_readv(dev_handle, acb, qiov->iov, qiov->niov,
+                            offset, (uint64_t)size, iio_flags);
+            break;
+    default:
+            trace_vxhs_aio_rw_invalid(iodir);
+            goto errout;
+    }
+
+    if (ret != 0) {
+        trace_vxhs_aio_rw_ioerr(s->vdisk_guid, iodir, size, offset,
+                                acb, ret, errno);
+        goto errout;
+    }
+    return &acb->common;
+
+errout:
+    qemu_aio_unref(acb);
+    return NULL;
+}
+
+static BlockAIOCB *vxhs_aio_readv(BlockDriverState *bs,
+                                   int64_t sector_num, QEMUIOVector *qiov,
+                                   int nb_sectors,
+                                   BlockCompletionFunc *cb, void *opaque)
+{
+    return vxhs_aio_rw(bs, sector_num, qiov, nb_sectors, cb,
+                       opaque, VDISK_AIO_READ);
+}
+
+static BlockAIOCB *vxhs_aio_writev(BlockDriverState *bs,
+                                   int64_t sector_num, QEMUIOVector *qiov,
+                                   int nb_sectors,
+                                   BlockCompletionFunc *cb, void *opaque)
+{
+    return vxhs_aio_rw(bs, sector_num, qiov, nb_sectors,
+                       cb, opaque, VDISK_AIO_WRITE);
+}
+
+static void vxhs_close(BlockDriverState *bs)
+{
+    BDRVVXHSState *s = bs->opaque;
+
+    trace_vxhs_close(s->vdisk_guid);
+
+    g_free(s->vdisk_guid);
+    s->vdisk_guid = NULL;
+
+    /*
+     * Close vDisk device
+     */
+    if (s->vdisk_hostinfo.dev_handle) {
+        iio_close(s->vdisk_hostinfo.dev_handle);
+        s->vdisk_hostinfo.dev_handle = NULL;
+    }
+
+    vxhs_unref();
+
+    /*
+     * Free the dynamically allocated host string
+     */
+    g_free(s->vdisk_hostinfo.host);
+    s->vdisk_hostinfo.host = NULL;
+    s->vdisk_hostinfo.port = 0;
+}
+
+static int64_t vxhs_get_vdisk_stat(BDRVVXHSState *s)
+{
+    int64_t vdisk_size = -1;
+    int ret = 0;
+    void *dev_handle = s->vdisk_hostinfo.dev_handle;
+
+    ret = iio_ioctl(dev_handle, IOR_VDISK_STAT, &vdisk_size, 0);
+    if (ret < 0) {
+        trace_vxhs_get_vdisk_stat_err(s->vdisk_guid, ret, errno);
+        return -EIO;
+    }
+
+    trace_vxhs_get_vdisk_stat(s->vdisk_guid, vdisk_size);
+    return vdisk_size;
+}
+
+/*
+ * Returns the size of vDisk in bytes. This is required
+ * by QEMU block upper block layer so that it is visible
+ * to guest.
+ */
+static int64_t vxhs_getlength(BlockDriverState *bs)
+{
+    BDRVVXHSState *s = bs->opaque;
+    int64_t vdisk_size;
+
+    vdisk_size = vxhs_get_vdisk_stat(s);
+    if (vdisk_size < 0) {
+        return -EIO;
+    }
+
+    return vdisk_size;
+}
+
+static BlockDriver bdrv_vxhs = {
+    .format_name                  = "vxhs",
+    .protocol_name                = "vxhs",
+    .instance_size                = sizeof(BDRVVXHSState),
+    .bdrv_file_open               = vxhs_open,
+    .bdrv_parse_filename          = vxhs_parse_filename,
+    .bdrv_close                   = vxhs_close,
+    .bdrv_getlength               = vxhs_getlength,
+    .bdrv_aio_readv               = vxhs_aio_readv,
+    .bdrv_aio_writev              = vxhs_aio_writev,
+};
+
+static void bdrv_vxhs_init(void)
+{
+    bdrv_register(&bdrv_vxhs);
+}
+
+block_init(bdrv_vxhs_init);
diff --git a/configure b/configure
index 1c9655e..d66ca09 100755
--- a/configure
+++ b/configure
@@ -321,6 +321,7 @@ numa=""
 tcmalloc="no"
 jemalloc="no"
 replication="yes"
+vxhs=""
 
 # parse CC options first
 for opt do
@@ -1170,6 +1171,10 @@ for opt do
   ;;
   --enable-replication) replication="yes"
   ;;
+  --disable-vxhs) vxhs="no"
+  ;;
+  --enable-vxhs) vxhs="yes"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1403,6 +1408,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   tcmalloc        tcmalloc support
   jemalloc        jemalloc support
   replication     replication support
+  vxhs            Veritas HyperScale vDisk backend support
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -4748,6 +4754,34 @@ if test "$modules" = "yes" && test "$LD_REL_FLAGS" = ""; then
 fi
 
 ##########################################
+# Veritas HyperScale block driver VxHS
+# Check if libvxhs is installed
+
+if test "$vxhs" != "no" ; then
+  cat > $TMPC <<EOF
+#include <stdint.h>
+#include <qnio/qnio_api.h>
+
+#define VXHS_UUID "12345678-1234-1234-1234-123456789012"
+void *vxhs_callback;
+
+int main(void) {
+    iio_init(QNIO_VERSION, vxhs_callback, VXHS_UUID);
+    return 0;
+}
+EOF
+  vxhs_libs="-lvxhs -lssl"
+  if compile_prog "" "$vxhs_libs" ; then
+    vxhs=yes
+  else
+    if test "$vxhs" = "yes" ; then
+      feature_not_found "vxhs block device" "Install libvxhs See github"
+    fi
+    vxhs=no
+  fi
+fi
+
+##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
 
@@ -5114,6 +5148,7 @@ echo "tcmalloc support  $tcmalloc"
 echo "jemalloc support  $jemalloc"
 echo "avx2 optimization $avx2_opt"
 echo "replication support $replication"
+echo "VxHS block device $vxhs"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -5729,6 +5764,11 @@ if test "$pthread_setname_np" = "yes" ; then
   echo "CONFIG_PTHREAD_SETNAME_NP=y" >> $config_host_mak
 fi
 
+if test "$vxhs" = "yes" ; then
+  echo "CONFIG_VXHS=y" >> $config_host_mak
+  echo "VXHS_LIBS=$vxhs_libs" >> $config_host_mak
+fi
+
 if test "$tcg_interpreter" = "yes"; then
   QEMU_INCLUDES="-I\$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 932f5bb..f37df56 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2110,6 +2110,7 @@
 # @nfs: Since 2.8
 # @replication: Since 2.8
 # @ssh: Since 2.8
+# @vxhs: Since 2.9
 #
 # Since: 2.0
 ##
@@ -2119,7 +2120,7 @@
             'host_device', 'http', 'https', 'luks', 'nbd', 'nfs', 'null-aio',
             'null-co', 'parallels', 'qcow', 'qcow2', 'qed', 'quorum', 'raw',
             'replication', 'ssh', 'vdi', 'vhdx', 'vmdk', 'vpc',
-            'vvfat' ] }
+            'vvfat','vxhs' ] }
 
 ##
 # @BlockdevOptionsFile:
@@ -2744,6 +2745,20 @@
   'data': { '*offset': 'int', '*size': 'int' } }
 
 ##
+# @BlockdevOptionsVxHS:
+#
+# Driver specific block device options for VxHS
+#
+# @vdisk-id:    UUID of VxHS volume
+# @server:      vxhs server IP, port
+#
+# Since: 2.9
+##
+{ 'struct': 'BlockdevOptionsVxHS',
+  'data': { 'vdisk-id': 'str',
+            'server': 'InetSocketAddress' } }
+
+##
 # @BlockdevOptions:
 #
 # Options for creating a block device.  Many options are available for all
@@ -2806,7 +2821,8 @@
       'vhdx':       'BlockdevOptionsGenericFormat',
       'vmdk':       'BlockdevOptionsGenericCOWFormat',
       'vpc':        'BlockdevOptionsGenericFormat',
-      'vvfat':      'BlockdevOptionsVVFAT'
+      'vvfat':      'BlockdevOptionsVVFAT',
+      'vxhs':       'BlockdevOptionsVxHS'
   } }
 
 ##
-- 
2.5.5
