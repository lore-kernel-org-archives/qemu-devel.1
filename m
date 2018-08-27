Received: from eggs.gnu.org ([2001:4830:134:3::10]:34921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbhat@linux.vnet.ibm.com>) id 1fuGlr-0002XI-76
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:37:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbhat@linux.vnet.ibm.com>) id 1fuGlo-0005BF-13
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:37:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37604
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbhat@linux.vnet.ibm.com>)
	id 1fuGln-00059I-Ql
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:37:23 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w7RCXisC017564
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 08:37:22 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2m4e09g9fj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 08:37:21 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sbhat@linux.vnet.ibm.com>;
	Mon, 27 Aug 2018 13:37:19 +0100
From: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Date: Mon, 27 Aug 2018 07:37:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <153537327445.92657.5884855110375406189.stgit@lep8c.aus.stglabs.ibm.com>
Subject: [Qemu-devel] [PATCH] linux-user: elf: mmap all the target-pages of
 hostpage for data segment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: riku.voipio@iki.fi, laurent@vivier.eu
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

If the hostpage size is greater than the TARGET_PAGESIZE, the
target-pages of size TARGET_PAGESIZE are marked valid only till the
length requested during the elfload. The glibc attempts to consume unused
space in the last page of data segment(__libc_memalign() in
elf/dl-minimal.c). The GLRO(dl_pagesize) is actually the host pagesize as
set in the auxillary vectors. So, there is no explicit mmap request for
the remaining target-pages on the last hostpage. The glibc assumes that
particular space as available and subsequent attempts to use
those addresses lead to crash as the target_mmap has not marked them valid
for those target-pages.

The issue is seen when trying to chroot to 16.04-x86_64 ubuntu on a PPC64
host where the fork fails to access the thread_id as it is allocated on a
page not marked valid. The recent glibc doesnt have checks for thread-id in
fork, but the issue can manifest somewhere else, none the less.

The fix here is to map all the target-pages of the hostpage during the
ELF load for data segment to allow the glibc for proper consumption.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
---
 linux-user/elfload.c |   24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8638612aec..1d86034c8d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1438,9 +1438,17 @@ struct exec
 
 /* Necessary parameters */
 #define TARGET_ELF_EXEC_PAGESIZE TARGET_PAGE_SIZE
-#define TARGET_ELF_PAGESTART(_v) ((_v) & \
-                                 ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE-1))
-#define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE-1))
+#define TARGET_ELF_PAGESTART(_v, _s) \
+        ((TARGET_ELF_EXEC_PAGESIZE > _s) ? \
+         (_v) & ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE - 1) : \
+         (_v) & ~(abi_ulong)(_s - 1));
+#define TARGET_ELF_PAGEOFFSET(_v, _s) \
+        ((TARGET_ELF_EXEC_PAGESIZE > _s) ? \
+         (_v) & (TARGET_ELF_EXEC_PAGESIZE - 1) : \
+         (_v) & (_s - 1));
+#define TARGET_ELF_PAGELENGTH(_v, _s) \
+        ((TARGET_ELF_EXEC_PAGESIZE > _s) ? \
+         TARGET_PAGE_ALIGN(_v) : HOST_PAGE_ALIGN(_v));
 
 #define DLINFO_ITEMS 15
 
@@ -2279,7 +2287,7 @@ static void load_elf_image(const char *image_name, int image_fd,
     for (i = 0; i < ehdr->e_phnum; i++) {
         struct elf_phdr *eppnt = phdr + i;
         if (eppnt->p_type == PT_LOAD) {
-            abi_ulong vaddr, vaddr_po, vaddr_ps, vaddr_ef, vaddr_em;
+            abi_ulong vaddr, vaddr_po, vaddr_ps, vaddr_ef, vaddr_em, vaddr_len;
             int elf_prot = 0;
 
             if (eppnt->p_flags & PF_R) elf_prot =  PROT_READ;
@@ -2287,10 +2295,12 @@ static void load_elf_image(const char *image_name, int image_fd,
             if (eppnt->p_flags & PF_X) elf_prot |= PROT_EXEC;
 
             vaddr = load_bias + eppnt->p_vaddr;
-            vaddr_po = TARGET_ELF_PAGEOFFSET(vaddr);
-            vaddr_ps = TARGET_ELF_PAGESTART(vaddr);
+            vaddr_po = TARGET_ELF_PAGEOFFSET(vaddr, qemu_host_page_size);
+            vaddr_ps = TARGET_ELF_PAGESTART(vaddr, qemu_host_page_size);
+            vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_filesz + vaddr_po,
+                                              qemu_host_page_size);
 
-            error = target_mmap(vaddr_ps, eppnt->p_filesz + vaddr_po,
+            error = target_mmap(vaddr_ps, vaddr_len,
                                 elf_prot, MAP_PRIVATE | MAP_FIXED,
                                 image_fd, eppnt->p_offset - vaddr_po);
             if (error == -1) {
