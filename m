Received: from eggs.gnu.org ([2001:4830:134:3::10]:51635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1fikA0-0000uh-Nx
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1fik9w-00036e-IX
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:34:44 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1fik9w-000369-CQ
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:34:40 -0400
Received: by mail-ua0-f194.google.com with SMTP id r10-v6so1628516uao.1
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 10:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180726113337.23144-1-kwolf@redhat.com>
	<605ad10a-13c0-7f62-1c71-a8afe9021ee6@redhat.com>
	<20180726150655.GG4215@localhost.localdomain>
	<6cdde651-acdc-e6eb-63fc-e7efe8136710@redhat.com>
	<20180726153356.GH4215@localhost.localdomain>
	<9eb742d5-42c7-29da-b06f-e41873d1d645@redhat.com>
	<CAMRbyyvWsSTCfNaDJDFwqECsErJHc3=Z+SEaRea0rro95AwUgA@mail.gmail.com>
	<20180726165823.GJ4215@localhost.localdomain>
In-Reply-To: <20180726165823.GJ4215@localhost.localdomain>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 26 Jul 2018 20:34:27 +0300
Message-ID: <CAMRbyyuTtC8YUgn-GECRsV=NqUBudHte8XfkSeF2rftpf701vQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.0] file-posix: Fix write_zeroes with
 unmap on block devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, Idan Shaby <ishaby@redhat.com>

On Thu, Jul 26, 2018 at 7:58 PM Kevin Wolf <kwolf@redhat.com> wrote:

> Am 26.07.2018 um 18:46 hat Nir Soffer geschrieben:
> > On Thu, Jul 26, 2018 at 7:10 PM Eric Blake <eblake@redhat.com> wrote:
> >
> > > On 07/26/2018 10:33 AM, Kevin Wolf wrote:
> > >
> > > >
> > > > As far as I know, the comment you quoted is accurate for BLKDISCARD
> and
> > > > BLKZEROOUT, but not for the fallocate() flags.
> > > >
> > >
> > > I sure wish the man pages were more explicit on what guarantees each
> > > flag offers.
> > >
> > > >> Hmm - that thread also mentions FALLOC_FL_NO_HIDE_STALE, which is a
> new
> > > flag
> > > >> not present/documented on Fedora 28. I wonder if it helps, too.
> > > >>
> > > >>>
> > > >>> FALLOC_FL_ZERO_RANGE in contrast implements write_zeroes without
> unmap.
> > > >>
> > > >> I thought the opposite: FALLOC_FL_ZERO_RANGE guarantees that you
> read
> > > back
> > > >> 0, using whatever is most efficient under the hood (in the case of
> block
> > > >> devices, unmapping that reliably reads back as zero is favored).
> > > >
> > > > See the code I quoted above, FALLOC_FL_ZERO_RANGE calls
> > > > blkdev_issue_zeroout() with BLKDEV_ZERO_NOUNMAP internally.
> > >
> > > Having to resort to reading the kernel code to learn what the
> guarantees
> > > are is annoying (it's nice that GPL guarantees that we CAN do that, but
> > > it means the man pages could use some TLC so that we don't have to).
> > > Especially since the kernel code has changed over time.
> > >
> > > But your paste of current kernel code is rather hard to argue against.
> >
> > I don't think we should depend on undocumented kernel code.
>
> Yes, the man page says "filesystem blocks" instead of just "blocks". If
> you're in a nit-picking mood, that excludes block devices. But I think
> it's pretty obvious what the intended meaning is and how it consistently
> extends to block devices, and the code confirms it.
>
> That's by far not "undocumented kernel code" in my book.
>

Maybe it is more correct to say this is poorly documented.

The manual is very specific about supported filesystems, but there nothing
about
block devices:

   Deallocating file space


       Specifying  the  FALLOC_FL_PUNCH_HOLE flag (available since Linux
       2.6.38) in mode deallocates space (i.e., creates a hole) in the
       byte range starting at offset and continuing for len bytes.  Within
the
       specified range, partial filesystem blocks are zeroed, and whole
       filesystem blocks are removed from the file.  After a successful
call,
       subsequent  reads from this range will return zeroes.

       The  FALLOC_FL_PUNCH_HOLE  flag  must be ORed with
FALLOC_FL_KEEP_SIZE
       in mode; in other words, even when punching off the end of the file,
the
       file size (as reported by stat(2)) does not change.

       Not all filesystems support FALLOC_FL_PUNCH_HOLE; if a filesystem
       doesn't support the operation, an error is returned.  The operation
is
       supported  on  at  least  the  following filesystems:

       *  XFS (since Linux 2.6.38)
       *  ext4 (since Linux 3.0)
       *  Btrfs (since Linux 3.7)
       *  tmpfs(5) (since Linux 3.5)

I expect to see something like:

    * block devices (since Linux 4.9)

Anyway this looks the same level of documentation as FALLOC_FL_ZERO_RANGE,
so if we are ok with using it, FALLOC_FL_PUNCH_HOLE is fine.

Does this change mean that oVirt can start to enable discard for VM when
disks are using wipe-after-delete?

Currently we disable discard if a disk is marked for wiping, since discard
does not
guarantee that discarded ranges are zeroed.

Nir
