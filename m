Received: from eggs.gnu.org ([209.51.188.92]:36226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5GT-0002VG-Lj
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5GK-0003rz-2j
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:05 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:37802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5GJ-0003qO-Q3
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:15:59 -0500
Received: by mail-wm1-x32f.google.com with SMTP id g67so4751223wmd.2
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:15:59 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:14:39 +0100
Message-Id: <1549390526-24246-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 29/76] contrib/elf2dmp: fix structures
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>

From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>

Remove duplicate structures definitions in case of build for Windows hosts.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Message-Id: <20181220012441.13694-5-viktor.prutyanov@phystech.edu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/elf2dmp/kdbg.h | 12 ++++++++----
 contrib/elf2dmp/pdb.h  |  2 ++
 contrib/elf2dmp/pe.h   |  6 ++++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/contrib/elf2dmp/kdbg.h b/contrib/elf2dmp/kdbg.h
index 851b57c..002e3d0 100644
--- a/contrib/elf2dmp/kdbg.h
+++ b/contrib/elf2dmp/kdbg.h
@@ -25,11 +25,15 @@ typedef struct DBGKD_GET_VERSION64 {
     uint64_t DebuggerDataList;
 } DBGKD_GET_VERSION64;
 
+#ifndef _WIN32
+typedef struct LIST_ENTRY64 {
+    struct LIST_ENTRY64 *Flink;
+    struct LIST_ENTRY64 *Blink;
+} LIST_ENTRY64;
+#endif
+
 typedef struct DBGKD_DEBUG_DATA_HEADER64 {
-    struct LIST_ENTRY64 {
-       struct LIST_ENTRY64 *Flink;
-       struct LIST_ENTRY64 *Blink;
-    } List;
+    LIST_ENTRY64    List;
     uint32_t           OwnerTag;
     uint32_t           Size;
 } DBGKD_DEBUG_DATA_HEADER64;
diff --git a/contrib/elf2dmp/pdb.h b/contrib/elf2dmp/pdb.h
index 1640d54..4ea8925 100644
--- a/contrib/elf2dmp/pdb.h
+++ b/contrib/elf2dmp/pdb.h
@@ -9,12 +9,14 @@
 #define PDB_H
 
 
+#ifndef _WIN32
 typedef struct GUID {
     unsigned int Data1;
     unsigned short Data2;
     unsigned short Data3;
     unsigned char Data4[8];
 } GUID;
+#endif
 
 struct PDB_FILE {
     uint32_t size;
diff --git a/contrib/elf2dmp/pe.h b/contrib/elf2dmp/pe.h
index dafb26a..c2a4a6b 100644
--- a/contrib/elf2dmp/pe.h
+++ b/contrib/elf2dmp/pe.h
@@ -9,6 +9,7 @@
 #define PE_H
 
 
+#ifndef _WIN32
 typedef struct IMAGE_DOS_HEADER {
     uint16_t  e_magic;      /* 0x00: MZ Header signature */
     uint16_t  e_cblp;       /* 0x02: Bytes on last page of file */
@@ -87,8 +88,6 @@ typedef struct IMAGE_NT_HEADERS64 {
   IMAGE_OPTIONAL_HEADER64 OptionalHeader;
 } __attribute__ ((packed)) IMAGE_NT_HEADERS64;
 
-#define IMAGE_FILE_DEBUG_DIRECTORY  6
-
 typedef struct IMAGE_DEBUG_DIRECTORY {
   uint32_t Characteristics;
   uint32_t TimeDateStamp;
@@ -101,6 +100,9 @@ typedef struct IMAGE_DEBUG_DIRECTORY {
 } __attribute__ ((packed)) IMAGE_DEBUG_DIRECTORY;
 
 #define IMAGE_DEBUG_TYPE_CODEVIEW   2
+#endif
+
+#define IMAGE_FILE_DEBUG_DIRECTORY  6
 
 typedef struct guid_t {
     uint32_t a;
-- 
1.8.3.1
