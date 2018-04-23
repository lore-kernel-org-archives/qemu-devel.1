Received: from eggs.gnu.org ([2001:4830:134:3::10]:33140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1fAWHx-0000L4-7O
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 03:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1fAWHu-0000RV-3v
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 03:53:29 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:33251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christophe.lyon@st.com>)
	id 1fAWHt-0000RA-QP
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 03:53:26 -0400
From: Christophe Lyon <christophe.lyon@st.com>
Date: Mon, 23 Apr 2018 09:51:54 +0200
Message-ID: <20180423075215.4572-4-christophe.lyon@st.com>
In-Reply-To: <20180423075215.4572-1-christophe.lyon@st.com>
References: <20180423075215.4572-1-christophe.lyon@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [ARM/FDPIC v2 3/4] linux-user: ARM-FDPIC: Add support
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
index 76d7718..1ee1e38 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -78,6 +78,11 @@ enum {
  */
 #define personality(pers)       (pers & PER_MASK)
=20
+int info_is_fdpic(struct image_info *info)
+{
+    return (info->personality =3D=3D PER_LINUX_FDPIC);
+}
+
 /* this flag is uneffective under linux too, should be deleted */
 #ifndef MAP_DENYWRITE
 #define MAP_DENYWRITE 0
@@ -287,6 +292,24 @@ static inline void init_thread(struct target_pt_regs=
 *regs,
     /* For uClinux PIC binaries.  */
     /* XXX: Linux does this only on ARM with no MMU (do we care ?) */
     regs->uregs[10] =3D infop->start_data;
+
+    /* Support ARM FDPIC.  */
+    if (info_is_fdpic(infop)) {
+            /* As described in the ABI document, r7 points to the loadma=
p info
+             * prepared by the kernel. If an interpreter is needed, r8 p=
oints
+             * to the interpreter loadmap and r9 points to the interpret=
er
+             * PT_DYNAMIC info. If no interpreter is needed, r8 is zer0,=
 and
+             * r9 points to the main program PT_DYNAMIC info.  */
+            regs->uregs[7] =3D infop->loadmap_addr;
+            if (infop->interpreter_loadmap_addr) {
+                /* Executable is dynamically loaded.  */
+                regs->uregs[8] =3D infop->interpreter_loadmap_addr;
+                regs->uregs[9] =3D infop->interpreter_pt_dynamic_addr;
+            } else {
+                regs->uregs[8] =3D 0;
+                regs->uregs[9] =3D infop->pt_dynamic_addr;
+            }
+        }
 }
=20
 #define ELF_NREG    18
@@ -1745,6 +1768,11 @@ static abi_ulong create_elf_tables(abi_ulong p, in=
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
diff --git a/linux-user/main.c b/linux-user/main.c
index 2acac36..3579f0e 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4893,6 +4893,9 @@ int main(int argc, char **argv, char **envp)
             env->cp15.sctlr_el[1] |=3D SCTLR_B;
         }
 #endif
+
+        /* Are we running an FDPIC binary?  */
+        ((TaskState *)thread_cpu->opaque)->is_fdpic =3D info_is_fdpic(in=
fo);
     }
 #elif defined(TARGET_SPARC)
     {
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index da3b517..a2ed148 100644
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
@@ -145,6 +147,9 @@ typedef struct TaskState {
      */
     int signal_pending;
=20
+    /* We need to know if we have an FDPIC binary to adapt signal
+     * syscalls.  */
+    int is_fdpic;
 } __attribute__((aligned(16))) TaskState;
=20
 extern char *exec_path;
@@ -182,6 +187,7 @@ abi_ulong loader_build_argptr(int envc, int argc, abi=
_ulong sp,
 int loader_exec(int fdexec, const char *filename, char **argv, char **en=
vp,
              struct target_pt_regs * regs, struct image_info *infop,
              struct linux_binprm *);
+int info_is_fdpic(struct image_info *info);
=20
 uint32_t get_elf_eflags(int fd);
 int load_elf_binary(struct linux_binprm *bprm, struct image_info *info);
--=20
2.6.3
