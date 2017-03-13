Received: from eggs.gnu.org ([2001:4830:134:3::10]:58300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnNY3-0000pO-3w
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnNY2-0007Ic-7L
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:49:55 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnNY2-0007I7-0o
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:49:54 -0400
Received: by mail-wm0-x22f.google.com with SMTP id v186so37066303wmd.0
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 03:49:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOuPqTEAw67784gswB_Xz+S1LwfmWhSqXK0DgFt05jb=hm2H5w@mail.gmail.com>
References: <CAOuPqTEAw67784gswB_Xz+S1LwfmWhSqXK0DgFt05jb=hm2H5w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Mar 2017 11:49:32 +0100
Message-ID: <CAFEAcA_=nPsgaN0pPuS=sUU_VdvXf3X83YV27jMO2yF3ddyL6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Small patch for getdents syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Henry Wertz <hwertz10@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <lvivier@redhat.com>

On 8 March 2017 at 00:40, Henry Wertz <hwertz10@gmail.com> wrote:
> I have a trivial, 1-line patch for getdents function; due to use of
> unsigned long, the struct on 64-bit and 32-bit systems is not the same.
> qemu is aware of this, however it currently only checks for a 32-bit target
> on 64-bit host case; in my case, I'm running 64-bit target on 32-bit host
> (x86-64 binaries on a 32-bit ARM).
>
> My use case for this patch, I have Android Studio on my (32-bit ARM)
> chromebook -- thank goodness I got the 4GB model!  Since Android Studio is
> java, that worked; but it calls aapt from build tools.  Up through 23.x.x
> (which is build for 32-bit x86) it worked.  With 25.0.0 (and 24.x.x
> version) aapt is now built for 64-bit x86-64; it would give an odd error
> about a directory being invalid.  By comparing strace between qemu and real
> x86-64, I found getdents was behaving differently.  WIth this patch aapt
> completes.
>
> I really wasn't sure if this would be better this way ("if target != host")
> or if something like  "if (target==32 && host==64) || (target==64 &&
> host==32)" would be preferrable.
> ---------------------------------------------------
>
> Signed-off-by: Henry Wertz <hwertz10@gmail.com>
>
> *** linux-user/syscall.c~       2017-03-04 10:31:14.000000000 -0600
> --- linux-user/syscall.c        2017-03-07 17:08:24.615399116 -0600
> ***************
> *** 9913,9921 ****
>   #endif
>   #ifdef TARGET_NR_getdents
>       case TARGET_NR_getdents:
>   #ifdef __NR_getdents
> ! #if TARGET_ABI_BITS == 32 && HOST_LONG_BITS == 64
>           {
>               struct target_dirent *target_dirp;
>               struct linux_dirent *dirp;
>               abi_long count = arg3;
> --- 9913,9921 ----
>   #endif
>   #ifdef TARGET_NR_getdents
>       case TARGET_NR_getdents:
>   #ifdef __NR_getdents
> ! #if TARGET_ABI_BITS != HOST_LONG_BITS
>           {
>               struct target_dirent *target_dirp;
>               struct linux_dirent *dirp;
>               abi_long count = arg3;

There is a theoretically better way to handle the 64-bit
guest on 32-bit host case: since here you know that the
guest dirent struct is bigger than the host dirent
struct you could read them directly into the guest buffer
and then convert in-place rather than having to malloc
a temporary buffer. The conversion code is a little
bit awkward though because you have to make sure you don't
overwrite host data you haven't read yet, so I think
you would need to start at the end of the buffer and
work backwards. This is basically fixing the #else
part of this code to work for guest > host as well
as for guest == host.

However, since 64-bit-on-32 is not exactly a very common
use case these days I think your patch is an OK fix for
things.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

PS: we prefer 'unified' format diffs; git format-patch
should produce those by default.

thanks
-- PMM
