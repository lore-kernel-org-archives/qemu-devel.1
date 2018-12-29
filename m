Received: from eggs.gnu.org ([208.118.235.92]:42243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tytso@mit.edu>) id 1gd4Jf-00022t-F1
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 21:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tytso@mit.edu>) id 1gd46k-0003Ot-GE
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 21:12:13 -0500
Received: from mail-eopbgr810095.outbound.protection.outlook.com
	([40.107.81.95]:13888
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tytso@mit.edu>) id 1gd46k-0003Iz-07
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 21:12:10 -0500
Date: Fri, 28 Dec 2018 21:11:57 -0500
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Message-ID: <20181229021157.GG5864@mit.edu>
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
	<CAFEAcA92m4vhzjJ+B=mP_o6Wfhx1XSKo3uWxah3osh=u5UXFuw@mail.gmail.com>
	<9C6A7D45-CF53-4C61-B5DD-12CA0D419972@dilger.ca>
	<CAFEAcA9W+JK7_TrtTnL1P2ES1knNPJX9wcUvhfLwxLq9augq1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9W+JK7_TrtTnL1P2ES1knNPJX9wcUvhfLwxLq9augq1w@mail.gmail.com>
Subject: Re: [Qemu-devel] d_off field in struct dirent and 32-on-64 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andreas Dilger <adilger@dilger.ca>, Florian Weimer <fw@deneb.enyo.de>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, lucho@ionkov.net, libc-alpha@sourceware.org, Arnd Bergmann <arnd@arndb.de>, ericvh@gmail.com, hpa@zytor.com, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, rminnich@sandia.gov, v9fs-developer@lists.sourceforge.net

On Fri, Dec 28, 2018 at 11:18:18AM +0000, Peter Maydell wrote:
> In general inodes and offsets start from 0 and work up --
> so almost all of the time they don't actually overflow.
> The problem with ext4 directory hash "offsets" is that they
> overflow all the time and immediately, so instead of "works
> unless you have a weird edge case" like all the other filesystems,h
> it's "never works".

Actually, XFS uses the inode number to encode the location of the
inode (it doesn't have a fixed inode table, so it's effectively the
block number shifted left by 3 or 4 bits, with the low bits indicating
the slot in the 4k block).  It has a hack to provide backwards
compatibility for 32-bit API's, but there is a similar, "oh, we're on
a non-paleolithic CPU, let's use the full 64-bits" sort of logic that
ext4 has.

> The problem is that there is no 32-bit API in some cases
> (unless I have misunderstood the kernel code) -- not all
> host architectures implement compat syscalls or allow them
> to be called from 64-bit processes or implement all the older
> syscall variants that had smaller offets. If there was a guaranteed
> "this syscall always exists and always gives me 32-bit offsets"
> we could use it.

Are there going to be cases where a process or a thread will sometimes
want the 64-bit interface, and sometimes want the 32-bit interface?
Or is it always going to be one or the other?  I wonder if we could
simply add a new flag to the process personality(2) flags.

> Yes, that has been suggested, but it seemed a bit dubious
> to bake in knowledge of ext4's internal implementation details.
> Can we rely on this as an ABI promise that will always work
> for all versions of all file systems going forwards?

Yeah, that seems dubious because I'm pretty sure there are other file
systems that may have their own 32/64-bit quirks.

						- Ted
