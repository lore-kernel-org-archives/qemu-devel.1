Received: from eggs.gnu.org ([2001:4830:134:3::10]:58558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gKS39-0002yf-Ej
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gKS36-0001wY-Eq
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:55:31 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:38529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1gKS34-0001mQ-QH
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:55:27 -0500
Received: by mail-ua1-f43.google.com with SMTP id p9so2185072uaa.5
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 09:55:22 -0800 (PST)
MIME-Version: 1.0
References: <20181107121319.GC14842@redhat.com>
	<20181107143628.GG8125@redhat.com>
	<CAMRbyyuFGVtNWF9LKoi0n6_r5Gr4j8LetbAMd0L_5cKMif9LjQ@mail.gmail.com>
	<20181107172737.GB4721@linux.fritz.box>
In-Reply-To: <20181107172737.GB4721@linux.fritz.box>
From: Nir Soffer <nsoffer@redhat.com>
Date: Wed, 7 Nov 2018 19:55:10 +0200
Message-ID: <CAMRbyys2XVgjPx9HteGP8c6R5rPM=n86m30kfEG6a0+c-jLZ4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, edgar.kaziakhmedov@virtuozzo.com, QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>

On Wed, Nov 7, 2018 at 7:27 PM Kevin Wolf <kwolf@redhat.com> wrote:

> Am 07.11.2018 um 15:56 hat Nir Soffer geschrieben:
> > Wed, Nov 7, 2018 at 4:36 PM Richard W.M. Jones <rjones@redhat.com>
> wrote:
> >
> > > Another thing I tried was to change the NBD server (nbdkit) so that it
> > > doesn't advertise zero support to the client:
> > >
> > >   $ nbdkit --filter=log --filter=nozero memory size=6G
> logfile=/tmp/log \
> > >       --run './qemu-img convert ./fedora-28.img -n $nbd'
> > >   $ grep '\.\.\.$' /tmp/log | sed 's/.*\([A-Z][a-z]*\).*/\1/' | uniq -c
> > >    2154 Write
> > >
> > > Not surprisingly no zero commands are issued.  The size of the write
> > > commands is very uneven -- it appears to be send one command per block
> > > of zeroes or data.
> > >
> > > Nir: If we could get information from imageio about whether zeroing is
> > > implemented efficiently or not by the backend, we could change
> > > virt-v2v / nbdkit to advertise this back to qemu.
> >
> > There is no way to detect the capability, ioctl(BLKZEROOUT) always
> > succeeds, falling back to manual zeroing in the kernel silently
> >
> > Even if we could, sending zero on the wire from qemu may be even
> > slower, and it looks like qemu send even more requests in this case
> > (2154 vs ~1300).
> >
> > Looks like this optimization in qemu side leads to worse performance,
> > so it should not be enabled by default.
>
> Well, that's overgeneralising your case a bit. If the backend does
> support efficient zero writes (which file systems, the most common case,
> generally do), doing one big write_zeroes request at the start can
> improve performance quite a bit.
>
> It seems the problem is that we can't really know whether the operation
> will be efficient because the backends generally don't tell us. Maybe
> NBD could introduce a flag for this, but in the general case it appears
> to me that we'll have to have a command line option.
>
> However, I'm curious what your exact use case and the backend used in it
> is? Can something be improved there to actually get efficient zero
> writes and get even better performance than by just disabling the big
> zero write?


The backend is some NetApp storage connected via FC. I don't have
more info on this. We get zero rate of about 1G/s on this storage, which
is quite slow compared with other storage we tested.

One option we check now is if this is the kernel silent fallback to manual
zeroing when the server advertise wrong value of write_same_max_bytes.

Having a command line option to control this behavior sounds good. I don't
have enough data to tell what should be the default, but I think the safe
way would be to keep old behavior.

Nir
