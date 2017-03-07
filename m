Received: from eggs.gnu.org ([2001:4830:134:3::10]:35796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hwertz10@gmail.com>) id 1clOir-0006FA-EA
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 18:40:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hwertz10@gmail.com>) id 1clOiq-0004cR-Dz
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 18:40:53 -0500
Received: from mail-vk0-x22d.google.com ([2607:f8b0:400c:c05::22d]:35570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hwertz10@gmail.com>) id 1clOiq-0004by-82
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 18:40:52 -0500
Received: by mail-vk0-x22d.google.com with SMTP id x75so889415vke.2
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 15:40:50 -0800 (PST)
MIME-Version: 1.0
From: Henry Wertz <hwertz10@gmail.com>
Date: Tue, 7 Mar 2017 17:40:49 -0600
Message-ID: <CAOuPqTEAw67784gswB_Xz+S1LwfmWhSqXK0DgFt05jb=hm2H5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Small patch for getdents syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I have a trivial, 1-line patch for getdents function; due to use of
unsigned long, the struct on 64-bit and 32-bit systems is not the same.
qemu is aware of this, however it currently only checks for a 32-bit target
on 64-bit host case; in my case, I'm running 64-bit target on 32-bit host
(x86-64 binaries on a 32-bit ARM).

My use case for this patch, I have Android Studio on my (32-bit ARM)
chromebook -- thank goodness I got the 4GB model!  Since Android Studio is
java, that worked; but it calls aapt from build tools.  Up through 23.x.x
(which is build for 32-bit x86) it worked.  With 25.0.0 (and 24.x.x
version) aapt is now built for 64-bit x86-64; it would give an odd error
about a directory being invalid.  By comparing strace between qemu and real
x86-64, I found getdents was behaving differently.  WIth this patch aapt
completes.

I really wasn't sure if this would be better this way ("if target != host")
or if something like  "if (target==32 && host==64) || (target==64 &&
host==32)" would be preferrable.
---------------------------------------------------

Signed-off-by: Henry Wertz <hwertz10@gmail.com>


*** linux-user/syscall.c~       2017-03-04 10:31:14.000000000 -0600
--- linux-user/syscall.c        2017-03-07 17:08:24.615399116 -0600
***************
*** 9913,9921 ****
  #endif
  #ifdef TARGET_NR_getdents
      case TARGET_NR_getdents:
  #ifdef __NR_getdents
! #if TARGET_ABI_BITS == 32 && HOST_LONG_BITS == 64
          {
              struct target_dirent *target_dirp;
              struct linux_dirent *dirp;
              abi_long count = arg3;
--- 9913,9921 ----
  #endif
  #ifdef TARGET_NR_getdents
      case TARGET_NR_getdents:
  #ifdef __NR_getdents
! #if TARGET_ABI_BITS != HOST_LONG_BITS
          {
              struct target_dirent *target_dirp;
              struct linux_dirent *dirp;
              abi_long count = arg3;
