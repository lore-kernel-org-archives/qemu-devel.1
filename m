Received: from eggs.gnu.org ([2001:4830:134:3::10]:36388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cqI96-0006eL-UO
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 07:40:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cqI92-00087n-Pt
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 07:40:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cqI92-00084x-GV
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 07:40:08 -0400
From: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Date: Thu, 16 Mar 2017 11:23:51 +0100
Message-Id: <20170316102351.25056-1-vfeenstr@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-ga: add guest-get-osinfo command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, Vinzenz Feenstra <vfeenstr@redhat.com>

From: Vinzenz Feenstra <vfeenstr@redhat.com>

Add a new 'guest-get-osinfo' command for reporting basic information of
the guest operating system (hereafter just 'OS'). This information
includes the type of the OS, the version, and the architecture.
Additionally reported would be a name, distribution type and kernel
version where applicable.

Here an example for a Fedora 25 VM:

$ virsh -c qemu:////system qemu-agent-command F25 \
    '{ "execute": "guest-get-osinfo" }'
  {"return":{"arch":"x86_64","codename":"Server Edition","version":"25",
   "kernel":"4.8.6-300.fc25.x86_64","type":"linux","distribution":"Fedora"}}

And an example for a Windows 2012 R2 VM:

$ virsh -c qemu:////system qemu-agent-command Win2k12R2 \
    '{ "execute": "guest-get-osinfo" }'
  {"return":{"arch":"x86_64","codename":"Win 2012 R2",
   "version":"6.3","kernel":"","type":"windows","distribution":""}}

Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
---
 qga/commands-posix.c | 206 +++++++++++++++++++++++++++++++++++++++++++++++++++
 qga/commands-win32.c | 105 ++++++++++++++++++++++++++
 qga/qapi-schema.json |  40 ++++++++++
 3 files changed, 351 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 73d93eb..70ec3fb 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
+#include <sys/utsname.h>
 #include <sys/wait.h>
 #include <dirent.h>
 #include "qga/guest-agent-core.h"
@@ -2356,6 +2357,205 @@ GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
     return info;
 }
 
+static void ga_strip_end(char *value)
+{
+    size_t value_length = strlen(value);
+    while (value_length > 0) {
+        switch (value[value_length - 1]) {
+        default:
+            value_length = 0;
+            break;
+        case ' ': case '\n': case '\t': case '\'': case '"':
+            value[value_length - 1] = 0;
+            --value_length;
+            break;
+        }
+    }
+}
+
+static void ga_parse_version_id(char const *value, GuestOSInfo *info)
+{
+    if (strlen(value) < 128) {
+        char codename[128];
+        char version[128];
+
+        if (*value == '"') {
+            ++value;
+        }
+
+        if (sscanf(value, "%[^(] (%[^)])", version, codename) == 2) {
+            /* eg. VERSION="16.04.1 LTS (Xenial Xerus)" */
+            info->codename = strdup(codename);
+            info->version = strdup(version);
+        } else if (sscanf(value, "%[^,] %[^\"]\"", version, codename) == 2) {
+            /* eg. VERSION="12.04.5 LTS, Precise Pangolin" */
+            info->codename = strdup(codename);
+            info->version = strdup(version);
+        } else {
+            /* Just use the rest */
+            info->version = strdup(version);
+            info->codename = strdup("");
+        }
+    }
+}
+
+static void ga_parse_debian_version(FILE *fp, GuestOSInfo *info)
+{
+    char *line = NULL;
+    size_t n = 0;
+
+    if (getline(&line, &n, fp) != -1) {
+        ga_strip_end(line);
+        info->version = strdup(line);
+        info->codename = strdup("");
+        info->distribution = strdup("Debian GNU/Linux");
+    }
+    free(line);
+}
+
+static void ga_parse_redhat_release(FILE *fp, GuestOSInfo *info)
+{
+    char *line = NULL;
+    size_t n = 0;
+
+    if (getline(&line, &n, fp) != -1) {
+        char *value = strstr(line, " release ");
+        if (value != NULL) {
+            *value = 0;
+            info->distribution = strdup(line);
+            value += 9;
+            ga_strip_end(value);
+            ga_parse_version_id(value, info);
+        }
+    }
+    free(line);
+}
+
+static void ga_parse_os_release(FILE *fp, GuestOSInfo *info)
+{
+    char *line = NULL;
+    size_t n = 0;
+    while (getline(&line, &n, fp) != -1) {
+        char *value = strstr(line, "=");
+        if (value != NULL) {
+            *value = 0;
+            ++value;
+            ga_strip_end(value);
+
+            size_t len = strlen(line);
+            if (len == 9 && strcmp(line, "VERSION_ID") == 0) {
+                info->version = strdup(value);
+            } else if (len == 7 && strcmp(line, "VERSION") == 0) {
+                ga_parse_version_id(value, info);
+            } else if (len == 4 && strcmp(line, "NAME") == 0) {
+                info->distribution = strdup(value);
+            }
+        }
+    }
+    free(line);
+}
+
+static char *ga_stripped_strdup(char const *value)
+{
+    char *result = NULL;
+    while (value && *value == '"') {
+        ++value;
+    }
+    result = strdup(value);
+    ga_strip_end(result);
+    return result;
+}
+
+static void ga_parse_lsb_release(FILE *fp, GuestOSInfo *info)
+{
+    char *line = NULL;
+    size_t n = 0;
+
+    while (getline(&line, &n, fp) != -1) {
+        char *value = strstr(line, "=");
+        if (value != NULL) {
+            *value = 0;
+            ++value;
+            ga_strip_end(value);
+
+            size_t len = strlen(line);
+            if (len == 15 && strcmp(line, "DISTRIB_RELEASE") == 0) {
+                info->version = ga_stripped_strdup(value);
+            } else if (len == 16 && strcmp(line, "DISTRIB_CODENAME") == 0) {
+                info->codename = ga_stripped_strdup(value);
+            } else if (len == 10 && strcmp(line, "DISTRIB_ID") == 0) {
+                info->distribution = ga_stripped_strdup(value);
+            }
+        }
+    }
+}
+
+static void ga_get_linux_distribution_info(GuestOSInfo *info)
+{
+    FILE *fp = NULL;
+    fp = fopen("/etc/os-release", "r");
+    if (fp != NULL) {
+        ga_parse_os_release(fp, info);
+        goto cleanup;
+    }
+    fp = fopen("/usr/lib/os-release", "r");
+    if (fp != NULL) {
+        ga_parse_os_release(fp, info);
+        goto cleanup;
+    }
+    fp = fopen("/etc/lsb-release", "r");
+    if (fp != NULL) {
+        ga_parse_lsb_release(fp, info);
+        goto cleanup;
+    }
+    fp = fopen("/etc/redhat-release", "r");
+    if (fp != NULL) {
+        ga_parse_redhat_release(fp, info);
+        goto cleanup;
+    }
+    fp = fopen("/etc/gentoo-release", "r");
+    if (fp != NULL) {
+        ga_parse_redhat_release(fp, info);
+        goto cleanup;
+    }
+    fp = fopen("/etc/debian_version", "r");
+    if (fp != NULL) {
+        ga_parse_debian_version(fp, info);
+        goto cleanup;
+    }
+
+    if (fp == NULL) {
+        info->distribution = strdup("Unknown");
+        info->version = strdup("");
+        info->codename = strdup("");
+    }
+
+cleanup:
+    if (fp != NULL) {
+        fclose(fp);
+    }
+
+}
+
+GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
+{
+    GuestOSInfo *info = g_new0(GuestOSInfo, 1);
+    struct utsname kinfo;
+
+    ga_get_linux_distribution_info(info);
+
+    if (!info->codename || !info->distribution || !info->version) {
+        qapi_free_GuestOSInfo(info);
+        return NULL;
+    }
+    info->type = GUESTOS_TYPE_LINUX;
+    uname(&kinfo);
+    info->kernel = g_strdup(kinfo.release);
+    info->arch = g_strdup(kinfo.machine);
+
+    return info;
+}
+
 #else /* defined(__linux__) */
 
 void qmp_guest_suspend_disk(Error **errp)
@@ -2418,6 +2618,12 @@ GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
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
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 19d72b2..b11cfde 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1536,3 +1536,108 @@ void ga_command_state_init(GAState *s, GACommandState *cs)
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
+        { 5, 0, "Win 2000"},
+        { 5, 1, "Win XP"},
+        { 6, 0, "Win Vista"},
+        { 6, 1, "Win 7"},
+
+        { 6, 2, "Win 8"},
+        { 6, 3, "Win 8.1"},
+        {10, 0, "Win 10"},
+        { 0, 0, 0}
+    },{
+        { 5, 2, "Win 2003"},
+        { 6, 0, "Win 2008"},
+        { 6, 1, "Win 2008 R2"},
+        { 6, 2, "Win 2012"},
+        { 6, 3, "Win 2012 R2"},
+        {10, 0, "Win 2016"},
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
+static char *ga_get_win_ver(void)
+{
+    OSVERSIONINFOEXW os_version;
+    ga_get_version(&os_version);
+    char buf[64] = {};
+    int major = (int)os_version.dwMajorVersion;
+    int minor = (int)os_version.dwMinorVersion;
+    sprintf(buf, "%d.%d", major, minor);
+    return strdup(buf);
+}
+
+static char *ga_get_win_name(void)
+{
+    OSVERSIONINFOEXW os_version;
+    ga_get_version(&os_version);
+    int major = (int)os_version.dwMajorVersion;
+    int minor = (int)os_version.dwMinorVersion;
+    int tbl_idx = (os_version.wProductType != VER_NT_WORKSTATION);
+    ga_matrix_lookup_t const *table = WIN_VERSION_MATRIX[tbl_idx];
+    while (table->name != NULL) {
+        if (major == table->major && minor == table->minor) {
+            return strdup(table->name);
+        }
+        ++table;
+    }
+    return strdup("N/A");
+}
+
+static char *ga_get_current_arch(void)
+{
+    SYSTEM_INFO info;
+    GetNativeSystemInfo(&info);
+    char *result = NULL;
+    switch (info.wProcessorArchitecture) {
+    case PROCESSOR_ARCHITECTURE_AMD64:
+        result = strdup("x86_64");;
+        break;
+    case PROCESSOR_ARCHITECTURE_ARM:
+        result = strdup("arm");;
+        break;
+    case PROCESSOR_ARCHITECTURE_IA64:
+        result = strdup("ia64");;
+        break;
+    case PROCESSOR_ARCHITECTURE_INTEL:
+        result = strdup("x86");;
+        break;
+    case PROCESSOR_ARCHITECTURE_UNKNOWN: default:
+        result = strdup("N/A");;
+        break;
+    }
+    return result;
+}
+
+GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
+{
+    GuestOSInfo *info = g_new0(GuestOSInfo, 1);
+    info->type = GUESTOS_TYPE_WINDOWS;
+    info->version = ga_get_win_ver();
+    info->codename = ga_get_win_name();
+    info->arch = ga_get_current_arch();
+    /* Not available on Windows */
+    info->kernel = strdup("");
+    info->distribution = strdup("");
+    return info;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index a02dbf2..e31cb17 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1042,3 +1042,43 @@
   'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
                '*input-data': 'str', '*capture-output': 'bool' },
   'returns': 'GuestExec' }
+
+##
+# @GuestOSType:
+#
+# @linux:    Indicator for linux distributions
+# @windows:  Indicator for windows versions
+# @other:    Indicator for any other operating system that is not yet
+#            explicitly supported
+#
+# Since: 2.8
+##
+{ 'enum': 'GuestOSType', 'data': ['linux', 'windows', 'other'] }
+
+##
+# @GuestOSInfo:
+#
+# @version:      OS version, e.g. 25 for FC25 etc.
+# @distribution: Fedora, Ubuntu, Debian, CentOS...
+# @codename:     Code name of the OS. e.g. Ubuntu has Xenial Xerus etc.
+# @arch:         Architecture of the OS e.g. x86, x86_64, ppc64, aarch64...
+# @type:         Specifies the type of the OS.
+# @kernel:       Linux kernel version (Might be used by other OS types too).
+#                May be empty.
+# Since: 2.8
+##
+{ 'struct': 'GuestOSInfo',
+  'data': { 'version': 'str', 'distribution': 'str', 'codename': 'str',
+            'arch': 'str', 'type': 'GuestOSType', 'kernel': 'str'} }
+
+##
+# @guest-get-osinfo:
+#
+# Retrieve guest operating system information
+#
+# Returns: operating system information on success
+#
+# Since 2.8
+##
+{ 'command': 'guest-get-osinfo',
+  'returns': 'GuestOSInfo' }
-- 
2.9.3
