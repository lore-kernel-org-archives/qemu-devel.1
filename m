Received: from eggs.gnu.org ([2001:4830:134:3::10]:60768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1f4T8C-0003mj-Ah
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1f4T89-0004V2-3R
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:18:24 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:43962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christophe.lyon@st.com>)
	id 1f4T88-0004Ua-PW
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:18:21 -0400
From: Christophe Lyon <christophe.lyon@st.com>
Date: Fri, 6 Apr 2018 17:17:29 +0200
Message-ID: <20180406151752.10854-2-christophe.lyon@st.com>
In-Reply-To: <20180406151752.10854-1-christophe.lyon@st.com>
References: <20180406151752.10854-1-christophe.lyon@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [ARM/FDPIC 1/4] linux-user: ARM-FDPIC: Add configure
 option to support loading of FDPIC binaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, christophe.lyon@linaro.org, peter.maydell@linaro.org

Adds --enable-fdpic and --disable-fdpic configure options.  This
feature is disabled by default, that's why it is not described in the
"Optional features" help section (which are enabled by default if
possible).

FDPIC ELF objects are identified with e_ident[EI_OSABI] =3D=3D
ELFOSABI_ARM_FDPIC.

Co-Authored-By: Micka=C3=ABl Gu=C3=AAn=C3=A9 <mickael.guene@st.com>
Signed-off-by: Christophe Lyon <christophe.lyon@st.com>

diff --git a/configure b/configure
index 4d0e92c..af4c14b 100755
--- a/configure
+++ b/configure
@@ -451,6 +451,7 @@ jemalloc=3D"no"
 replication=3D"yes"
 vxhs=3D""
 libxml2=3D""
+fdpic=3D"no"
=20
 supported_cpu=3D"no"
 supported_os=3D"no"
@@ -1374,6 +1375,10 @@ for opt do
   ;;
   --disable-git-update) git_update=3Dno
   ;;
+  --disable-fdpic) fdpic=3D"no"
+  ;;
+  --enable-fdpic) fdpic=3D"yes"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1544,6 +1549,8 @@ Advanced options (experts only):
                            xen pv domain builder
   --enable-debug-stack-usage
                            track the maximum stack usage of stacks creat=
ed by qemu_alloc_stack
+  --disable-fdpic          disable loading of FDPIC binary (default)
+  --enable-fdpic           enable loading of FDPIC binary
=20
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -7085,6 +7092,9 @@ fi
=20
 echo "LDFLAGS+=3D$ldflags" >> $config_target_mak
 echo "QEMU_CFLAGS+=3D$cflags" >> $config_target_mak
+if [ "$fdpic" =3D "yes" ]; then
+    echo "CONFIG_USE_FDPIC=3Dy" >> $config_target_mak
+fi
=20
 done # for target in $targets
=20
diff --git a/include/elf.h b/include/elf.h
index c0dc9bb..934dbbd 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -1483,6 +1483,7 @@ typedef struct elf64_shdr {
 #define ELFOSABI_TRU64          10      /* Compaq TRU64 UNIX.  */
 #define ELFOSABI_MODESTO        11      /* Novell Modesto.  */
 #define ELFOSABI_OPENBSD        12      /* OpenBSD.  */
+#define ELFOSABI_ARM_FDPIC      65      /* ARM FDPIC */
 #define ELFOSABI_ARM            97      /* ARM */
 #define ELFOSABI_STANDALONE     255     /* Standalone (embedded) applica=
tion */
=20
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 23e3495..7ba3795 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1658,6 +1658,14 @@ static void zero_bss(abi_ulong elf_bss, abi_ulong =
last_bss, int prot)
 }
=20
 #ifdef CONFIG_USE_FDPIC
+
+#ifdef TARGET_ARM
+static int elf_is_fdpic(struct elfhdr *exec)
+{
+    return exec->e_ident[EI_OSABI] =3D=3D ELFOSABI_ARM_FDPIC;
+}
+#endif
+
 static abi_ulong loader_build_fdpic_loadmap(struct image_info *info, abi=
_ulong sp)
 {
     uint16_t n;
--=20
2.6.3
