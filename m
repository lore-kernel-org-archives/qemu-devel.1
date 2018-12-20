Received: from eggs.gnu.org ([2001:4830:134:3::10]:46547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gZn5S-0005lh-7u
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gZn5O-0002rO-HR
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:25:17 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <viktor.prutyanov@phystech.edu>)
	id 1gZn5M-0002hn-G9
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:25:14 -0500
Received: by mail-lj1-x242.google.com with SMTP id k19-v6so53687lji.11
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 17:25:09 -0800 (PST)
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Date: Thu, 20 Dec 2018 04:24:39 +0300
Message-Id: <20181220012441.13694-5-viktor.prutyanov@phystech.edu>
In-Reply-To: <20181220012441.13694-1-viktor.prutyanov@phystech.edu>
References: <20181220012441.13694-1-viktor.prutyanov@phystech.edu>
Subject: [Qemu-devel] [PATCH v2 4/6] contrib/elf2dmp: fix structures
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rkagan@virtuozzo.com
Cc: eblake@redhat.com, qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>

Remove duplicate structures definitions in case of build for Windows hosts.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
---
 contrib/elf2dmp/kdbg.h | 12 ++++++++----
 contrib/elf2dmp/pdb.h  |  2 ++
 contrib/elf2dmp/pe.h   |  6 ++++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/contrib/elf2dmp/kdbg.h b/contrib/elf2dmp/kdbg.h
index 851b57c321..002e3d0cd5 100644
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
index 8e395119d1..9a848f75e2 100644
--- a/contrib/elf2dmp/pdb.h
+++ b/contrib/elf2dmp/pdb.h
@@ -11,12 +11,14 @@
 #include <stdint.h>
 #include <stdlib.h>
 
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
index 374e06a9c5..0fd5c23c7f 100644
--- a/contrib/elf2dmp/pe.h
+++ b/contrib/elf2dmp/pe.h
@@ -10,6 +10,7 @@
 
 #include <stdint.h>
 
+#ifndef _WIN32
 typedef struct IMAGE_DOS_HEADER {
     uint16_t  e_magic;      /* 0x00: MZ Header signature */
     uint16_t  e_cblp;       /* 0x02: Bytes on last page of file */
@@ -88,8 +89,6 @@ typedef struct IMAGE_NT_HEADERS64 {
   IMAGE_OPTIONAL_HEADER64 OptionalHeader;
 } __attribute__ ((packed)) IMAGE_NT_HEADERS64;
 
-#define IMAGE_FILE_DEBUG_DIRECTORY  6
-
 typedef struct IMAGE_DEBUG_DIRECTORY {
   uint32_t Characteristics;
   uint32_t TimeDateStamp;
@@ -102,6 +101,9 @@ typedef struct IMAGE_DEBUG_DIRECTORY {
 } __attribute__ ((packed)) IMAGE_DEBUG_DIRECTORY;
 
 #define IMAGE_DEBUG_TYPE_CODEVIEW   2
+#endif
+
+#define IMAGE_FILE_DEBUG_DIRECTORY  6
 
 typedef struct guid_t {
     uint32_t a;
-- 
2.17.2
