Received: from eggs.gnu.org ([2001:4830:134:3::10]:45053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gKRcP-0007AP-53
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:27:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gKRcO-0002Dt-AS
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:27:53 -0500
Date: Wed, 7 Nov 2018 18:27:37 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181107172737.GB4721@linux.fritz.box>
References: <20181107121319.GC14842@redhat.com>
	<20181107143628.GG8125@redhat.com>
	<CAMRbyyuFGVtNWF9LKoi0n6_r5Gr4j8LetbAMd0L_5cKMif9LjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRbyyuFGVtNWF9LKoi0n6_r5Gr4j8LetbAMd0L_5cKMif9LjQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] Change in qemu 2.12 causes qemu-img
 convert to NBD to write more data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, edgar.kaziakhmedov@virtuozzo.com, QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>

Am 07.11.2018 um 15:56 hat Nir Soffer geschrieben:
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
> 
> There is no way to detect the capability, ioctl(BLKZEROOUT) always
> succeeds, falling back to manual zeroing in the kernel silently
> 
> Even if we could, sending zero on the wire from qemu may be even
> slower, and it looks like qemu send even more requests in this case
> (2154 vs ~1300).
> 
> Looks like this optimization in qemu side leads to worse performance,
> so it should not be enabled by default.

Well, that's overgeneralising your case a bit. If the backend does
support efficient zero writes (which file systems, the most common case,
generally do), doing one big write_zeroes request at the start can
improve performance quite a bit.

It seems the problem is that we can't really know whether the operation
will be efficient because the backends generally don't tell us. Maybe
NBD could introduce a flag for this, but in the general case it appears
to me that we'll have to have a command line option.

However, I'm curious what your exact use case and the backend used in it
is? Can something be improved there to actually get efficient zero
writes and get even better performance than by just disabling the big
zero write?

Kevin
