Received: from eggs.gnu.org ([2001:4830:134:3::10]:53852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkAC-0006jT-IC
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkAA-0001Sm-6I
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:32 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:34814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkA9-0001Rn-Mw
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:30 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 26 Apr 2018 17:53:28 +0100
Message-ID: <1524761612-5307-4-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 3/7] error reporting: Use
 error_report_errno in obvious places
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ian Jackson <ian.jackson@eu.citrix.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>

This patch is the result of

  git-grep -l 'error_report.*strerror' | xargs perl -p -i~ ../t

with ../t containing

  s{error_report\("(.*): \%s"(, .*)?, strerror\(errno\)\)\;}{error_report_errno\("$1"$2)\;}

Since this is an automatically generated patch, it does not contain
any cleanups of the occasional idiosyncratic messages.  That is left
to the future.

No functional change, since error_report_errno does exactly what this
previous open-coded pattern does.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
 audio/wavcapture.c       |  2 +-
 hw/i386/xen/xen-hvm.c    |  2 +-
 hw/tpm/tpm_emulator.c    |  2 +-
 hw/xen/xen_pt_load_rom.c |  4 ++--
 migration/postcopy-ram.c | 12 ++++++------
 net/tap-linux.c          |  2 +-
 os-posix.c               |  8 ++++----
 qemu-nbd.c               |  4 ++--
 scsi/qemu-pr-helper.c    |  4 ++--
 slirp/misc.c             |  4 ++--
 util/osdep.c             |  2 +-
 vl.c                     |  6 +++---
 12 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index cf31ed6..7046365 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -66,7 +66,7 @@ static void wav_destroy (void *opaque)
         }
     doclose:
         if (fclose (wav->f)) {
-            error_report("wav_destroy: fclose failed: %s", strerror(errno));
+            error_report_errno("wav_destroy: fclose failed");
         }
     }
 
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index caa563b..2778c92 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -414,7 +414,7 @@ go_physmap:
                                    (start_addr + size - 1) >> TARGET_PAGE_BITS,
                                    XEN_DOMCTL_MEM_CACHEATTR_WB);
     if (rc) {
-        error_report("pin_memory_cacheattr failed: %s", strerror(errno));
+        error_report_errno("pin_memory_cacheattr failed");
     }
     return xen_save_physmap(state, physmap);
 }
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 6418ef0..4345c1d 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -190,7 +190,7 @@ static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
 {
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_CAPABILITY,
                              &tpm_emu->caps, 0, sizeof(tpm_emu->caps)) < 0) {
-        error_report("tpm-emulator: probing failed : %s", strerror(errno));
+        error_report_errno("tpm-emulator: probing failed ");
         return -1;
     }
 
diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
index 71063c4..bbfe423 100644
--- a/hw/xen/xen_pt_load_rom.c
+++ b/hw/xen/xen_pt_load_rom.c
@@ -43,12 +43,12 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev, struct Object *owner,
     fp = fopen(rom_file, "r+");
     if (fp == NULL) {
         if (errno != ENOENT) {
-            error_report("pci-assign: Cannot open %s: %s", rom_file, strerror(errno));
+            error_report_errno("pci-assign: Cannot open %s", rom_file);
         }
         return NULL;
     }
     if (fstat(fileno(fp), &st) == -1) {
-        error_report("pci-assign: Cannot stat %s: %s", rom_file, strerror(errno));
+        error_report_errno("pci-assign: Cannot stat %s", rom_file);
         goto close_rom;
     }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 8ceeaa2..6bfe002 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -406,14 +406,14 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
     reg_struct.mode = UFFDIO_REGISTER_MODE_MISSING;
 
     if (ioctl(ufd, UFFDIO_REGISTER, &reg_struct)) {
-        error_report("%s userfault register: %s", __func__, strerror(errno));
+        error_report_errno("%s userfault register", __func__);
         goto out;
     }
 
     range_struct.start = (uintptr_t)testarea;
     range_struct.len = pagesize;
     if (ioctl(ufd, UFFDIO_UNREGISTER, &range_struct)) {
-        error_report("%s userfault unregister: %s", __func__, strerror(errno));
+        error_report_errno("%s userfault unregister", __func__);
         goto out;
     }
 
@@ -543,7 +543,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
 
     if (enable_mlock) {
         if (os_mlock() < 0) {
-            error_report("mlock: %s", strerror(errno));
+            error_report_errno("mlock");
             /*
              * It doesn't feel right to fail at this point, we have a valid
              * VM state.
@@ -624,7 +624,7 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
 
     /* Now tell our userfault_fd that it's responsible for this area */
     if (ioctl(mis->userfault_fd, UFFDIO_REGISTER, &reg_struct)) {
-        error_report("%s userfault register: %s", __func__, strerror(errno));
+        error_report_errno("%s userfault register", __func__);
         return -1;
     }
     if (!(reg_struct.ioctls & ((__u64)1 << _UFFDIO_COPY))) {
@@ -876,7 +876,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
 
         poll_result = poll(pfd, pfd_len, -1 /* Wait forever */);
         if (poll_result == -1) {
-            error_report("%s: userfault poll: %s", __func__, strerror(errno));
+            error_report_errno("%s: userfault poll", __func__);
             break;
         }
 
@@ -1199,7 +1199,7 @@ void *postcopy_get_tmp_page(MigrationIncomingState *mis)
                              MAP_ANONYMOUS, -1, 0);
         if (mis->postcopy_tmp_page == MAP_FAILED) {
             mis->postcopy_tmp_page = NULL;
-            error_report("%s: %s", __func__, strerror(errno));
+            error_report_errno("%s", __func__);
             return NULL;
         }
     }
diff --git a/net/tap-linux.c b/net/tap-linux.c
index 535b1dd..897e788 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -152,7 +152,7 @@ int tap_probe_vnet_hdr(int fd)
     struct ifreq ifr;
 
     if (ioctl(fd, TUNGETIFF, &ifr) != 0) {
-        error_report("TUNGETIFF ioctl() failed: %s", strerror(errno));
+        error_report_errno("TUNGETIFF ioctl() failed");
         return 0;
     }
 
diff --git a/os-posix.c b/os-posix.c
index 24eb700..e6edb7d 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -125,7 +125,7 @@ void os_set_proc_name(const char *s)
     /* Could rewrite argv[0] too, but that's a bit more complicated.
        This simple way is enough for `top'. */
     if (prctl(PR_SET_NAME, name)) {
-        error_report("unable to change process name: %s", strerror(errno));
+        error_report_errno("unable to change process name");
         exit(1);
     }
 #else
@@ -247,7 +247,7 @@ static void change_root(void)
             exit(1);
         }
         if (chdir("/")) {
-            error_report("not able to chdir to /: %s", strerror(errno));
+            error_report_errno("not able to chdir to /");
             exit(1);
         }
     }
@@ -309,7 +309,7 @@ void os_setup_post(void)
 
     if (daemonize) {
         if (chdir("/")) {
-            error_report("not able to chdir to /: %s", strerror(errno));
+            error_report_errno("not able to chdir to /");
             exit(1);
         }
         TFR(fd = qemu_open("/dev/null", O_RDWR));
@@ -383,7 +383,7 @@ int os_mlock(void)
 
     ret = mlockall(MCL_CURRENT | MCL_FUTURE);
     if (ret < 0) {
-        error_report("mlockall: %s", strerror(errno));
+        error_report_errno("mlockall");
     }
 
     return ret;
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 0af0560..47b6957 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -847,7 +847,7 @@ int main(int argc, char **argv)
          */
         pid = fork();
         if (pid < 0) {
-            error_report("Failed to fork: %s", strerror(errno));
+            error_report_errno("Failed to fork");
             exit(EXIT_FAILURE);
         } else if (pid == 0) {
             close(stderr_fd[0]);
@@ -857,7 +857,7 @@ int main(int argc, char **argv)
             old_stderr = dup(STDERR_FILENO);
             dup2(stderr_fd[1], STDERR_FILENO);
             if (ret < 0) {
-                error_report("Failed to daemonize: %s", strerror(errno));
+                error_report_errno("Failed to daemonize");
                 exit(EXIT_FAILURE);
             }
 
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index d0f8317..663a8a8 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -1085,7 +1085,7 @@ int main(int argc, char **argv)
 
     if (daemonize) {
         if (daemon(0, 0) < 0) {
-            error_report("Failed to daemonize: %s", strerror(errno));
+            error_report_errno("Failed to daemonize");
             exit(EXIT_FAILURE);
         }
     }
@@ -1095,7 +1095,7 @@ int main(int argc, char **argv)
 
 #ifdef CONFIG_LIBCAP
     if (drop_privileges() < 0) {
-        error_report("Failed to drop privileges: %s", strerror(errno));
+        error_report_errno("Failed to drop privileges");
         exit(EXIT_FAILURE);
     }
 #endif
diff --git a/slirp/misc.c b/slirp/misc.c
index 260187b..11a8bd1 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -111,7 +111,7 @@ fork_exec(struct socket *so, const char *ex, int do_pty)
 		if ((s = qemu_socket(AF_INET, SOCK_STREAM, 0)) < 0 ||
 		    bind(s, (struct sockaddr *)&addr, addrlen) < 0 ||
 		    listen(s, 1) < 0) {
-			error_report("Error: inet socket: %s", strerror(errno));
+			error_report_errno("Error: inet socket");
 			if (s >= 0) {
 			    closesocket(s);
 			}
@@ -123,7 +123,7 @@ fork_exec(struct socket *so, const char *ex, int do_pty)
 	pid = fork();
 	switch(pid) {
 	 case -1:
-		error_report("Error: fork failed: %s", strerror(errno));
+		error_report_errno("Error: fork failed");
 		close(s);
 		return 0;
 
diff --git a/util/osdep.c b/util/osdep.c
index a73de0e..b78b98b 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -89,7 +89,7 @@ static int qemu_mprotect__osdep(void *addr, size_t size, int prot)
     return 0;
 #else
     if (mprotect(addr, size, prot)) {
-        error_report("%s: mprotect failed: %s", __func__, strerror(errno));
+        error_report_errno("%s: mprotect failed", __func__);
         return -1;
     }
     return 0;
diff --git a/vl.c b/vl.c
index d37e857..2f09210 100644
--- a/vl.c
+++ b/vl.c
@@ -1194,7 +1194,7 @@ static int parse_add_fd(void *opaque, QemuOpts *opts, Error **errp)
     }
 #endif
     if (dupfd == -1) {
-        error_report("error duplicating fd: %s", strerror(errno));
+        error_report_errno("error duplicating fd");
         return -1;
     }
 
@@ -4069,7 +4069,7 @@ int main(int argc, char **argv, char **envp)
                 }
                 vmstate_dump_file = fopen(optarg, "w");
                 if (vmstate_dump_file == NULL) {
-                    error_report("open %s: %s", optarg, strerror(errno));
+                    error_report_errno("open %s", optarg);
                     exit(1);
                 }
                 break;
@@ -4094,7 +4094,7 @@ int main(int argc, char **argv, char **envp)
     rcu_disable_atfork();
 
     if (pid_file && qemu_create_pidfile(pid_file) != 0) {
-        error_report("could not acquire pid file: %s", strerror(errno));
+        error_report_errno("could not acquire pid file");
         exit(1);
     }
 
-- 
2.1.4
