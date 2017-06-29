Received: from eggs.gnu.org ([2001:4830:134:3::10]:56148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dQgy4-0004Ch-KH
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dQgxz-0000uH-UF
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:27:16 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dQgxz-0000ti-KS
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:27:11 -0400
Received: by mail-wm0-f46.google.com with SMTP id b184so27670539wme.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 14:27:11 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Thu, 29 Jun 2017 23:27:04 +0200
Message-Id: <c9594284892b77e65645c9dfc804ebe3cb4552ca.1498771584.git.tgolembi@redhat.com>
In-Reply-To: <cover.1498771584.git.tgolembi@redhat.com>
References: <cover.1498771584.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 1/3] qemu-ga: add guest-get-osinfo command
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
 qga/commands-posix.c | 136 +++++++++++++++++++++++++++++++++++++
 qga/commands-win32.c | 185 +++++++++++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json |  65 ++++++++++++++++++
 3 files changed, 386 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index d8e412275e..2406518d47 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
+#include <sys/utsname.h>
 #include <sys/wait.h>
 #include <dirent.h>
 #include <utmpx.h>
@@ -2577,3 +2578,138 @@ GuestUserList *qmp_guest_get_users(Error **err)
     g_hash_table_destroy(cache);
     return head;
 }
+
+/* Replace escaped special characters with theire real values. The replacement
+ * is done in place -- returned value is in the original string.
+ */
+static void ga_osrelease_replace_special(gchar *value)
+{
+    gchar *p, *p2, quote;
+
+    /* Trim the string at first space or semicolon if it is not enclosed in
+     * single or double quotes. */
+    if ((value[0] != '"') || (value[0] == '\'')) {
+        p = strchr(value, ' ');
+        if (p != NULL) {
+            *p = 0;
+        }
+        p = strchr(value, ';');
+        if (p != NULL) {
+            *p = 0;
+        }
+        return;
+    }
+
+    quote = value[0];
+    p2 = value;
+    p = value+1;
+    while (*p != 0) {
+        if (*p == '\\') {
+            p++;
+            switch (*p) {
+                case '$':
+                case '\'':
+                case '"':
+                case '\\':
+                case '`':
+                    break;
+                default:
+                    /* Keep literal backslash followed by whatever is there */
+                    p--;
+                    break;
+            }
+        } else if (*p == quote) {
+            *p2 = 0;
+            break;
+        }
+        *(p2++) = *(p++);
+    }
+}
+
+static GKeyFile *ga_parse_osrelease(const char *fname)
+{
+    gboolean ret;
+    gchar *content = NULL;
+    gchar *content2 = NULL;
+    gsize len;
+    GError *err = NULL;
+    GKeyFile *keys = g_key_file_new();
+    const char *group = "[os-release]\n";
+
+    ret = g_file_get_contents(fname, &content, &len, &err);
+    if (ret != TRUE) {
+        slog("failed to read '%s', error: %s", fname, err->message);
+        goto fail;
+    }
+
+    ret = g_utf8_validate(content, len, NULL);
+    if (ret != TRUE) {
+        slog("file is not utf-8 encoded: %s", fname);
+        goto fail;
+    }
+    content2 = g_strdup_printf("%s%s", group, content);
+    len += strlen(group);
+
+    ret = g_key_file_load_from_data (keys, content2, len, G_KEY_FILE_NONE,
+        &err);
+    if (ret != TRUE) {
+        slog("failed to parse file '%s', error: %s", fname, err->message);
+        goto fail;
+    }
+
+    g_free(content);
+    g_free(content2);
+    return keys;
+
+fail:
+    g_error_free(err);
+    g_free(content);
+    g_free(content2);
+    g_key_file_free(keys);
+    return NULL;
+}
+
+GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
+{
+    GuestOSInfo *info = g_new0(GuestOSInfo, 1);
+
+    struct utsname kinfo = {0};
+    if (uname(&kinfo) != 0) {
+        error_setg_errno(errp, errno, "uname failed");
+        return NULL;
+    }
+
+    info->kernel_version = g_strdup(kinfo.version);
+    info->kernel_release = g_strdup(kinfo.release);
+    info->machine_hardware = g_strdup(kinfo.machine);
+
+    GKeyFile *osrelease = ga_parse_osrelease("/etc/os-release");
+    if (osrelease == NULL) {
+        osrelease = ga_parse_osrelease("/usr/lib/os-release");
+    }
+
+    if (osrelease != NULL) {
+        char *value;
+
+#define GET_FIELD(field, osfield) do { \
+    value = g_key_file_get_value(osrelease, "os-release", osfield, NULL); \
+    if (value != NULL) { \
+        ga_osrelease_replace_special(value); \
+        info->has_ ## field = true; \
+        info->field = value; \
+    } \
+} while (0)
+        GET_FIELD(id, "ID");
+        GET_FIELD(name, "NAME");
+        GET_FIELD(pretty_name, "PRETTY_NAME");
+        GET_FIELD(version, "VERSION");
+        GET_FIELD(version_id, "VERSION_ID");
+        GET_FIELD(variant, "VARIANT");
+        GET_FIELD(variant_id, "VARIANT_ID");
+#undef GET_FIELD
+
+        g_key_file_free(osrelease);
+    }
+
+    return info;
+}
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 439d229225..a451c6e8dd 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1639,3 +1639,188 @@ GuestUserList *qmp_guest_get_users(Error **err)
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
+static void ga_get_win_version(RTL_OSVERSIONINFOEXW *info, Error **errp)
+{
+    typedef NTSTATUS(WINAPI * rtl_get_version_t)(
+        RTL_OSVERSIONINFOEXW *os_version_info_ex);
+
+    info->dwOSVersionInfoSize = sizeof(RTL_OSVERSIONINFOEXW);
+
+    HMODULE module = GetModuleHandle("ntdll");
+    PVOID fun = GetProcAddress(module, "RtlGetVersion");
+    if (fun != NULL) {
+        error_setg(errp, QERR_QGA_COMMAND_FAILED,
+            "Failed to get address of RtlGetVersion");
+        return;
+    }
+
+    rtl_get_version_t rtl_get_version = (rtl_get_version_t)fun;
+    rtl_get_version(info);
+    return;
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
+static char *ga_get_win_product_name(Error **errp)
+{
+    HKEY key = NULL;
+    DWORD size = 128;
+    char *result = g_malloc0(size);
+    LONG err = ERROR_SUCCESS;
+
+    err = RegOpenKeyA(HKEY_LOCAL_MACHINE,
+                      "SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion",
+                      &key);
+    if (err != ERROR_SUCCESS) {
+        error_setg_win32(errp, err, "failed to open registry key");
+        goto fail;
+    }
+
+    err = RegQueryValueExA(key, "ProductName", NULL, NULL,
+                            (LPBYTE)result, &size);
+    if (err == ERROR_MORE_DATA) {
+        slog("ProductName longer than expected (%lu bytes), retrying",
+                size);
+        g_free(result);
+        result = NULL;
+        if (size > 0) {
+            result = g_malloc0(size);
+            err = RegQueryValueExA(key, "ProductName", NULL, NULL,
+                                    (LPBYTE)result, &size);
+        }
+    }
+    if (err != ERROR_SUCCESS) {
+        error_setg_win32(errp, err, "failed to retrive ProductName");
+        goto fail;
+    }
+
+    return result;
+
+fail:
+    g_free(result);
+    return NULL;
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
+    Error *local_err = NULL;
+    OSVERSIONINFOEXW os_version = {0};
+
+    ga_get_win_version(&os_version, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    bool server = os_version.wProductType != VER_NT_WORKSTATION;
+    char *product_name = ga_get_win_product_name(&local_err);
+    if (product_name == NULL) {
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
index 03743ab905..3d9478c10b 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1126,3 +1126,68 @@
 ##
 { 'command': 'guest-get-timezone',
   'returns': 'GuestTimezone' }
+
+##
+# @GuestOSInfo:
+#
+# @kernel-release:
+#     * _POSIX:_ release field returned by uname(2)
+#     * _Windows:_ version number of the OS
+# @kernel-version:
+#     * _POSIX:_ version field returned by uname(2)
+#     * _Windows:_ build number of the OS
+# @machine-hardware:
+#     * _POSIX:_ machine field returned by uname(2)
+#     * _Windows:_ architecture of the hardware
+# @id:
+#     * _POSIX:_ as defined by os-release(5)
+#     * _Windows:_ contains string "mswindows"
+# @name:
+#     * _POSIX:_ as defined by os-release(5)
+#     * _Windows:_ contains string "Microsoft Windows"
+# @pretty-name:
+#     * _POSIX:_ as defined by os-release(5)
+#     * _Windows:_ product name, e.g. "Microsoft Windows 10 Enterprise"
+# @version:
+#     * _POSIX:_ as defined by os-release(5)
+#     * _Windows:_ long version string, e.g. "Microsoft Windows Server 2008"
+# @version-id:
+#     * _POSIX:_ as defined by os-release(5)
+#     * _Windows:_ short version identifier, e.g. "7" or "20012r2"
+# @variant:
+#     * _POSIX:_ as defined by os-release(5)
+#     * _Windows:_ contains string "server" or "client"
+# @variant-id:
+#     * _POSIX:_ as defined by os-release(5)
+#     * _Windows:_ contains string "server" or "client"
+#
+# Notes:
+#
+# On POSIX systems the fields @id, @name, @pretty-name, @version, @version-id,
+# @variant and @variant-id follow the definition specified in os-release(5).
+# Refer to the manual page for exact description of the fields. Their values
+# are taken from the os-release file. If the file is not present in the system,
+# or the values are not present in the file, the fields are not included.
+#
+# On Windows the values are filled from information gathered from the system.
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
+# Returns: @GuestOSInfo
+#
+# Since: 2.10
+##
+{ 'command': 'guest-get-osinfo',
+  'returns': 'GuestOSInfo' }
-- 
2.13.1
