Received: from eggs.gnu.org ([2001:4830:134:3::10]:43110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gLrci-0002Oa-4l
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 10:26:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gLrcd-0002Af-4h
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 10:26:04 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:46078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1gLrcZ-00020J-LS
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 10:25:57 -0500
Received: by mail-ua1-f42.google.com with SMTP id e16so1015643uam.12
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 07:25:33 -0800 (PST)
MIME-Version: 1.0
References: <20181107121319.GC14842@redhat.com>
	<d797ae29-97ba-9c18-68ec-a2943bdf7728@redhat.com>
In-Reply-To: <d797ae29-97ba-9c18-68ec-a2943bdf7728@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Sun, 11 Nov 2018 17:25:21 +0200
Message-ID: <CAMRbyyuQSyq=Tg-o-k8BhpwHUPuwHLBL2Pa=5VOcUmx5xNywog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eric Blake <eblake@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, edgar.kaziakhmedov@virtuozzo.com

On Wed, Nov 7, 2018 at 6:42 PM Eric Blake <eblake@redhat.com> wrote:

> On 11/7/18 6:13 AM, Richard W.M. Jones wrote:
> > (I'm not going to claim this is a bug, but it causes a large, easily
> > measurable performance regression in virt-v2v).
>
> I haven't closely looked at at this email thread yet, but a quick first
> impression:
>
>
> > In qemu 2.12 this behaviour changed:
> >
> >    $ nbdkit --filter=log memory size=6G logfile=/tmp/log \
> >        --run './qemu-img convert ./fedora-28.img -n $nbd'
> >    $ grep '\.\.\.$' /tmp/log | sed 's/.*\([A-Z][a-z]*\).*/\1/' | uniq -c
> >        193 Zero
> >       1246 Write
> >
> > It now zeroes the whole disk up front and then writes data over the
> > top of the zeroed blocks.
> >
> > The reason for the performance regression is that in the first case we
> > write 6G in total.  In the second case we write 6G of zeroes up front,
> > followed by the amount of data in the disk image (in this case the
> > test disk image contains 1G of non-sparse data, so we write about 7G
> > in total).
>
> There was talk on the NBD list a while ago about the idea of letting the
> server advertise to the client when the image is known to start in an
> all-zero state, so that the client doesn't have to waste time writing
> zeroes (or relying on repeated NBD_CMD_BLOCK_STATUS calls to learn the
> same).  This may be justification for reviving that topic.
>

This is a good idea in general, since in some cases we know that
a volume is already zeroed (e.g. new file on NFS/Gluster storage). But with
block storage, we typically don't have any guarantee about storage content,
and qemu need to zero or write the entire device, so this does not solve the
issue discussed in this thread.

Nir
