Received: from eggs.gnu.org ([2001:4830:134:3::10]:58926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eFLoQ-0002jS-Gd
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eFLoL-0007Hz-Kf
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:10:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1eFLoL-0007Es-E5
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:10:37 -0500
Date: Thu, 16 Nov 2017 15:10:32 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171116151031.GV2787@redhat.com>
References: <20171115115246.GA1955@redhat.com>
	<20171116144746.GE29106@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171116144746.GE29106@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] Effect of qemu-img convert -m and -W options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: libguestfs@redhat.com, pl@kamp.de, qemu-devel@nongnu.org

On Thu, Nov 16, 2017 at 02:47:46PM +0000, Stefan Hajnoczi wrote:
> The threads you observed are the thread pool that performs
> preadv(2)/pwritev(2) syscalls.  The Linux AIO API could be used instead
> and does not use threads for read and write operations.

I guess if I used AIO then I wouldn't get any parallelism at all since
Linux doesn't block on local file access (at least, it never used to)?

> Interesting.  Did you perform multiple runs of each setting to verify
> that the benchmark results are stable with little volatility?

I retested the -m 8 no-W/-W ones because those were so unexpected and
those are repeatable.

> Which command-line did you use to create the preallocated qcow2 file?

What I actually did was qemu-img convert -n into the existing qcow2
file, so there was no separate command for that.

> Are the source and target files on the same file system and host block
> device?  The benefit of using multiple coroutines depends on the
> performance characteristics of the source and target files.

Both local filesystems, but on different SATA devices.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
