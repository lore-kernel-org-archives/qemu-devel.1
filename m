Received: from eggs.gnu.org ([2001:4830:134:3::10]:54698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leif.lindholm@linaro.org>) id 1cHuM2-0003IT-2o
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:23:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leif.lindholm@linaro.org>) id 1cHuM0-00017A-Vp
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:23:25 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <leif.lindholm@linaro.org>)
	id 1cHuM0-00016b-PC
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:23:24 -0500
Received: by mail-wm0-x22b.google.com with SMTP id a197so36857633wmd.0
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 07:23:22 -0800 (PST)
From: Leif Lindholm <leif.lindholm@linaro.org>
Date: Fri, 16 Dec 2016 15:23:19 +0000
Message-Id: <20161216152319.12494-1-leif.lindholm@linaro.org>
Subject: [Qemu-devel] [PATCH] smbios: stop ignoring command line options for
 TARGET_ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Commit c30e1565 ("smbios: implement smbios support for mach-virt")
enabled automatic generation of SMBIOS tables for TARGET_ARM, and
actually provides data for the "virt" machine.

However, do_smbios_option() still had an #ifdef TARGET_I386, preventing
any -smbios command line options from being parsed for any non-x86
targets.
Change this to use a status variable instead of compile-time filtering.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
---

Verified on ARM mach-virt with UEFI shell "smbiosview" command and QEMU
command line parameter -smbios type=0,version=foobar.

 arch_init.c                | 6 +++---
 include/hw/smbios/smbios.h | 2 ++
 vl.c                       | 2 ++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch_init.c b/arch_init.c
index 5cc58b2..d4e28c0 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -250,9 +250,9 @@ void do_acpitable_option(const QemuOpts *opts)
 
 void do_smbios_option(QemuOpts *opts)
 {
-#ifdef TARGET_I386
-    smbios_entry_add(opts);
-#endif
+    if (smbios_override) {
+        smbios_entry_add(opts);
+    }
 }
 
 int kvm_available(void)
diff --git a/include/hw/smbios/smbios.h b/include/hw/smbios/smbios.h
index 1cd53cc..2a3dca2 100644
--- a/include/hw/smbios/smbios.h
+++ b/include/hw/smbios/smbios.h
@@ -267,4 +267,6 @@ void smbios_get_tables(const struct smbios_phys_mem_area *mem_array,
                        const unsigned int mem_array_size,
                        uint8_t **tables, size_t *tables_len,
                        uint8_t **anchor, size_t *anchor_len);
+
+extern int smbios_override;
 #endif /* QEMU_SMBIOS_H */
diff --git a/vl.c b/vl.c
index d77dd86..8e71b06 100644
--- a/vl.c
+++ b/vl.c
@@ -159,6 +159,7 @@ int smp_cpus = 1;
 int max_cpus = 1;
 int smp_cores = 1;
 int smp_threads = 1;
+int smbios_override = 0;
 int acpi_enabled = 1;
 int no_hpet = 0;
 int fd_bootchk = 1;
@@ -3711,6 +3712,7 @@ int main(int argc, char **argv, char **envp)
                 if (!opts) {
                     exit(1);
                 }
+                smbios_override = 1;
                 do_smbios_option(opts);
                 break;
             case QEMU_OPTION_fwcfg:
-- 
2.10.2
