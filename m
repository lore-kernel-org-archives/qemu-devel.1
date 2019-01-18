Received: from eggs.gnu.org ([209.51.188.92]:33121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gkS4q-0003wj-9s
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:12:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gkS4p-0005Mt-8s
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:12:44 -0500
Date: Fri, 18 Jan 2019 12:12:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190118111221.GE4530@dhcp-200-176.str.redhat.com>
References: <29ff1bde-73ab-3033-ac5d-1ecf79b523ee@msgid.tls.msk.ru>
	<20190114110104.GB6837@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114110104.GB6837@linux.fritz.box>
Subject: Re: [Qemu-devel] block: Update flags in bdrv_set_read_only()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, armbru@redhat.com, qemu-block@nongnu.org

[ Cc: qemu-block - noticed only now that it was missing ]

Am 14.01.2019 um 12:01 hat Kevin Wolf geschrieben:
> Am 12.01.2019 um 18:08 hat Michael Tokarev geschrieben:
> >     commit eeae6a596b0efc092f5101c67683053e245e6250
> >     Author: Kevin Wolf <kwolf@redhat.com>
> >     Date:   Tue Oct 9 16:57:12 2018 +0200
> > 
> >         block: Update flags in bdrv_set_read_only()
> > 
> >         To fully change the read-only state of a node, we must not only change
> >         bs->read_only, but also update bs->open_flags.
> > 
> > sort of broke vfat support:
> > 
> >  $ qemu-system-x86_64 -hda fat:foo/
> >  WARNING: Image format was not specified for 'json:{"fat-type": 0, "dir": "foo/", "driver": "vvfat", "floppy": false, "rw": false}' and probing guessed raw.
> >           Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
> >           Specify the 'raw' format explicitly to remove the restrictions.
> >  qemu-system-x86_64: Initialization of device ide-hd failed: Block node is read-only
> >  $ _
> > 
> > The warning is annoying but harmless, but the read-only error is fatal.
> > 
> > "Sort-of" is because there's a somewhat strange workaround:
> > 
> >   -hda fat:rw:foo/
> > 
> > but it is a bit more dangerous as well.
> > 
> > It looks like vfat should be handled differently somewhere, to
> > eliminate both the warning and the error?
> 
> Hm... This is not nice, but obviously that patch is still correct.
> 
> Essentially what you're saying is either:
> 
> 1. We want to be able to attach read-only backends to read-write guest
>    devices sometimes. If you actually do a write request then, you'll
>    get an I/O error,
> 
>    or
> 
> 2. vvfat shouldn't expose a read-only backend, but a read-write one that
>    always fails when you write.
> 
> I think 2. is easier to implement, but it's special casing vvfat. Does
> this make sense or is it a problem that needs to be solved more
> generically? If it's okay for a read-only FAT backend to be attached to
> an IDE disk that really needs a read-write backend, why wouldn't it be
> okay to attach e.g. a read-only HTTP backend? Or even a read-only image
> file on the local filesystem?
> 
> On the other hand, usually users wouldn't want to silently get a guest
> started up that produces I/O errors on the first write request when they
> just configured things wrong or have the wrong file permissions.
> 
> We can't do both at the same time, though. So what is the behaviour that
> we actually want regarding read-only backends and read-write guest
> devices?
> 
> Kevin
