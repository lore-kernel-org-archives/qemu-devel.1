Received: from eggs.gnu.org ([208.118.235.92]:37067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <adhemerval.zanella@linaro.org>) id 1gcZvu-0001my-BT
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 12:58:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <adhemerval.zanella@linaro.org>) id 1gcZvq-0008Be-8T
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 12:58:58 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:35124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <adhemerval.zanella@linaro.org>)
	id 1gcZvq-00089I-2w
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 12:58:54 -0500
Received: by mail-qt1-x842.google.com with SMTP id v11so20925070qtc.2
	for <qemu-devel@nongnu.org>; Thu, 27 Dec 2018 09:58:53 -0800 (PST)
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Message-ID: <957967d7-5717-8ada-fb30-dfdf19898b6b@linaro.org>
Date: Thu, 27 Dec 2018 15:58:47 -0200
MIME-Version: 1.0
In-Reply-To: <87bm56vqg4.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] d_off field in struct dirent and 32-on-64 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Florian Weimer <fw@deneb.enyo.de>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, libc-alpha@sourceware.org, qemu-devel@nongnu.org, ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net, hpa@zytor.com, arnd@arndb.de



On 27/12/2018 15:18, Florian Weimer wrote:
> We have a bit of an interesting problem with respect to the d_off
> field in struct dirent.
> 
> When running a 64-bit kernel on certain file systems, notably ext4,
> this field uses the full 63 bits even for small directories (strace -v
> output, wrapped here for readability):
> 
> getdents(3, [
>   {d_ino=1494304, d_off=3901177228673045825, d_reclen=40, d_name="authorized_keys", d_type=DT_REG},
>   {d_ino=1494277, d_off=7491915799041650922, d_reclen=24, d_name=".", d_type=DT_DIR},
>   {d_ino=1314655, d_off=9223372036854775807, d_reclen=24, d_name="..", d_type=DT_DIR}
> ], 32768) = 88
> 
> When running in 32-bit compat mode, this value is somehow truncated to
> 31 bits, for both the getdents and the getdents64 (!) system call (at
> least on i386).
> 
> In an effort to simplify support for future architectures which only
> have the getdents64 system call, we changed glibc 2.28 to use the
> getdents64 system call unconditionally, and perform translation if
> necessary.  This translation is noteworthy because it includes
> overflow checking for the d_ino and d_off members of struct dirent.
> We did not initially observe a regression because the kernel performs
> consistent d_off truncation (with the ext4 file system; small
> directories do not show this issue on XFS), so the overflow check does
> not fire.
> 
> However, both qemu-user and the 9p file system can run in such a way
> that the kernel is entered from a 64-bit process, but the actual usage
> is from a 32-bit process:
> 
>   <https://sourceware.org/bugzilla/show_bug.cgi?id=23960>
> 
> I think diagrammatically, this looks like this:
> 
>   guest process  (32-bit)
>     | getdents64, 32-bit UAPI
>   qemu-user (64-bit)
>     | getdents, 64-bit UAPI
>   host kernel (64-bit)
> 
> Or:
> 
>   guest process 
>     | getdents64, 32-bit UAPI
>   guest kernel (64-bit)
>     | 9p over virtio (64-bit d_off in struct p9_dirent)
>   qemu
>     | getdents, 64-bit UAPI
>   host kernel (64-bit)
> 
> Back when we still called getdents, in the first case, the 32-bit
> getdents system call emulation in a 64-bit qemu-user process would
> just silently truncate the d_off field as part of the translation, not
> reporting an error.  The second case is more complicated, and I have
> not figured out where the truncation happens.
> 
> This truncation has always been a bug; it breaks telldir/seekdir at
> least in some cases.  But use of telldir/seekdir is comparatively
> rare.  In contrast, now that we detect d_off overflow in glibc,
> readdir will always fail in the sketched configurations, which is bad.
> (glibc exposes the d_off field to applications, and it cannot know
> whether the application will use it or not, so there is no direct way
> to restrict the overflow error to the telldir/seekdir use case.)
> 
> We could switch glibc to call getdents again if the system call is
> available.  But that merely relies on the existence of the truncation
> bug somewhere else in the file system stack.  This is why I don't
> think it's the right solution, just the path of least resistance.
> 
> I don't want to reimplement the ext4 truncation behavior in glibc (it
> doesn't look like a straightforward truncation), and it wouldn't work
> for the second scenario where we see the 9p file system in the 32-bit
> glibc, not the ext4 file system.  So that's not a good solution.

Also for glibc standpoint, although reverting it back to use getdents 
syscall for non-LFS mode might fix this issue for architectures that
provides non-LFS getdents syscall it won't be a fix for architectures 
that still provides off_t different than off64_t *and* only provides 
getdents64 syscall.

Currently we only have nios2 and csky (unfortunately).  But since generic 
definition for off_t and off64_t still assumes non-LFS support, all new
32-bits ports potentially might carry the issue.

> 
> There is another annoying aspect: The standards expose d_off through
> the telldir function, and that returns long int on all architectures
> (not off_t, so unchanged by _FILE_OFFSET_BITS).  That's mostly a
> userspace issue and thus needing different steps to resolve (possibly
> standards action).
> 
> Any suggestions how to solve this?  Why does the kernel return
> different d_off values for 32-bit and 64-bit processes even when using
> getdents64, for the same directory?
> 
