Received: from eggs.gnu.org ([2001:4830:134:3::10]:47509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1fD3ny-0002v3-5h
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 04:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1fD3nv-0002SN-1k
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 04:05:02 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37644
	helo=mx07-00178001.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christophe.lyon@st.com>)
	id 1fD3nu-0002S6-NE
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 04:04:58 -0400
From: Christophe Lyon <christophe.lyon@st.com>
Date: Mon, 30 Apr 2018 10:03:42 +0200
Message-ID: <20180430080404.7323-3-christophe.lyon@st.com>
In-Reply-To: <20180430080404.7323-1-christophe.lyon@st.com>
References: <20180430080404.7323-1-christophe.lyon@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [ARM/FDPIC v4 2/4] linux-user: ARM-FDPIC: Identify ARM
 FDPIC binaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, christophe.lyon@linaro.org, peter.maydell@linaro.org, riku.voipio@iki.fi, laurent@vivier.eu

Define an ARM-specific version of elf_is_fdpic:
FDPIC ELF objects are identified with e_ident[EI_OSABI] =3D=3D
ELFOSABI_ARM_FDPIC.

Co-Authored-By: Micka=C3=ABl Gu=C3=AAn=C3=A9 <mickael.guene@st.com>
Signed-off-by: Christophe Lyon <christophe.lyon@st.com>

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
index bbe93b0..76d7718 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1681,11 +1681,18 @@ static void zero_bss(abi_ulong elf_bss, abi_ulong=
 last_bss, int prot)
     }
 }
=20
+#ifdef TARGET_ARM
+static int elf_is_fdpic(struct elfhdr *exec)
+{
+    return exec->e_ident[EI_OSABI] =3D=3D ELFOSABI_ARM_FDPIC;
+}
+#else
 /* Default implementation, always false.  */
 static int elf_is_fdpic(struct elfhdr *exec)
 {
     return 0;
 }
+#endif
=20
 static abi_ulong loader_build_fdpic_loadmap(struct image_info *info, abi=
_ulong sp)
 {
--=20
2.6.3
