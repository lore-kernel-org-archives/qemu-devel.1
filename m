Received: from eggs.gnu.org ([2001:4830:134:3::10]:53425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF7-0005x9-Hq
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF5-0007lR-T8
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:05 -0400
Received: from mifritscher.de ([188.40.170.105]:32944
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxtF5-0007kj-Iv
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:03 -0400
From: Michael Fritscher <michael@fritscher.net>
Date: Fri, 29 Sep 2017 13:13:11 +0200
Message-Id: <20170929111323.6308-7-michael@fritscher.net>
In-Reply-To: <20170929111323.6308-1-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
Subject: [Qemu-devel] [PATCH 06/18] Stub out functions for 9pfs.
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org
Cc: Michael Fritscher <michael@fritscher.net>
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Michael Fritscher <michael@fritscher.net>
---
 include/sysemu/os-win32.h | 226 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 226 insertions(+)

diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index d344516987..26bb0dae66 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -268,4 +268,230 @@ struct statfs {
 
 /* from glibc/dirent/dirent.h */
 #define DT_UNKNOWN 0
+
+/* from gnulib */
+/* Find the first occurrence of C in S or the final NUL byte.  */
+static inline char *
+strchrnul(const char *s, int c_in)
+{
+    /* On 32-bit hardware, choosing longword to be a 32-bit unsigned
+       long instead of a 64-bit uintmax_t tends to give better
+       performance. On 64-bit hardware, unsigned long is generally 64
+       bits already. Change this typedef to experiment with
+       performance. */
+    typedef unsigned long int longword;
+
+    const unsigned char *char_ptr;
+    const longword *longword_ptr;
+    longword repeated_one;
+    longword repeated_c;
+    unsigned char c;
+
+    c = (unsigned char) c_in;
+
+    /* Handle the first few bytes by reading one byte at a time.
+       Do this until CHAR_PTR is aligned on a longword boundary. */
+    for (char_ptr = (const unsigned char *) s;
+             (size_t) char_ptr % sizeof(longword) != 0;
+             ++char_ptr) {
+        if (!*char_ptr || *char_ptr == c) {
+            return (char *) char_ptr;
+        }
+    }
+
+    longword_ptr = (const longword *) char_ptr;
+
+    /* All these elucidatory comments refer to 4-byte longwords,
+       but the theory applies equally well to any size longwords. */
+
+    /* Compute auxiliary longword values:
+       repeated_one is a value which has a 1 in every byte.
+       repeated_c has c in every byte. */
+    repeated_one = 0x01010101;
+    repeated_c = c | (c << 8);
+    repeated_c |= repeated_c << 16;
+    if (0xffffffffU < (longword) -1) {
+        repeated_one |= repeated_one << 31 << 1;
+        repeated_c |= repeated_c << 31 << 1;
+        if (8 < sizeof(longword)) {
+            size_t i;
+
+            for (i = 64; i < sizeof(longword) * 8; i *= 2) {
+                repeated_one |= repeated_one << i;
+                repeated_c |= repeated_c << i;
+            }
+        }
+    }
+
+    /* Instead of the traditional loop which tests each byte, we will
+       test a longword at a time. The tricky part is testing if *any of
+       the four* bytes in the longword in question are equal to NUL or
+       c.    We first use an xor with repeated_c. This reduces the task
+       to testing whether *any of the four* bytes in longword1 or
+       longword2 is zero.
+
+       Let's consider longword1.    We compute tmp =
+           ((longword1 - repeated_one) & ~longword1) & (repeated_one << 7).
+       That is, we perform the following operations:
+           1. Subtract repeated_one.
+           2. & ~longword1.
+           3. & a mask consisting of 0x80 in every byte.
+       Consider what happens in each byte:
+           - If a byte of longword1 is zero, step 1 and 2 transform it into 0xff,
+               and step 3 transforms it into 0x80. A carry can also be propagated
+               to more significant bytes.
+           - If a byte of longword1 is nonzero, let its lowest 1 bit be at
+               position k (0 <= k <= 7); so the lowest k bits are 0. After step 1,
+               the byte ends in a single bit of value 0 and k bits of value 1.
+               After step 2, the result is just k bits of value 1: 2^k - 1. After
+               step 3, the result is 0. And no carry is produced.
+       So, if longword1 has only non-zero bytes, tmp is zero.
+       Whereas if longword1 has a zero byte, call j the position of the least
+       significant zero byte. Then the result has a zero at positions 0, ...,
+       j-1 and a 0x80 at position j. We cannot predict the result at the more
+       significant bytes (positions j+1..3), but it does not matter since we
+       already have a non-zero bit at position 8*j+7.
+
+       The test whether any byte in longword1 or longword2 is zero is equivalent
+       to testing whether tmp1 is nonzero or tmp2 is nonzero. We can combine
+       this into a single test, whether (tmp1 | tmp2) is nonzero.
+
+       This test can read more than one byte beyond the end of a string,
+       depending on where the terminating NUL is encountered. However,
+       this is considered safe since the initialization phase ensured
+       that the read will be aligned, therefore, the read will not cross
+       page boundaries and will not cause a fault. */
+
+    while (1) {
+        longword longword1 = *longword_ptr ^ repeated_c;
+        longword longword2 = *longword_ptr;
+
+        if (((((longword1 - repeated_one) & ~longword1)
+            | ((longword2 - repeated_one) & ~longword2))
+            & (repeated_one << 7)) != 0) {
+                break;
+            }
+        longword_ptr++;
+    }
+
+    char_ptr = (const unsigned char *) longword_ptr;
+
+    /* At this point, we know that one of the sizeof(longword) bytes
+       starting at char_ptr is == 0 or == c. On little-endian machines,
+       we could determine the first such byte without any further memory
+       accesses, just by looking at the tmp result from the last loop
+       iteration. But this does not work on big-endian machines.
+       Choose code that works in both cases. */
+
+    char_ptr = (unsigned char *) longword_ptr;
+    while (*char_ptr && (*char_ptr != c)) {
+        char_ptr++;
+    }
+    return (char *) char_ptr;
+}
+
+static inline int openat(int dirfd, const char *pathname, int flags, ...)
+{
+    return 0;
+}
+
+static inline int renameat(int olddirfd, const char *oldpath,
+                           int newdirfd, const char *newpath)
+{
+    return 0;
+}
+
+static inline int unlinkat(int dirfd, const char *pathname, int flags)
+{
+    return 0;
+}
+
+static inline int fstatat(int dirfd, const char *pathname, struct stat *buf,
+                          int flags)
+{
+    memset(buf, 0, sizeof(struct stat));
+    return 0;
+}
+
+static inline int mkdirat(int dirfd, const char *pathname, mode_t mode)
+{
+    return 0;
+}
+
+static inline ssize_t readlinkat(int dirfd, const char *pathname,
+                                 char *buf, size_t bufsiz)
+{
+    return 0;
+}
+
+static inline int mknodat(int dirfd, const char *pathname, mode_t mode, dev_t dev)
+{
+    return 0;
+}
+
+static inline int symlinkat(const char *target, int newdirfd, const char *linkpath)
+{
+    return 0;
+}
+
+static inline int linkat(int olddirfd, const char *oldpath,
+                         int newdirfd, const char *newpath, int flags)
+{
+    return 0;
+}
+
+static inline int fchownat(int dirfd, const char *pathname,
+                           uid_t owner, gid_t group, int flags)
+{
+    return 0;
+}
+
+static inline int fstatfs(int fd, struct statfs *buf)
+{
+    memset(buf, 0, sizeof(struct statfs));
+    buf->f_type = 0x01021997; /* V9FS_MAGIC */
+    buf->f_bsize = 4096;
+    buf->f_blocks = 4000000;
+    buf->f_bfree = 3000000;
+    buf->f_bavail = 2999000;
+    buf->f_files = 1000000;
+    buf->f_ffree = 800000;
+    buf->f_namelen = NAME_MAX;
+    return 0;
+}
+
+static inline int utimensat(int dirfd, const char *pathname,
+                            const struct timespec times[2], int flags)
+{
+    return 0;
+}
+
+/* pretend success */
+static inline int setxattr(const char *path, const char *name,
+                    const void *value, size_t size, int flags)
+{
+    return 0;
+}
+
+static inline ssize_t fgetxattr(int fd, const char *name,
+                         void *value, size_t size)
+{
+    return 0;
+}
+
+static inline ssize_t lgetxattr(const char *path, const char *name,
+                                void *value, size_t size)
+{
+    return 0;
+}
+
+/* from fcntl.h*/
+#define F_SETFL 6
+#define AT_SYMLINK_NOFOLLOW 0x100
+
+static inline int fcntl(int fd, int cmd, ... /* arg */)
+{
+    return 0;
+}
+
 #endif
-- 
2.13.2.windows.1
