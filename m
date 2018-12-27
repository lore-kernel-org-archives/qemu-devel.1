Received: from eggs.gnu.org ([208.118.235.92]:33981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gcZfh-000561-MZ
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 12:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gcZfg-0006PB-Al
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 12:42:13 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gcZfe-0006L3-KZ
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 12:42:12 -0500
Received: by mail-ot1-x344.google.com with SMTP id i20so16855773otl.0
	for <qemu-devel@nongnu.org>; Thu, 27 Dec 2018 09:42:10 -0800 (PST)
MIME-Version: 1.0
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
In-Reply-To: <87bm56vqg4.fsf@mid.deneb.enyo.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Dec 2018 17:41:58 +0000
Message-ID: <CAFEAcA92m4vhzjJ+B=mP_o6Wfhx1XSKo3uWxah3osh=u5UXFuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] d_off field in struct dirent and 32-on-64 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-ext4@vger.kernel.org, lucho@ionkov.net, libc-alpha@sourceware.org, Arnd Bergmann <arnd@arndb.de>, ericvh@gmail.com, hpa@zytor.com, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, rminnich@sandia.gov, v9fs-developer@lists.sourceforge.net

On Thu, 27 Dec 2018 at 17:19, Florian Weimer <fw@deneb.enyo.de> wrote:
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

Yes -- look for hash2pos() and friends in fs/ext4/dir.c.
The ext4 code in the kernel uses a 32 bit hash if (a) the kernel
is 32 bit (b) this is a compat syscall (b) some other bit of
the kernel asked it to via the FMODE_32BITHASH flag (currently only
NFS does that I think).

As you note, this causes breakage for userspace programs which
need to implement an API/ABI with 32-bit offset but which only
have access to the kernel's 64-bit offset API/ABI.

I think the best fix for this would be for the kernel to either
(a) consistently use a 32-bit hash or (b) to provide an API
so that userspace can use the FMODE_32BITHASH flag the way
that kernel-internal users already can.

I couldn't think of or find any existing way for userspace
to get the right results here, which is why
32-bit-guest-on-64-bit-host QEMU doesn't work on these filesystems
(depending on what exactly the guest's libc etc do).

> the 32-bit getdents system call emulation in a 64-bit qemu-user
> process would just silently truncate the d_off field as part of
> the translation, not reporting an error.
> [...]
> This truncation has always been a bug; it breaks telldir/seekdir
> at least in some cases.

Yes; you can't fit a quart into a pint pot, so if the guest
only handles 32-bit offsets then truncation is about all we
can do. This works fine if offsets are offsets, assuming the
directory isn't so enormous it would have broken the guest
anyway. I'm not aware of any issues with this other than the
oddball ext4 offsets-are-hashes situation -- could you expand
on the telldir/seekdir issue? (I suppose we should probably
make QEMU's syscall emulation layer return "no more entries"
rather than entries with truncated hashes.)

thanks
-- PMM
