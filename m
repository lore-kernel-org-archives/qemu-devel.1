Received: from eggs.gnu.org ([2001:4830:134:3::10]:51802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fIYEY-0002Kp-4l
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fIYDT-0003bk-UH
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:35:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fIYDT-0003a9-7U
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:34:03 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4FBTQcC018205
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 07:34:01 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hyw0m4xf1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 07:34:01 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Tue, 15 May 2018 05:34:00 -0600
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Tue, 15 May 2018 19:33:48 +0800
In-Reply-To: <20180515113348.10516-1-zyimin@linux.ibm.com>
References: <20180515113348.10516-1-zyimin@linux.ibm.com>
Message-Id: <20180515113348.10516-2-zyimin@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/1] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jtomko@redhat.com, jferlan@redhat.com, berrange@redhat.com, otubo@redhat.com, borntraeger@de.ibm.com, fiuczy@linux.ibm.com, zyimin@linux.ibm.com

If CONFIG_SECCOMP is undefined, the option 'elevateprivileges' remains
compiled. This would make libvirt set the corresponding capability and
then trigger the guest startup fails. So this patch excludes the code
regarding seccomp staff if CONFIG_SECCOMP is undefined.

Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
---
 vl.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/vl.c b/vl.c
index 806eec2ef6..b22d158f5f 100644
--- a/vl.c
+++ b/vl.c
@@ -257,6 +257,7 @@ static QemuOptsList qemu_rtc_opts = {
     },
 };
 
+#ifdef CONFIG_SECCOMP
 static QemuOptsList qemu_sandbox_opts = {
     .name = "sandbox",
     .implied_opt_name = "enable",
@@ -285,6 +286,7 @@ static QemuOptsList qemu_sandbox_opts = {
         { /* end of list */ }
     },
 };
+#endif
 
 static QemuOptsList qemu_option_rom_opts = {
     .name = "option-rom",
@@ -1041,10 +1043,10 @@ static int bt_parse(const char *opt)
     return 1;
 }
 
+#ifdef CONFIG_SECCOMP
 static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
 {
     if (qemu_opt_get_bool(opts, "enable", false)) {
-#ifdef CONFIG_SECCOMP
         uint32_t seccomp_opts = QEMU_SECCOMP_SET_DEFAULT
                 | QEMU_SECCOMP_SET_OBSOLETE;
         const char *value = NULL;
@@ -1114,14 +1116,11 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
                          "in the kernel");
             return -1;
         }
-#else
-        error_report("seccomp support is disabled");
-        return -1;
-#endif
     }
 
     return 0;
 }
+#endif
 
 static int parse_name(void *opaque, QemuOpts *opts, Error **errp)
 {
@@ -3074,7 +3073,9 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_mem_opts);
     qemu_add_opts(&qemu_smp_opts);
     qemu_add_opts(&qemu_boot_opts);
+#ifdef CONFIG_SECCOMP
     qemu_add_opts(&qemu_sandbox_opts);
+#endif
     qemu_add_opts(&qemu_add_fd_opts);
     qemu_add_opts(&qemu_object_opts);
     qemu_add_opts(&qemu_tpmdev_opts);
@@ -4071,10 +4072,12 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
 
+#ifdef CONFIG_SECCOMP
     if (qemu_opts_foreach(qemu_find_opts("sandbox"),
                           parse_sandbox, NULL, NULL)) {
         exit(1);
     }
+#endif
 
     if (qemu_opts_foreach(qemu_find_opts("name"),
                           parse_name, NULL, NULL)) {
-- 
Yi Min
