Received: from eggs.gnu.org ([2001:4830:134:3::10]:39503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkjK-00041x-J0
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkjG-0005lG-Hc
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:58:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cfkjG-0005l6-89
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:58 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1K9rdEa020587
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:57 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28qvby4ppk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:56 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 20 Feb 2017 09:57:54 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Mon, 20 Feb 2017 10:57:34 +0100
In-Reply-To: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
References: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
Message-Id: <20170220095734.7890-13-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 12/12] s390x/arch_dump: pass cpuid into notes
 sections
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

we need to pass the cpuid into the pid field of the notes
section, otherwise the notes for different CPUs all have 0:

e.g. objdump -h shows:
old:
  5 .reg-s390-prefix/0 00000004  0000000000000000  0000000000000000
  6 .reg-s390-prefix 00000004  0000000000000000  0000000000000000
 21 .reg-s390-prefix/0 00000004  0000000000000000  0000000000000000
new:
  5 .reg-s390-prefix/1 00000004  0000000000000000  0000000000000000
  6 .reg-s390-prefix 00000004  0000000000000000  0000000000000000
 21 .reg-s390-prefix/2 00000004  0000000000000000  0000000000000000

Reported-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 target/s390x/arch_dump.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 887cae947e..105ae9a5d8 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -73,7 +73,7 @@ typedef struct noteStruct {
     } contents;
 } QEMU_PACKED Note;
 
-static void s390x_write_elf64_prstatus(Note *note, S390CPU *cpu)
+static void s390x_write_elf64_prstatus(Note *note, S390CPU *cpu, int id)
 {
     int i;
     S390xUserRegs *regs;
@@ -87,9 +87,10 @@ static void s390x_write_elf64_prstatus(Note *note, S390CPU *cpu)
         regs->acrs[i] = cpu_to_be32(cpu->env.aregs[i]);
         regs->gprs[i] = cpu_to_be64(cpu->env.regs[i]);
     }
+    note->contents.prstatus.pid = id;
 }
 
-static void s390x_write_elf64_fpregset(Note *note, S390CPU *cpu)
+static void s390x_write_elf64_fpregset(Note *note, S390CPU *cpu, int id)
 {
     int i;
     CPUS390XState *cs = &cpu->env;
@@ -101,7 +102,7 @@ static void s390x_write_elf64_fpregset(Note *note, S390CPU *cpu)
     }
 }
 
-static void s390x_write_elf64_vregslo(Note *note, S390CPU *cpu)
+static void s390x_write_elf64_vregslo(Note *note, S390CPU *cpu,  int id)
 {
     int i;
 
@@ -111,7 +112,7 @@ static void s390x_write_elf64_vregslo(Note *note, S390CPU *cpu)
     }
 }
 
-static void s390x_write_elf64_vregshi(Note *note, S390CPU *cpu)
+static void s390x_write_elf64_vregshi(Note *note, S390CPU *cpu, int id)
 {
     int i;
     S390xElfVregsHi *temp_vregshi;
@@ -125,25 +126,25 @@ static void s390x_write_elf64_vregshi(Note *note, S390CPU *cpu)
     }
 }
 
-static void s390x_write_elf64_timer(Note *note, S390CPU *cpu)
+static void s390x_write_elf64_timer(Note *note, S390CPU *cpu, int id)
 {
     note->hdr.n_type = cpu_to_be32(NT_S390_TIMER);
     note->contents.timer = cpu_to_be64((uint64_t)(cpu->env.cputm));
 }
 
-static void s390x_write_elf64_todcmp(Note *note, S390CPU *cpu)
+static void s390x_write_elf64_todcmp(Note *note, S390CPU *cpu, int id)
 {
     note->hdr.n_type = cpu_to_be32(NT_S390_TODCMP);
     note->contents.todcmp = cpu_to_be64((uint64_t)(cpu->env.ckc));
 }
 
-static void s390x_write_elf64_todpreg(Note *note, S390CPU *cpu)
+static void s390x_write_elf64_todpreg(Note *note, S390CPU *cpu, int id)
 {
     note->hdr.n_type = cpu_to_be32(NT_S390_TODPREG);
     note->contents.todpreg = cpu_to_be32((uint32_t)(cpu->env.todpr));
 }
 
-static void s390x_write_elf64_ctrs(Note *note, S390CPU *cpu)
+static void s390x_write_elf64_ctrs(Note *note, S390CPU *cpu, int id)
 {
     int i;
 
@@ -154,7 +155,7 @@ static void s390x_write_elf64_ctrs(Note *note, S390CPU *cpu)
     }
 }
 
-static void s390x_write_elf64_prefix(Note *note, S390CPU *cpu)
+static void s390x_write_elf64_prefix(Note *note, S390CPU *cpu, int id)
 {
     note->hdr.n_type = cpu_to_be32(NT_S390_PREFIX);
     note->contents.prefix = cpu_to_be32((uint32_t)(cpu->env.psa));
@@ -163,7 +164,7 @@ static void s390x_write_elf64_prefix(Note *note, S390CPU *cpu)
 
 typedef struct NoteFuncDescStruct {
     int contents_size;
-    void (*note_contents_func)(Note *note, S390CPU *cpu);
+    void (*note_contents_func)(Note *note, S390CPU *cpu, int id);
 } NoteFuncDesc;
 
 static const NoteFuncDesc note_core[] = {
@@ -199,7 +200,7 @@ static int s390x_write_elf64_notes(const char *note_name,
         note.hdr.n_namesz = cpu_to_be32(strlen(note_name) + 1);
         note.hdr.n_descsz = cpu_to_be32(nf->contents_size);
         strncpy(note.name, note_name, sizeof(note.name));
-        (*nf->note_contents_func)(&note, cpu);
+        (*nf->note_contents_func)(&note, cpu, id);
 
         note_size = sizeof(note) - sizeof(note.contents) + nf->contents_size;
         ret = f(&note, note_size, opaque);
-- 
2.11.0
