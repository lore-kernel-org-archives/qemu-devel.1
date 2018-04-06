Received: from eggs.gnu.org ([2001:4830:134:3::10]:60903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1f4T8W-000467-Vf
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1f4T8T-0004cO-OB
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:18:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54306
	helo=mx07-00178001.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christophe.lyon@st.com>)
	id 1f4T8T-0004br-FD
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:18:41 -0400
From: Christophe Lyon <christophe.lyon@st.com>
Date: Fri, 6 Apr 2018 17:17:30 +0200
Message-ID: <20180406151752.10854-3-christophe.lyon@st.com>
In-Reply-To: <20180406151752.10854-1-christophe.lyon@st.com>
References: <20180406151752.10854-1-christophe.lyon@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [ARM/FDPIC 2/4] linux-user: ARM-FDPIC: Add support of
 FDPIC for ARM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, christophe.lyon@linaro.org, peter.maydell@linaro.org

Add FDPIC info into image_info structure since interpreter info is on
stack and needs to be saved to be accessed later on.

Co-Authored-By:  Micka=C3=ABl Gu=C3=AAn=C3=A9 <mickael.guene@st.com>
Signed-off-by: Christophe Lyon <christophe.lyon@st.com>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7ba3795..363da67 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -287,6 +287,23 @@ static inline void init_thread(struct target_pt_regs=
 *regs,
     /* For uClinux PIC binaries.  */
     /* XXX: Linux does this only on ARM with no MMU (do we care ?) */
     regs->uregs[10] =3D infop->start_data;
+#ifdef CONFIG_USE_FDPIC
+    /* Support ARM FDPIC.  */
+    /* As described in the ABI document, r7 points to the loadmap info
+     * prepared by the kernel. If an interpreter is needed, r8 points
+     * to the interpreter loadmap and r9 points to the interpreter
+     * PT_DYNAMIC info. If no interpreter is needed, r8 is zer0, and
+     * r9 points to the main program PT_DYNAMIC info.  */
+    regs->uregs[7] =3D infop->loadmap_addr;
+    if (infop->interpreter_loadmap_addr) {
+        /* Executable is dynamically loaded.  */
+        regs->uregs[8] =3D infop->interpreter_loadmap_addr;
+        regs->uregs[9] =3D infop->interpreter_pt_dynamic_addr;
+    } else {
+        regs->uregs[8] =3D 0;
+        regs->uregs[9] =3D infop->pt_dynamic_addr;
+    }
+#endif
 }
=20
 #define ELF_NREG    18
@@ -1692,6 +1709,11 @@ static abi_ulong loader_build_fdpic_loadmap(struct=
 image_info *info, abi_ulong s
 }
 #endif
=20
+int info_is_fdpic(struct image_info *info)
+{
+    return (info->personality =3D=3D PER_LINUX_FDPIC);
+}
+
 static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
                                    struct elfhdr *exec,
                                    struct image_info *info,
@@ -1719,6 +1741,11 @@ static abi_ulong create_elf_tables(abi_ulong p, in=
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
 #endif
diff --git a/linux-user/main.c b/linux-user/main.c
index ba09b7d..00810d6 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4868,6 +4868,11 @@ int main(int argc, char **argv, char **envp)
             env->cp15.sctlr_el[i] |=3D SCTLR_EE;
         }
 #endif
+
+#if defined(CONFIG_USE_FDPIC)
+        /* Are we running an FDPIC binary?  */
+        env->is_fdpic =3D info_is_fdpic(info);
+#endif
     }
 #elif defined(TARGET_ARM)
     {
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 192a0d2..7eaf9e9 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -56,6 +56,8 @@ struct image_info {
         uint16_t        nsegs;
         void           *loadsegs;
         abi_ulong       pt_dynamic_addr;
+        abi_ulong       interpreter_loadmap_addr;
+        abi_ulong       interpreter_pt_dynamic_addr;
         struct image_info *other_info;
 #endif
 };
@@ -182,6 +184,7 @@ abi_ulong loader_build_argptr(int envc, int argc, abi=
_ulong sp,
 int loader_exec(int fdexec, const char *filename, char **argv, char **en=
vp,
              struct target_pt_regs * regs, struct image_info *infop,
              struct linux_binprm *);
+int info_is_fdpic(struct image_info *info);
=20
 uint32_t get_elf_eflags(int fd);
 int load_elf_binary(struct linux_binprm *bprm, struct image_info *info);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 19a0c03..90c8ee1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -629,6 +629,12 @@ typedef struct CPUARMState {
     const struct arm_boot_info *boot_info;
     /* Store GICv3CPUState to access from this struct */
     void *gicv3state;
+
+#if defined(CONFIG_USER_ONLY) && defined(CONFIG_USE_FDPIC)
+    /* We need to know if we have an FDPIC binary to adapt signal
+     * syscalls.  */
+    int is_fdpic;
+#endif
 } CPUARMState;
=20
 /**
--=20
2.6.3
