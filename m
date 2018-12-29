Received: from eggs.gnu.org ([208.118.235.92]:49131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asmadeus@notk.org>) id 1gd4iq-0000D6-Jp
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 21:51:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asmadeus@notk.org>) id 1gd4VQ-0001jN-AA
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 21:37:43 -0500
Received: from nautica.notk.org ([91.121.71.147]:33538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <asmadeus@notk.org>) id 1gd4VQ-0001iO-3p
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 21:37:40 -0500
Date: Sat, 29 Dec 2018 03:37:21 +0100
From: Dominique Martinet <asmadeus@codewreck.org>
Message-ID: <20181229023721.GA9291@nautica>
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
	<CAFEAcA92m4vhzjJ+B=mP_o6Wfhx1XSKo3uWxah3osh=u5UXFuw@mail.gmail.com>
	<9C6A7D45-CF53-4C61-B5DD-12CA0D419972@dilger.ca>
	<CAFEAcA9W+JK7_TrtTnL1P2ES1knNPJX9wcUvhfLwxLq9augq1w@mail.gmail.com>
	<20181229021157.GG5864@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181229021157.GG5864@mit.edu>
Subject: Re: [Qemu-devel] d_off field in struct dirent and 32-on-64 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Peter Maydell <peter.maydell@linaro.org>, Andreas Dilger <adilger@dilger.ca>, Florian Weimer <fw@deneb.enyo.de>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, lucho@ionkov.net, libc-alpha@sourceware.org, Arnd Bergmann <arnd@arndb.de>, ericvh@gmail.com, hpa@zytor.com, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, rminnich@sandia.gov, v9fs-developer@lists.sourceforge.net

Theodore Y. Ts'o wrote on Fri, Dec 28, 2018:
> > The problem is that there is no 32-bit API in some cases
> > (unless I have misunderstood the kernel code) -- not all
> > host architectures implement compat syscalls or allow them
> > to be called from 64-bit processes or implement all the older
> > syscall variants that had smaller offets. If there was a guaranteed
> > "this syscall always exists and always gives me 32-bit offsets"
> > we could use it.
> 
> Are there going to be cases where a process or a thread will sometimes
> want the 64-bit interface, and sometimes want the 32-bit interface?
> Or is it always going to be one or the other?  I wonder if we could
> simply add a new flag to the process personality(2) flags.

That would likely work for qemu user, but the qemu system+9p case is
going to be more painful..
More precisely, the 9p protocol does not plan for anything other than
64bit offset so if the vfs needs to hand out a 32bit offset we'll need
to make a correspondance table between the 32bit offsets we hand off and
the 64bit ones to use; unless some flag can be passed at lopen to tell
the server to always hand out 32bit offsets for this directory... And if
we do that then 9p servers will need a way to use both APIs in parallel
for both types of directories.

(Although I'd rather not have to do either in the first place, keeping
track of all used offsets just in case seems like a waste even if we
only do it for processes in 32bit mode, and a new flag would be a
protocol change with 9p not being designed to catter for subtle protocol
changes so would be rather painful to roll out)


No bright idea here, sorry.
-- 
Dominique Martinet | Asmadeus
