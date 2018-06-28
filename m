Received: from eggs.gnu.org ([2001:4830:134:3::10]:38493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdBC-0007tu-B1
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB9-0001NC-RD
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:10 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:46759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdB9-0001K7-Ft
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:07 -0400
Received: by mail-wr0-x22f.google.com with SMTP id t6-v6so6666629wrq.13
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:06:07 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:05:03 +0200
Message-Id: <1530216310-52873-54-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 53/60] dump: add Windows dump format to
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
Cc: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

This patch adds Windows crashdumping feature. Now QEMU can produce ELF-dump
containing Windows crashdump header, which can help to convert to a valid
WinDbg-understandable crashdump file, or immediately create such file.
The crashdump will be obtained by joining physical memory dump and 8K header
exposed through vmcoreinfo/fw_cfg device by guest driver at BSOD time. Option
'-w' was added to dump-guest-memory command. At the moment, only x64
configuration is supported.
Suitable driver can be found at
https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/fwcfg64

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180517162342.4330-2-viktor.prutyanov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target |   1 +
 dump.c          |  24 ++++++-
 hmp-commands.hx |  13 ++--
 hmp.c           |   9 ++-
 qapi/misc.json  |   5 +-
 win_dump.c      | 209 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 win_dump.h      |  87 +++++++++++++++++++++++
 7 files changed, 339 insertions(+), 9 deletions(-)
 create mode 100644 win_dump.c
 create mode 100644 win_dump.h

diff --git a/Makefile.target b/Makefile.target
index a9d8928..4d56298 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -143,6 +143,7 @@ obj-y += hw/
 obj-y += memory.o
 obj-y += memory_mapping.o
 obj-y += dump.o
+obj-$(TARGET_X86_64) += win_dump.o
 obj-y += migration/ram.o
 LIBS := $(libs_softmmu) $(LIBS)
 
diff --git a/dump.c b/dump.c
index b54cd42..04467b3 100644
--- a/dump.c
+++ b/dump.c
@@ -29,6 +29,10 @@
 #include "qemu/error-report.h"
 #include "hw/misc/vmcoreinfo.h"
 
+#ifdef TARGET_X86_64
+#include "win_dump.h"
+#endif
+
 #include <zlib.h>
 #ifdef CONFIG_LZO
 #include <lzo/lzo1x.h>
@@ -1866,7 +1870,11 @@ static void dump_process(DumpState *s, Error **errp)
     Error *local_err = NULL;
     DumpQueryResult *result = NULL;
 
-    if (s->has_format && s->format != DUMP_GUEST_MEMORY_FORMAT_ELF) {
+    if (s->has_format && s->format == DUMP_GUEST_MEMORY_FORMAT_WIN_DMP) {
+#ifdef TARGET_X86_64
+        create_win_dump(s, &local_err);
+#endif
+    } else if (s->has_format && s->format != DUMP_GUEST_MEMORY_FORMAT_ELF) {
         create_kdump_vmcore(s, &local_err);
     } else {
         create_vmcore(s, &local_err);
@@ -1970,6 +1978,13 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     }
 #endif
 
+#ifndef TARGET_X86_64
+    if (has_format && format == DUMP_GUEST_MEMORY_FORMAT_WIN_DMP) {
+        error_setg(errp, "Windows dump is only available for x86-64");
+        return;
+    }
+#endif
+
 #if !defined(WIN32)
     if (strstart(file, "fd:", &p)) {
         fd = monitor_get_fd(cur_mon, p, errp);
@@ -2044,5 +2059,12 @@ DumpGuestMemoryCapability *qmp_query_dump_guest_memory_capability(Error **errp)
     item->value = DUMP_GUEST_MEMORY_FORMAT_KDUMP_SNAPPY;
 #endif
 
+    /* Windows dump is available only if target is x86_64 */
+#ifdef TARGET_X86_64
+    item->next = g_malloc0(sizeof(DumpGuestMemoryFormatList));
+    item = item->next;
+    item->value = DUMP_GUEST_MEMORY_FORMAT_WIN_DMP;
+#endif
+
     return cap;
 }
diff --git a/hmp-commands.hx b/hmp-commands.hx
index ba9cdb8..c1fc747 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1136,30 +1136,33 @@ ETEXI
 
     {
         .name       = "dump-guest-memory",
-        .args_type  = "paging:-p,detach:-d,zlib:-z,lzo:-l,snappy:-s,filename:F,begin:l?,length:l?",
-        .params     = "[-p] [-d] [-z|-l|-s] filename [begin length]",
+        .args_type  = "paging:-p,detach:-d,windmp:-w,zlib:-z,lzo:-l,snappy:-s,filename:F,begin:l?,length:l?",
+        .params     = "[-p] [-d] [-z|-l|-s|-w] filename [begin length]",
         .help       = "dump guest memory into file 'filename'.\n\t\t\t"
                       "-p: do paging to get guest's memory mapping.\n\t\t\t"
                       "-d: return immediately (do not wait for completion).\n\t\t\t"
                       "-z: dump in kdump-compressed format, with zlib compression.\n\t\t\t"
                       "-l: dump in kdump-compressed format, with lzo compression.\n\t\t\t"
                       "-s: dump in kdump-compressed format, with snappy compression.\n\t\t\t"
+                      "-w: dump in Windows crashdump format (can be used instead of ELF-dump converting),\n\t\t\t"
+                      "    for Windows x64 guests with vmcoreinfo driver only.\n\t\t\t"
                       "begin: the starting physical address.\n\t\t\t"
                       "length: the memory size, in bytes.",
         .cmd        = hmp_dump_guest_memory,
     },
 
-
 STEXI
 @item dump-guest-memory [-p] @var{filename} @var{begin} @var{length}
-@item dump-guest-memory [-z|-l|-s] @var{filename}
+@item dump-guest-memory [-z|-l|-s|-w] @var{filename}
 @findex dump-guest-memory
 Dump guest memory to @var{protocol}. The file can be processed with crash or
-gdb. Without -z|-l|-s, the dump format is ELF.
+gdb. Without -z|-l|-s|-w, the dump format is ELF.
         -p: do paging to get guest's memory mapping.
         -z: dump in kdump-compressed format, with zlib compression.
         -l: dump in kdump-compressed format, with lzo compression.
         -s: dump in kdump-compressed format, with snappy compression.
+        -w: dump in Windows crashdump format (can be used instead of ELF-dump converting),
+            for Windows x64 guests with vmcoreinfo driver only
   filename: dump file name.
      begin: the starting physical address. It's optional, and should be
             specified together with length.
diff --git a/hmp.c b/hmp.c
index 0da0b0a..41f5e39 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2014,6 +2014,7 @@ void hmp_device_del(Monitor *mon, const QDict *qdict)
 void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
+    bool win_dmp = qdict_get_try_bool(qdict, "windmp", false);
     bool paging = qdict_get_try_bool(qdict, "paging", false);
     bool zlib = qdict_get_try_bool(qdict, "zlib", false);
     bool lzo = qdict_get_try_bool(qdict, "lzo", false);
@@ -2028,12 +2029,16 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict)
     enum DumpGuestMemoryFormat dump_format = DUMP_GUEST_MEMORY_FORMAT_ELF;
     char *prot;
 
-    if (zlib + lzo + snappy > 1) {
-        error_setg(&err, "only one of '-z|-l|-s' can be set");
+    if (zlib + lzo + snappy + win_dmp > 1) {
+        error_setg(&err, "only one of '-z|-l|-s|-w' can be set");
         hmp_handle_error(mon, &err);
         return;
     }
 
+    if (win_dmp) {
+        dump_format = DUMP_GUEST_MEMORY_FORMAT_WIN_DMP;
+    }
+
     if (zlib) {
         dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZLIB;
     }
diff --git a/qapi/misc.json b/qapi/misc.json
index c6bc18a..29da785 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1677,10 +1677,13 @@
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
+  'data': [ 'elf', 'kdump-zlib', 'kdump-lzo', 'kdump-snappy', 'win-dmp' ] }
 
 ##
 # @dump-guest-memory:
diff --git a/win_dump.c b/win_dump.c
new file mode 100644
index 0000000..58255c1
--- /dev/null
+++ b/win_dump.c
@@ -0,0 +1,209 @@
+/*
+ * Windows crashdump
+ *
+ * Copyright (c) 2018 Virtuozzo International GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
+    uint64_t addr = run->BasePage << TARGET_PAGE_BITS;
+    uint64_t size = run->PageCount << TARGET_PAGE_BITS;
+    uint64_t len = size;
+
+    buf = cpu_physical_memory_map(addr, &len, false);
+    if (!buf) {
+        error_setg(errp, "win-dump: failed to map run");
+        return 0;
+    }
+    if (len != size) {
+        error_setg(errp, "win-dump: failed to map entire run");
+        len = 0;
+        goto out_unmap;
+    }
+
+    len = qemu_write_full(fd, buf, len);
+    if (len != size) {
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
+    WinDumpPhyMemDesc64 *desc = &h->PhysicalMemoryBlock;
+    WinDumpPhyMemRun64 *run = desc->Run;
+    Error *local_err = NULL;
+    int i;
+
+    for (i = 0; i < desc->NumberOfRuns; i++) {
+        s->written_size += write_run(run + i, s->fd, &local_err);
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
+    Error *local_err = NULL;
+
+    h->RequiredDumpSpace = sizeof(WinDumpHeader64) +
+            (h->PhysicalMemoryBlock.NumberOfPages << TARGET_PAGE_BITS);
+    h->PhysicalMemoryBlock.unused = 0;
+    h->unused1 = 0;
+
+    /*
+     * We assume h->DirectoryBase and current CR3 are the same when we access
+     * memory by virtual address. In other words, we suppose current context
+     * is system context. It is definetely true in case of BSOD.
+     */
+
+    patch_mm_pfn_database(h, &local_err);
+    if (local_err) {
+        warn_report_err(local_err);
+        local_err = NULL;
+    }
+    patch_bugcheck_data(h, &local_err);
+    if (local_err) {
+        warn_report_err(local_err);
+    }
+}
+
+static void check_header(WinDumpHeader64 *h, Error **errp)
+{
+    const char Signature[] = "PAGE";
+    const char ValidDump[] = "DU64";
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
+    const char OwnerTag[] = "KDBG";
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
+    WinDumpHeader64 *h = (WinDumpHeader64 *)(s->guest_note +
+            VMCOREINFO_ELF_NOTE_HDR_SIZE);
+    Error *local_err = NULL;
+
+    if (s->guest_note_size != sizeof(WinDumpHeader64) +
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
+    s->total_size = h->RequiredDumpSpace;
+
+    s->written_size = qemu_write_full(s->fd, h, sizeof(*h));
+    if (s->written_size != sizeof(*h)) {
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
index 0000000..2812418
--- /dev/null
+++ b/win_dump.h
@@ -0,0 +1,87 @@
+/*
+ * Windows crashdump
+ *
+ * Copyright (c) 2018 Virtuozzo International GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
-- 
1.8.3.1
