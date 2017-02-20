Received: from eggs.gnu.org ([2001:4830:134:3::10]:39492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkjJ-00040f-19
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkjE-0005ko-On
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:58:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cfkjE-0005jr-FU
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:56 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1K9rbaD117476
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:55 -0500
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28pp6mfdpt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:54 -0500
Received: from localhost
	by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 20 Feb 2017 09:57:52 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Mon, 20 Feb 2017 10:57:33 +0100
In-Reply-To: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
References: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
Message-Id: <20170220095734.7890-12-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 11/12] s390x/arch_dump: use proper note name
 and note size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

In binutils/libbfd (bfd/elf.c) it is enforced that all s390
specific ELF notes like e.g. NT_S390_PREFIX or NT_S390_CTRS
have "LINUX" specified as note name and that the namesz is
6. Otherwise the notes are ignored.

QEMU currently uses "CORE" for these notes. Up to now this has
not been a real problem because the dump analysis tool "crash"
does handle that. But it will break all programs that use libbfd
for processing ELF notes.

So fix this and use "LINUX" for all s390 specific notes to comply
with libbfd. Also set the correct namesz.

Reported-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 target/s390x/arch_dump.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 4731869f6b..887cae947e 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -59,8 +59,7 @@ typedef struct S390xElfVregsHiStruct S390xElfVregsHi;
 
 typedef struct noteStruct {
     Elf64_Nhdr hdr;
-    char name[5];
-    char pad3[3];
+    char name[8];
     union {
         S390xElfPrstatus prstatus;
         S390xElfFpregset fpregset;
@@ -162,13 +161,19 @@ static void s390x_write_elf64_prefix(Note *note, S390CPU *cpu)
 }
 
 
-static const struct NoteFuncDescStruct {
+typedef struct NoteFuncDescStruct {
     int contents_size;
     void (*note_contents_func)(Note *note, S390CPU *cpu);
-} note_func[] = {
+} NoteFuncDesc;
+
+static const NoteFuncDesc note_core[] = {
     {sizeof(((Note *)0)->contents.prstatus), s390x_write_elf64_prstatus},
-    {sizeof(((Note *)0)->contents.prefix),   s390x_write_elf64_prefix},
     {sizeof(((Note *)0)->contents.fpregset), s390x_write_elf64_fpregset},
+    { 0, NULL}
+};
+
+static const NoteFuncDesc note_linux[] = {
+    {sizeof(((Note *)0)->contents.prefix),   s390x_write_elf64_prefix},
     {sizeof(((Note *)0)->contents.ctrs),     s390x_write_elf64_ctrs},
     {sizeof(((Note *)0)->contents.timer),    s390x_write_elf64_timer},
     {sizeof(((Note *)0)->contents.todcmp),   s390x_write_elf64_todcmp},
@@ -178,22 +183,20 @@ static const struct NoteFuncDescStruct {
     { 0, NULL}
 };
 
-typedef struct NoteFuncDescStruct NoteFuncDesc;
-
-
-static int s390x_write_all_elf64_notes(const char *note_name,
+static int s390x_write_elf64_notes(const char *note_name,
                                        WriteCoreDumpFunction f,
                                        S390CPU *cpu, int id,
-                                       void *opaque)
+                                       void *opaque,
+                                       const NoteFuncDesc *funcs)
 {
     Note note;
     const NoteFuncDesc *nf;
     int note_size;
     int ret = -1;
 
-    for (nf = note_func; nf->note_contents_func; nf++) {
+    for (nf = funcs; nf->note_contents_func; nf++) {
         memset(&note, 0, sizeof(note));
-        note.hdr.n_namesz = cpu_to_be32(sizeof(note.name));
+        note.hdr.n_namesz = cpu_to_be32(strlen(note_name) + 1);
         note.hdr.n_descsz = cpu_to_be32(nf->contents_size);
         strncpy(note.name, note_name, sizeof(note.name));
         (*nf->note_contents_func)(&note, cpu);
@@ -215,7 +218,13 @@ int s390_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                               int cpuid, void *opaque)
 {
     S390CPU *cpu = S390_CPU(cs);
-    return s390x_write_all_elf64_notes("CORE", f, cpu, cpuid, opaque);
+    int r;
+
+    r = s390x_write_elf64_notes("CORE", f, cpu, cpuid, opaque, note_core);
+    if (r) {
+        return r;
+    }
+    return s390x_write_elf64_notes("LINUX", f, cpu, cpuid, opaque, note_linux);
 }
 
 int cpu_get_dump_info(ArchDumpInfo *info,
@@ -230,7 +239,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
 
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
-    int name_size = 8; /* "CORE" or "QEMU" rounded */
+    int name_size = 8; /* "LINUX" or "CORE" + pad */
     size_t elf_note_size = 0;
     int note_head_size;
     const NoteFuncDesc *nf;
@@ -240,7 +249,11 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     note_head_size = sizeof(Elf64_Nhdr);
 
-    for (nf = note_func; nf->note_contents_func; nf++) {
+    for (nf = note_core; nf->note_contents_func; nf++) {
+        elf_note_size = elf_note_size + note_head_size + name_size +
+                        nf->contents_size;
+    }
+    for (nf = note_linux; nf->note_contents_func; nf++) {
         elf_note_size = elf_note_size + note_head_size + name_size +
                         nf->contents_size;
     }
-- 
2.11.0
