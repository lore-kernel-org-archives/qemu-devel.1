Received: from eggs.gnu.org ([2001:4830:134:3::10]:40854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ckAAK-00044K-4u
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 08:56:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ckAAG-0001A5-V5
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 08:56:08 -0500
Received: from chuckie.co.uk ([82.165.15.123]:56414
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ckAAG-00019Z-HP
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 08:56:04 -0500
References: <148856193073.554.6631259860971664030.stgit@bahia>
	<ef91a081-c25f-881e-eb60-90798df36a5a@redhat.com>
	<ebe5c30c-0af6-7f5b-15bf-4626773a2a9d@redhat.com>
	<20170304122139.63796173@bahia.lan>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <9a2499fe-c082-eb29-ddde-c259a0629954@ilande.co.uk>
Date: Sat, 4 Mar 2017 13:55:47 +0000
MIME-Version: 1.0
In-Reply-To: <20170304122139.63796173@bahia.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix vulnerability in openat_dir()
 and local_unlinkat_common()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On 04/03/17 11:21, Greg Kurz wrote:

> On Fri, 3 Mar 2017 17:43:49 -0600
> Eric Blake <eblake@redhat.com> wrote:
> 
>> On 03/03/2017 12:14 PM, Eric Blake wrote:
>>> On 03/03/2017 11:25 AM, Greg Kurz wrote:  
>>>> We should pass O_NOFOLLOW otherwise openat() will follow symlinks and make
>>>> QEMU vulnerable.
>>>>
>>>> O_PATH was used as an optimization: the fd returned by openat_dir() is only
>>>> passed to openat() actually, so we don't really need to reach the underlying
>>>> filesystem.
>>>>
>>>> O_NOFOLLOW | O_PATH isn't an option: if name is a symlink, openat() will
>>>> return a fd, forcing us to do some other syscall to detect we have a
>>>> symlink. Also, O_PATH doesn't exist in glibc 2.13 and older.  
>>>
>>> But the very next use of openat(fd, ) should fail with EBADF if fd is  
>>
>> or ENOTDIR, actually
>>
>>> not a directory, so you don't need any extra syscalls.  I agree that we
>>> _need_ O_NOFOLLOW, but I'm not yet convinced that we must avoid O_PATH
>>> where it works.
>>>
>>> I'm in the middle of writing a test program to probe kernel behavior and
>>> demonstrate (at least to myself) whether there are scenarios where
>>> O_PATH makes it possible to open something where omitting it did not,
>>> while at the same time validating that O_NOFOLLOW doesn't cause problems
>>> if a symlink-fd is returned instead of a directory fd, based on our
>>> subsequent use of that fd in a *at call.  
>>
>> My test case is below.  Note that based on my testing, I think you want
>> a v2 of this patch, which does:
>>
> 
> Yeah, #12 and #13 in your test case show that we're safe because O_DIRECTORY
> causes openat() to fail with EISDIR right away (we won't have to worry about
> an hypothetical symlink-fd).
> 
>> #ifndef O_PATH
>> #define O_PATH 0
>> #endif
>>
> 
> It is acceptable to ignore O_PATH here because we have O_DIRECTORY, and
> we know openat_dir() will hence fail. But this code sits in a header
> file, and we probably don't want O_PATH to be silently converted to 0 in
> other potential cases where it is used without O_DIRECTORY.
> 
> I'd rather do something like the following then:
> 
> #ifdef O_PATH
> #define OPENAT_DIR_O_PATH O_PATH
> #else
> #define OPENAT_DIR_O_PATH 0
> #endif
> 
> Makes sense ?

I can confirm that the revised version of the original patch below fixes
the build issue for me.

Given that I don't have any configurations set up for 9pfs then I don't
have an easy way to verify the security aspects of the patch but it
looks like Eric's tests have verified this.


diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 01467d2..96c1736 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -959,7 +959,7 @@ static int local_unlinkat_common(FsContext *ctx, int
dirfd, const char *name,
         if (flags == AT_REMOVEDIR) {
             int fd;

-            fd = openat(dirfd, name, O_RDONLY | O_DIRECTORY | O_PATH);
+            fd = openat_dir(dirfd, name);
             if (fd == -1) {
                 goto err_out;
             }
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 091f3ce..c26ed1b 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -20,9 +20,16 @@ static inline void close_preserve_errno(int fd)
     errno = serrno;
 }

+#ifdef O_PATH
+#define OPENAT_DIR_O_PATH O_PATH
+#else
+#define OPENAT_DIR_O_PATH 0
+#endif
+
 static inline int openat_dir(int dirfd, const char *name)
 {
-    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | O_PATH);
+    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | OPENAT_DIR_O_PATH |
+                               O_NOFOLLOW);
 }

 static inline int openat_file(int dirfd, const char *name, int flags,



ATB,

Mark.
