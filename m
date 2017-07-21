Received: from eggs.gnu.org ([2001:4830:134:3::10]:47206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dYWXe-0008BX-1C
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dYWXc-0008Pj-Ok
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:56:22 -0400
Date: Fri, 21 Jul 2017 13:56:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170721115608.GC4228@noname.redhat.com>
References: <20170721102059.14663-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170721102059.14663-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] block: Do OFD lock check at runtime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>, jsnow@redhat.com, Max Reitz <mreitz@redhat.com>, eblake@redhat.com

Am 21.07.2017 um 12:20 hat Fam Zheng geschrieben:
> This fixes the image opening failure reported by Andrew Baumann:
> 
> > I'm running a recent Linux build of qemu on Windows Subsystem for Linux (WSL)
> > which doesn't appear to implement file locking:
> >
> > $ qemu-system-aarch64 ... -drive file=test.vhdx,if=none,id=hd0 -device virtio-blk-pci,drive=hd0
> > qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to unlock byte 100
> > qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to unlock byte 100
> > qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to lock byte 100
> 
> It appears to be that the binary is built for Linux targets, but the WSL
> runtime doesn't recognize the ops (-EINVAL).
> 
> Convert to runtime check to cope with that.

Fair enough in this specific case because we still support older Linux
kernels and we want to fail gracefully if the binary was built against
a newer kernel.

However, I think the real problem here is with the WSL ecosystem if qemu
is routinely built against a real Linux while WSL doesn't provide the
same functionality. WSL should provide kernel headers that match what
it can provide (i.e. either remove the unimplemnted constants or
implement them).

So for the future, I'm not sure that we should add workarounds for WSL
shortcomings when no real Linux is affected.

This is even more true when the reporter is a Microsoft employee.

Kevin
