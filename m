Received: from eggs.gnu.org ([2001:4830:134:3::10]:40610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f2jiq-0006VZ-Nb
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 16:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f2jip-0003u1-Lu
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 16:37:04 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:46959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f2jip-0003tt-DQ
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 16:37:03 -0400
Received: by mail-lf0-x243.google.com with SMTP id j68-v6so18237006lfg.13
	for <qemu-devel@nongnu.org>; Sun, 01 Apr 2018 13:37:03 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun,  1 Apr 2018 13:36:40 -0700
Message-Id: <20180401203640.31617-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2] target/xtensa: linux-user: fix sysv IPC
 structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>

- make target_ipc_perm fields match kernel definitions for xtensa;
- add target_semid64_ds with proper order of times and reserved fields
  for little/big endian specific for xtensa;
- add missing reserved fields after time fields to the target_shmid_ds;
- fix types of shm_cpid, shm_lpid and shm_nattch fields of
  target_shmid_ds to match kernel definitions for xtensa.

These changes fix guest ipcs output and fix glibc testsuite tests
sysvipc/test-sysvsem and sysvipc/test-sysvshm.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- remove little/big endian versions of target_shmid_ds layout to match
  kernel definition.

 linux-user/xtensa/target_structs.h | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/linux-user/xtensa/target_structs.h b/linux-user/xtensa/target_structs.h
index 020e20e242fc..1b3d9ca314ff 100644
--- a/linux-user/xtensa/target_structs.h
+++ b/linux-user/xtensa/target_structs.h
@@ -8,21 +8,44 @@ struct target_ipc_perm {
     abi_uint cuid;                      /* Creator's user ID.  */
     abi_uint cgid;                      /* Creator's group ID.  */
     abi_uint mode;                      /* Read/write permission.  */
-    abi_ushort __seq;                   /* Sequence number.  */
+    abi_ulong __seq;                    /* Sequence number.  */
+    abi_ulong __unused1;
+    abi_ulong __unused2;
+};
+
+struct target_semid64_ds {
+  struct target_ipc_perm sem_perm;
+#ifdef TARGET_WORDS_BIGENDIAN
+  abi_ulong __unused1;
+  abi_ulong sem_otime;
+  abi_ulong __unused2;
+  abi_ulong sem_ctime;
+#else
+  abi_ulong sem_otime;
+  abi_ulong __unused1;
+  abi_ulong sem_ctime;
+  abi_ulong __unused2;
+#endif
+  abi_ulong sem_nsems;
+  abi_ulong __unused3;
+  abi_ulong __unused4;
 };
+#define TARGET_SEMID64_DS
 
 struct target_shmid_ds {
     struct target_ipc_perm shm_perm;    /* operation permission struct */
-    abi_int shm_segsz;                  /* size of segment in bytes */
+    abi_long shm_segsz;                 /* size of segment in bytes */
     abi_long shm_atime;                 /* time of last shmat() */
+    abi_ulong __unused1;
     abi_long shm_dtime;                 /* time of last shmdt() */
-    abi_long shm_ctime;                 /* time of last change by shmctl() */
-    abi_ushort shm_cpid;                /* pid of creator */
-    abi_ushort shm_lpid;                /* pid of last shmop */
-    abi_ushort shm_nattch;              /* number of current attaches */
-    abi_ushort shm_unused;              /* compatibility */
     abi_ulong __unused2;
+    abi_long shm_ctime;                 /* time of last change by shmctl() */
     abi_ulong __unused3;
+    abi_uint shm_cpid;                  /* pid of creator */
+    abi_uint shm_lpid;                  /* pid of last shmop */
+    abi_ulong shm_nattch;               /* number of current attaches */
+    abi_ulong __unused4;
+    abi_ulong __unused5;
 };
 
 #endif
-- 
2.11.0
