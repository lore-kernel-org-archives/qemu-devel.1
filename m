Received: from eggs.gnu.org ([2001:4830:134:3::10]:34456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fJLhX-0006aY-Iy
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fJLhT-0007Ip-TT
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:24:23 -0400
Received: from mail-eopbgr50097.outbound.protection.outlook.com
	([40.107.5.97]:20608
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <viktor.prutyanov@virtuozzo.com>)
	id 1fJLhT-0007FD-Hd
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:24:19 -0400
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Date: Thu, 17 May 2018 19:23:39 +0300
Message-ID: <20180517162342.4330-2-viktor.prutyanov@virtuozzo.com>
In-Reply-To: <20180517162342.4330-1-viktor.prutyanov@virtuozzo.com>
References: <20180517162342.4330-1-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] dump: add Windows dump format to
 dump-guest-memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rkagan@virtuozzo.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, armbru@redhat.com, Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

This patch adds Windows crashdumping feature. Now QEMU can produce ELF-dump
containing Windows crashdump header, which can help to convert to a valid
WinDbg-understandable crashdump file, or immediately create such file.
The crashdump will be obtained by joining physical memory dump and 8K heade=
r
exposed through vmcoreinfo/fw_cfg device by guest driver at BSOD time. Opti=
on
'-w' was added to dump-guest-memory command. At the moment, only x64
configuration is supported.
Suitable driver can be found at
https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/fwcfg64

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
This patch is unchanged from the one posted separately on 2018-05-01
with message-id: <20180501132031.13270-1-viktor.prutyanov@virtuozzo.com>

 Makefile.target |   1 +
 dump.c          |  24 ++++++-
 hmp-commands.hx |  13 ++--
 hmp.c           |   9 ++-
 qapi/misc.json  |   5 +-
 win_dump.c      | 209 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 win_dump.h      |  87 +++++++++++++++++++++++
 7 files changed, 339 insertions(+), 9 deletions(-)
 create mode 100644 win_dump.c
 create mode 100644 win_dump.h

diff --git a/Makefile.target b/Makefile.target
index d0ec77a307..6ae2609597 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -138,6 +138,7 @@ obj-y +=3D hw/
 obj-y +=3D memory.o
 obj-y +=3D memory_mapping.o
 obj-y +=3D dump.o
+obj-y +=3D win_dump.o
 obj-y +=3D migration/ram.o
 LIBS :=3D $(libs_softmmu) $(LIBS)
=20
diff --git a/dump.c b/dump.c
index b54cd42b21..04467b353e 100644
--- a/dump.c
+++ b/dump.c
@@ -29,6 +29,10 @@
 #include "qemu/error-report.h"
 #include "hw/misc/vmcoreinfo.h"
=20
+#ifdef TARGET_X86_64
+#include "win_dump.h"
+#endif
+
 #include <zlib.h>
 #ifdef CONFIG_LZO
 #include <lzo/lzo1x.h>
@@ -1866,7 +1870,11 @@ static void dump_process(DumpState *s, Error **errp)
     Error *local_err =3D NULL;
     DumpQueryResult *result =3D NULL;
=20
-    if (s->has_format && s->format !=3D DUMP_GUEST_MEMORY_FORMAT_ELF) {
+    if (s->has_format && s->format =3D=3D DUMP_GUEST_MEMORY_FORMAT_WIN_DMP=
) {
+#ifdef TARGET_X86_64
+        create_win_dump(s, &local_err);
+#endif
+    } else if (s->has_format && s->format !=3D DUMP_GUEST_MEMORY_FORMAT_EL=
F) {
         create_kdump_vmcore(s, &local_err);
     } else {
         create_vmcore(s, &local_err);
@@ -1970,6 +1978,13 @@ void qmp_dump_guest_memory(bool paging, const char *=
file,
     }
 #endif
=20
+#ifndef TARGET_X86_64
+    if (has_format && format =3D=3D DUMP_GUEST_MEMORY_FORMAT_WIN_DMP) {
+        error_setg(errp, "Windows dump is only available for x86-64");
+        return;
+    }
+#endif
+
 #if !defined(WIN32)
     if (strstart(file, "fd:", &p)) {
         fd =3D monitor_get_fd(cur_mon, p, errp);
@@ -2044,5 +2059,12 @@ DumpGuestMemoryCapability *qmp_query_dump_guest_memo=
ry_capability(Error **errp)
     item->value =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_SNAPPY;
 #endif
=20
+    /* Windows dump is available only if target is x86_64 */
+#ifdef TARGET_X86_64
+    item->next =3D g_malloc0(sizeof(DumpGuestMemoryFormatList));
+    item =3D item->next;
+    item->value =3D DUMP_GUEST_MEMORY_FORMAT_WIN_DMP;
+#endif
+
     return cap;
 }
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 227f7eee88..fc1f7401f7 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1088,30 +1088,33 @@ ETEXI
=20
     {
         .name       =3D "dump-guest-memory",
-        .args_type  =3D "paging:-p,detach:-d,zlib:-z,lzo:-l,snappy:-s,file=
name:F,begin:i?,length:i?",
-        .params     =3D "[-p] [-d] [-z|-l|-s] filename [begin length]",
+        .args_type  =3D "paging:-p,detach:-d,windmp:-w,zlib:-z,lzo:-l,snap=
py:-s,filename:F,begin:i?,length:i?",
+        .params     =3D "[-p] [-d] [-z|-l|-s|-w] filename [begin length]",
         .help       =3D "dump guest memory into file 'filename'.\n\t\t\t"
                       "-p: do paging to get guest's memory mapping.\n\t\t\=
t"
                       "-d: return immediately (do not wait for completion)=
.\n\t\t\t"
                       "-z: dump in kdump-compressed format, with zlib comp=
ression.\n\t\t\t"
                       "-l: dump in kdump-compressed format, with lzo compr=
ession.\n\t\t\t"
                       "-s: dump in kdump-compressed format, with snappy co=
mpression.\n\t\t\t"
+                      "-w: dump in Windows crashdump format (can be used i=
nstead of ELF-dump converting),\n\t\t\t"
+                      "    for Windows x64 guests with vmcoreinfo driver o=
nly.\n\t\t\t"
                       "begin: the starting physical address.\n\t\t\t"
                       "length: the memory size, in bytes.",
         .cmd        =3D hmp_dump_guest_memory,
     },
=20
-
 STEXI
 @item dump-guest-memory [-p] @var{filename} @var{begin} @var{length}
-@item dump-guest-memory [-z|-l|-s] @var{filename}
+@item dump-guest-memory [-z|-l|-s|-w] @var{filename}
 @findex dump-guest-memory
 Dump guest memory to @var{protocol}. The file can be processed with crash =
or
-gdb. Without -z|-l|-s, the dump format is ELF.
+gdb. Without -z|-l|-s|-w, the dump format is ELF.
         -p: do paging to get guest's memory mapping.
         -z: dump in kdump-compressed format, with zlib compression.
         -l: dump in kdump-compressed format, with lzo compression.
         -s: dump in kdump-compressed format, with snappy compression.
+        -w: dump in Windows crashdump format (can be used instead of ELF-d=
ump converting),
+            for Windows x64 guests with vmcoreinfo driver only
   filename: dump file name.
      begin: the starting physical address. It's optional, and should be
             specified together with length.
diff --git a/hmp.c b/hmp.c
index bdb340605c..c0c7ff0982 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1976,6 +1976,7 @@ void hmp_device_del(Monitor *mon, const QDict *qdict)
 void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict)
 {
     Error *err =3D NULL;
+    bool win_dmp =3D qdict_get_try_bool(qdict, "windmp", false);
     bool paging =3D qdict_get_try_bool(qdict, "paging", false);
     bool zlib =3D qdict_get_try_bool(qdict, "zlib", false);
     bool lzo =3D qdict_get_try_bool(qdict, "lzo", false);
@@ -1990,12 +1991,16 @@ void hmp_dump_guest_memory(Monitor *mon, const QDic=
t *qdict)
     enum DumpGuestMemoryFormat dump_format =3D DUMP_GUEST_MEMORY_FORMAT_EL=
F;
     char *prot;
=20
-    if (zlib + lzo + snappy > 1) {
-        error_setg(&err, "only one of '-z|-l|-s' can be set");
+    if (zlib + lzo + snappy + win_dmp > 1) {
+        error_setg(&err, "only one of '-z|-l|-s|-w' can be set");
         hmp_handle_error(mon, &err);
         return;
     }
=20
+    if (win_dmp) {
+        dump_format =3D DUMP_GUEST_MEMORY_FORMAT_WIN_DMP;
+    }
+
     if (zlib) {
         dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZLIB;
     }
diff --git a/qapi/misc.json b/qapi/misc.json
index f5988cc0b5..5d02d07298 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1679,10 +1679,13 @@
 #
 # @kdump-snappy: kdump-compressed format with snappy-compressed
 #
+# @win-dmp: Windows full crashdump format,
+#           can be used instead of ELF converting (since 2.13)
+#
 # Since: 2.0
 ##
 { 'enum': 'DumpGuestMemoryFormat',
-  'data': [ 'elf', 'kdump-zlib', 'kdump-lzo', 'kdump-snappy' ] }
+  'data': [ 'elf', 'kdump-zlib', 'kdump-lzo', 'kdump-snappy', 'win-dmp' ] =
}
=20
 ##
 # @dump-guest-memory:
diff --git a/win_dump.c b/win_dump.c
new file mode 100644
index 0000000000..58255c12ee
--- /dev/null
+++ b/win_dump.c
@@ -0,0 +1,209 @@
+/*
+ * Windows crashdump
+ *
+ * Copyright (c) 2018 Virtuozzo International GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "elf.h"
+#include "cpu.h"
+#include "exec/hwaddr.h"
+#include "monitor/monitor.h"
+#include "sysemu/kvm.h"
+#include "sysemu/dump.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/memory_mapping.h"
+#include "sysemu/cpus.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
+#include "qemu/error-report.h"
+#include "hw/misc/vmcoreinfo.h"
+#include "win_dump.h"
+
+static size_t write_run(WinDumpPhyMemRun64 *run, int fd, Error **errp)
+{
+    void *buf;
+    uint64_t addr =3D run->BasePage << TARGET_PAGE_BITS;
+    uint64_t size =3D run->PageCount << TARGET_PAGE_BITS;
+    uint64_t len =3D size;
+
+    buf =3D cpu_physical_memory_map(addr, &len, false);
+    if (!buf) {
+        error_setg(errp, "win-dump: failed to map run");
+        return 0;
+    }
+    if (len !=3D size) {
+        error_setg(errp, "win-dump: failed to map entire run");
+        len =3D 0;
+        goto out_unmap;
+    }
+
+    len =3D qemu_write_full(fd, buf, len);
+    if (len !=3D size) {
+        error_setg(errp, QERR_IO_ERROR);
+    }
+
+out_unmap:
+    cpu_physical_memory_unmap(buf, addr, false, len);
+
+    return len;
+}
+
+static void write_runs(DumpState *s, WinDumpHeader64 *h, Error **errp)
+{
+    WinDumpPhyMemDesc64 *desc =3D &h->PhysicalMemoryBlock;
+    WinDumpPhyMemRun64 *run =3D desc->Run;
+    Error *local_err =3D NULL;
+    int i;
+
+    for (i =3D 0; i < desc->NumberOfRuns; i++) {
+        s->written_size +=3D write_run(run + i, s->fd, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+}
+
+static void patch_mm_pfn_database(WinDumpHeader64 *h, Error **errp)
+{
+    if (cpu_memory_rw_debug(first_cpu,
+            h->KdDebuggerDataBlock + KDBG_MM_PFN_DATABASE_OFFSET64,
+            (uint8_t *)&h->PfnDatabase, sizeof(h->PfnDatabase), 0)) {
+        error_setg(errp, "win-dump: failed to read MmPfnDatabase");
+        return;
+    }
+}
+
+static void patch_bugcheck_data(WinDumpHeader64 *h, Error **errp)
+{
+    uint64_t KiBugcheckData;
+
+    if (cpu_memory_rw_debug(first_cpu,
+            h->KdDebuggerDataBlock + KDBG_KI_BUGCHECK_DATA_OFFSET64,
+            (uint8_t *)&KiBugcheckData, sizeof(KiBugcheckData), 0)) {
+        error_setg(errp, "win-dump: failed to read KiBugcheckData");
+        return;
+    }
+
+    if (cpu_memory_rw_debug(first_cpu,
+            KiBugcheckData,
+            h->BugcheckData, sizeof(h->BugcheckData), 0)) {
+        error_setg(errp, "win-dump: failed to read bugcheck data");
+        return;
+    }
+}
+
+/*
+ * This routine tries to correct mistakes in crashdump header.
+ */
+static void patch_header(WinDumpHeader64 *h)
+{
+    Error *local_err =3D NULL;
+
+    h->RequiredDumpSpace =3D sizeof(WinDumpHeader64) +
+            (h->PhysicalMemoryBlock.NumberOfPages << TARGET_PAGE_BITS);
+    h->PhysicalMemoryBlock.unused =3D 0;
+    h->unused1 =3D 0;
+
+    /*
+     * We assume h->DirectoryBase and current CR3 are the same when we acc=
ess
+     * memory by virtual address. In other words, we suppose current conte=
xt
+     * is system context. It is definetely true in case of BSOD.
+     */
+
+    patch_mm_pfn_database(h, &local_err);
+    if (local_err) {
+        warn_report_err(local_err);
+        local_err =3D NULL;
+    }
+    patch_bugcheck_data(h, &local_err);
+    if (local_err) {
+        warn_report_err(local_err);
+    }
+}
+
+static void check_header(WinDumpHeader64 *h, Error **errp)
+{
+    const char Signature[] =3D "PAGE";
+    const char ValidDump[] =3D "DU64";
+
+    if (memcmp(h->Signature, Signature, sizeof(h->Signature))) {
+        error_setg(errp, "win-dump: invalid header, expected '%.4s',"
+                         " got '%.4s'", Signature, h->Signature);
+        return;
+    }
+
+    if (memcmp(h->ValidDump, ValidDump, sizeof(h->ValidDump))) {
+        error_setg(errp, "win-dump: invalid header, expected '%.4s',"
+                         " got '%.4s'", ValidDump, h->ValidDump);
+        return;
+    }
+}
+
+static void check_kdbg(WinDumpHeader64 *h, Error **errp)
+{
+    const char OwnerTag[] =3D "KDBG";
+    char read_OwnerTag[4];
+
+    if (cpu_memory_rw_debug(first_cpu,
+            h->KdDebuggerDataBlock + KDBG_OWNER_TAG_OFFSET64,
+            (uint8_t *)&read_OwnerTag, sizeof(read_OwnerTag), 0)) {
+        error_setg(errp, "win-dump: failed to read OwnerTag");
+        return;
+    }
+
+    if (memcmp(read_OwnerTag, OwnerTag, sizeof(read_OwnerTag))) {
+        error_setg(errp, "win-dump: invalid KDBG OwnerTag,"
+                         " expected '%.4s', got '%.4s',"
+                         " KdDebuggerDataBlock seems to be encrypted",
+                         OwnerTag, read_OwnerTag);
+        return;
+    }
+}
+
+void create_win_dump(DumpState *s, Error **errp)
+{
+    WinDumpHeader64 *h =3D (WinDumpHeader64 *)(s->guest_note +
+            VMCOREINFO_ELF_NOTE_HDR_SIZE);
+    Error *local_err =3D NULL;
+
+    if (s->guest_note_size !=3D sizeof(WinDumpHeader64) +
+            VMCOREINFO_ELF_NOTE_HDR_SIZE) {
+        error_setg(errp, "win-dump: invalid vmcoreinfo note size");
+        return;
+    }
+
+    check_header(h, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    check_kdbg(h, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    patch_header(h);
+
+    s->total_size =3D h->RequiredDumpSpace;
+
+    s->written_size =3D qemu_write_full(s->fd, h, sizeof(*h));
+    if (s->written_size !=3D sizeof(*h)) {
+        error_setg(errp, QERR_IO_ERROR);
+        return;
+    }
+
+    write_runs(s, h, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
diff --git a/win_dump.h b/win_dump.h
new file mode 100644
index 0000000000..281241881e
--- /dev/null
+++ b/win_dump.h
@@ -0,0 +1,87 @@
+/*
+ * Windows crashdump
+ *
+ * Copyright (c) 2018 Virtuozzo International GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+typedef struct WinDumpPhyMemRun64 {
+    uint64_t BasePage;
+    uint64_t PageCount;
+} QEMU_PACKED WinDumpPhyMemRun64;
+
+typedef struct WinDumpPhyMemDesc64 {
+    uint32_t NumberOfRuns;
+    uint32_t unused;
+    uint64_t NumberOfPages;
+    WinDumpPhyMemRun64 Run[43];
+} QEMU_PACKED WinDumpPhyMemDesc64;
+
+typedef struct WinDumpExceptionRecord {
+    uint32_t ExceptionCode;
+    uint32_t ExceptionFlags;
+    uint64_t ExceptionRecord;
+    uint64_t ExceptionAddress;
+    uint32_t NumberParameters;
+    uint32_t unused;
+    uint64_t ExceptionInformation[15];
+} QEMU_PACKED WinDumpExceptionRecord;
+
+typedef struct WinDumpHeader64 {
+    char Signature[4];
+    char ValidDump[4];
+    uint32_t MajorVersion;
+    uint32_t MinorVersion;
+    uint64_t DirectoryTableBase;
+    uint64_t PfnDatabase;
+    uint64_t PsLoadedModuleList;
+    uint64_t PsActiveProcessHead;
+    uint32_t MachineImageType;
+    uint32_t NumberProcessors;
+    union {
+        struct {
+            uint32_t BugcheckCode;
+            uint32_t unused0;
+            uint64_t BugcheckParameter1;
+            uint64_t BugcheckParameter2;
+            uint64_t BugcheckParameter3;
+            uint64_t BugcheckParameter4;
+        };
+        uint8_t BugcheckData[40];
+    };
+    uint8_t VersionUser[32];
+    uint64_t KdDebuggerDataBlock;
+    union {
+        WinDumpPhyMemDesc64 PhysicalMemoryBlock;
+        uint8_t PhysicalMemoryBlockBuffer[704];
+    };
+    union {
+        uint8_t ContextBuffer[3000];
+    };
+    WinDumpExceptionRecord Exception;
+    uint32_t DumpType;
+    uint32_t unused1;
+    uint64_t RequiredDumpSpace;
+    uint64_t SystemTime;
+    char Comment[128];
+    uint64_t SystemUpTime;
+    uint32_t MiniDumpFields;
+    uint32_t SecondaryDataState;
+    uint32_t ProductType;
+    uint32_t SuiteMask;
+    uint32_t WriterStatus;
+    uint8_t unused2;
+    uint8_t KdSecondaryVersion;
+    uint8_t reserved[4018];
+} QEMU_PACKED WinDumpHeader64;
+
+void create_win_dump(DumpState *s, Error **errp);
+
+#define KDBG_OWNER_TAG_OFFSET64         0x10
+#define KDBG_KI_BUGCHECK_DATA_OFFSET64  0x88
+#define KDBG_MM_PFN_DATABASE_OFFSET64   0xC0
+
+#define VMCOREINFO_ELF_NOTE_HDR_SIZE    24
--=20
2.14.3
