Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B286C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:01:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF3320409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF3320409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDu31-0003p9-CY
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsQ6-00083N-Us
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsQ2-0003is-8h
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:50 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:47389)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsQ1-0003Y3-Pf
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:46 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M9Ib1-1jGMb12Fap-006KoS; Mon, 16 Mar 2020 17:16:41 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 29/38] linux-user, mips: add syscall table generation support
Date: Mon, 16 Mar 2020 17:15:41 +0100
Message-Id: <20200316161550.336150-30-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UfDxmTiLspa+MzS/SJo/YUN2rig+JRW3QoKUqSL6WjCqXy78CIV
 6KME96cC9amJWaqnSNiQd4riMbdYObALFSUc4wUydhjJkgLOgnzu7v6UL8GDNSmRwTcO/hS
 gbrMmp7JRo50wcaJSWDjg2cpMHXFzohnbxvJLiWhqd8MF3JzUw8ZzgP0tdqvgJtoxjYIdAL
 BpWJljEbw3h+5DOtVe2Wg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tzx7wsVlZDw=:Zl5lIAeS5H/eq8yFkBr2HD
 zzp88TP3nPjwDAP9K9MckXF55JHuK5SkXvPfqstiQwYCreG9V5TIW9PW+CnlFHfijyDxxxqxX
 /+XWQnDbTo+3YQV5fAjpNbuvsmAblo0z7Uuktc7U02rKDnTRMVCoPYvHh6s+KrmMestxdgs51
 Rf5kjKDwKHD0106NZ4kdiw2Evm11k4gg0WPCQIbubOBCV9bFTeIjR+DozmvrXuxG3pay/Nd4e
 AGVbHSuO4HNn1lxwyWx5ePPdBSaHE2Kvy1ij5XDiOOC+8NuD03ARMLfevt91esVP1UseQwqvL
 U48CTePKHaFPcoanXBPY9VxfSDjqwpxIZkDgNkDGlBAOeBkg+l3nPmJ0Nwf6fNNW2enhqE18S
 AALP8rSDBOoDgCe7NSFwkqTR7nbC6QdygNH4rw5icGpCpj4GAx2A4nhoGg+RVTBrbgFAijGIl
 me4VEfdujW8eZ8tVXlC2g6bwNRPMvOpytg1/ux6eICH5NBtUjfxDqUhEGc30MbSfls7tKGsSB
 wMvUAzxCG+NuzWX7XTvz8I7S1GIVlNAIGAOhkZNONPL6YwJ/J88n7VqzUhbAPxOG09PZybzea
 mRcu/Rn6HDrgIqkkDIpSTn1xXphXNFlRkSBkK0uoiNeoZ4kLvfR7wSbN6uc29+LksZWc9tOtW
 /kMG5mzOJ/Si2sTG9WwExqK6x24tLS+Zvx/Sxeer/2WXrwd0Xl/3oAL6eNuTsNAokfhpAUZjk
 umBxGKCAhPuJJjdbWp579sXYVL6ef4uXiu0sI6u8Lr22a9hYvcGUw6unBQgSIGtWD6NFQph8C
 uMPWKPRe6anOjDIPKxFNKSP67xrZQFihgEjihZvhHqE7rBD4Hmxpdew/BrF9UvgxmjAGglD
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Copy syscall.tbl and syscallhdr.sh from linux/arch/mips/kernel/syscalls/syscall_o32.tbl v5.5
Update syscallhdr.sh to generate QEMU syscall_nr.h
Move the offset (4000) from the file to the Makefile.objs to be passed
to syscallhdr.sh
Rename on the fly fadvise64 to fadvise64_64.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <20200310103403.3284090-17-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure                       |   3 +-
 linux-user/Makefile.objs        |   1 +
 linux-user/mips/Makefile.objs   |   5 +
 linux-user/mips/syscall_nr.h    | 425 --------------------------------
 linux-user/mips/syscall_o32.tbl | 425 ++++++++++++++++++++++++++++++++
 linux-user/mips/syscallhdr.sh   |  36 +++
 6 files changed, 469 insertions(+), 426 deletions(-)
 create mode 100644 linux-user/mips/Makefile.objs
 delete mode 100644 linux-user/mips/syscall_nr.h
 create mode 100644 linux-user/mips/syscall_o32.tbl
 create mode 100644 linux-user/mips/syscallhdr.sh

diff --git a/configure b/configure
index eda37fd47669..7432f955b8f5 100755
--- a/configure
+++ b/configure
@@ -1890,7 +1890,7 @@ rm -f */config-devices.mak.d
 # Remove syscall_nr.h to be sure they will be regenerated in the build
 # directory, not in the source directory
 for arch in alpha hppa m68k xtensa sh4 microblaze arm ppc s390x sparc sparc64 \
-    i386 x86_64 ; do
+    i386 x86_64 mips ; do
     # remove the file if it has been generated in the source directory
     rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
     # remove the dependency files
@@ -7837,6 +7837,7 @@ case "$target_name" in
     mttcg="yes"
     TARGET_ARCH=mips
     echo "TARGET_ABI_MIPSO32=y" >> $config_target_mak
+    TARGET_SYSTBL_ABI=o32
   ;;
   mipsn32|mipsn32el)
     mttcg="yes"
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 1791bc48cd17..0a0715e9e192 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -13,6 +13,7 @@ obj-$(TARGET_HPPA) += hppa/
 obj-$(TARGET_I386) += i386/
 obj-$(TARGET_M68K) += m68k/
 obj-$(TARGET_MICROBLAZE) += microblaze/
+obj-$(TARGET_MIPS) += mips/
 obj-$(TARGET_PPC) += ppc/
 obj-$(TARGET_PPC64) += ppc/
 obj-$(TARGET_S390X) += s390x/
diff --git a/linux-user/mips/Makefile.objs b/linux-user/mips/Makefile.objs
new file mode 100644
index 000000000000..9be4de07d99a
--- /dev/null
+++ b/linux-user/mips/Makefile.objs
@@ -0,0 +1,5 @@
+generated-files-y += linux-user/mips/syscall_nr.h
+
+syshdr := $(SRC_PATH)/linux-user/mips/syscallhdr.sh
+%/syscall_nr.h: $(SRC_PATH)/linux-user/mips/syscall_o32.tbl $(syshdr)
+	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI) "" 4000,"GEN","$@")
diff --git a/linux-user/mips/syscall_nr.h b/linux-user/mips/syscall_nr.h
deleted file mode 100644
index 0be3af1c8455..000000000000
--- a/linux-user/mips/syscall_nr.h
+++ /dev/null
@@ -1,425 +0,0 @@
-/*
- * Linux o32 style syscalls are in the range from 4000 to 4999.
- */
-
-#ifndef LINUX_USER_MIPS_SYSCALL_NR_H
-#define LINUX_USER_MIPS_SYSCALL_NR_H
-
-#define TARGET_NR_Linux			4000
-#define TARGET_NR_syscall		(TARGET_NR_Linux +   0)
-#define TARGET_NR_exit			(TARGET_NR_Linux +   1)
-#define TARGET_NR_fork			(TARGET_NR_Linux +   2)
-#define TARGET_NR_read			(TARGET_NR_Linux +   3)
-#define TARGET_NR_write			(TARGET_NR_Linux +   4)
-#define TARGET_NR_open			(TARGET_NR_Linux +   5)
-#define TARGET_NR_close			(TARGET_NR_Linux +   6)
-#define TARGET_NR_waitpid		(TARGET_NR_Linux +   7)
-#define TARGET_NR_creat			(TARGET_NR_Linux +   8)
-#define TARGET_NR_link			(TARGET_NR_Linux +   9)
-#define TARGET_NR_unlink		(TARGET_NR_Linux +  10)
-#define TARGET_NR_execve		(TARGET_NR_Linux +  11)
-#define TARGET_NR_chdir			(TARGET_NR_Linux +  12)
-#define TARGET_NR_time			(TARGET_NR_Linux +  13)
-#define TARGET_NR_mknod			(TARGET_NR_Linux +  14)
-#define TARGET_NR_chmod			(TARGET_NR_Linux +  15)
-#define TARGET_NR_lchown		(TARGET_NR_Linux +  16)
-#define TARGET_NR_break			(TARGET_NR_Linux +  17)
-#define TARGET_NR_unused18		(TARGET_NR_Linux +  18)
-#define TARGET_NR_lseek			(TARGET_NR_Linux +  19)
-#define TARGET_NR_getpid		(TARGET_NR_Linux +  20)
-#define TARGET_NR_mount			(TARGET_NR_Linux +  21)
-#define TARGET_NR_umount		(TARGET_NR_Linux +  22)
-#define TARGET_NR_setuid		(TARGET_NR_Linux +  23)
-#define TARGET_NR_getuid		(TARGET_NR_Linux +  24)
-#define TARGET_NR_stime			(TARGET_NR_Linux +  25)
-#define TARGET_NR_ptrace		(TARGET_NR_Linux +  26)
-#define TARGET_NR_alarm			(TARGET_NR_Linux +  27)
-#define TARGET_NR_unused28		(TARGET_NR_Linux +  28)
-#define TARGET_NR_pause			(TARGET_NR_Linux +  29)
-#define TARGET_NR_utime			(TARGET_NR_Linux +  30)
-#define TARGET_NR_stty			(TARGET_NR_Linux +  31)
-#define TARGET_NR_gtty			(TARGET_NR_Linux +  32)
-#define TARGET_NR_access		(TARGET_NR_Linux +  33)
-#define TARGET_NR_nice			(TARGET_NR_Linux +  34)
-#define TARGET_NR_ftime			(TARGET_NR_Linux +  35)
-#define TARGET_NR_sync			(TARGET_NR_Linux +  36)
-#define TARGET_NR_kill			(TARGET_NR_Linux +  37)
-#define TARGET_NR_rename		(TARGET_NR_Linux +  38)
-#define TARGET_NR_mkdir			(TARGET_NR_Linux +  39)
-#define TARGET_NR_rmdir			(TARGET_NR_Linux +  40)
-#define TARGET_NR_dup			(TARGET_NR_Linux +  41)
-#define TARGET_NR_pipe			(TARGET_NR_Linux +  42)
-#define TARGET_NR_times			(TARGET_NR_Linux +  43)
-#define TARGET_NR_prof			(TARGET_NR_Linux +  44)
-#define TARGET_NR_brk			(TARGET_NR_Linux +  45)
-#define TARGET_NR_setgid		(TARGET_NR_Linux +  46)
-#define TARGET_NR_getgid		(TARGET_NR_Linux +  47)
-#define TARGET_NR_signal		(TARGET_NR_Linux +  48)
-#define TARGET_NR_geteuid		(TARGET_NR_Linux +  49)
-#define TARGET_NR_getegid		(TARGET_NR_Linux +  50)
-#define TARGET_NR_acct			(TARGET_NR_Linux +  51)
-#define TARGET_NR_umount2		(TARGET_NR_Linux +  52)
-#define TARGET_NR_lock			(TARGET_NR_Linux +  53)
-#define TARGET_NR_ioctl			(TARGET_NR_Linux +  54)
-#define TARGET_NR_fcntl			(TARGET_NR_Linux +  55)
-#define TARGET_NR_mpx			(TARGET_NR_Linux +  56)
-#define TARGET_NR_setpgid		(TARGET_NR_Linux +  57)
-#define TARGET_NR_ulimit		(TARGET_NR_Linux +  58)
-#define TARGET_NR_unused59		(TARGET_NR_Linux +  59)
-#define TARGET_NR_umask			(TARGET_NR_Linux +  60)
-#define TARGET_NR_chroot		(TARGET_NR_Linux +  61)
-#define TARGET_NR_ustat			(TARGET_NR_Linux +  62)
-#define TARGET_NR_dup2			(TARGET_NR_Linux +  63)
-#define TARGET_NR_getppid		(TARGET_NR_Linux +  64)
-#define TARGET_NR_getpgrp		(TARGET_NR_Linux +  65)
-#define TARGET_NR_setsid		(TARGET_NR_Linux +  66)
-#define TARGET_NR_sigaction		(TARGET_NR_Linux +  67)
-#define TARGET_NR_sgetmask		(TARGET_NR_Linux +  68)
-#define TARGET_NR_ssetmask		(TARGET_NR_Linux +  69)
-#define TARGET_NR_setreuid		(TARGET_NR_Linux +  70)
-#define TARGET_NR_setregid		(TARGET_NR_Linux +  71)
-#define TARGET_NR_sigsuspend		(TARGET_NR_Linux +  72)
-#define TARGET_NR_sigpending		(TARGET_NR_Linux +  73)
-#define TARGET_NR_sethostname		(TARGET_NR_Linux +  74)
-#define TARGET_NR_setrlimit		(TARGET_NR_Linux +  75)
-#define TARGET_NR_getrlimit		(TARGET_NR_Linux +  76)
-#define TARGET_NR_getrusage		(TARGET_NR_Linux +  77)
-#define TARGET_NR_gettimeofday		(TARGET_NR_Linux +  78)
-#define TARGET_NR_settimeofday		(TARGET_NR_Linux +  79)
-#define TARGET_NR_getgroups		(TARGET_NR_Linux +  80)
-#define TARGET_NR_setgroups		(TARGET_NR_Linux +  81)
-#define TARGET_NR_reserved82		(TARGET_NR_Linux +  82)
-#define TARGET_NR_symlink		(TARGET_NR_Linux +  83)
-#define TARGET_NR_unused84		(TARGET_NR_Linux +  84)
-#define TARGET_NR_readlink		(TARGET_NR_Linux +  85)
-#define TARGET_NR_uselib		(TARGET_NR_Linux +  86)
-#define TARGET_NR_swapon		(TARGET_NR_Linux +  87)
-#define TARGET_NR_reboot		(TARGET_NR_Linux +  88)
-#define TARGET_NR_readdir		(TARGET_NR_Linux +  89)
-#define TARGET_NR_mmap			(TARGET_NR_Linux +  90)
-#define TARGET_NR_munmap		(TARGET_NR_Linux +  91)
-#define TARGET_NR_truncate		(TARGET_NR_Linux +  92)
-#define TARGET_NR_ftruncate		(TARGET_NR_Linux +  93)
-#define TARGET_NR_fchmod		(TARGET_NR_Linux +  94)
-#define TARGET_NR_fchown		(TARGET_NR_Linux +  95)
-#define TARGET_NR_getpriority		(TARGET_NR_Linux +  96)
-#define TARGET_NR_setpriority		(TARGET_NR_Linux +  97)
-#define TARGET_NR_profil		(TARGET_NR_Linux +  98)
-#define TARGET_NR_statfs		(TARGET_NR_Linux +  99)
-#define TARGET_NR_fstatfs		(TARGET_NR_Linux + 100)
-#define TARGET_NR_ioperm		(TARGET_NR_Linux + 101)
-#define TARGET_NR_socketcall		(TARGET_NR_Linux + 102)
-#define TARGET_NR_syslog		(TARGET_NR_Linux + 103)
-#define TARGET_NR_setitimer		(TARGET_NR_Linux + 104)
-#define TARGET_NR_getitimer		(TARGET_NR_Linux + 105)
-#define TARGET_NR_stat			(TARGET_NR_Linux + 106)
-#define TARGET_NR_lstat			(TARGET_NR_Linux + 107)
-#define TARGET_NR_fstat			(TARGET_NR_Linux + 108)
-#define TARGET_NR_unused109		(TARGET_NR_Linux + 109)
-#define TARGET_NR_iopl			(TARGET_NR_Linux + 110)
-#define TARGET_NR_vhangup		(TARGET_NR_Linux + 111)
-#define TARGET_NR_idle			(TARGET_NR_Linux + 112)
-#define TARGET_NR_vm86			(TARGET_NR_Linux + 113)
-#define TARGET_NR_wait4			(TARGET_NR_Linux + 114)
-#define TARGET_NR_swapoff		(TARGET_NR_Linux + 115)
-#define TARGET_NR_sysinfo		(TARGET_NR_Linux + 116)
-#define TARGET_NR_ipc			(TARGET_NR_Linux + 117)
-#define TARGET_NR_fsync			(TARGET_NR_Linux + 118)
-#define TARGET_NR_sigreturn		(TARGET_NR_Linux + 119)
-#define TARGET_NR_clone			(TARGET_NR_Linux + 120)
-#define TARGET_NR_setdomainname		(TARGET_NR_Linux + 121)
-#define TARGET_NR_uname			(TARGET_NR_Linux + 122)
-#define TARGET_NR_modify_ldt		(TARGET_NR_Linux + 123)
-#define TARGET_NR_adjtimex		(TARGET_NR_Linux + 124)
-#define TARGET_NR_mprotect		(TARGET_NR_Linux + 125)
-#define TARGET_NR_sigprocmask		(TARGET_NR_Linux + 126)
-#define TARGET_NR_create_module		(TARGET_NR_Linux + 127)
-#define TARGET_NR_init_module		(TARGET_NR_Linux + 128)
-#define TARGET_NR_delete_module		(TARGET_NR_Linux + 129)
-#define TARGET_NR_get_kernel_syms	(TARGET_NR_Linux + 130)
-#define TARGET_NR_quotactl		(TARGET_NR_Linux + 131)
-#define TARGET_NR_getpgid		(TARGET_NR_Linux + 132)
-#define TARGET_NR_fchdir		(TARGET_NR_Linux + 133)
-#define TARGET_NR_bdflush		(TARGET_NR_Linux + 134)
-#define TARGET_NR_sysfs			(TARGET_NR_Linux + 135)
-#define TARGET_NR_personality		(TARGET_NR_Linux + 136)
-#define TARGET_NR_afs_syscall		(TARGET_NR_Linux + 137) /* Syscall for Andrew File System */
-#define TARGET_NR_setfsuid		(TARGET_NR_Linux + 138)
-#define TARGET_NR_setfsgid		(TARGET_NR_Linux + 139)
-#define TARGET_NR__llseek		(TARGET_NR_Linux + 140)
-#define TARGET_NR_getdents		(TARGET_NR_Linux + 141)
-#define TARGET_NR__newselect		(TARGET_NR_Linux + 142)
-#define TARGET_NR_flock			(TARGET_NR_Linux + 143)
-#define TARGET_NR_msync			(TARGET_NR_Linux + 144)
-#define TARGET_NR_readv			(TARGET_NR_Linux + 145)
-#define TARGET_NR_writev		(TARGET_NR_Linux + 146)
-#define TARGET_NR_cacheflush		(TARGET_NR_Linux + 147)
-#define TARGET_NR_cachectl		(TARGET_NR_Linux + 148)
-#define TARGET_NR_sysmips		(TARGET_NR_Linux + 149)
-#define TARGET_NR_unused150		(TARGET_NR_Linux + 150)
-#define TARGET_NR_getsid		(TARGET_NR_Linux + 151)
-#define TARGET_NR_fdatasync		(TARGET_NR_Linux + 152)
-#define TARGET_NR__sysctl		(TARGET_NR_Linux + 153)
-#define TARGET_NR_mlock			(TARGET_NR_Linux + 154)
-#define TARGET_NR_munlock		(TARGET_NR_Linux + 155)
-#define TARGET_NR_mlockall		(TARGET_NR_Linux + 156)
-#define TARGET_NR_munlockall		(TARGET_NR_Linux + 157)
-#define TARGET_NR_sched_setparam	(TARGET_NR_Linux + 158)
-#define TARGET_NR_sched_getparam	(TARGET_NR_Linux + 159)
-#define TARGET_NR_sched_setscheduler	(TARGET_NR_Linux + 160)
-#define TARGET_NR_sched_getscheduler	(TARGET_NR_Linux + 161)
-#define TARGET_NR_sched_yield		(TARGET_NR_Linux + 162)
-#define TARGET_NR_sched_get_priority_max	(TARGET_NR_Linux + 163)
-#define TARGET_NR_sched_get_priority_min	(TARGET_NR_Linux + 164)
-#define TARGET_NR_sched_rr_get_interval	(TARGET_NR_Linux + 165)
-#define TARGET_NR_nanosleep		(TARGET_NR_Linux + 166)
-#define TARGET_NR_mremap		(TARGET_NR_Linux + 167)
-#define TARGET_NR_accept		(TARGET_NR_Linux + 168)
-#define TARGET_NR_bind			(TARGET_NR_Linux + 169)
-#define TARGET_NR_connect		(TARGET_NR_Linux + 170)
-#define TARGET_NR_getpeername		(TARGET_NR_Linux + 171)
-#define TARGET_NR_getsockname		(TARGET_NR_Linux + 172)
-#define TARGET_NR_getsockopt		(TARGET_NR_Linux + 173)
-#define TARGET_NR_listen		(TARGET_NR_Linux + 174)
-#define TARGET_NR_recv			(TARGET_NR_Linux + 175)
-#define TARGET_NR_recvfrom		(TARGET_NR_Linux + 176)
-#define TARGET_NR_recvmsg		(TARGET_NR_Linux + 177)
-#define TARGET_NR_send			(TARGET_NR_Linux + 178)
-#define TARGET_NR_sendmsg		(TARGET_NR_Linux + 179)
-#define TARGET_NR_sendto		(TARGET_NR_Linux + 180)
-#define TARGET_NR_setsockopt		(TARGET_NR_Linux + 181)
-#define TARGET_NR_shutdown		(TARGET_NR_Linux + 182)
-#define TARGET_NR_socket		(TARGET_NR_Linux + 183)
-#define TARGET_NR_socketpair		(TARGET_NR_Linux + 184)
-#define TARGET_NR_setresuid		(TARGET_NR_Linux + 185)
-#define TARGET_NR_getresuid		(TARGET_NR_Linux + 186)
-#define TARGET_NR_query_module		(TARGET_NR_Linux + 187)
-#define TARGET_NR_poll			(TARGET_NR_Linux + 188)
-#define TARGET_NR_nfsservctl		(TARGET_NR_Linux + 189)
-#define TARGET_NR_setresgid		(TARGET_NR_Linux + 190)
-#define TARGET_NR_getresgid		(TARGET_NR_Linux + 191)
-#define TARGET_NR_prctl			(TARGET_NR_Linux + 192)
-#define TARGET_NR_rt_sigreturn		(TARGET_NR_Linux + 193)
-#define TARGET_NR_rt_sigaction		(TARGET_NR_Linux + 194)
-#define TARGET_NR_rt_sigprocmask	(TARGET_NR_Linux + 195)
-#define TARGET_NR_rt_sigpending		(TARGET_NR_Linux + 196)
-#define TARGET_NR_rt_sigtimedwait	(TARGET_NR_Linux + 197)
-#define TARGET_NR_rt_sigqueueinfo	(TARGET_NR_Linux + 198)
-#define TARGET_NR_rt_sigsuspend		(TARGET_NR_Linux + 199)
-#define TARGET_NR_pread64		(TARGET_NR_Linux + 200)
-#define TARGET_NR_pwrite64		(TARGET_NR_Linux + 201)
-#define TARGET_NR_chown 		(TARGET_NR_Linux + 202)
-#define TARGET_NR_getcwd		(TARGET_NR_Linux + 203)
-#define TARGET_NR_capget		(TARGET_NR_Linux + 204)
-#define TARGET_NR_capset		(TARGET_NR_Linux + 205)
-#define TARGET_NR_sigaltstack		(TARGET_NR_Linux + 206)
-#define TARGET_NR_sendfile		(TARGET_NR_Linux + 207)
-#define TARGET_NR_getpmsg		(TARGET_NR_Linux + 208)
-#define TARGET_NR_putpmsg		(TARGET_NR_Linux + 209)
-#define TARGET_NR_mmap2			(TARGET_NR_Linux + 210)
-#define TARGET_NR_truncate64		(TARGET_NR_Linux + 211)
-#define TARGET_NR_ftruncate64		(TARGET_NR_Linux + 212)
-#define TARGET_NR_stat64		(TARGET_NR_Linux + 213)
-#define TARGET_NR_lstat64		(TARGET_NR_Linux + 214)
-#define TARGET_NR_fstat64		(TARGET_NR_Linux + 215)
-#define TARGET_NR_pivot_root		(TARGET_NR_Linux + 216)
-#define TARGET_NR_mincore		(TARGET_NR_Linux + 217)
-#define TARGET_NR_madvise		(TARGET_NR_Linux + 218)
-#define TARGET_NR_getdents64		(TARGET_NR_Linux + 219)
-#define TARGET_NR_fcntl64		(TARGET_NR_Linux + 220)
-#define TARGET_NR_reserved221		(TARGET_NR_Linux + 221)
-#define TARGET_NR_gettid		(TARGET_NR_Linux + 222)
-#define TARGET_NR_readahead		(TARGET_NR_Linux + 223)
-#define TARGET_NR_setxattr		(TARGET_NR_Linux + 224)
-#define TARGET_NR_lsetxattr		(TARGET_NR_Linux + 225)
-#define TARGET_NR_fsetxattr		(TARGET_NR_Linux + 226)
-#define TARGET_NR_getxattr		(TARGET_NR_Linux + 227)
-#define TARGET_NR_lgetxattr		(TARGET_NR_Linux + 228)
-#define TARGET_NR_fgetxattr		(TARGET_NR_Linux + 229)
-#define TARGET_NR_listxattr		(TARGET_NR_Linux + 230)
-#define TARGET_NR_llistxattr		(TARGET_NR_Linux + 231)
-#define TARGET_NR_flistxattr		(TARGET_NR_Linux + 232)
-#define TARGET_NR_removexattr		(TARGET_NR_Linux + 233)
-#define TARGET_NR_lremovexattr		(TARGET_NR_Linux + 234)
-#define TARGET_NR_fremovexattr		(TARGET_NR_Linux + 235)
-#define TARGET_NR_tkill			(TARGET_NR_Linux + 236)
-#define TARGET_NR_sendfile64		(TARGET_NR_Linux + 237)
-#define TARGET_NR_futex			(TARGET_NR_Linux + 238)
-#define TARGET_NR_sched_setaffinity	(TARGET_NR_Linux + 239)
-#define TARGET_NR_sched_getaffinity	(TARGET_NR_Linux + 240)
-#define TARGET_NR_io_setup		(TARGET_NR_Linux + 241)
-#define TARGET_NR_io_destroy		(TARGET_NR_Linux + 242)
-#define TARGET_NR_io_getevents		(TARGET_NR_Linux + 243)
-#define TARGET_NR_io_submit		(TARGET_NR_Linux + 244)
-#define TARGET_NR_io_cancel		(TARGET_NR_Linux + 245)
-#define TARGET_NR_exit_group		(TARGET_NR_Linux + 246)
-#define TARGET_NR_lookup_dcookie	(TARGET_NR_Linux + 247)
-#define TARGET_NR_epoll_create		(TARGET_NR_Linux + 248)
-#define TARGET_NR_epoll_ctl		(TARGET_NR_Linux + 249)
-#define TARGET_NR_epoll_wait		(TARGET_NR_Linux + 250)
-#define TARGET_NR_remap_file_pages	(TARGET_NR_Linux + 251)
-#define TARGET_NR_set_tid_address	(TARGET_NR_Linux + 252)
-#define TARGET_NR_restart_syscall	(TARGET_NR_Linux + 253)
-#define TARGET_NR_fadvise64_64          (TARGET_NR_Linux + 254)
-#define TARGET_NR_statfs64		(TARGET_NR_Linux + 255)
-#define TARGET_NR_fstatfs64		(TARGET_NR_Linux + 256)
-#define TARGET_NR_timer_create		(TARGET_NR_Linux + 257)
-#define TARGET_NR_timer_settime		(TARGET_NR_Linux + 258)
-#define TARGET_NR_timer_gettime		(TARGET_NR_Linux + 259)
-#define TARGET_NR_timer_getoverrun	(TARGET_NR_Linux + 260)
-#define TARGET_NR_timer_delete		(TARGET_NR_Linux + 261)
-#define TARGET_NR_clock_settime		(TARGET_NR_Linux + 262)
-#define TARGET_NR_clock_gettime		(TARGET_NR_Linux + 263)
-#define TARGET_NR_clock_getres		(TARGET_NR_Linux + 264)
-#define TARGET_NR_clock_nanosleep	(TARGET_NR_Linux + 265)
-#define TARGET_NR_tgkill		(TARGET_NR_Linux + 266)
-#define TARGET_NR_utimes		(TARGET_NR_Linux + 267)
-#define TARGET_NR_mbind			(TARGET_NR_Linux + 268)
-#define TARGET_NR_get_mempolicy		(TARGET_NR_Linux + 269)
-#define TARGET_NR_set_mempolicy		(TARGET_NR_Linux + 270)
-#define TARGET_NR_mq_open		(TARGET_NR_Linux + 271)
-#define TARGET_NR_mq_unlink		(TARGET_NR_Linux + 272)
-#define TARGET_NR_mq_timedsend		(TARGET_NR_Linux + 273)
-#define TARGET_NR_mq_timedreceive	(TARGET_NR_Linux + 274)
-#define TARGET_NR_mq_notify		(TARGET_NR_Linux + 275)
-#define TARGET_NR_mq_getsetattr		(TARGET_NR_Linux + 276)
-#define TARGET_NR_vserver		(TARGET_NR_Linux + 277)
-#define TARGET_NR_waitid		(TARGET_NR_Linux + 278)
-/* #define TARGET_NR_sys_setaltroot	(TARGET_NR_Linux + 279) */
-#define TARGET_NR_add_key		(TARGET_NR_Linux + 280)
-#define TARGET_NR_request_key		(TARGET_NR_Linux + 281)
-#define TARGET_NR_keyctl		(TARGET_NR_Linux + 282)
-#define TARGET_NR_set_thread_area	(TARGET_NR_Linux + 283)
-#define TARGET_NR_inotify_init		(TARGET_NR_Linux + 284)
-#define TARGET_NR_inotify_add_watch	(TARGET_NR_Linux + 285)
-#define TARGET_NR_inotify_rm_watch	(TARGET_NR_Linux + 286)
-#define TARGET_NR_migrate_pages		(TARGET_NR_Linux + 287)
-#define TARGET_NR_openat		(TARGET_NR_Linux + 288)
-#define TARGET_NR_mkdirat		(TARGET_NR_Linux + 289)
-#define TARGET_NR_mknodat		(TARGET_NR_Linux + 290)
-#define TARGET_NR_fchownat		(TARGET_NR_Linux + 291)
-#define TARGET_NR_futimesat		(TARGET_NR_Linux + 292)
-#define TARGET_NR_fstatat64		(TARGET_NR_Linux + 293)
-#define TARGET_NR_unlinkat		(TARGET_NR_Linux + 294)
-#define TARGET_NR_renameat		(TARGET_NR_Linux + 295)
-#define TARGET_NR_linkat		(TARGET_NR_Linux + 296)
-#define TARGET_NR_symlinkat		(TARGET_NR_Linux + 297)
-#define TARGET_NR_readlinkat		(TARGET_NR_Linux + 298)
-#define TARGET_NR_fchmodat		(TARGET_NR_Linux + 299)
-#define TARGET_NR_faccessat		(TARGET_NR_Linux + 300)
-#define TARGET_NR_pselect6		(TARGET_NR_Linux + 301)
-#define TARGET_NR_ppoll			(TARGET_NR_Linux + 302)
-#define TARGET_NR_unshare		(TARGET_NR_Linux + 303)
-#define TARGET_NR_splice		(TARGET_NR_Linux + 304)
-#define TARGET_NR_sync_file_range	(TARGET_NR_Linux + 305)
-#define TARGET_NR_tee			(TARGET_NR_Linux + 306)
-#define TARGET_NR_vmsplice		(TARGET_NR_Linux + 307)
-#define TARGET_NR_move_pages		(TARGET_NR_Linux + 308)
-#define TARGET_NR_set_robust_list	(TARGET_NR_Linux + 309)
-#define TARGET_NR_get_robust_list	(TARGET_NR_Linux + 310)
-#define TARGET_NR_kexec_load		(TARGET_NR_Linux + 311)
-#define TARGET_NR_getcpu		(TARGET_NR_Linux + 312)
-#define TARGET_NR_epoll_pwait		(TARGET_NR_Linux + 313)
-#define TARGET_NR_ioprio_set		(TARGET_NR_Linux + 314)
-#define TARGET_NR_ioprio_get		(TARGET_NR_Linux + 315)
-#define TARGET_NR_utimensat		(TARGET_NR_Linux + 316)
-#define TARGET_NR_signalfd		(TARGET_NR_Linux + 317)
-#define TARGET_NR_timerfd		(TARGET_NR_Linux + 318)
-#define TARGET_NR_eventfd		(TARGET_NR_Linux + 319)
-#define TARGET_NR_fallocate		(TARGET_NR_Linux + 320)
-#define TARGET_NR_timerfd_create	(TARGET_NR_Linux + 321)
-#define TARGET_NR_timerfd_gettime	(TARGET_NR_Linux + 322)
-#define TARGET_NR_timerfd_settime	(TARGET_NR_Linux + 323)
-#define TARGET_NR_signalfd4		(TARGET_NR_Linux + 324)
-#define TARGET_NR_eventfd2		(TARGET_NR_Linux + 325)
-#define TARGET_NR_epoll_create1	(TARGET_NR_Linux + 326)
-#define TARGET_NR_dup3			(TARGET_NR_Linux + 327)
-#define TARGET_NR_pipe2		(TARGET_NR_Linux + 328)
-#define TARGET_NR_inotify_init1	(TARGET_NR_Linux + 329)
-#define TARGET_NR_preadv                (TARGET_NR_Linux + 330)
-#define TARGET_NR_pwritev               (TARGET_NR_Linux + 331)
-#define TARGET_NR_rt_tgsigqueueinfo     (TARGET_NR_Linux + 332)
-#define TARGET_NR_perf_event_open       (TARGET_NR_Linux + 333)
-#define TARGET_NR_accept4               (TARGET_NR_Linux + 334)
-#define TARGET_NR_recvmmsg              (TARGET_NR_Linux + 335)
-#define TARGET_NR_fanotify_init         (TARGET_NR_Linux + 336)
-#define TARGET_NR_fanotify_mark         (TARGET_NR_Linux + 337)
-#define TARGET_NR_prlimit64             (TARGET_NR_Linux + 338)
-#define TARGET_NR_name_to_handle_at     (TARGET_NR_Linux + 339)
-#define TARGET_NR_open_by_handle_at     (TARGET_NR_Linux + 340)
-#define TARGET_NR_clock_adjtime         (TARGET_NR_Linux + 341)
-#define TARGET_NR_syncfs                (TARGET_NR_Linux + 342)
-#define TARGET_NR_sendmmsg              (TARGET_NR_Linux + 343)
-#define TARGET_NR_setns                 (TARGET_NR_Linux + 344)
-#define TARGET_NR_process_vm_readv      (TARGET_NR_Linux + 345)
-#define TARGET_NR_process_vm_writev     (TARGET_NR_Linux + 346)
-#define TARGET_NR_kcmp                  (TARGET_NR_Linux + 347)
-#define TARGET_NR_finit_module          (TARGET_NR_Linux + 348)
-
-#define TARGET_NR_sched_setattr         (TARGET_NR_Linux + 349)
-#define TARGET_NR_sched_getattr         (TARGET_NR_Linux + 350)
-#define TARGET_NR_renameat2             (TARGET_NR_Linux + 351)
-#define TARGET_NR_seccomp               (TARGET_NR_Linux + 352)
-#define TARGET_NR_getrandom             (TARGET_NR_Linux + 353)
-#define TARGET_NR_memfd_create          (TARGET_NR_Linux + 354)
-#define TARGET_NR_bpf                   (TARGET_NR_Linux + 355)
-#define TARGET_NR_execveat              (TARGET_NR_Linux + 356)
-#define TARGET_NR_userfaultfd           (TARGET_NR_Linux + 357)
-#define TARGET_NR_membarrier            (TARGET_NR_Linux + 358)
-#define TARGET_NR_mlock2                (TARGET_NR_Linux + 359)
-#define TARGET_NR_copy_file_range       (TARGET_NR_Linux + 360)
-#define TARGET_NR_preadv2               (TARGET_NR_Linux + 361)
-#define TARGET_NR_pwritev2              (TARGET_NR_Linux + 362)
-#define TARGET_NR_pkey_mprotect         (TARGET_NR_Linux + 363)
-#define TARGET_NR_pkey_alloc            (TARGET_NR_Linux + 364)
-#define TARGET_NR_pkey_free             (TARGET_NR_Linux + 365)
-#define TARGET_NR_statx                 (TARGET_NR_Linux + 366)
-#define TARGET_NR_rseq                  (TARGET_NR_Linux + 367)
-#define TARGET_NR_io_pgetevents         (TARGET_NR_Linux + 368)
-/* room for arch specific calls */
-#define TARGET_NR_semget                (TARGET_NR_Linux + 393)
-#define TARGET_NR_semctl                (TARGET_NR_Linux + 394)
-#define TARGET_NR_shmget                (TARGET_NR_Linux + 395)
-#define TARGET_NR_shmctl                (TARGET_NR_Linux + 396)
-#define TARGET_NR_shmat                 (TARGET_NR_Linux + 397)
-#define TARGET_NR_shmdt                 (TARGET_NR_Linux + 398)
-#define TARGET_NR_msgget                (TARGET_NR_Linux + 399)
-#define TARGET_NR_msgsnd                (TARGET_NR_Linux + 400)
-#define TARGET_NR_msgrcv                (TARGET_NR_Linux + 401)
-#define TARGET_NR_msgctl                (TARGET_NR_Linux + 402)
-/* 403-423 common for 32-bit archs */
-#define TARGET_NR_clock_gettime64              (TARGET_NR_Linux + 403)
-#define TARGET_NR_clock_settime64              (TARGET_NR_Linux + 404)
-#define TARGET_NR_clock_adjtime64              (TARGET_NR_Linux + 405)
-#define TARGET_NR_clock_getres_time64          (TARGET_NR_Linux + 406)
-#define TARGET_NR_clock_nanosleep_time64       (TARGET_NR_Linux + 407)
-#define TARGET_NR_timer_gettime64              (TARGET_NR_Linux + 408)
-#define TARGET_NR_timer_settime64              (TARGET_NR_Linux + 409)
-#define TARGET_NR_timerfd_gettime64            (TARGET_NR_Linux + 410)
-#define TARGET_NR_timerfd_settime64            (TARGET_NR_Linux + 411)
-#define TARGET_NR_utimensat_time64             (TARGET_NR_Linux + 412)
-#define TARGET_NR_pselect6_time64              (TARGET_NR_Linux + 413)
-#define TARGET_NR_ppoll_time64                 (TARGET_NR_Linux + 414)
-#define TARGET_NR_io_pgetevents_time64         (TARGET_NR_Linux + 416)
-#define TARGET_NR_recvmmsg_time64              (TARGET_NR_Linux + 417)
-#define TARGET_NR_mq_timedsend_time64          (TARGET_NR_Linux + 418)
-#define TARGET_NR_mq_timedreceive_time64       (TARGET_NR_Linux + 419)
-#define TARGET_NR_semtimedop_time64            (TARGET_NR_Linux + 420)
-#define TARGET_NR_rt_sigtimedwait_time64       (TARGET_NR_Linux + 421)
-#define TARGET_NR_futex_time64                 (TARGET_NR_Linux + 422)
-#define TARGET_NR_sched_rr_get_interval_time64 (TARGET_NR_Linux + 423)
-/* 424 onwards common for all archs */
-#define TARGET_NR_pidfd_send_signal            (TARGET_NR_Linux + 424)
-#define TARGET_NR_io_uring_setup               (TARGET_NR_Linux + 425)
-#define TARGET_NR_io_uring_enter               (TARGET_NR_Linux + 426)
-#define TARGET_NR_io_uring_register            (TARGET_NR_Linux + 427)
-#define TARGET_NR_open_tree                    (TARGET_NR_Linux + 428)
-#define TARGET_NR_move_mount                   (TARGET_NR_Linux + 429)
-#define TARGET_NR_fsopen                       (TARGET_NR_Linux + 430)
-#define TARGET_NR_fsconfig                     (TARGET_NR_Linux + 431)
-#define TARGET_NR_fsmount                      (TARGET_NR_Linux + 432)
-#define TARGET_NR_fspick                       (TARGET_NR_Linux + 433)
-#define TARGET_NR_pidfd_open                   (TARGET_NR_Linux + 434)
-#define TARGET_NR_clone3                       (TARGET_NR_Linux + 435)
-
-#endif
diff --git a/linux-user/mips/syscall_o32.tbl b/linux-user/mips/syscall_o32.tbl
new file mode 100644
index 000000000000..353539ea4140
--- /dev/null
+++ b/linux-user/mips/syscall_o32.tbl
@@ -0,0 +1,425 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# system call numbers and entry vectors for mips
+#
+# The format is:
+# <number> <abi> <name> <entry point> <compat entry point>
+#
+# The <abi> is always "o32" for this file.
+#
+0	o32	syscall				sys_syscall			sys32_syscall
+1	o32	exit				sys_exit
+2	o32	fork				__sys_fork
+3	o32	read				sys_read
+4	o32	write				sys_write
+5	o32	open				sys_open			compat_sys_open
+6	o32	close				sys_close
+7	o32	waitpid				sys_waitpid
+8	o32	creat				sys_creat
+9	o32	link				sys_link
+10	o32	unlink				sys_unlink
+11	o32	execve				sys_execve			compat_sys_execve
+12	o32	chdir				sys_chdir
+13	o32	time				sys_time32
+14	o32	mknod				sys_mknod
+15	o32	chmod				sys_chmod
+16	o32	lchown				sys_lchown
+17	o32	break				sys_ni_syscall
+# 18 was sys_stat
+18	o32	unused18			sys_ni_syscall
+19	o32	lseek				sys_lseek
+20	o32	getpid				sys_getpid
+21	o32	mount				sys_mount			compat_sys_mount
+22	o32	umount				sys_oldumount
+23	o32	setuid				sys_setuid
+24	o32	getuid				sys_getuid
+25	o32	stime				sys_stime32
+26	o32	ptrace				sys_ptrace			compat_sys_ptrace
+27	o32	alarm				sys_alarm
+# 28 was sys_fstat
+28	o32	unused28			sys_ni_syscall
+29	o32	pause				sys_pause
+30	o32	utime				sys_utime32
+31	o32	stty				sys_ni_syscall
+32	o32	gtty				sys_ni_syscall
+33	o32	access				sys_access
+34	o32	nice				sys_nice
+35	o32	ftime				sys_ni_syscall
+36	o32	sync				sys_sync
+37	o32	kill				sys_kill
+38	o32	rename				sys_rename
+39	o32	mkdir				sys_mkdir
+40	o32	rmdir				sys_rmdir
+41	o32	dup				sys_dup
+42	o32	pipe				sysm_pipe
+43	o32	times				sys_times			compat_sys_times
+44	o32	prof				sys_ni_syscall
+45	o32	brk				sys_brk
+46	o32	setgid				sys_setgid
+47	o32	getgid				sys_getgid
+48	o32	signal				sys_ni_syscall
+49	o32	geteuid				sys_geteuid
+50	o32	getegid				sys_getegid
+51	o32	acct				sys_acct
+52	o32	umount2				sys_umount
+53	o32	lock				sys_ni_syscall
+54	o32	ioctl				sys_ioctl			compat_sys_ioctl
+55	o32	fcntl				sys_fcntl			compat_sys_fcntl
+56	o32	mpx				sys_ni_syscall
+57	o32	setpgid				sys_setpgid
+58	o32	ulimit				sys_ni_syscall
+59	o32	unused59			sys_olduname
+60	o32	umask				sys_umask
+61	o32	chroot				sys_chroot
+62	o32	ustat				sys_ustat			compat_sys_ustat
+63	o32	dup2				sys_dup2
+64	o32	getppid				sys_getppid
+65	o32	getpgrp				sys_getpgrp
+66	o32	setsid				sys_setsid
+67	o32	sigaction			sys_sigaction			sys_32_sigaction
+68	o32	sgetmask			sys_sgetmask
+69	o32	ssetmask			sys_ssetmask
+70	o32	setreuid			sys_setreuid
+71	o32	setregid			sys_setregid
+72	o32	sigsuspend			sys_sigsuspend			sys32_sigsuspend
+73	o32	sigpending			sys_sigpending			compat_sys_sigpending
+74	o32	sethostname			sys_sethostname
+75	o32	setrlimit			sys_setrlimit			compat_sys_setrlimit
+76	o32	getrlimit			sys_getrlimit			compat_sys_getrlimit
+77	o32	getrusage			sys_getrusage			compat_sys_getrusage
+78	o32	gettimeofday			sys_gettimeofday		compat_sys_gettimeofday
+79	o32	settimeofday			sys_settimeofday		compat_sys_settimeofday
+80	o32	getgroups			sys_getgroups
+81	o32	setgroups			sys_setgroups
+# 82 was old_select
+82	o32	reserved82			sys_ni_syscall
+83	o32	symlink				sys_symlink
+# 84 was sys_lstat
+84	o32	unused84			sys_ni_syscall
+85	o32	readlink			sys_readlink
+86	o32	uselib				sys_uselib
+87	o32	swapon				sys_swapon
+88	o32	reboot				sys_reboot
+89	o32	readdir				sys_old_readdir			compat_sys_old_readdir
+90	o32	mmap				sys_mips_mmap
+91	o32	munmap				sys_munmap
+92	o32	truncate			sys_truncate			compat_sys_truncate
+93	o32	ftruncate			sys_ftruncate			compat_sys_ftruncate
+94	o32	fchmod				sys_fchmod
+95	o32	fchown				sys_fchown
+96	o32	getpriority			sys_getpriority
+97	o32	setpriority			sys_setpriority
+98	o32	profil				sys_ni_syscall
+99	o32	statfs				sys_statfs			compat_sys_statfs
+100	o32	fstatfs				sys_fstatfs			compat_sys_fstatfs
+101	o32	ioperm				sys_ni_syscall
+102	o32	socketcall			sys_socketcall			compat_sys_socketcall
+103	o32	syslog				sys_syslog
+104	o32	setitimer			sys_setitimer			compat_sys_setitimer
+105	o32	getitimer			sys_getitimer			compat_sys_getitimer
+106	o32	stat				sys_newstat			compat_sys_newstat
+107	o32	lstat				sys_newlstat			compat_sys_newlstat
+108	o32	fstat				sys_newfstat			compat_sys_newfstat
+109	o32	unused109			sys_uname
+110	o32	iopl				sys_ni_syscall
+111	o32	vhangup				sys_vhangup
+112	o32	idle				sys_ni_syscall
+113	o32	vm86				sys_ni_syscall
+114	o32	wait4				sys_wait4			compat_sys_wait4
+115	o32	swapoff				sys_swapoff
+116	o32	sysinfo				sys_sysinfo			compat_sys_sysinfo
+117	o32	ipc				sys_ipc				compat_sys_ipc
+118	o32	fsync				sys_fsync
+119	o32	sigreturn			sys_sigreturn			sys32_sigreturn
+120	o32	clone				__sys_clone
+121	o32	setdomainname			sys_setdomainname
+122	o32	uname				sys_newuname
+123	o32	modify_ldt			sys_ni_syscall
+124	o32	adjtimex			sys_adjtimex_time32
+125	o32	mprotect			sys_mprotect
+126	o32	sigprocmask			sys_sigprocmask			compat_sys_sigprocmask
+127	o32	create_module			sys_ni_syscall
+128	o32	init_module			sys_init_module
+129	o32	delete_module			sys_delete_module
+130	o32	get_kernel_syms			sys_ni_syscall
+131	o32	quotactl			sys_quotactl
+132	o32	getpgid				sys_getpgid
+133	o32	fchdir				sys_fchdir
+134	o32	bdflush				sys_bdflush
+135	o32	sysfs				sys_sysfs
+136	o32	personality			sys_personality			sys_32_personality
+137	o32	afs_syscall			sys_ni_syscall
+138	o32	setfsuid			sys_setfsuid
+139	o32	setfsgid			sys_setfsgid
+140	o32	_llseek				sys_llseek			sys_32_llseek
+141	o32	getdents			sys_getdents			compat_sys_getdents
+142	o32	_newselect			sys_select			compat_sys_select
+143	o32	flock				sys_flock
+144	o32	msync				sys_msync
+145	o32	readv				sys_readv			compat_sys_readv
+146	o32	writev				sys_writev			compat_sys_writev
+147	o32	cacheflush			sys_cacheflush
+148	o32	cachectl			sys_cachectl
+149	o32	sysmips				__sys_sysmips
+150	o32	unused150			sys_ni_syscall
+151	o32	getsid				sys_getsid
+152	o32	fdatasync			sys_fdatasync
+153	o32	_sysctl				sys_sysctl			compat_sys_sysctl
+154	o32	mlock				sys_mlock
+155	o32	munlock				sys_munlock
+156	o32	mlockall			sys_mlockall
+157	o32	munlockall			sys_munlockall
+158	o32	sched_setparam			sys_sched_setparam
+159	o32	sched_getparam			sys_sched_getparam
+160	o32	sched_setscheduler		sys_sched_setscheduler
+161	o32	sched_getscheduler		sys_sched_getscheduler
+162	o32	sched_yield			sys_sched_yield
+163	o32	sched_get_priority_max		sys_sched_get_priority_max
+164	o32	sched_get_priority_min		sys_sched_get_priority_min
+165	o32	sched_rr_get_interval		sys_sched_rr_get_interval_time32
+166	o32	nanosleep			sys_nanosleep_time32
+167	o32	mremap				sys_mremap
+168	o32	accept				sys_accept
+169	o32	bind				sys_bind
+170	o32	connect				sys_connect
+171	o32	getpeername			sys_getpeername
+172	o32	getsockname			sys_getsockname
+173	o32	getsockopt			sys_getsockopt			compat_sys_getsockopt
+174	o32	listen				sys_listen
+175	o32	recv				sys_recv			compat_sys_recv
+176	o32	recvfrom			sys_recvfrom			compat_sys_recvfrom
+177	o32	recvmsg				sys_recvmsg			compat_sys_recvmsg
+178	o32	send				sys_send
+179	o32	sendmsg				sys_sendmsg			compat_sys_sendmsg
+180	o32	sendto				sys_sendto
+181	o32	setsockopt			sys_setsockopt			compat_sys_setsockopt
+182	o32	shutdown			sys_shutdown
+183	o32	socket				sys_socket
+184	o32	socketpair			sys_socketpair
+185	o32	setresuid			sys_setresuid
+186	o32	getresuid			sys_getresuid
+187	o32	query_module			sys_ni_syscall
+188	o32	poll				sys_poll
+189	o32	nfsservctl			sys_ni_syscall
+190	o32	setresgid			sys_setresgid
+191	o32	getresgid			sys_getresgid
+192	o32	prctl				sys_prctl
+193	o32	rt_sigreturn			sys_rt_sigreturn		sys32_rt_sigreturn
+194	o32	rt_sigaction			sys_rt_sigaction		compat_sys_rt_sigaction
+195	o32	rt_sigprocmask			sys_rt_sigprocmask		compat_sys_rt_sigprocmask
+196	o32	rt_sigpending			sys_rt_sigpending		compat_sys_rt_sigpending
+197	o32	rt_sigtimedwait			sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
+198	o32	rt_sigqueueinfo			sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
+199	o32	rt_sigsuspend			sys_rt_sigsuspend		compat_sys_rt_sigsuspend
+200	o32	pread64				sys_pread64			sys_32_pread
+201	o32	pwrite64			sys_pwrite64			sys_32_pwrite
+202	o32	chown				sys_chown
+203	o32	getcwd				sys_getcwd
+204	o32	capget				sys_capget
+205	o32	capset				sys_capset
+206	o32	sigaltstack			sys_sigaltstack			compat_sys_sigaltstack
+207	o32	sendfile			sys_sendfile			compat_sys_sendfile
+208	o32	getpmsg				sys_ni_syscall
+209	o32	putpmsg				sys_ni_syscall
+210	o32	mmap2				sys_mips_mmap2
+211	o32	truncate64			sys_truncate64			sys_32_truncate64
+212	o32	ftruncate64			sys_ftruncate64			sys_32_ftruncate64
+213	o32	stat64				sys_stat64			sys_newstat
+214	o32	lstat64				sys_lstat64			sys_newlstat
+215	o32	fstat64				sys_fstat64			sys_newfstat
+216	o32	pivot_root			sys_pivot_root
+217	o32	mincore				sys_mincore
+218	o32	madvise				sys_madvise
+219	o32	getdents64			sys_getdents64
+220	o32	fcntl64				sys_fcntl64			compat_sys_fcntl64
+221	o32	reserved221			sys_ni_syscall
+222	o32	gettid				sys_gettid
+223	o32	readahead			sys_readahead			sys32_readahead
+224	o32	setxattr			sys_setxattr
+225	o32	lsetxattr			sys_lsetxattr
+226	o32	fsetxattr			sys_fsetxattr
+227	o32	getxattr			sys_getxattr
+228	o32	lgetxattr			sys_lgetxattr
+229	o32	fgetxattr			sys_fgetxattr
+230	o32	listxattr			sys_listxattr
+231	o32	llistxattr			sys_llistxattr
+232	o32	flistxattr			sys_flistxattr
+233	o32	removexattr			sys_removexattr
+234	o32	lremovexattr			sys_lremovexattr
+235	o32	fremovexattr			sys_fremovexattr
+236	o32	tkill				sys_tkill
+237	o32	sendfile64			sys_sendfile64
+238	o32	futex				sys_futex_time32
+239	o32	sched_setaffinity		sys_sched_setaffinity		compat_sys_sched_setaffinity
+240	o32	sched_getaffinity		sys_sched_getaffinity		compat_sys_sched_getaffinity
+241	o32	io_setup			sys_io_setup			compat_sys_io_setup
+242	o32	io_destroy			sys_io_destroy
+243	o32	io_getevents			sys_io_getevents_time32
+244	o32	io_submit			sys_io_submit			compat_sys_io_submit
+245	o32	io_cancel			sys_io_cancel
+246	o32	exit_group			sys_exit_group
+247	o32	lookup_dcookie			sys_lookup_dcookie		compat_sys_lookup_dcookie
+248	o32	epoll_create			sys_epoll_create
+249	o32	epoll_ctl			sys_epoll_ctl
+250	o32	epoll_wait			sys_epoll_wait
+251	o32	remap_file_pages		sys_remap_file_pages
+252	o32	set_tid_address			sys_set_tid_address
+253	o32	restart_syscall			sys_restart_syscall
+254	o32	fadvise64			sys_fadvise64_64		sys32_fadvise64_64
+255	o32	statfs64			sys_statfs64			compat_sys_statfs64
+256	o32	fstatfs64			sys_fstatfs64			compat_sys_fstatfs64
+257	o32	timer_create			sys_timer_create		compat_sys_timer_create
+258	o32	timer_settime			sys_timer_settime32
+259	o32	timer_gettime			sys_timer_gettime32
+260	o32	timer_getoverrun		sys_timer_getoverrun
+261	o32	timer_delete			sys_timer_delete
+262	o32	clock_settime			sys_clock_settime32
+263	o32	clock_gettime			sys_clock_gettime32
+264	o32	clock_getres			sys_clock_getres_time32
+265	o32	clock_nanosleep			sys_clock_nanosleep_time32
+266	o32	tgkill				sys_tgkill
+267	o32	utimes				sys_utimes_time32
+268	o32	mbind				sys_mbind			compat_sys_mbind
+269	o32	get_mempolicy			sys_get_mempolicy		compat_sys_get_mempolicy
+270	o32	set_mempolicy			sys_set_mempolicy		compat_sys_set_mempolicy
+271	o32	mq_open				sys_mq_open			compat_sys_mq_open
+272	o32	mq_unlink			sys_mq_unlink
+273	o32	mq_timedsend			sys_mq_timedsend_time32
+274	o32	mq_timedreceive			sys_mq_timedreceive_time32
+275	o32	mq_notify			sys_mq_notify			compat_sys_mq_notify
+276	o32	mq_getsetattr			sys_mq_getsetattr		compat_sys_mq_getsetattr
+277	o32	vserver				sys_ni_syscall
+278	o32	waitid				sys_waitid			compat_sys_waitid
+# 279 was sys_setaltroot
+280	o32	add_key				sys_add_key
+281	o32	request_key			sys_request_key
+282	o32	keyctl				sys_keyctl			compat_sys_keyctl
+283	o32	set_thread_area			sys_set_thread_area
+284	o32	inotify_init			sys_inotify_init
+285	o32	inotify_add_watch		sys_inotify_add_watch
+286	o32	inotify_rm_watch		sys_inotify_rm_watch
+287	o32	migrate_pages			sys_migrate_pages		compat_sys_migrate_pages
+288	o32	openat				sys_openat			compat_sys_openat
+289	o32	mkdirat				sys_mkdirat
+290	o32	mknodat				sys_mknodat
+291	o32	fchownat			sys_fchownat
+292	o32	futimesat			sys_futimesat_time32
+293	o32	fstatat64			sys_fstatat64			sys_newfstatat
+294	o32	unlinkat			sys_unlinkat
+295	o32	renameat			sys_renameat
+296	o32	linkat				sys_linkat
+297	o32	symlinkat			sys_symlinkat
+298	o32	readlinkat			sys_readlinkat
+299	o32	fchmodat			sys_fchmodat
+300	o32	faccessat			sys_faccessat
+301	o32	pselect6			sys_pselect6_time32		compat_sys_pselect6_time32
+302	o32	ppoll				sys_ppoll_time32		compat_sys_ppoll_time32
+303	o32	unshare				sys_unshare
+304	o32	splice				sys_splice
+305	o32	sync_file_range			sys_sync_file_range		sys32_sync_file_range
+306	o32	tee				sys_tee
+307	o32	vmsplice			sys_vmsplice			compat_sys_vmsplice
+308	o32	move_pages			sys_move_pages			compat_sys_move_pages
+309	o32	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
+310	o32	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
+311	o32	kexec_load			sys_kexec_load			compat_sys_kexec_load
+312	o32	getcpu				sys_getcpu
+313	o32	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
+314	o32	ioprio_set			sys_ioprio_set
+315	o32	ioprio_get			sys_ioprio_get
+316	o32	utimensat			sys_utimensat_time32
+317	o32	signalfd			sys_signalfd			compat_sys_signalfd
+318	o32	timerfd				sys_ni_syscall
+319	o32	eventfd				sys_eventfd
+320	o32	fallocate			sys_fallocate			sys32_fallocate
+321	o32	timerfd_create			sys_timerfd_create
+322	o32	timerfd_gettime			sys_timerfd_gettime32
+323	o32	timerfd_settime			sys_timerfd_settime32
+324	o32	signalfd4			sys_signalfd4			compat_sys_signalfd4
+325	o32	eventfd2			sys_eventfd2
+326	o32	epoll_create1			sys_epoll_create1
+327	o32	dup3				sys_dup3
+328	o32	pipe2				sys_pipe2
+329	o32	inotify_init1			sys_inotify_init1
+330	o32	preadv				sys_preadv			compat_sys_preadv
+331	o32	pwritev				sys_pwritev			compat_sys_pwritev
+332	o32	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+333	o32	perf_event_open			sys_perf_event_open
+334	o32	accept4				sys_accept4
+335	o32	recvmmsg			sys_recvmmsg_time32		compat_sys_recvmmsg_time32
+336	o32	fanotify_init			sys_fanotify_init
+337	o32	fanotify_mark			sys_fanotify_mark		compat_sys_fanotify_mark
+338	o32	prlimit64			sys_prlimit64
+339	o32	name_to_handle_at		sys_name_to_handle_at
+340	o32	open_by_handle_at		sys_open_by_handle_at		compat_sys_open_by_handle_at
+341	o32	clock_adjtime			sys_clock_adjtime32
+342	o32	syncfs				sys_syncfs
+343	o32	sendmmsg			sys_sendmmsg			compat_sys_sendmmsg
+344	o32	setns				sys_setns
+345	o32	process_vm_readv		sys_process_vm_readv		compat_sys_process_vm_readv
+346	o32	process_vm_writev		sys_process_vm_writev		compat_sys_process_vm_writev
+347	o32	kcmp				sys_kcmp
+348	o32	finit_module			sys_finit_module
+349	o32	sched_setattr			sys_sched_setattr
+350	o32	sched_getattr			sys_sched_getattr
+351	o32	renameat2			sys_renameat2
+352	o32	seccomp				sys_seccomp
+353	o32	getrandom			sys_getrandom
+354	o32	memfd_create			sys_memfd_create
+355	o32	bpf				sys_bpf
+356	o32	execveat			sys_execveat			compat_sys_execveat
+357	o32	userfaultfd			sys_userfaultfd
+358	o32	membarrier			sys_membarrier
+359	o32	mlock2				sys_mlock2
+360	o32	copy_file_range			sys_copy_file_range
+361	o32	preadv2				sys_preadv2			compat_sys_preadv2
+362	o32	pwritev2			sys_pwritev2			compat_sys_pwritev2
+363	o32	pkey_mprotect			sys_pkey_mprotect
+364	o32	pkey_alloc			sys_pkey_alloc
+365	o32	pkey_free			sys_pkey_free
+366	o32	statx				sys_statx
+367	o32	rseq				sys_rseq
+368	o32	io_pgetevents			sys_io_pgetevents_time32	compat_sys_io_pgetevents
+# room for arch specific calls
+393	o32	semget				sys_semget
+394	o32	semctl				sys_semctl			compat_sys_semctl
+395	o32	shmget				sys_shmget
+396	o32	shmctl				sys_shmctl			compat_sys_shmctl
+397	o32	shmat				sys_shmat			compat_sys_shmat
+398	o32	shmdt				sys_shmdt
+399	o32	msgget				sys_msgget
+400	o32	msgsnd				sys_msgsnd			compat_sys_msgsnd
+401	o32	msgrcv				sys_msgrcv			compat_sys_msgrcv
+402	o32	msgctl				sys_msgctl			compat_sys_msgctl
+403	o32	clock_gettime64			sys_clock_gettime		sys_clock_gettime
+404	o32	clock_settime64			sys_clock_settime		sys_clock_settime
+405	o32	clock_adjtime64			sys_clock_adjtime		sys_clock_adjtime
+406	o32	clock_getres_time64		sys_clock_getres		sys_clock_getres
+407	o32	clock_nanosleep_time64		sys_clock_nanosleep		sys_clock_nanosleep
+408	o32	timer_gettime64			sys_timer_gettime		sys_timer_gettime
+409	o32	timer_settime64			sys_timer_settime		sys_timer_settime
+410	o32	timerfd_gettime64		sys_timerfd_gettime		sys_timerfd_gettime
+411	o32	timerfd_settime64		sys_timerfd_settime		sys_timerfd_settime
+412	o32	utimensat_time64		sys_utimensat			sys_utimensat
+413	o32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
+414	o32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
+416	o32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+417	o32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
+418	o32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
+419	o32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
+420	o32	semtimedop_time64		sys_semtimedop			sys_semtimedop
+421	o32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	o32	futex_time64			sys_futex			sys_futex
+423	o32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+424	o32	pidfd_send_signal		sys_pidfd_send_signal
+425	o32	io_uring_setup			sys_io_uring_setup
+426	o32	io_uring_enter			sys_io_uring_enter
+427	o32	io_uring_register		sys_io_uring_register
+428	o32	open_tree			sys_open_tree
+429	o32	move_mount			sys_move_mount
+430	o32	fsopen				sys_fsopen
+431	o32	fsconfig			sys_fsconfig
+432	o32	fsmount				sys_fsmount
+433	o32	fspick				sys_fspick
+434	o32	pidfd_open			sys_pidfd_open
+435	o32	clone3				__sys_clone3
diff --git a/linux-user/mips/syscallhdr.sh b/linux-user/mips/syscallhdr.sh
new file mode 100644
index 000000000000..761e3e47dda2
--- /dev/null
+++ b/linux-user/mips/syscallhdr.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+in="$1"
+out="$2"
+my_abis=`echo "($3)" | tr ',' '|'`
+prefix="$4"
+offset="$5"
+
+fileguard=LINUX_USER_MIPS_`basename "$out" | sed \
+    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
+    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
+grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
+    printf "#ifndef %s\n" "${fileguard}"
+    printf "#define %s\n" "${fileguard}"
+    printf "\n"
+
+    nxt=0
+    while read nr abi name entry compat ; do
+        if [ "$name" = "fadvise64" ] ; then
+            name="fadvise64_64"
+        fi
+        if [ -z "$offset" ]; then
+            printf "#define TARGET_NR_%s%s\t%s\n" \
+                "${prefix}" "${name}" "${nr}"
+        else
+            printf "#define TARGET_NR_%s%s\t(%s + %s)\n" \
+                "${prefix}" "${name}" "${offset}" "${nr}"
+        fi
+        nxt=$((nr+1))
+    done
+
+    printf "\n"
+    printf "#endif /* %s */" "${fileguard}"
+    printf "\n"
+) > "$out"
-- 
2.24.1


