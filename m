Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF66C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2971020881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjTRXMdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2971020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46168 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTN0-0008Db-8A
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 11:41:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wens@kernel.org>) id 1hTTLI-0006Ra-L4
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wens@kernel.org>) id 1hTTIN-0006jI-H6
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wens@kernel.org>) id 1hTTIN-0006dU-2Z
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:36:47 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 381B820868;
	Wed, 22 May 2019 15:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558539405;
	bh=LOdC4corK+KeXRAyuWvkbfNSPl5KZ7kzktBbJu4P2sQ=;
	h=From:To:Cc:Subject:Date:From;
	b=DjTRXMdzvb5DTU2ehHPuwVlMVpQayFL+Cwz1HfWhFEn1H1AIsQfXSejgmXedqea+F
	FLKVWRr9vxXbY8IHgUAZrxXK24i4ixuDeug4a1BnOdyvyhVuNjO3OqjuaUh5yxCj3k
	LVwpyZ1gd/J5w8lqOBLsMfRYtkwvmJ0gaPI2YVko=
Received: by wens.tw (Postfix, from userid 1000)
	id 35F14602F9; Wed, 22 May 2019 23:36:42 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 23:36:31 +0800
Message-Id: <20190522153631.17152-1-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
Subject: [Qemu-devel] [PATCH v2] linux-user: Pass through nanosecond
 timestamp components for stat syscalls
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>, Chen-Yu Tsai <wens@kernel.org>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen-Yu Tsai <wens@csie.org>

Since Linux 2.6 the stat syscalls have mostly supported nanosecond
components for each of the file-related timestamps.

QEMU user mode emulation currently does not pass through the nanosecond
portion of the timestamp, even when the host system fills in the value.
This results in a mismatch when run on subsecond resolution filesystems
such as ext4 or XFS.

An example of this leading to inconsistency is cross-debootstraping a
full desktop root filesystem of Debian Buster. Recent versions of
fontconfig store the full timestamp (instead of just the second portion)
of the directory in its per-directory cache file, and checks this against
the directory to see if the cache is up-to-date. With QEMU user mode
emulation, the timestamp stored is incorrect, and upon booting the rootfs
natively, fontconfig discovers the mismatch, and proceeds to rebuild the
cache on the comparatively slow machine (low-power ARM vs x86). This
stalls the first attempt to open whatever application that incorporates
fontconfig.

This patch renames the "unused" padding trailing each timestamp element
to its nanosecond counterpart name if such an element exists in the
kernel sources for the given platform. Not all do. Then have the syscall
wrapper fill in the nanosecond portion if the host supports it, as
specified by the _POSIX_C_SOURCE and _XOPEN_SOURCE feature macros.

Recent versions of glibc only use stat64 and newfstatat syscalls on
32-bit and 64-bit platforms respectively. The changes in this patch
were tested by directly calling the stat, stat64 and newfstatat syscalls
directly, in addition to the glibc wrapper, on arm and aarch64 little
endian targets.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>

---

Changes since v1:

  - Define TARGET_STAT_HAS_NSEC for targets that have the *_nsec fields
    in their struct stat

  - Only copy the *_nsec fields in the stat (not stat64) code path if
    TARGET_STAT_HAS_NSEC is defined

  - Picked up Reviewed-by from Laurent

As Laurent mentioned, linux-user/syscall_defs.h is indented with tabs,
so the checkpatch.pl errors can be ignored.

Original cover letter:

This issue was found while integrating some software that uses newer
versions of fontconfig into Raspbian images. We found that the first
launch of said software always stalls with fontconfig regenerating its
font cache files. Upon closer examination I found the timestamps were
not matching. The rest is explained above. Currently we're just working
around the problem by patching the correct timestamps into the cache
files after the fact.

Please consider this a drive-by scratch-my-own-itch contribution, but I
will stick around to deal with any comments raised during review. I'm
not on the mailing lists either, so please keep me in CC.

checkpatch returns "ERROR: code indent should never use tabs" for
linux-user/syscall_defs.h, however as far as I can tell the whole file
is indented with tabs. I'm not sure what to make of this.

Finally, I think this could be worth backporting to older versions.
---
 linux-user/syscall.c      | 19 +++++++++++++++
 linux-user/syscall_defs.h | 49 +++++++++++++++++++++++++--------------
 2 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index efa3ec2837..6d0f13c155 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6408,6 +6408,11 @@ static inline abi_long host_to_target_stat64(void =
*cpu_env,
         __put_user(host_st->st_atime, &target_st->target_st_atime);
         __put_user(host_st->st_mtime, &target_st->target_st_mtime);
         __put_user(host_st->st_ctime, &target_st->target_st_ctime);
+#if _POSIX_C_SOURCE >=3D 200809L || _XOPEN_SOURCE >=3D 700
+        __put_user(host_st->st_atim.tv_nsec, &target_st->target_st_atime=
_nsec);
+        __put_user(host_st->st_mtim.tv_nsec, &target_st->target_st_mtime=
_nsec);
+        __put_user(host_st->st_ctim.tv_nsec, &target_st->target_st_ctime=
_nsec);
+#endif
         unlock_user_struct(target_st, target_addr, 1);
     } else
 #endif
@@ -6438,6 +6443,11 @@ static inline abi_long host_to_target_stat64(void =
*cpu_env,
         __put_user(host_st->st_atime, &target_st->target_st_atime);
         __put_user(host_st->st_mtime, &target_st->target_st_mtime);
         __put_user(host_st->st_ctime, &target_st->target_st_ctime);
+#if _POSIX_C_SOURCE >=3D 200809L || _XOPEN_SOURCE >=3D 700
+        __put_user(host_st->st_atim.tv_nsec, &target_st->target_st_atime=
_nsec);
+        __put_user(host_st->st_mtim.tv_nsec, &target_st->target_st_mtime=
_nsec);
+        __put_user(host_st->st_ctim.tv_nsec, &target_st->target_st_ctime=
_nsec);
+#endif
         unlock_user_struct(target_st, target_addr, 1);
     }
=20
@@ -8866,6 +8876,15 @@ static abi_long do_syscall1(void *cpu_env, int num=
, abi_long arg1,
                 __put_user(st.st_atime, &target_st->target_st_atime);
                 __put_user(st.st_mtime, &target_st->target_st_mtime);
                 __put_user(st.st_ctime, &target_st->target_st_ctime);
+#if (_POSIX_C_SOURCE >=3D 200809L || _XOPEN_SOURCE >=3D 700) && \
+    defined(TARGET_STAT_HAS_NSEC)
+                __put_user(st.st_atim.tv_nsec,
+                           &target_st->target_st_atime_nsec);
+                __put_user(st.st_mtim.tv_nsec,
+                           &target_st->target_st_mtime_nsec);
+                __put_user(st.st_ctim.tv_nsec,
+                           &target_st->target_st_ctime_nsec);
+#endif
                 unlock_user_struct(target_st, arg2, 1);
             }
         }
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 1f5b2d18db..f02f3deb6a 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1179,6 +1179,7 @@ struct target_winsize {
 #if (defined(TARGET_I386) && defined(TARGET_ABI32)) \
     || (defined(TARGET_ARM) && defined(TARGET_ABI32)) \
     || defined(TARGET_CRIS)
+#define TARGET_STAT_HAS_NSEC
 struct target_stat {
 	unsigned short st_dev;
 	unsigned short __pad1;
@@ -1193,11 +1194,11 @@ struct target_stat {
 	abi_ulong  st_blksize;
 	abi_ulong  st_blocks;
 	abi_ulong  target_st_atime;
-	abi_ulong  __unused1;
+	abi_ulong  target_st_atime_nsec;
 	abi_ulong  target_st_mtime;
-	abi_ulong  __unused2;
+	abi_ulong  target_st_mtime_nsec;
 	abi_ulong  target_st_ctime;
-	abi_ulong  __unused3;
+	abi_ulong  target_st_ctime_nsec;
 	abi_ulong  __unused4;
 	abi_ulong  __unused5;
 };
@@ -1229,13 +1230,13 @@ struct target_stat64 {
 	abi_ulong	__pad4;		/* future possible st_blocks high bits */
=20
 	abi_ulong	target_st_atime;
-	abi_ulong	__pad5;
+	abi_ulong	target_st_atime_nsec;
=20
 	abi_ulong	target_st_mtime;
-	abi_ulong	__pad6;
+	abi_ulong	target_st_mtime_nsec;
=20
 	abi_ulong	target_st_ctime;
-	abi_ulong	__pad7;		/* will be high 32 bits of ctime someday */
+	abi_ulong	target_st_ctime_nsec;
=20
 	unsigned long long	st_ino;
 } QEMU_PACKED;
@@ -1314,19 +1315,20 @@ struct target_stat64 {
 	unsigned int	st_blocks;
=20
 	abi_ulong	target_st_atime;
-	abi_ulong	__unused1;
+	abi_ulong	target_st_atime_nsec;
=20
 	abi_ulong	target_st_mtime;
-	abi_ulong	__unused2;
+	abi_ulong	target_st_mtime_nsec;
=20
 	abi_ulong	target_st_ctime;
-	abi_ulong	__unused3;
+	abi_ulong	target_st_ctime_nsec;
=20
 	abi_ulong	__unused4[3];
 };
=20
 #elif defined(TARGET_SPARC)
=20
+#define TARGET_STAT_HAS_NSEC
 struct target_stat {
 	unsigned short	st_dev;
 	abi_ulong	st_ino;
@@ -1337,14 +1339,14 @@ struct target_stat {
 	unsigned short	st_rdev;
 	abi_long	st_size;
 	abi_long	target_st_atime;
-	abi_ulong	__unused1;
+	abi_ulong	target_st_atime_nsec;
 	abi_long	target_st_mtime;
-	abi_ulong	__unused2;
+	abi_ulong	target_st_mtime_nsec;
 	abi_long	target_st_ctime;
-	abi_ulong	__unused3;
+	abi_ulong	target_st_ctime_nsec;
 	abi_long	st_blksize;
 	abi_long	st_blocks;
-	abi_ulong	__unused4[2];
+	abi_ulong	__unused1[2];
 };
=20
 #define TARGET_HAS_STRUCT_STAT64
@@ -1372,20 +1374,21 @@ struct target_stat64 {
 	unsigned int	st_blocks;
=20
 	unsigned int	target_st_atime;
-	unsigned int	__unused1;
+	unsigned int	target_st_atime_nsec;
=20
 	unsigned int	target_st_mtime;
-	unsigned int	__unused2;
+	unsigned int	target_st_mtime_nsec;
=20
 	unsigned int	target_st_ctime;
-	unsigned int	__unused3;
+	unsigned int	target_st_ctime_nsec;
=20
-	unsigned int	__unused4;
-	unsigned int	__unused5;
+	unsigned int	__unused1;
+	unsigned int	__unused2;
 };
=20
 #elif defined(TARGET_PPC)
=20
+#define TARGET_STAT_HAS_NSEC
 struct target_stat {
 	abi_ulong st_dev;
 	abi_ulong st_ino;
@@ -1443,6 +1446,7 @@ struct QEMU_PACKED target_stat64 {
=20
 #elif defined(TARGET_MICROBLAZE)
=20
+#define TARGET_STAT_HAS_NSEC
 struct target_stat {
 	abi_ulong st_dev;
 	abi_ulong st_ino;
@@ -1558,6 +1562,7 @@ struct target_stat64 {
=20
 #elif defined(TARGET_ABI_MIPSN64)
=20
+#define TARGET_STAT_HAS_NSEC
 /* The memory layout is the same as of struct stat64 of the 32-bit kerne=
l.  */
 struct target_stat {
 	unsigned int		st_dev;
@@ -1597,6 +1602,7 @@ struct target_stat {
=20
 #elif defined(TARGET_ABI_MIPSN32)
=20
+#define TARGET_STAT_HAS_NSEC
 struct target_stat {
         abi_ulong    st_dev;
         abi_ulong    st_pad0[3]; /* Reserved for st_dev expansion */
@@ -1621,6 +1627,7 @@ struct target_stat {
=20
 #elif defined(TARGET_ABI_MIPSO32)
=20
+#define TARGET_STAT_HAS_NSEC
 struct target_stat {
 	unsigned	st_dev;
 	abi_long	st_pad1[3];		/* Reserved for network id */
@@ -1737,6 +1744,7 @@ struct target_stat64 {
=20
 #elif defined(TARGET_SH4)
=20
+#define TARGET_STAT_HAS_NSEC
 struct target_stat {
 	abi_ulong  st_dev;
 	abi_ulong  st_ino;
@@ -1796,6 +1804,7 @@ struct QEMU_PACKED target_stat64 {
 };
=20
 #elif defined(TARGET_I386) && !defined(TARGET_ABI32)
+#define TARGET_STAT_HAS_NSEC
 struct target_stat {
 	abi_ulong	st_dev;
 	abi_ulong	st_ino;
@@ -1841,6 +1850,7 @@ struct target_stat {
     abi_ulong  __unused[3];
 };
 #elif defined(TARGET_AARCH64)
+#define TARGET_STAT_HAS_NSEC
 struct target_stat {
     abi_ulong  st_dev;
     abi_ulong  st_ino;
@@ -1863,6 +1873,7 @@ struct target_stat {
     unsigned int __unused[2];
 };
 #elif defined(TARGET_XTENSA)
+#define TARGET_STAT_HAS_NSEC
 struct target_stat {
     abi_ulong       st_dev;
     abi_ulong       st_ino;
@@ -1912,6 +1923,7 @@ struct target_stat64  {
=20
 /* These are the asm-generic versions of the stat and stat64 structures =
*/
=20
+#define TARGET_STAT_HAS_NSEC
 struct target_stat {
     abi_ulong st_dev;
     abi_ulong st_ino;
@@ -1963,6 +1975,7 @@ struct target_stat64 {
=20
 #elif defined(TARGET_HPPA)
=20
+#define TARGET_STAT_HAS_NSEC
 struct target_stat {
     abi_uint   st_dev;
     abi_uint   st_ino;
--=20
2.20.1


