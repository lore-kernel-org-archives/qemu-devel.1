Received: from eggs.gnu.org ([2001:4830:134:3::10]:56898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gKPM4-000618-PG
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gKPM0-0006vq-Tt
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:02:50 -0500
Date: Wed, 7 Nov 2018 15:02:19 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181107150219.GC27120@redhat.com>
References: <20181107121319.GC14842@redhat.com>
	<20181107143628.GG8125@redhat.com>
	<CAMRbyyuFGVtNWF9LKoi0n6_r5Gr4j8LetbAMd0L_5cKMif9LjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRbyyuFGVtNWF9LKoi0n6_r5Gr4j8LetbAMd0L_5cKMif9LjQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Change in qemu 2.12 causes qemu-img convert to NBD
 to write more data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, qemu-block <qemu-block@nongnu.org>, edgar.kaziakhmedov@virtuozzo.com

On Wed, Nov 07, 2018 at 04:56:48PM +0200, Nir Soffer wrote:
> Wed, Nov 7, 2018 at 4:36 PM Richard W.M. Jones <rjones@redhat.com> wrote:
> 
> > Another thing I tried was to change the NBD server (nbdkit) so that it
> > doesn't advertise zero support to the client:
> >
> >   $ nbdkit --filter=log --filter=nozero memory size=6G logfile=/tmp/log \
> >       --run './qemu-img convert ./fedora-28.img -n $nbd'
> >   $ grep '\.\.\.$' /tmp/log | sed 's/.*\([A-Z][a-z]*\).*/\1/' | uniq -c
> >    2154 Write
> >
> > Not surprisingly no zero commands are issued.  The size of the write
> > commands is very uneven -- it appears to be send one command per block
> > of zeroes or data.
> >
> > Nir: If we could get information from imageio about whether zeroing is
> > implemented efficiently or not by the backend, we could change
> > virt-v2v / nbdkit to advertise this back to qemu.
> >
> 
> There is no way to detect the capability, ioctl(BLKZEROOUT) always
> succeeds, falling back to manual zeroing in the kernel silently
> 
> Even if we could, sending zero on the wire from qemu may be even
> slower,

Yes this is a very good point.  Sending zeroes would be terrible.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
