Received: from eggs.gnu.org ([2001:4830:134:3::10]:36183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFGcv-0001hU-07
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFGcq-0006EO-UV
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:06:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFGcq-0006Ca-Kh
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:06:08 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4T94E4o059698
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 05:06:07 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aqfqjwbwe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 05:06:07 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 29 May 2017 10:06:04 +0100
From: Greg Kurz <groug@kaod.org>
Date: Mon, 29 May 2017 11:05:36 +0200
In-Reply-To: <1496048740-26578-1-git-send-email-groug@kaod.org>
References: <1496048740-26578-1-git-send-email-groug@kaod.org>
Message-Id: <1496048740-26578-8-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 07/11] util: drop old utimensat() compat code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kurz <groug@kaod.org>

Now that 9pfs and virtfs-proxy-helper have been converted to utimensat(),
we don't need to keep qemu_utimens() anymore.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 configure                 | 22 ----------------------
 include/sysemu/os-posix.h | 11 -----------
 util/oslib-posix.c        | 47 -----------------------------------------------
 3 files changed, 80 deletions(-)

diff --git a/configure b/configure
index 1a5ee4b909b8..0586ec9c64de 100755
--- a/configure
+++ b/configure
@@ -3629,25 +3629,6 @@ if compile_prog "" "" ; then
   inotify1=yes
 fi
 
-# check if utimensat and futimens are supported
-utimens=no
-cat > $TMPC << EOF
-#define _ATFILE_SOURCE
-#include <stddef.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-
-int main(void)
-{
-    utimensat(AT_FDCWD, "foo", NULL, 0);
-    futimens(0, NULL);
-    return 0;
-}
-EOF
-if compile_prog "" "" ; then
-  utimens=yes
-fi
-
 # check if pipe2 is there
 pipe2=no
 cat > $TMPC << EOF
@@ -5434,9 +5415,6 @@ fi
 if test "$curses" = "yes" ; then
   echo "CONFIG_CURSES=y" >> $config_host_mak
 fi
-if test "$utimens" = "yes" ; then
-  echo "CONFIG_UTIMENSAT=y" >> $config_host_mak
-fi
 if test "$pipe2" = "yes" ; then
   echo "CONFIG_PIPE2=y" >> $config_host_mak
 fi
diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index 900bdcb45ad0..629c8c648b7a 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -51,17 +51,6 @@ int os_mlock(void);
 typedef struct timeval qemu_timeval;
 #define qemu_gettimeofday(tp) gettimeofday(tp, NULL)
 
-#ifndef CONFIG_UTIMENSAT
-#ifndef UTIME_NOW
-# define UTIME_NOW     ((1l << 30) - 1l)
-#endif
-#ifndef UTIME_OMIT
-# define UTIME_OMIT    ((1l << 30) - 2l)
-#endif
-#endif
-typedef struct timespec qemu_timespec;
-int qemu_utimens(const char *path, const qemu_timespec *times);
-
 bool is_daemonized(void);
 
 /**
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 4d9189e9efcf..7e28c161b257 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -207,53 +207,6 @@ int qemu_pipe(int pipefd[2])
     return ret;
 }
 
-int qemu_utimens(const char *path, const struct timespec *times)
-{
-    struct timeval tv[2], tv_now;
-    struct stat st;
-    int i;
-#ifdef CONFIG_UTIMENSAT
-    int ret;
-
-    ret = utimensat(AT_FDCWD, path, times, AT_SYMLINK_NOFOLLOW);
-    if (ret != -1 || errno != ENOSYS) {
-        return ret;
-    }
-#endif
-    /* Fallback: use utimes() instead of utimensat() */
-
-    /* happy if special cases */
-    if (times[0].tv_nsec == UTIME_OMIT && times[1].tv_nsec == UTIME_OMIT) {
-        return 0;
-    }
-    if (times[0].tv_nsec == UTIME_NOW && times[1].tv_nsec == UTIME_NOW) {
-        return utimes(path, NULL);
-    }
-
-    /* prepare for hard cases */
-    if (times[0].tv_nsec == UTIME_NOW || times[1].tv_nsec == UTIME_NOW) {
-        gettimeofday(&tv_now, NULL);
-    }
-    if (times[0].tv_nsec == UTIME_OMIT || times[1].tv_nsec == UTIME_OMIT) {
-        stat(path, &st);
-    }
-
-    for (i = 0; i < 2; i++) {
-        if (times[i].tv_nsec == UTIME_NOW) {
-            tv[i].tv_sec = tv_now.tv_sec;
-            tv[i].tv_usec = tv_now.tv_usec;
-        } else if (times[i].tv_nsec == UTIME_OMIT) {
-            tv[i].tv_sec = (i == 0) ? st.st_atime : st.st_mtime;
-            tv[i].tv_usec = 0;
-        } else {
-            tv[i].tv_sec = times[i].tv_sec;
-            tv[i].tv_usec = times[i].tv_nsec / 1000;
-        }
-    }
-
-    return utimes(path, &tv[0]);
-}
-
 char *
 qemu_get_local_state_pathname(const char *relative_pathname)
 {
-- 
2.7.4
