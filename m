Received: from eggs.gnu.org ([209.51.188.92]:34045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wzssyqa@gmail.com>) id 1hGNe8-0003y2-Vh
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wzssyqa@gmail.com>) id 1hGNe7-0000Xb-2x
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:08 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wzssyqa@gmail.com>) id 1hGNe4-0000UA-HT
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:05 -0400
Received: by mail-pf1-x443.google.com with SMTP id 8so10386845pfr.4
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:57:01 -0700 (PDT)
Sender: YunQiang Su <wzssyqa@gmail.com>
From: YunQiang Su <syq@debian.org>
Date: Tue, 16 Apr 2019 20:56:41 +0800
Message-Id: <20190416125641.3068-1-syq@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] binfmt_misc: pass info about P flag by AT_FLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-fsdevel@vger.kernel.org
Cc: qemu-devel@nongnu.org, pburton@wavecomp.com, YunQiang Su <ysu@wavecomp.com>

From: YunQiang Su <ysu@wavecomp.com>

Currently program invoked by binfmt_misc cannot be aware about whether
P flag, aka preserve path is enabled.

Some applications like qemu need to know since it has 2 use case:
  1. call by hand, like: qemu-mipsel-static test.app OPTION
     so, qemu have to assume that P option is not enabled.
  2. call by binfmt_misc. If qemu cannot know about whether P flag is
     enabled, distribution's have to set qemu without P flag, and
     binfmt_misc call qemu like:
       qemu-mipsel-static /absolute/path/to/test.app OPTION
     even test.app is not called by absoulute path, like
       ./relative/path/to/test.app

This patch passes this information by the 3rd bits of unused AT_FLAGS.
Then, in qemu, we can get this info by:
   getauxval(AT_FLAGS) & (1<<3)

See: https://bugs.launchpad.net/qemu/+bug/1818483
Signed-off-by: YunQiang Su <ysu@wavecomp.com>
---
 fs/binfmt_elf.c         | 6 +++++-
 fs/binfmt_elf_fdpic.c   | 9 +++++++--
 fs/binfmt_misc.c        | 2 ++
 include/linux/binfmts.h | 4 ++++
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 09e76b25d833..30688fbad615 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -175,6 +175,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	unsigned char k_rand_bytes[16];
 	int items;
 	elf_addr_t *elf_info;
+	elf_addr_t flags = 0;
 	int ei_index = 0;
 	const struct cred *cred = current_cred();
 	struct vm_area_struct *vma;
@@ -249,7 +250,10 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
 	NEW_AUX_ENT(AT_BASE, interp_load_addr);
-	NEW_AUX_ENT(AT_FLAGS, 0);
+	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0) {
+		flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
+	}
+	NEW_AUX_ENT(AT_FLAGS, flags);
 	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
 	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index b53bb3729ac1..ba3385be00fb 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -46,7 +46,7 @@
 
 typedef char *elf_caddr_t;
 
-#if 0
+#if 1
 #define kdebug(fmt, ...) printk("FDPIC "fmt"\n" ,##__VA_ARGS__ )
 #else
 #define kdebug(fmt, ...) do {} while(0)
@@ -511,6 +511,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	char __user *u_platform, *u_base_platform, *p;
 	int loop;
 	int nr;	/* reset for each csp adjustment */
+	unsigned long flags = 0;
 
 #ifdef CONFIG_MMU
 	/* In some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
@@ -651,7 +652,11 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	NEW_AUX_ENT(AT_PHENT,	sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM,	exec_params->hdr.e_phnum);
 	NEW_AUX_ENT(AT_BASE,	interp_params->elfhdr_addr);
-	NEW_AUX_ENT(AT_FLAGS,	0);
+	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0) {
+		flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
+	}
+	kdebug("AT_FLAGS %ld\n", flags);
+	NEW_AUX_ENT(AT_FLAGS,	flags);
 	NEW_AUX_ENT(AT_ENTRY,	exec_params->entry_addr);
 	NEW_AUX_ENT(AT_UID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index aa4a7a23ff99..46c509cd096e 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -156,6 +156,8 @@ static int load_misc_binary(struct linux_binprm *bprm)
 		retval = remove_arg_zero(bprm);
 		if (retval)
 			goto ret;
+	} else {
+		bprm->interp_flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
 	}
 
 	if (fmt->flags & MISC_FMT_OPEN_BINARY) {
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 688ab0de7810..c082650a0310 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -77,6 +77,10 @@ struct linux_binprm {
 #define BINPRM_FLAGS_PATH_INACCESSIBLE_BIT 2
 #define BINPRM_FLAGS_PATH_INACCESSIBLE (1 << BINPRM_FLAGS_PATH_INACCESSIBLE_BIT)
 
+/* if preserve the argv0 for the interpreter  */
+#define BINPRM_FLAGS_PRESERVE_ARGV0_BIT 3
+#define BINPRM_FLAGS_PRESERVE_ARGV0 (1 << BINPRM_FLAGS_PRESERVE_ARGV0_BIT)
+
 /* Function parameter for binfmt->coredump */
 struct coredump_params {
 	const kernel_siginfo_t *siginfo;
-- 
2.20.1
