Received: from eggs.gnu.org ([2001:4830:134:3::10]:59191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbhat@linux.vnet.ibm.com>) id 1fuwhQ-00085i-7o
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbhat@linux.vnet.ibm.com>) id 1fuwhL-0003A2-8T
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:23:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33722
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbhat@linux.vnet.ibm.com>)
	id 1fuwhK-00039H-Ro
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:23:35 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w7T9JcnP063492
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 05:23:34 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2m5n8rrh07-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 05:23:33 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sbhat@linux.vnet.ibm.com>;
	Wed, 29 Aug 2018 10:23:32 +0100
From: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Date: Wed, 29 Aug 2018 04:23:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <153553435604.51992.5640085189104207249.stgit@lep8c.aus.stglabs.ibm.com>
Subject: [Qemu-devel] [PATCH v3] linux-user: elf: mmap all the target-pages
 of hostpage for data segment
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
elf/dl-minimal.c). If PT_LOAD p_align is greater than or
equal to hostpage size, the GLRO(dl_pagesize) is actually the host pagesize
as set in the auxillary vectors. So, there is no explicit mmap request for
the remaining target-pages on the last hostpage. The glibc assumes that
particular space as available and subsequent attempts to use
those addresses lead to crash as the target_mmap has not marked them valid
for those target-pages.

The issue is seen when trying to chroot to 16.04-x86_64 ubuntu on a PPC64
host where the fork fails to access the thread_id as it is allocated on a
page not marked valid. The recent glibc doesn't have checks for thread-id in
fork, but the issue can manifest somewhere else, none the less.

The fix here is to map all the target-pages of the hostpage during the
elfload if the p_align is greater than or equal to hostpage size, for
data segment to allow the glibc for proper consumption.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
---
v2: https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg05943.html
Changes from v2:
    - Simplified the macro as suggested.
    - Fixed some grammatical error in commit message.
v1: https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg05730.html
Changes from v1:
   - Made the conditionals consistent with the commit "33143c446e" and
     changed the commit message accordingly.

 linux-user/elfload.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8638612aec..6ead0d11c6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1437,7 +1437,10 @@ struct exec
 #define QMAGIC 0314
 
 /* Necessary parameters */
-#define TARGET_ELF_EXEC_PAGESIZE TARGET_PAGE_SIZE
+#define TARGET_ELF_EXEC_PAGESIZE \
+        (((eppnt->p_align & ~qemu_host_page_mask) != 0) ? \
+         TARGET_PAGE_SIZE : MAX(qemu_host_page_size, TARGET_PAGE_SIZE))
+#define TARGET_ELF_PAGELENGTH(_v) ROUND_UP((_v), TARGET_ELF_EXEC_PAGESIZE)
 #define TARGET_ELF_PAGESTART(_v) ((_v) & \
                                  ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE-1))
 #define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE-1))
@@ -2279,7 +2282,7 @@ static void load_elf_image(const char *image_name, int image_fd,
     for (i = 0; i < ehdr->e_phnum; i++) {
         struct elf_phdr *eppnt = phdr + i;
         if (eppnt->p_type == PT_LOAD) {
-            abi_ulong vaddr, vaddr_po, vaddr_ps, vaddr_ef, vaddr_em;
+            abi_ulong vaddr, vaddr_po, vaddr_ps, vaddr_ef, vaddr_em, vaddr_len;
             int elf_prot = 0;
 
             if (eppnt->p_flags & PF_R) elf_prot =  PROT_READ;
@@ -2289,8 +2292,9 @@ static void load_elf_image(const char *image_name, int image_fd,
             vaddr = load_bias + eppnt->p_vaddr;
             vaddr_po = TARGET_ELF_PAGEOFFSET(vaddr);
             vaddr_ps = TARGET_ELF_PAGESTART(vaddr);
+            vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_filesz + vaddr_po);
 
-            error = target_mmap(vaddr_ps, eppnt->p_filesz + vaddr_po,
+            error = target_mmap(vaddr_ps, vaddr_len,
                                 elf_prot, MAP_PRIVATE | MAP_FIXED,
                                 image_fd, eppnt->p_offset - vaddr_po);
             if (error == -1) {
