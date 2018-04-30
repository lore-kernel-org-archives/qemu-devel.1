Received: from eggs.gnu.org ([2001:4830:134:3::10]:47485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1fD3ne-0002lj-Qj
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 04:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1fD3nb-0002OW-Lh
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 04:04:42 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59623
	helo=mx07-00178001.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christophe.lyon@st.com>)
	id 1fD3nb-0002OC-Cp
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 04:04:39 -0400
From: Christophe Lyon <christophe.lyon@st.com>
Date: Mon, 30 Apr 2018 10:03:41 +0200
Message-ID: <20180430080404.7323-2-christophe.lyon@st.com>
In-Reply-To: <20180430080404.7323-1-christophe.lyon@st.com>
References: <20180430080404.7323-1-christophe.lyon@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [ARM/FDPIC v4 1/4] Remove CONFIG_USE_FDPIC.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, christophe.lyon@linaro.org, peter.maydell@linaro.org, riku.voipio@iki.fi, laurent@vivier.eu

We want to avoid code disabled by default, because it ends up less
tested. This patch removes all instances of #ifdef CONFIG_USE_FDPIC,
most of which can be safely kept. For the ones that should be
conditionally executed, we define elf_is_fdpic(). Without this patch,
defining CONFIG_USE_FDPIC would prevent QEMU from building precisely
because elf_is_fdpic is not defined.

Signed-off-by: Christophe Lyon <christophe.lyon@st.com>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c77ed1b..bbe93b0 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1681,7 +1681,12 @@ static void zero_bss(abi_ulong elf_bss, abi_ulong last_bss, int prot)
     }
 }
 
-#ifdef CONFIG_USE_FDPIC
+/* Default implementation, always false.  */
+static int elf_is_fdpic(struct elfhdr *exec)
+{
+    return 0;
+}
+
 static abi_ulong loader_build_fdpic_loadmap(struct image_info *info, abi_ulong sp)
 {
     uint16_t n;
@@ -1706,7 +1711,6 @@ static abi_ulong loader_build_fdpic_loadmap(struct image_info *info, abi_ulong s
 
     return sp;
 }
-#endif
 
 static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
                                    struct elfhdr *exec,
@@ -1725,7 +1729,6 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
 
     sp = p;
 
-#ifdef CONFIG_USE_FDPIC
     /* Needs to be before we load the env/argc/... */
     if (elf_is_fdpic(exec)) {
         /* Need 4 byte alignment for these structs */
@@ -1737,7 +1740,6 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
             sp = loader_build_fdpic_loadmap(interp_info, sp);
         }
     }
-#endif
 
     u_platform = 0;
     k_platform = ELF_PLATFORM;
@@ -2153,10 +2155,8 @@ static void load_elf_image(const char *image_name, int image_fd,
     }
     bswap_phdr(phdr, ehdr->e_phnum);
 
-#ifdef CONFIG_USE_FDPIC
     info->nsegs = 0;
     info->pt_dynamic_addr = 0;
-#endif
 
     mmap_lock();
 
@@ -2173,9 +2173,7 @@ static void load_elf_image(const char *image_name, int image_fd,
             if (a > hiaddr) {
                 hiaddr = a;
             }
-#ifdef CONFIG_USE_FDPIC
             ++info->nsegs;
-#endif
         }
     }
 
@@ -2200,8 +2198,7 @@ static void load_elf_image(const char *image_name, int image_fd,
     }
     load_bias = load_addr - loaddr;
 
-#ifdef CONFIG_USE_FDPIC
-    {
+    if (elf_is_fdpic(ehdr)) {
         struct elf32_fdpic_loadseg *loadsegs = info->loadsegs =
             g_malloc(sizeof(*loadsegs) * info->nsegs);
 
@@ -2219,7 +2216,6 @@ static void load_elf_image(const char *image_name, int image_fd,
             }
         }
     }
-#endif
 
     info->load_bias = load_bias;
     info->load_addr = load_addr;
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 192a0d2..da3b517 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -51,13 +51,13 @@ struct image_info {
         abi_ulong       file_string;
         uint32_t        elf_flags;
 	int		personality;
-#ifdef CONFIG_USE_FDPIC
+
+        /* The fields below are used in FDPIC mode.  */
         abi_ulong       loadmap_addr;
         uint16_t        nsegs;
         void           *loadsegs;
         abi_ulong       pt_dynamic_addr;
         struct image_info *other_info;
-#endif
 };
 
 #ifdef TARGET_I386
-- 
2.6.3
