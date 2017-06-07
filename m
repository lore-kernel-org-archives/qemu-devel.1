Received: from eggs.gnu.org ([2001:4830:134:3::10]:59596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dIZfD-0008RC-Nb
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dIZf9-0002es-PZ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:02:15 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dIZf9-0002eL-FL
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:02:11 -0400
Received: by mail-wm0-f42.google.com with SMTP id d64so9189126wmf.1
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 05:02:11 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Wed,  7 Jun 2017 14:02:06 +0200
Message-Id: <930101cb4053f016ba6880bb4d93618ece4a9102.1496836915.git.tgolembi@redhat.com>
In-Reply-To: <cover.1496836915.git.tgolembi@redhat.com>
References: <cover.1496836915.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 1/1] qemu-ga: add guest-get-osinfo command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Add a new 'guest-get-osinfo' command for reporting basic information of
the guest operating system. This includes machine architecture,
version and release of the kernel and several fields from os-release
file if it is present (as defined in [1]).

[1] https://www.freedesktop.org/software/systemd/man/os-release.html

Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 configure            |   2 +-
 qga/commands-posix.c | 160 ++++++++++++++++++++++++++++++++++++++++++++++++
 qga/commands-win32.c | 170 +++++++++++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json |  57 +++++++++++++++++
 4 files changed, 388 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 21944eaa05..94e294e350 100755
--- a/configure
+++ b/configure
@@ -3131,7 +3131,7 @@ if test "$mingw32" = yes; then
 else
     glib_req_ver=2.22
 fi
-glib_modules=gthread-2.0
+glib_modules="gthread-2.0 gio-2.0"
 if test "$modules" = yes; then
     glib_modules="$glib_modules gmodule-2.0"
 fi
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 284ecc6d7e..48b812e013 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -13,9 +13,11 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
+#include <sys/utsname.h>
 #include <sys/wait.h>
 #include <dirent.h>
 #include <utmpx.h>
+#include <gio/gio.h>
 #include "qga/guest-agent-core.h"
 #include "qga-qmp-commands.h"
 #include "qapi/qmp/qerror.h"
@@ -2579,3 +2581,161 @@ GuestUserList *qmp_guest_get_users(Error **err)
     g_hash_table_destroy(cache);
     return head;
 }
+
+static GHashTable *ga_parse_osrelease(const char *fname)
+{
+    GFile *f;
+    GFileInputStream *fis = NULL;
+    GDataInputStream *dis = NULL;
+    GError *err = NULL;
+    gsize length;
+    char *line;
+    char *value;
+    GHashTable *tbl = NULL;
+
+    /* Open the file */
+    f = g_file_new_for_path(fname);
+    fis = g_file_read(f, NULL, &err);
+    if (err != NULL) {
+        slog("failed to open file '%s', error: %s", fname, err->message);
+        g_error_free(err);
+        g_object_unref(f);
+        return NULL;
+    }
+    dis = g_data_input_stream_new(G_INPUT_STREAM(fis));
+
+    err = NULL;
+    tbl = g_hash_table_new_full(g_str_hash, g_str_equal, g_free, g_free);
+    /* Go through all lines */
+    line = NULL;
+    while (err == NULL) {
+        g_free(line);
+        line = g_data_input_stream_read_line(dis, &length, NULL, &err);
+        if (err != NULL) {
+            slog("failed to read line from file '%s', error: %s",
+                fname, err->message);
+            g_error_free(err);
+            break;
+        } else if (line == NULL) {
+            /* EOF */
+            break;
+        }
+        if (g_utf8_validate(line, length, NULL) == FALSE) {
+            slog("file '%s' contains non-UTF8 content", fname);
+            break;
+        } else if (length == 0 || line[0] == '#') {
+            continue;
+        }
+
+        value = strchr(line, '=');
+        if (value == NULL) {
+            continue;
+        }
+        value[0] = 0;
+        value++;
+
+        if ((value[0] == '"') || (value[0] == '\'')) {
+            char *p;
+            char end = value[0];
+            value++;
+            p = value;
+            while (*p != 0) {
+                if (*p == '\\') {
+                    switch (*(p + 1)) {
+                    case '\'':
+                    case '"':
+                    case '$':
+                    case '`':
+                        memmove(p, p + 1, strlen(p + 1));
+                        break;
+                    default:
+                        /* Keep literal backslash */
+                        p++;
+                        break;
+                    }
+                    if (*p != 0) {
+                        p++;
+                    }
+                    continue;
+                }
+                if (*p == end) {
+                    *p = 0;
+                    break;
+                }
+                p++;
+            }
+        }
+        g_hash_table_insert(tbl, g_strdup(line), g_strdup(value));
+    }
+    g_free(line);
+
+    g_object_unref(fis);
+    g_object_unref(dis);
+    g_object_unref(f);
+
+    return tbl;
+}
+
+GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
+{
+    GuestOSInfo *info = g_new0(GuestOSInfo, 1);
+    memset(info, 0, sizeof(GuestOSInfo));
+
+    struct utsname kinfo;
+    uname(&kinfo);
+
+    info->kernel_version = g_strdup(kinfo.version);
+    info->kernel_release = g_strdup(kinfo.release);
+    info->machine_hardware = g_strdup(kinfo.machine);
+
+    GHashTable *osrelease = ga_parse_osrelease("/etc/os-release");
+    if (osrelease == NULL) {
+        slog("could not read /etc/os-release");
+        osrelease = ga_parse_osrelease("/usr/lib/os-release");
+        if (osrelease == NULL) {
+            slog("could not read /usr/lib/os-release");
+        }
+    }
+
+    if (osrelease != NULL) {
+        char *value;
+        value = g_hash_table_lookup(osrelease, "ID");
+        if (value != NULL) {
+            info->has_id = true;
+            info->id = g_strdup(value);
+        }
+        value = g_hash_table_lookup(osrelease, "PRETTY_NAME");
+        if (value != NULL) {
+            info->has_pretty_name = true;
+            info->pretty_name = g_strdup(value);
+        }
+        value = g_hash_table_lookup(osrelease, "NAME");
+        if (value != NULL) {
+            info->has_name = true;
+            info->name = g_strdup(value);
+        }
+        value = g_hash_table_lookup(osrelease, "VERSION");
+        if (value != NULL) {
+            info->has_version = true;
+            info->version = g_strdup(value);
+        }
+        value = g_hash_table_lookup(osrelease, "VERSION_ID");
+        if (value != NULL) {
+            info->has_version_id = true;
+            info->version_id = g_strdup(value);
+        }
+        value = g_hash_table_lookup(osrelease, "VARIANT");
+        if (value != NULL) {
+            info->has_variant = true;
+            info->variant = g_strdup(value);
+        }
+        value = g_hash_table_lookup(osrelease, "VARIANT_ID");
+        if (value != NULL) {
+            info->has_variant_id = true;
+            info->variant_id = g_strdup(value);
+        }
+        g_hash_table_destroy(osrelease);
+    }
+
+    return info;
+}
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 439d229225..f9867baf1f 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1639,3 +1639,173 @@ GuestUserList *qmp_guest_get_users(Error **err)
     return NULL;
 #endif
 }
+
+typedef struct _ga_matrix_lookup_t {
+    int major;
+    int minor;
+    char const *version;
+    char const *version_id;
+} ga_matrix_lookup_t;
+
+static ga_matrix_lookup_t const WIN_VERSION_MATRIX[2][8] = {
+    {
+        /* Desktop editions */
+        { 5, 0, "Microsoft Windows 2000",   "2000"},
+        { 5, 1, "Microsoft Windows XP",     "xp"},
+        { 6, 0, "Microsoft Windows Vista",  "vista"},
+        { 6, 1, "Microsoft Windows 7"       "7"},
+        { 6, 2, "Microsoft Windows 8",      "8"},
+        { 6, 3, "Microsoft Windows 8.1",    "8.1"},
+        {10, 0, "Microsoft Windows 10",     "10"},
+        { 0, 0, 0}
+    },{
+        /* Server editions */
+        { 5, 2, "Microsoft Windows Server 2003",        "2003"},
+        { 6, 0, "Microsoft Windows Server 2008",        "2008"},
+        { 6, 1, "Microsoft Windows Server 2008 R2",     "2008r2"},
+        { 6, 2, "Microsoft Windows Server 2012",        "2012"},
+        { 6, 3, "Microsoft Windows Server 2012 R2",     "2012r2"},
+        {10, 0, "Microsoft Windows Server 2016",        "2016"},
+        { 0, 0, 0},
+        { 0, 0, 0}
+    }
+};
+
+static void ga_get_win_version(RTL_OSVERSIONINFOEXW *info)
+{
+    info->dwOSVersionInfoSize = sizeof(RTL_OSVERSIONINFOEXW);
+
+    typedef NTSTATUS(WINAPI * rtl_get_version_t)(
+        RTL_OSVERSIONINFOEXW *os_version_info_ex);
+    HMODULE module = GetModuleHandle("ntdll");
+    PVOID fun = GetProcAddress(module, "RtlGetVersion");
+    rtl_get_version_t rtl_get_version = (rtl_get_version_t)fun;
+    rtl_get_version(info);
+}
+
+static char *ga_get_win_name(OSVERSIONINFOEXW const *os_version, bool id)
+{
+    DWORD major = os_version->dwMajorVersion;
+    DWORD minor = os_version->dwMinorVersion;
+    int tbl_idx = (os_version->wProductType != VER_NT_WORKSTATION);
+    ga_matrix_lookup_t const *table = WIN_VERSION_MATRIX[tbl_idx];
+    while (table->version != NULL) {
+        if (major == table->major && minor == table->minor) {
+            if (id) {
+                return g_strdup(table->version_id);
+            } else {
+                return g_strdup(table->version);
+            }
+        }
+        ++table;
+    }
+    slog("failed to lookup Windows version: major=%lu, minor=%lu",
+        major, minor);
+    return g_strdup("N/A");
+}
+
+static char *ga_get_win_product_name(void)
+{
+    HKEY key = NULL;
+    DWORD size = 128;
+    char *result = g_malloc0(size);
+    memset(result, 0, size);
+    LONG err = ERROR_SUCCESS;
+
+    err = RegOpenKeyA(HKEY_LOCAL_MACHINE,
+                      "SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion",
+                      &key);
+    if (err == ERROR_SUCCESS) {
+        err = RegQueryValueExA(key, "ProductName", NULL, NULL,
+                               (LPBYTE)result, &size);
+        if (err == ERROR_MORE_DATA) {
+            slog("ProductName longer than expected (%lu bytes), retrying",
+                 size);
+            g_free(result);
+            result = NULL;
+            if (size > 0) {
+                result = g_malloc0(size);
+                err = RegQueryValueExA(key, "ProductName", NULL, NULL,
+                                       (LPBYTE)result, &size);
+                if (err != ERROR_SUCCESS) {
+                    g_free(result);
+                    result = NULL;
+                }
+            }
+        }
+        if (err != ERROR_SUCCESS) {
+            slog("failed to retrive ProductName");
+        }
+    }
+    return result;
+}
+
+static char *ga_get_current_arch(void)
+{
+    SYSTEM_INFO info;
+    GetNativeSystemInfo(&info);
+    char *result = NULL;
+    switch (info.wProcessorArchitecture) {
+    case PROCESSOR_ARCHITECTURE_AMD64:
+        result = g_strdup("x86_64");
+        break;
+    case PROCESSOR_ARCHITECTURE_ARM:
+        result = g_strdup("arm");
+        break;
+    case PROCESSOR_ARCHITECTURE_IA64:
+        result = g_strdup("ia64");
+        break;
+    case PROCESSOR_ARCHITECTURE_INTEL:
+        result = g_strdup("x86");
+        break;
+    case PROCESSOR_ARCHITECTURE_UNKNOWN:
+    default:
+        slog("unknown processor architecture 0x%0x",
+            info.wProcessorArchitecture);
+        result = g_strdup("unknown");
+        break;
+    }
+    return result;
+}
+
+GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
+{
+    OSVERSIONINFOEXW os_version;
+    ga_get_win_version(&os_version);
+
+    bool server = os_version.wProductType != VER_NT_WORKSTATION;
+    char *product_name = ga_get_win_product_name();
+    if (product_name == NULL) {
+        Error *local_err = NULL;
+        error_setg(&local_err, QERR_QGA_COMMAND_FAILED,
+                   "failed to retrieve ProductName from registry");
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    GuestOSInfo *info = g_new0(GuestOSInfo, 1);
+
+    info->kernel_version = g_strdup_printf("%lu.%lu",
+        os_version.dwMajorVersion,
+        os_version.dwMinorVersion);
+    info->kernel_release = g_strdup_printf("%lu",
+        os_version.dwBuildNumber);
+    info->machine_hardware = ga_get_current_arch();
+
+    info->has_id = true;
+    info->id = g_strdup("mswindows");
+    info->has_name = true;
+    info->name = g_strdup("Microsoft Windows");
+    info->has_pretty_name = true;
+    info->pretty_name = product_name;
+    info->has_version = true;
+    info->version = ga_get_win_name(&os_version, false);
+    info->has_version_id = true;
+    info->version_id = ga_get_win_name(&os_version, true);
+    info->has_variant = true;
+    info->variant = g_strdup(server ? "server" : "client");
+    info->has_variant_id = true;
+    info->variant_id = g_strdup(server ? "server" : "client");
+
+    return info;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 03743ab905..eb565da345 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1126,3 +1126,60 @@
 ##
 { 'command': 'guest-get-timezone',
   'returns': 'GuestTimezone' }
+
+##
+# @GuestOSInfo:
+#
+# Notes:
+#
+# The fields @id, @name, @pretty-name, @version, @version-id, @variant and
+# @variant-id follow the definition specified in os-release(5). Refer to the
+# manual page for exact description of the fields.
+#
+# On POSIX systems:
+#
+# kernel-release: release field returned by uname(2)
+# kernel-version': version field returned by uname(2)
+# machine-hardware': machine field returned by uname(2)
+# id: as defined by os-release(5)
+# name: as defined by os-release(5)
+# pretty-name: as defined by os-release(5)
+# version: as defined by os-release(5)
+# version-id: as defined by os-release(5)
+# variant: as defined by os-release(5)
+# variant-id: as defined by os-release(5)
+#
+#
+# On Windows:
+#
+# kernel-release: version number of the OS
+# kernel-version': build number of the OS
+# machine-hardware': architecture of the hardware
+# id: contains string "mswindows"
+# name: contains string "Microsoft Windows"
+# pretty-name: product name, e.g. "Microsoft Windows 10 Enterprise"
+# version: long version string, e.g. "Microsoft Windows Server 2008"
+# version-id: short version identifier, e.g. "7" or "20012r2"
+# variant: contains string "server" or "client"
+# variant-id: contains string "server" or "client"
+#
+# Since: 2.10
+##
+{ 'struct': 'GuestOSInfo',
+  'data': {
+      'kernel-release': 'str', 'kernel-version': 'str',
+      'machine-hardware': 'str', '*id': 'str', '*name': 'str',
+      '*pretty-name': 'str', '*version': 'str', '*version-id': 'str',
+      '*variant': 'str', '*variant-id': 'str' } }
+
+##
+# @guest-get-osinfo:
+#
+# Retrieve guest operating system information
+#
+# Returns: operating system information on success
+#
+# Since 2.10
+##
+{ 'command': 'guest-get-osinfo',
+  'returns': 'GuestOSInfo' }
-- 
2.13.0
