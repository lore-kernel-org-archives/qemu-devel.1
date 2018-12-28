Received: from eggs.gnu.org ([208.118.235.92]:43056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gcqGP-0007wi-Hd
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 06:25:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gcq9v-0004pR-Qk
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 06:18:33 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gcq9v-0004oT-5E
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 06:18:31 -0500
Received: by mail-oi1-x241.google.com with SMTP id a77so17126767oii.5
	for <qemu-devel@nongnu.org>; Fri, 28 Dec 2018 03:18:30 -0800 (PST)
MIME-Version: 1.0
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
	<CAFEAcA92m4vhzjJ+B=mP_o6Wfhx1XSKo3uWxah3osh=u5UXFuw@mail.gmail.com>
	<9C6A7D45-CF53-4C61-B5DD-12CA0D419972@dilger.ca>
In-Reply-To: <9C6A7D45-CF53-4C61-B5DD-12CA0D419972@dilger.ca>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Dec 2018 11:18:18 +0000
Message-ID: <CAFEAcA9W+JK7_TrtTnL1P2ES1knNPJX9wcUvhfLwxLq9augq1w@mail.gmail.com>
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
To: Andreas Dilger <adilger@dilger.ca>
Cc: Florian Weimer <fw@deneb.enyo.de>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, lucho@ionkov.net, libc-alpha@sourceware.org, Arnd Bergmann <arnd@arndb.de>, ericvh@gmail.com, hpa@zytor.com, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, rminnich@sandia.gov, v9fs-developer@lists.sourceforge.net

On Fri, 28 Dec 2018 at 00:23, Andreas Dilger <adilger@dilger.ca> wrote:
> On Dec 27, 2018, at 10:41 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> > As you note, this causes breakage for userspace programs which
> > need to implement an API/ABI with 32-bit offset but which only
> > have access to the kernel's 64-bit offset API/ABI.
>
> This is (IMHO) a bit of an oxymoron, isn't it?  Applications using
> the 64-bit API, but storing the value in a 32-bit field?

I didn't say "which choose to store the value in a 32-bit field",
I said "which have to implement an API/ABI which has 32-bit fields".
In QEMU's case, we use the host kernel's ABI, which has 64-bit
offset fields. We implement a syscall ABI for the guest binary
we are running under emulation, which may have 32-bit offset fields
(for instance if we are running a 32-bit Arm binary.) Both of
these ABIs are fixed -- QEMU doesn't have a choice here, it
just has to make the best effort it can with what the host kernel
provides it, to provide the semantics the guest binary needs.
My suggestion in this thread is that the host kernel provides
a wider range of facilities so that QEMU can do the job it's
trying to do.

>  The same
> problem would exist for filesystems with 64-bit inodes or 64-bit
> file offsets trying to store these values in 32-bit variables.
> It might work most of the time, but it can also break randomly.

In general inodes and offsets start from 0 and work up --
so almost all of the time they don't actually overflow.
The problem with ext4 directory hash "offsets" is that they
overflow all the time and immediately, so instead of "works
unless you have a weird edge case" like all the other filesystems,
it's "never works".

> > I think the best fix for this would be for the kernel to either
> > (a) consistently use a 32-bit hash or (b) to provide an API
> > so that userspace can use the FMODE_32BITHASH flag the way
> > that kernel-internal users already can.
>
> It would be relatively straight forward to add a "32bitapi" mount
> option to return a 32-bit directory hash to userspace for operations
> on that mountpoint (ext4 doesn't have 64-bit inode numbers yet).
> However, I can't think of an easy way to do this on a per-process
> basis without just having it call the 32-bit API directly.

The problem is that there is no 32-bit API in some cases
(unless I have misunderstood the kernel code) -- not all
host architectures implement compat syscalls or allow them
to be called from 64-bit processes or implement all the older
syscall variants that had smaller offets. If there was a guaranteed
"this syscall always exists and always gives me 32-bit offsets"
we could use it.

> For ext4 at least, you could just shift the high 32-bit part of
> the 64-bit hash down into a 32-bit value in telldir(), and
> shift it back up when seekdir() is called.

Yes, that has been suggested, but it seemed a bit dubious
to bake in knowledge of ext4's internal implementation details.
Can we rely on this as an ABI promise that will always work
for all versions of all file systems going forwards?

thanks
-- PMM
