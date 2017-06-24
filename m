Received: from eggs.gnu.org ([2001:4830:134:3::10]:46422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexey.perevalov@hotmail.com>) id 1dOdMV-0000wv-16
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 01:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alexey.perevalov@hotmail.com>) id 1dOdMR-0001RF-SG
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 01:11:58 -0400
Received: from mail-oln040092070024.outbound.protection.outlook.com
	([40.92.70.24]:9824
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alexey.perevalov@hotmail.com>)
	id 1dOdMR-0001Qi-C6
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 01:11:55 -0400
From: Perevalov Alexey <alexey.perevalov@hotmail.com>
Date: Sat, 24 Jun 2017 05:11:52 +0000
Message-ID: <HE1PR0901MB132475564DAD2691CC281C6B8DD90@HE1PR0901MB1324.eurprd09.prod.outlook.com>
References: <1497640120-10729-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170616190852eucas1p18bc3671b480012ede7cbd810b40a8263@eucas1p1.samsung.com>
	<1497640120-10729-4-git-send-email-a.perevalov@samsung.com>
	<20170623102941.GB2252@work-vm>
	<HE1PR0901MB13240187397F213E9AF03BF18DD80@HE1PR0901MB1324.eurprd09.prod.outlook.com>
	<20170623194140.GA2547@work-vm>
In-Reply-To: <20170623194140.GA2547@work-vm>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <39399FC83589664593DAA797C132F40A@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 3/3] migration: add bitmap for received
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Perevalov Alexey <alexey.perevalov@hotmail.com>, Alexey Perevalov <a.perevalov@samsung.com>, "i.maximets@samsung.com" <i.maximets@samsung.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peterx@redhat.com" <peterx@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>

On Fri, Jun 23, 2017 at 08:41:41PM +0100, Dr. David Alan Gilbert wrote:
> * Perevalov Alexey (alexey.perevalov@hotmail.com) wrote:
> > On Fri, Jun 23, 2017 at 11:29:42AM +0100, Dr. David Alan Gilbert wrote:
> > > * Alexey Perevalov (a.perevalov@samsung.com) wrote:
> > > > This patch adds ability to track down already received
> > > > pages, it's necessary for calculation vCPU block time in
> > > > postcopy migration feature, maybe for restore after
> > > > postcopy migration failure.
> > > > Also it's necessary to solve shared memory issue in
> > > > postcopy livemigration. Information about received pages
> > > > will be transferred to the software virtual bridge
> > > > (e.g. OVS-VSWITCHD), to avoid fallocate (unmap) for
> > > > already received pages. fallocate syscall is required for
> > > > remmaped shared memory, due to remmaping itself blocks
> > > > ioctl(UFFDIO_COPY, ioctl in this case will end with EEXIT
> > > > error (struct page is exists after remmap).
> > > >=20
> > > > Bitmap is placed into RAMBlock as another postcopy/precopy
> > > > related bitmaps.
> > > >=20
> > > > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > > > ---
[...]
> > > >  static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
> > > > -        void *from_addr, uint64_t pagesize)
> > > > +        void *from_addr, uint64_t pagesize, RAMBlock *rb)
> > > >  {
> > > > +    /* received page isn't feature of blocktime calculation,
> > > > +     * it's more general entity, so keep it here,
> > > > +     * but gup betwean two following operation could be high,
> > > > +     * and in this case blocktime for such small interval will be =
lost */
> > > > +    ramblock_recv_bitmap_set(host_addr, rb);
> > >=20
> > > I have a fun problem here in my world with using the same bitmap for
> > > shared memory with the vhost-user client;  for that a set bit means
> > > that the data has already arrived and we need to do a UFFDIO_WAKE on
> > > the client;
> > Do you mean vhost-user client?
>=20
> Yes, I'm doing UFFDIO_WAKE calls on the userfault fd passed to me by
> the client.
>=20
> > > but that means we can't set the bit in this function until
> > > the end after we've done the COPY/ZERO.
> >=20
> > I have the same problem, I described it to Peter, when he asked why=20
> > ramblock_recv_bitmap_set should be closer to ioctl. But even such
> > position doesn't solve that problem.
> >=20
> > I could repeat here, I'm sending that bitmap to vhost-user client, and
> > it's possible situation when bitmap is set but page not yet copied.
> > Did you faced that? Or just mention it as potential problem.
>=20
> A similar problem;  I've got the fault thread receiving a fault request
> from the UFD, if the bit is set then it sends a WAKE, if it's not set
> then it sends a request back to the source.
> If we set the bit before the COPY/ZERO then I could send a WAKE too
> early.
>=20
> > If so, we could move ramblock_recv_bitmap_set after ioctl,
> > but we chose that way to avoid situation when new page fault happening
> > during ioctl or betwean ioctl and ramblock_recv_bitmap_set on the same =
vCPU.
> > Or introduce 2 bitmap, copied/received.
>=20
> It's a shame to need 2 bits.   We shouldn't get another fault on the
> same page, but I guess we can get it from another CPU on the same page
> which hmm is the problem with the stats code.
Yes, 2 bitmap is bad idea. I'm going to place ramblock_recv_bitmap_set
after ioctl, and leave such trade off in stats code or return back to
tree where key was an address of the pagefault.

>=20
> Dave
>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


Alexey
