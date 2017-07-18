Received: from eggs.gnu.org ([2001:4830:134:3::10]:48670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dXKwN-0000Wt-EW
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dXKwK-0005bV-4k
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:20:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dXKwJ-0005af-Qh
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:20:56 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6I5JMfu090328
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:20:54 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bs1svyr5y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:20:54 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 17 Jul 2017 23:20:53 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 18 Jul 2017 00:20:14 -0500
In-Reply-To: <1500355216-23603-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1500355216-23603-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1500355216-23603-7-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/8] qemu-ga: add guest-get-osinfo command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>, Vinzenz Feenstra <vfeenstr@redhat.com>

From: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

Add a new 'guest-get-osinfo' command for reporting basic information of
the guest operating system. This includes machine architecture,
version and release of the kernel and several fields from os-release
file if it is present (as defined in [1]).

[1] https://www.freedesktop.org/software/systemd/man/os-release.html

Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c | 134 ++++++++++++++++++++++++++++++++++++
 qga/commands-win32.c | 188 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
 qga/qapi-schema.json |  65 ++++++++++++++++++
 3 files changed, 387 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index e7a047e..672bf29 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
+#include <sys/utsname.h>
 #include <sys/wait.h>
 #include <dirent.h>
 #include "qga/guest-agent-core.h"
@@ -2592,3 +2593,136 @@ GuestUserList *qmp_guest_get_users(Error **errp)
 }
=20
 #endif
+
+/* Replace escaped special characters with theire real values. The repla=
cement
+ * is done in place -- returned value is in the original string.
+ */
+static void ga_osrelease_replace_special(gchar *value)
+{
+    gchar *p, *p2, quote;
+
+    /* Trim the string at first space or semicolon if it is not enclosed=
 in
+     * single or double quotes. */
+    if ((value[0] !=3D '"') || (value[0] =3D=3D '\'')) {
+        p =3D strchr(value, ' ');
+        if (p !=3D NULL) {
+            *p =3D 0;
+        }
+        p =3D strchr(value, ';');
+        if (p !=3D NULL) {
+            *p =3D 0;
+        }
+        return;
+    }
+
+    quote =3D value[0];
+    p2 =3D value;
+    p =3D value + 1;
+    while (*p !=3D 0) {
+        if (*p =3D=3D '\\') {
+            p++;
+            switch (*p) {
+            case '$':
+            case '\'':
+            case '"':
+            case '\\':
+            case '`':
+                break;
+            default:
+                /* Keep literal backslash followed by whatever is there =
*/
+                p--;
+                break;
+            }
+        } else if (*p =3D=3D quote) {
+            *p2 =3D 0;
+            break;
+        }
+        *(p2++) =3D *(p++);
+    }
+}
+
+static GKeyFile *ga_parse_osrelease(const char *fname)
+{
+    gchar *content =3D NULL;
+    gchar *content2 =3D NULL;
+    GError *err =3D NULL;
+    GKeyFile *keys =3D g_key_file_new();
+    const char *group =3D "[os-release]\n";
+
+    if (!g_file_get_contents(fname, &content, NULL, &err)) {
+        slog("failed to read '%s', error: %s", fname, err->message);
+        goto fail;
+    }
+
+    if (!g_utf8_validate(content, -1, NULL)) {
+        slog("file is not utf-8 encoded: %s", fname);
+        goto fail;
+    }
+    content2 =3D g_strdup_printf("%s%s", group, content);
+
+    if (!g_key_file_load_from_data(keys, content2, -1, G_KEY_FILE_NONE,
+                                   &err)) {
+        slog("failed to parse file '%s', error: %s", fname, err->message=
);
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
+    GuestOSInfo *info =3D NULL;
+    struct utsname kinfo =3D {0};
+
+    info =3D g_new0(GuestOSInfo, 1);
+
+    if (uname(&kinfo) !=3D 0) {
+        error_setg_errno(errp, errno, "uname failed");
+    } else {
+        info->has_kernel_version =3D true;
+        info->kernel_version =3D g_strdup(kinfo.version);
+        info->has_kernel_release =3D true;
+        info->kernel_release =3D g_strdup(kinfo.release);
+        info->has_machine =3D true;
+        info->machine =3D g_strdup(kinfo.machine);
+    }
+
+    GKeyFile *osrelease =3D ga_parse_osrelease("/etc/os-release");
+    if (osrelease =3D=3D NULL) {
+        osrelease =3D ga_parse_osrelease("/usr/lib/os-release");
+    }
+
+    if (osrelease !=3D NULL) {
+        char *value;
+
+#define GET_FIELD(field, osfield) do { \
+    value =3D g_key_file_get_value(osrelease, "os-release", osfield, NUL=
L); \
+    if (value !=3D NULL) { \
+        ga_osrelease_replace_special(value); \
+        info->has_ ## field =3D true; \
+        info->field =3D value; \
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
index 6f16457..524c71b 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1642,3 +1642,191 @@ GuestUserList *qmp_guest_get_users(Error **err)
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
+static ga_matrix_lookup_t const WIN_VERSION_MATRIX[2][8] =3D {
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
+    info->dwOSVersionInfoSize =3D sizeof(RTL_OSVERSIONINFOEXW);
+
+    HMODULE module =3D GetModuleHandle("ntdll");
+    PVOID fun =3D GetProcAddress(module, "RtlGetVersion");
+    if (fun =3D=3D NULL) {
+        error_setg(errp, QERR_QGA_COMMAND_FAILED,
+            "Failed to get address of RtlGetVersion");
+        return;
+    }
+
+    rtl_get_version_t rtl_get_version =3D (rtl_get_version_t)fun;
+    rtl_get_version(info);
+    return;
+}
+
+static char *ga_get_win_name(OSVERSIONINFOEXW const *os_version, bool id=
)
+{
+    DWORD major =3D os_version->dwMajorVersion;
+    DWORD minor =3D os_version->dwMinorVersion;
+    int tbl_idx =3D (os_version->wProductType !=3D VER_NT_WORKSTATION);
+    ga_matrix_lookup_t const *table =3D WIN_VERSION_MATRIX[tbl_idx];
+    while (table->version !=3D NULL) {
+        if (major =3D=3D table->major && minor =3D=3D table->minor) {
+            if (id) {
+                return g_strdup(table->version_id);
+            } else {
+                return g_strdup(table->version);
+            }
+        }
+        ++table;
+    }
+    slog("failed to lookup Windows version: major=3D%lu, minor=3D%lu",
+        major, minor);
+    return g_strdup("N/A");
+}
+
+static char *ga_get_win_product_name(Error **errp)
+{
+    HKEY key =3D NULL;
+    DWORD size =3D 128;
+    char *result =3D g_malloc0(size);
+    LONG err =3D ERROR_SUCCESS;
+
+    err =3D RegOpenKeyA(HKEY_LOCAL_MACHINE,
+                      "SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion",
+                      &key);
+    if (err !=3D ERROR_SUCCESS) {
+        error_setg_win32(errp, err, "failed to open registry key");
+        goto fail;
+    }
+
+    err =3D RegQueryValueExA(key, "ProductName", NULL, NULL,
+                            (LPBYTE)result, &size);
+    if (err =3D=3D ERROR_MORE_DATA) {
+        slog("ProductName longer than expected (%lu bytes), retrying",
+                size);
+        g_free(result);
+        result =3D NULL;
+        if (size > 0) {
+            result =3D g_malloc0(size);
+            err =3D RegQueryValueExA(key, "ProductName", NULL, NULL,
+                                    (LPBYTE)result, &size);
+        }
+    }
+    if (err !=3D ERROR_SUCCESS) {
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
+    char *result =3D NULL;
+    switch (info.wProcessorArchitecture) {
+    case PROCESSOR_ARCHITECTURE_AMD64:
+        result =3D g_strdup("x86_64");
+        break;
+    case PROCESSOR_ARCHITECTURE_ARM:
+        result =3D g_strdup("arm");
+        break;
+    case PROCESSOR_ARCHITECTURE_IA64:
+        result =3D g_strdup("ia64");
+        break;
+    case PROCESSOR_ARCHITECTURE_INTEL:
+        result =3D g_strdup("x86");
+        break;
+    case PROCESSOR_ARCHITECTURE_UNKNOWN:
+    default:
+        slog("unknown processor architecture 0x%0x",
+            info.wProcessorArchitecture);
+        result =3D g_strdup("unknown");
+        break;
+    }
+    return result;
+}
+
+GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
+{
+    Error *local_err =3D NULL;
+    OSVERSIONINFOEXW os_version =3D {0};
+
+    ga_get_win_version(&os_version, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    bool server =3D os_version.wProductType !=3D VER_NT_WORKSTATION;
+    char *product_name =3D ga_get_win_product_name(&local_err);
+    if (product_name =3D=3D NULL) {
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    GuestOSInfo *info =3D g_new0(GuestOSInfo, 1);
+
+    info->has_kernel_version =3D true;
+    info->kernel_version =3D g_strdup_printf("%lu.%lu",
+        os_version.dwMajorVersion,
+        os_version.dwMinorVersion);
+    info->has_kernel_release =3D true;
+    info->kernel_release =3D g_strdup_printf("%lu",
+        os_version.dwBuildNumber);
+    info->has_machine =3D true;
+    info->machine =3D ga_get_current_arch();
+
+    info->has_id =3D true;
+    info->id =3D g_strdup("mswindows");
+    info->has_name =3D true;
+    info->name =3D g_strdup("Microsoft Windows");
+    info->has_pretty_name =3D true;
+    info->pretty_name =3D product_name;
+    info->has_version =3D true;
+    info->version =3D ga_get_win_name(&os_version, false);
+    info->has_version_id =3D true;
+    info->version_id =3D ga_get_win_name(&os_version, true);
+    info->has_variant =3D true;
+    info->variant =3D g_strdup(server ? "server" : "client");
+    info->has_variant_id =3D true;
+    info->variant_id =3D g_strdup(server ? "server" : "client");
+
+    return info;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 03743ab..90a0c86 100644
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
+#     * POSIX: release field returned by uname(2)
+#     * Windows: version number of the OS
+# @kernel-version:
+#     * POSIX: version field returned by uname(2)
+#     * Windows: build number of the OS
+# @machine:
+#     * POSIX: machine field returned by uname(2)
+#     * Windows: one of x86, x86_64, arm, ia64
+# @id:
+#     * POSIX: as defined by os-release(5)
+#     * Windows: contains string "mswindows"
+# @name:
+#     * POSIX: as defined by os-release(5)
+#     * Windows: contains string "Microsoft Windows"
+# @pretty-name:
+#     * POSIX: as defined by os-release(5)
+#     * Windows: product name, e.g. "Microsoft Windows 10 Enterprise"
+# @version:
+#     * POSIX: as defined by os-release(5)
+#     * Windows: long version string, e.g. "Microsoft Windows Server 200=
8"
+# @version-id:
+#     * POSIX: as defined by os-release(5)
+#     * Windows: short version identifier, e.g. "7" or "20012r2"
+# @variant:
+#     * POSIX: as defined by os-release(5)
+#     * Windows: contains string "server" or "client"
+# @variant-id:
+#     * POSIX: as defined by os-release(5)
+#     * Windows: contains string "server" or "client"
+#
+# Notes:
+#
+# On POSIX systems the fields @id, @name, @pretty-name, @version, @versi=
on-id,
+# @variant and @variant-id follow the definition specified in os-release=
(5).
+# Refer to the manual page for exact description of the fields. Their va=
lues
+# are taken from the os-release file. If the file is not present in the =
system,
+# or the values are not present in the file, the fields are not included.
+#
+# On Windows the values are filled from information gathered from the sy=
stem.
+#
+# Since: 2.10
+##
+{ 'struct': 'GuestOSInfo',
+  'data': {
+      '*kernel-release': 'str', '*kernel-version': 'str',
+      '*machine': 'str', '*id': 'str', '*name': 'str',
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
--=20
2.7.4
