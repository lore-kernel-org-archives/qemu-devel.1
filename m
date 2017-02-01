Received: from eggs.gnu.org ([2001:4830:134:3::10]:55118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cYroV-0004WR-6r
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:06:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cYroQ-0005QV-8G
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:06:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1cYroQ-0005Q1-02
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:06:50 -0500
From: Ladi Prosek <lprosek@redhat.com>
Date: Wed,  1 Feb 2017 11:06:46 +0100
Message-Id: <1485943606-13998-1-git-send-email-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH] qga: implement guest-file-ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

Analogous to guest-file-read and guest-file-write, this commit adds
support for issuing IOCTLs to files in the guest. With the goal of
abstracting away the differences between Posix ioctl() and Win32
DeviceIoControl() to provide one unified API, the schema distinguishes
between input and output buffer sizes (as required by Win32) and
allows the caller to supply either a 'buffer', pointer to which will
be passed to the Posix ioctl(), or an integer argument, passed to
ioctl() directly.

Examples:

To issue an IOCTL that takes const int * as its argument, one would
call guest-file-ioctl with:
out-count = 0
in-buf-b64 = <base64-encoded binary representation of an integer>

To issue an IOCTL that takes int * as its argument, one would use:
out-count = sizeof(int)
in-buf-b64 = <empty string if the argument is output-only>
and the returned GuestFileIOCTL will contain:
count = sizeof(int)
buf-b64 = <base64-encoded binary representation of an integer>

To issue an IOCTL that takes int as its argument, one would use:
out-count = 0
in-buf-b64 = <empty string>
int-arg = <an integer>
This last example will work only with the Posix guest agent as
Win32 always uses indirect input and output data.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 qga/commands-posix.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 qga/commands-win32.c | 66 ++++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json | 45 ++++++++++++++++++++++++++++++
 3 files changed, 189 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index ea37c09..4fb6edc 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -547,6 +547,84 @@ GuestFileWrite *qmp_guest_file_write(int64_t handle, const char *buf_b64,
     return write_data;
 }
 
+GuestFileIOCTL *qmp_guest_file_ioctl(int64_t handle, int64_t code,
+                                     int64_t out_count, const char *in_buf_b64,
+                                     bool has_in_count, int64_t in_count,
+                                     bool has_int_arg, int64_t int_arg,
+                                     Error **errp)
+{
+    GuestFileIOCTL *ioctl_data = NULL;
+    guchar *buf;
+    gsize buf_len;
+    int ioctl_retval;
+    GuestFileHandle *gfh = guest_file_handle_find(handle, errp);
+    int fd;
+
+    if (!gfh) {
+        return NULL;
+    }
+    fd = fileno(gfh->fh);
+    if (fd < 0) {
+        error_setg_errno(errp, errno, "failed to get fd");
+        return NULL;
+    }
+
+    buf = qbase64_decode(in_buf_b64, -1, &buf_len, errp);
+    if (!buf) {
+        return NULL;
+    }
+    if (has_int_arg && buf_len) {
+        error_setg(errp,
+            "int-arg and non-empty in-buf-b64 must not be specified at the same time");
+        g_free(buf);
+        return NULL;
+    }
+    if (has_int_arg && out_count) {
+        error_setg(errp,
+            "int-arg and non-zero out-count must not be specified at the same time");
+        g_free(buf);
+        return NULL;
+    }
+
+    if (!has_in_count) {
+        in_count = buf_len;
+    } else if (in_count < 0 || in_count > buf_len) {
+        error_setg(errp, "value '%" PRId64 "' is invalid for argument in-count",
+                   in_count);
+        g_free(buf);
+        return NULL;
+    }
+
+    /* there's only one input/output buffer so make sure it's large enough */
+    if (out_count > buf_len) {
+        guchar *old_buf = buf;
+        buf = g_malloc(out_count);
+
+        memcpy(buf, old_buf, buf_len);
+        memset(buf + buf_len, 0, out_count - buf_len);
+        g_free(old_buf);
+    }
+
+    if (has_int_arg) {
+        ioctl_retval = ioctl(fd, code, int_arg);
+    } else {
+        ioctl_retval = ioctl(fd, code, buf);
+    }
+
+    if (ioctl_retval < 0) {
+        error_setg_errno(errp, errno, "failed to issue IOCTL to file");
+        slog("guest-file-ioctl failed, handle: %" PRId64, handle);
+    } else {
+        ioctl_data = g_new0(GuestFileIOCTL, 1);
+        ioctl_data->retcode = ioctl_retval;
+        ioctl_data->count = out_count;
+        ioctl_data->buf_b64 = g_base64_encode(buf, out_count);
+    }
+    g_free(buf);
+
+    return ioctl_data;
+}
+
 struct GuestFileSeek *qmp_guest_file_seek(int64_t handle, int64_t offset,
                                           GuestFileWhence *whence_code,
                                           Error **errp)
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 19d72b2..7d1ad35 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -381,6 +381,72 @@ done:
     return write_data;
 }
 
+GuestFileIOCTL *qmp_guest_file_ioctl(int64_t handle, int64_t code,
+                                     int64_t out_count, const char *in_buf_b64,
+                                     bool has_in_count, int64_t in_count,
+                                     bool has_int_arg, int64_t int_arg,
+                                     Error **errp)
+{
+    GuestFileIOCTL *ioctl_data = NULL;
+    guchar *in_buf = NULL, *out_buf = NULL;
+    gsize in_buf_len;
+    BOOL is_ok;
+    GuestFileHandle *gfh = guest_file_handle_find(handle, errp);
+    DWORD bytes_returned;
+    HANDLE fh;
+
+    if (!gfh) {
+        return NULL;
+    }
+    fh = gfh->fh;
+    in_buf = qbase64_decode(in_buf_b64, -1, &in_buf_len, errp);
+    if (!in_buf) {
+        return NULL;
+    }
+    if (has_int_arg) {
+        error_setg(errp, "integer arguments are not supported");
+        goto done;
+    }
+
+    if (!has_in_count) {
+        in_count = in_buf_len;
+    } else if (in_count < 0 || in_count > in_buf_len) {
+        error_setg(errp, "value '%" PRId64
+                   "' is invalid for argument in-count", in_count);
+        goto done;
+    }
+
+    if (out_count < 0) {
+        error_setg(errp, "value '%" PRId64
+                   "' is invalid for argument out-count", out_count);
+        goto done;
+    }
+    if (out_count > 0) {
+        out_buf = g_malloc(out_count);
+    }
+
+    is_ok = DeviceIoControl(fh, code, in_buf, in_count, out_buf, out_count,
+                            &bytes_returned, NULL);
+    if (!is_ok) {
+        error_setg_win32(errp, GetLastError(), "failed to issue IOCTL to file");
+        slog("guest-file-ioctl-failed, handle: %" PRId64, handle);
+    } else {
+        ioctl_data = g_new0(GuestFileIOCTL, 1);
+        ioctl_data->retcode = is_ok;
+        ioctl_data->count = bytes_returned;
+        if (out_buf) {
+            ioctl_data->buf_b64 = g_base64_encode(out_buf, bytes_returned);
+        } else {
+            ioctl_data->buf_b64 = g_strdup("");
+        }
+    }
+
+done:
+    g_free(in_buf);
+    g_free(out_buf);
+    return ioctl_data;
+}
+
 GuestFileSeek *qmp_guest_file_seek(int64_t handle, int64_t offset,
                                    GuestFileWhence *whence_code,
                                    Error **errp)
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index d421609..efef6d9 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -298,6 +298,51 @@
   'data':    { 'handle': 'int', 'buf-b64': 'str', '*count': 'int' },
   'returns': 'GuestFileWrite' }
 
+##
+# @GuestFileIOCTL:
+#
+# Result of guest agent file-ioctl operation
+#
+# @retcode: return value of the IOCTL call
+#
+# @count: number of output bytes (note: count is *before*
+#         base64-encoding is applied)
+#
+# @buf-b64: base64-encoded output bytes
+#
+# Since: 2.9
+##
+{ 'struct': 'GuestFileIOCTL',
+  'data': { 'retcode': 'int', 'count': 'int', 'buf-b64': 'str' } }
+
+##
+# @guest-file-ioctl:
+#
+# Issue an IOCTL to an open file in the guest.
+#
+# @handle: filehandle returned by guest-file-open
+#
+# @code: device-dependent request code
+#
+# @out-count: output bytes expected to be returned by the IOCTL
+#
+# @in-buf-b64: base64-encoded string representing input data
+#
+# @in-count: #optional input bytes (actual bytes, after base64-decode),
+#            default is all content in in-buf-b64 buffer after base64 decoding
+#
+# @int-arg: #optional integer input argument to be used instead of buf-b64,
+#           it is an error to pass both a non-empty in-buf-b64 and int-arg
+#           and to pass both a non-zero out-count and int-arg
+#
+# Returns: @GuestFileIOCTL on success.
+#
+# Since: 2.9
+##
+{ 'command': 'guest-file-ioctl',
+  'data':    { 'handle': 'int', 'code': 'int', 'out-count': 'int',
+               'in-buf-b64': 'str', '*in-count': 'int', '*int-arg': 'int' },
+  'returns': 'GuestFileIOCTL' }
 
 ##
 # @GuestFileSeek:
-- 
2.7.4
