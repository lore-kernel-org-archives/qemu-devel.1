Received: from eggs.gnu.org ([2001:4830:134:3::10]:59932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH3I-0005te-Vi
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH39-0007EX-EH
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:49 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55854 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpH38-0007Bc-Ri
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:39 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 13 Aug 2018 19:53:46 +0200
Message-Id: <1534182832-554-82-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 81/87] linux-user: Add support for statx()
 syscall for all platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Implement support for translation of system call statx(). The
implementation includes invoking other (more mature) syscalls
(from the same 'stat' family) on the host side. This way,
problems of availability of statx() on the host side are
avoided.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/syscall.c      | 121 +++++++++++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |  38 +++++++++++++++
 2 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bced9b8..f1b6d71 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8002,7 +8002,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     abi_long ret;
 #if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) \
     || defined(TARGET_NR_lstat) || defined(TARGET_NR_lstat64) \
-    || defined(TARGET_NR_fstat) || defined(TARGET_NR_fstat64)
+    || defined(TARGET_NR_fstat) || defined(TARGET_NR_fstat64) \
+    || defined(TARGET_NR_statx)
     struct stat st;
 #endif
 #if defined(TARGET_NR_statfs) || defined(TARGET_NR_statfs64) \
@@ -10025,6 +10026,124 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         }
         break;
 #endif
+#if defined(TARGET_NR_statx)
+    case TARGET_NR_statx:
+        {
+            struct target_statx *target_stx;
+            int dirfd = tswap32(arg1);
+            int flags = tswap32(arg3);
+
+            p = lock_user_string(arg2);
+            if (p == NULL) {
+                goto efault;
+            }
+#if defined(__NR_statx)
+            {
+                /* We assume that struct statx is arhitecture independent */
+                struct target_statx host_stx;
+                int mask = tswap32(arg4);
+
+                ret = get_errno(syscall(__NR_statx, dirfd, p, flags, mask,
+                                        &host_stx));
+                if (!is_error(ret)) {
+                    unlock_user(p, arg2, 0);
+                    if (!lock_user_struct(VERIFY_WRITE, target_stx, arg5, 0)) {
+                        goto efault;
+                    }
+                    memset(target_stx, 0, sizeof(*target_stx));
+
+                    __put_user(host_stx.stx_mask, &target_stx->stx_mask);
+                    __put_user(host_stx.stx_blksize, &target_stx->stx_blksize);
+                    __put_user(host_stx.stx_attributes,
+                               &target_stx->stx_attributes);
+                    __put_user(host_stx.stx_nlink, &target_stx->stx_nlink);
+                    __put_user(host_stx.stx_uid, &target_stx->stx_uid);
+                    __put_user(host_stx.stx_gid, &target_stx->stx_gid);
+                    __put_user(host_stx.stx_mode, &target_stx->stx_mode);
+                    __put_user(host_stx.stx_ino, &target_stx->stx_ino);
+                    __put_user(host_stx.stx_size, &target_stx->stx_size);
+                    __put_user(host_stx.stx_blocks, &target_stx->stx_blocks);
+                    __put_user(host_stx.stx_attributes_mask,
+                               &target_stx->stx_attributes_mask);
+                    __put_user(host_stx.stx_atime.tv_sec,
+                               &target_stx->stx_atime.tv_sec);
+                    __put_user(host_stx.stx_atime.tv_nsec,
+                               &target_stx->stx_atime.tv_nsec);
+                    __put_user(host_stx.stx_btime.tv_sec,
+                               &target_stx->stx_atime.tv_sec);
+                    __put_user(host_stx.stx_btime.tv_nsec,
+                               &target_stx->stx_atime.tv_nsec);
+                    __put_user(host_stx.stx_ctime.tv_sec,
+                               &target_stx->stx_atime.tv_sec);
+                    __put_user(host_stx.stx_ctime.tv_nsec,
+                               &target_stx->stx_atime.tv_nsec);
+                    __put_user(host_stx.stx_mtime.tv_sec,
+                               &target_stx->stx_atime.tv_sec);
+                    __put_user(host_stx.stx_mtime.tv_nsec,
+                               &target_stx->stx_atime.tv_nsec);
+                    __put_user(host_stx.stx_rdev_major,
+                               &target_stx->stx_rdev_major);
+                    __put_user(host_stx.stx_rdev_minor,
+                               &target_stx->stx_rdev_minor);
+                    __put_user(host_stx.stx_dev_major,
+                               &target_stx->stx_dev_major);
+                    __put_user(host_stx.stx_dev_minor,
+                               &target_stx->stx_dev_minor);
+                }
+
+                if (ret != TARGET_ENOSYS) {
+                    break;
+                }
+            }
+#endif
+            if ((p == NULL) || (*((char *)p) == 0)) {
+                /* By file descriptor */
+                ret = get_errno(fstat(dirfd, &st));
+                unlock_user(p, arg2, 0);
+            } else if (*((char *)p) == '/') {
+                /* Absolute pathname */
+                ret = get_errno(stat(path(p), &st));
+                unlock_user(p, arg2, 0);
+            } else {
+                if (dirfd == AT_FDCWD) {
+                    /* Pathname relative to the current working directory */
+                    ret = get_errno(stat(path(p), &st));
+                    unlock_user(p, arg2, 0);
+                } else {
+                    /*
+                     * Pathname relative to the directory referred to by the
+                     * file descriptor dirfd
+                     */
+                    ret = get_errno(fstatat(dirfd, path(p), &st, flags));
+                    unlock_user(p, arg2, 0);
+                }
+            }
+
+            if (!is_error(ret)) {
+                if (!lock_user_struct(VERIFY_WRITE, target_stx, arg5, 0)) {
+                    goto efault;
+                }
+                memset(target_stx, 0, sizeof(*target_stx));
+                __put_user(major(st.st_dev), &target_stx->stx_dev_major);
+                __put_user(minor(st.st_dev), &target_stx->stx_dev_minor);
+                __put_user(st.st_ino, &target_stx->stx_ino);
+                __put_user(st.st_mode, &target_stx->stx_mode);
+                __put_user(st.st_uid, &target_stx->stx_uid);
+                __put_user(st.st_gid, &target_stx->stx_gid);
+                __put_user(st.st_nlink, &target_stx->stx_nlink);
+                __put_user(major(st.st_rdev), &target_stx->stx_rdev_major);
+                __put_user(minor(st.st_rdev), &target_stx->stx_rdev_minor);
+                __put_user(st.st_size, &target_stx->stx_size);
+                __put_user(st.st_blksize, &target_stx->stx_blksize);
+                __put_user(st.st_blocks, &target_stx->stx_blocks);
+                __put_user(st.st_atime, &target_stx->stx_atime.tv_sec);
+                __put_user(st.st_mtime, &target_stx->stx_mtime.tv_sec);
+                __put_user(st.st_ctime, &target_stx->stx_ctime.tv_sec);
+                unlock_user_struct(target_stx, arg5, 1);
+            }
+        }
+        break;
+#endif
 #ifdef TARGET_NR_olduname
     case TARGET_NR_olduname:
         goto unimplemented;
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index abf94b8..34cc6e0 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2530,4 +2530,42 @@ struct target_user_cap_data {
 /* Return size of the log buffer */
 #define TARGET_SYSLOG_ACTION_SIZE_BUFFER   10
 
+struct target_statx_timestamp {
+   int64_t tv_sec;
+   uint32_t tv_nsec;
+   int32_t __reserved;
+};
+
+struct target_statx {
+   /* 0x00 */
+   uint32_t stx_mask;       /* What results were written [uncond] */
+   uint32_t stx_blksize;    /* Preferred general I/O size [uncond] */
+   uint64_t stx_attributes; /* Flags conveying information about the file */
+   /* 0x10 */
+   uint32_t stx_nlink;      /* Number of hard links */
+   uint32_t stx_uid;        /* User ID of owner */
+   uint32_t stx_gid;        /* Group ID of owner */
+   uint16_t stx_mode;       /* File mode */
+   uint16_t __spare0[1];
+   /* 0x20 */
+   uint64_t stx_ino;        /* Inode number */
+   uint64_t stx_size;       /* File size */
+   uint64_t stx_blocks;     /* Number of 512-byte blocks allocated */
+   uint64_t stx_attributes_mask; /* Mask to show what's supported in
+                                    stx_attributes */
+   /* 0x40 */
+   struct target_statx_timestamp  stx_atime;  /* Last access time */
+   struct target_statx_timestamp  stx_btime;  /* File creation time */
+   struct target_statx_timestamp  stx_ctime;  /* Last attribute change time */
+   struct target_statx_timestamp  stx_mtime;  /* Last data modification time */
+   /* 0x80 */
+   uint32_t stx_rdev_major;   /* Device ID of special file [if bdev/cdev] */
+   uint32_t stx_rdev_minor;
+   uint32_t stx_dev_major; /* ID of device containing file [uncond] */
+   uint32_t stx_dev_minor;
+   /* 0x90 */
+   uint64_t __spare2[14];  /* Spare space for future expansion */
+   /* 0x100 */
+};
+
 #endif
-- 
2.7.4
