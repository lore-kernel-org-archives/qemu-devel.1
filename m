Received: from eggs.gnu.org ([2001:4830:134:3::10]:47604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1fD3oH-0003Bt-1s
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 04:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1fD3oF-0002f7-TD
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 04:05:20 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37675
	helo=mx07-00178001.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christophe.lyon@st.com>)
	id 1fD3oF-0002eu-Jq
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 04:05:19 -0400
From: Christophe Lyon <christophe.lyon@st.com>
Date: Mon, 30 Apr 2018 10:03:43 +0200
Message-ID: <20180430080404.7323-4-christophe.lyon@st.com>
In-Reply-To: <20180430080404.7323-1-christophe.lyon@st.com>
References: <20180430080404.7323-1-christophe.lyon@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [ARM/FDPIC v4 3/4] linux-user: ARM-FDPIC: Add support
 of FDPIC for ARM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, christophe.lyon@linaro.org, peter.maydell@linaro.org, riku.voipio@iki.fi, laurent@vivier.eu

Add FDPIC info into image_info structure since interpreter info is on
stack and needs to be saved to be accessed later on.

Co-Authored-By:  Micka=C3=ABl Gu=C3=AAn=C3=A9 <mickael.guene@st.com>
Signed-off-by: Christophe Lyon <christophe.lyon@st.com>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 76d7718..36d5219 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -78,6 +78,11 @@ enum {
  */
 #define personality(pers)       (pers & PER_MASK)
=20
+int info_is_fdpic(struct image_info *info)
+{
+    return info->personality =3D=3D PER_LINUX_FDPIC;
+}
+
 /* this flag is uneffective under linux too, should be deleted */
 #ifndef MAP_DENYWRITE
 #define MAP_DENYWRITE 0
@@ -287,6 +292,25 @@ static inline void init_thread(struct target_pt_regs=
 *regs,
     /* For uClinux PIC binaries.  */
     /* XXX: Linux does this only on ARM with no MMU (do we care ?) */
     regs->uregs[10] =3D infop->start_data;
+
+    /* Support ARM FDPIC.  */
+    if (info_is_fdpic(infop)) {
+        /* As described in the ABI document, r7 points to the loadmap in=
fo
+         * prepared by the kernel. If an interpreter is needed, r8 point=
s
+         * to the interpreter loadmap and r9 points to the interpreter
+         * PT_DYNAMIC info. If no interpreter is needed, r8 is zero, and
+         * r9 points to the main program PT_DYNAMIC info.
+         */
+        regs->uregs[7] =3D infop->loadmap_addr;
+        if (infop->interpreter_loadmap_addr) {
+            /* Executable is dynamically loaded.  */
+            regs->uregs[8] =3D infop->interpreter_loadmap_addr;
+            regs->uregs[9] =3D infop->interpreter_pt_dynamic_addr;
+        } else {
+            regs->uregs[8] =3D 0;
+            regs->uregs[9] =3D infop->pt_dynamic_addr;
+        }
+    }
 }
=20
 #define ELF_NREG    18
@@ -1745,6 +1769,11 @@ static abi_ulong create_elf_tables(abi_ulong p, in=
t argc, int envc,
         if (interp_info) {
             interp_info->other_info =3D info;
             sp =3D loader_build_fdpic_loadmap(interp_info, sp);
+            info->interpreter_loadmap_addr =3D interp_info->loadmap_addr=
;
+            info->interpreter_pt_dynamic_addr =3D interp_info->pt_dynami=
c_addr;
+        } else {
+            info->interpreter_loadmap_addr =3D 0;
+            info->interpreter_pt_dynamic_addr =3D 0;
         }
     }
=20
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index da3b517..c55c8e2 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -57,6 +57,8 @@ struct image_info {
         uint16_t        nsegs;
         void           *loadsegs;
         abi_ulong       pt_dynamic_addr;
+        abi_ulong       interpreter_loadmap_addr;
+        abi_ulong       interpreter_pt_dynamic_addr;
         struct image_info *other_info;
 };
=20
@@ -183,6 +185,13 @@ int loader_exec(int fdexec, const char *filename, ch=
ar **argv, char **envp,
              struct target_pt_regs * regs, struct image_info *infop,
              struct linux_binprm *);
=20
+/* Returns true if the image uses the FDPIC ABI. If this is the case,
+ * we have to provide some information (loadmap, pt_dynamic_info) such
+ * that the program can be relocated adequately. This is also useful
+ * when handling signals.
+ */
+int info_is_fdpic(struct image_info *info);
+
 uint32_t get_elf_eflags(int fd);
 int load_elf_binary(struct linux_binprm *bprm, struct image_info *info);
 int load_flt_binary(struct linux_binprm *bprm, struct image_info *info);
--=20
2.6.3
