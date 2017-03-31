Received: from eggs.gnu.org ([2001:4830:134:3::10]:49944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cttew-0006VL-D1
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cttet-0004dG-Qv
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:19:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cttet-0004d6-HV
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:19:55 -0400
From: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Date: Fri, 31 Mar 2017 12:19:47 +0200
Message-Id: <20170331101947.2046-2-vfeenstr@redhat.com>
In-Reply-To: <20170331101947.2046-1-vfeenstr@redhat.com>
References: <20170331101947.2046-1-vfeenstr@redhat.com>
Subject: [Qemu-devel] [PATCH v3] qemu-ga: add guest-get-osrelease command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, mdroth@linux.vnet.ibm.com, marcandre.lureau@gmail.com, Vinzenz Feenstra <vfeenstr@redhat.com>

From: Vinzenz Feenstra <vfeenstr@redhat.com>

Add a new 'guest-get-osrelease' command to report OS information in the
os-release format. As documented here:
https://www.freedesktop.org/software/systemd/man/os-release.html

The win32 implementation generates the information.
On POSIX systems the /etc/os-release or /usr/lib/os-release files
content is returned when available and gets extended with the fields:
- QGA_UNAME_RELEASE which is the content of `uname -r`
- QGA_UNAME_VERSION which is the content of `uname -v`
- QGA_UNAME_MACHINE which is the content of `uname -m`

Here an example for a Fedora 25 VM:

virsh # qemu-agent-command F25 '{ "execute": "guest-get-osrelease" }'
{"return":{"content":"NAME=Fedora\nVERSION=\"25 (Server Edition)\"\n
ID=fedora\nVERSION_ID=25\nPRETTY_NAME=\"Fedora 25 (Server Edition)\"\n
ANSI_COLOR=\"0;34\"\nCPE_NAME=\"cpe:/o:fedoraproject:fedora:25\"\n
HOME_URL=\"https://fedoraproject.org/\"\n
BUG_REPORT_URL=\"https://bugzilla.redhat.com/\"\n
REDHAT_BUGZILLA_PRODUCT=\"Fedora\"\n
REDHAT_BUGZILLA_PRODUCT_VERSION=25\nREDHAT_SUPPORT_PRODUCT=\"Fedora\"\n
REDHAT_SUPPORT_PRODUCT_VERSION=25\n
PRIVACY_POLICY_URL=https://fedoraproject.org/wiki/Legal:PrivacyPolicy\n
VARIANT=\"Server Edition\"\nVARIANT_ID=server\n\n
QGA_UNAME_RELEASE=\"4.8.6-300.fc25.x86_64\"\n
QGA_UNAME_VERSION=\"#1 SMP Tue Nov 1 12:36:38 UTC 2016\"\n
QGA_UNAME_MACHINE=\"x86_64\"\n"}}

And an example for a Windows 2012 R2 VM:

virsh # qemu-agent-command Win2k12r2 '{ "execute": "guest-get-osrelease" }'
{"return":{"content":"NAME=\"Microsoft Windows\"\nID=mswindows\n
VERSION=\"Microsoft Windows Server 2012 R2 (6.3)\"\nVERSION_ID=6.3\n
PRETTY_NAME=\"Windows Server 2012 R2 Datacenter\"\nVARIANT=\"server\"\n
VARIANT_ID=server\n"}}

Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
---
 qga/commands-posix.c |  41 +++++++++++++++++
 qga/commands-win32.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json |  29 ++++++++++++
 3 files changed, 197 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 73d93eb..0a1fa28 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
+#include <sys/utsname.h>
 #include <sys/wait.h>
 #include <dirent.h>
 #include "qga/guest-agent-core.h"
@@ -2418,6 +2419,12 @@ GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
     return NULL;
 }
 
+GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
+
 #endif
 
 #if !defined(CONFIG_FSFREEZE)
@@ -2515,3 +2522,37 @@ void ga_command_state_init(GAState *s, GACommandState *cs)
     ga_command_state_add(cs, NULL, guest_fsfreeze_cleanup);
 #endif
 }
+
+GuestOSRelease *qmp_guest_get_osrelease(Error **errp)
+{
+    GuestOSRelease *info = g_new0(GuestOSRelease, 1);
+    memset(info, 0, sizeof(GuestOSRelease));
+
+    struct utsname kinfo;
+    uname(&kinfo);
+
+    if (!g_file_get_contents("/etc/os-release", &info->content, NULL,
+                             NULL)){
+        g_file_get_contents("/usr/lib/os-release", &info->content,
+                            NULL, NULL);
+    }
+
+    char *extension = g_strdup_printf(
+        "\n"
+        "QGA_UNAME_RELEASE=\"%s\"\n"
+        "QGA_UNAME_VERSION=\"%s\"\n"
+        "QGA_UNAME_MACHINE=\"%s\"\n",
+        kinfo.release,
+        kinfo.version,
+        kinfo.machine
+    );
+    if (info->content != NULL) {
+        char *previous = info->content;
+        info->content = g_strconcat(previous, extension, NULL);
+        g_free(previous);
+    } else {
+        info->content = extension;
+    }
+    return info;
+}
+
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 19d72b2..a1c217e 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1536,3 +1536,130 @@ void ga_command_state_init(GAState *s, GACommandState *cs)
         ga_command_state_add(cs, NULL, guest_fsfreeze_cleanup);
     }
 }
+
+typedef struct _ga_matrix_lookup_t {
+    int major;
+    int minor;
+    char const *name;
+} ga_matrix_lookup_t;
+
+static ga_matrix_lookup_t const WIN_VERSION_MATRIX[2][8] = {
+    {
+        { 5, 0, "Microsoft Windows 2000"},
+        { 5, 1, "Microsoft Windows XP"},
+        { 6, 0, "Microsoft Windows Vista"},
+        { 6, 1, "Microsoft Windows 7"},
+
+        { 6, 2, "Microsoft Windows 8"},
+        { 6, 3, "Microsoft Windows 8.1"},
+        {10, 0, "Microsoft Windows 10"},
+        { 0, 0, 0}
+    },{
+        { 5, 2, "Microsoft Windows Server 2003"},
+        { 6, 0, "Microsoft Windows Server 2008"},
+        { 6, 1, "Microsoft Windows Server 2008 R2"},
+        { 6, 2, "Microsoft Windows Server 2012"},
+        { 6, 3, "Microsoft Windows Server 2012 R2"},
+        {10, 0, "Microsoft Windows Server 2016"},
+        { 0, 0, 0},
+        { 0, 0, 0}
+    }
+};
+
+static void ga_get_version(OSVERSIONINFOEXW *info)
+{
+    typedef NTSTATUS(WINAPI * rtl_get_version_t)(
+        OSVERSIONINFOEXW *os_version_info_ex);
+    HMODULE module = GetModuleHandle("ntdll");
+    PVOID fun = GetProcAddress(module, "RtlGetVersion");
+    rtl_get_version_t rtl_get_version = (rtl_get_version_t)fun;
+    rtl_get_version(info);
+}
+
+static char *ga_get_win_name(OSVERSIONINFOEXW const *os_version)
+{
+    int major = (int)os_version->dwMajorVersion;
+    int minor = (int)os_version->dwMinorVersion;
+    int tbl_idx = (os_version->wProductType != VER_NT_WORKSTATION);
+    ga_matrix_lookup_t const *table = WIN_VERSION_MATRIX[tbl_idx];
+    while (table->name != NULL) {
+        if (major == table->major && minor == table->minor) {
+            return g_strdup(table->name);
+        }
+        ++table;
+    }
+    return g_strdup("N/A");
+}
+
+static char *ga_get_windows_product_name(void)
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
+            g_free(result);
+            result = NULL;
+            if (size > 0) {
+                result = g_malloc0(size);
+                memset(result, 0, size);
+            }
+            if (result != NULL && size > 0) {
+                err = RegQueryValueExA(key, "ProductName", NULL, NULL,
+                                       (LPBYTE)result, &size);
+                if (err != ERROR_SUCCESS) {
+                    g_free(result);
+                    result = NULL;
+                }
+            }
+        }
+    }
+    return result;
+}
+
+GuestOSRelease *qmp_guest_get_osrelease(Error **errp)
+{
+    OSVERSIONINFOEXW os_version;
+    ga_get_version(&os_version);
+    int major = (int)os_version.dwMajorVersion;
+    int minor = (int)os_version.dwMinorVersion;
+    bool server = os_version.wProductType != VER_NT_WORKSTATION;
+    char *product_name = ga_get_windows_product_name();
+    if (product_name == NULL) {
+        return NULL;
+    }
+
+    GuestOSRelease *info = g_new0(GuestOSRelease, 1);
+    memset(info, 0, sizeof(GuestOSRelease));
+
+    info->content = g_strdup_printf(
+        "NAME=\"Microsoft Windows\"\n"
+        "ID=mswindows\n"
+        "VERSION=\"%s (%d.%d)\"\n"
+        "VERSION_ID=%d.%d\n"
+        "PRETTY_NAME=\"%s\"\n"
+        "VARIANT=\"%s\"\n"
+        "VARIANT_ID=%s\n",
+
+        /* VERSION */
+        ga_get_win_name(&os_version), major, minor,
+        /* VERSION_ID */
+        major, minor,
+        /* PRETTY_NAME */
+        product_name,
+        /* VARIANT */
+        server ? "server" : "client",
+        /* VARIANT_ID */
+        server ? "server" : "client"
+    );
+    g_free(product_name);
+    return info;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index a02dbf2..268648c 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1042,3 +1042,32 @@
   'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
                '*input-data': 'str', '*capture-output': 'bool' },
   'returns': 'GuestExec' }
+
+##
+# @GuestOSRelease:
+#
+# @content: OS information in the os-release format as specified at:
+#           https://www.freedesktop.org/software/systemd/man/os-release.html
+#           On GNU/Linux this will be content of /etc/os-release or
+#           /usr/lib/os-release if either exists.
+#           On Windows, the data will be generated in the os-release format.
+#           Additionally on POSIX systems the os-release format will be
+#           extended with 3 fields QGA_UNAME_{VERSION,RELEASE,MACHINE} which
+#           are the retrieved through the uname syscall.
+#
+# Since: 2.10
+##
+{ 'struct': 'GuestOSRelease',
+  'data': { 'content': 'str' } }
+
+##
+# @guest-get-osrelease:
+#
+# Retrieve guest operating system information
+#
+# Returns: operating system information on success
+#
+# Since 2.10
+##
+{ 'command': 'guest-get-osrelease',
+  'returns': 'GuestOSRelease' }
-- 
2.9.3
