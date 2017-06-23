Received: from eggs.gnu.org ([2001:4830:134:3::10]:44630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexey.perevalov@hotmail.com>) id 1dOQcI-0002X8-4N
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alexey.perevalov@hotmail.com>) id 1dOQcD-00035g-DJ
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:35:26 -0400
Received: from mail-oln040092064102.outbound.protection.outlook.com
	([40.92.64.102]:7728
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alexey.perevalov@hotmail.com>)
	id 1dOQcC-00035L-Ts
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:35:21 -0400
From: Perevalov Alexey <alexey.perevalov@hotmail.com>
Date: Fri, 23 Jun 2017 15:35:17 +0000
Message-ID: <HE1PR0901MB1324EF1CA6D9AAC579DA5BA38DD80@HE1PR0901MB1324.eurprd09.prod.outlook.com>
References: <1497640120-10729-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170616190852eucas1p18bc3671b480012ede7cbd810b40a8263@eucas1p1.samsung.com>
	<1497640120-10729-4-git-send-email-a.perevalov@samsung.com>
	<87h8z9jgdc.fsf@secure.laptop>
In-Reply-To: <87h8z9jgdc.fsf@secure.laptop>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E3F83A692DB5254080BAD88B25035065@eurprd09.prod.outlook.com>
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
To: Juan Quintela <quintela@redhat.com>
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "i.maximets@samsung.com" <i.maximets@samsung.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peterx@redhat.com" <peterx@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>

On Wed, Jun 21, 2017 at 09:22:07PM +0200, Juan Quintela wrote:
> Alexey Perevalov <a.perevalov@samsung.com> wrote:
> > This patch adds ability to track down already received
> > pages, it's necessary for calculation vCPU block time in
> > postcopy migration feature, maybe for restore after
> > postcopy migration failure.
> > Also it's necessary to solve shared memory issue in
> > postcopy livemigration. Information about received pages
> > will be transferred to the software virtual bridge
> > (e.g. OVS-VSWITCHD), to avoid fallocate (unmap) for
> > already received pages. fallocate syscall is required for
> > remmaped shared memory, due to remmaping itself blocks
> > ioctl(UFFDIO_COPY, ioctl in this case will end with EEXIT
> > error (struct page is exists after remmap).
> >
> > Bitmap is placed into RAMBlock as another postcopy/precopy
> > related bitmaps.
> >
> > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
>=20
> Hi
>=20
> A few commets.
>=20
> Happy with all the changes that you did.
>=20
> > @@ -60,6 +62,7 @@ static inline void *ramblock_ptr(RAMBlock *block, ram=
_addr_t offset)
> >     return (char *)block->host + offset;
> > }
> >=20
> > +unsigned long int ramblock_recv_bitmap_offset(void *host_addr, RAMBloc=
k *rb);
> >  long qemu_getrampagesize(void);
> >  unsigned long last_ram_page(void);
> > RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>=20
> I think we shouldn't export it at all.  But if we do, we should export
> it with the other functions.
>=20
>=20
> > +unsigned long int ramblock_recv_bitmap_offset(void *host_addr, RAMBloc=
k *rb)
>=20
> I think this function can be made static, as nothing else should use it, =
no?


Peter asked me to export it in "Re: [Qemu-devel] [PATCH v2 3/3]
migration: add bitmap for received page",
looks like he needs it, but he suggested static inline,
ok, it will be static inline

>=20
> > +{
> > +    uint64_t host_addr_offset =3D (uint64_t)(uintptr_t)(host_addr
> > +                                                      - (void *)rb->ho=
st);
>=20
> Intdentation is weird:
>=20
> uint64_t host_addr_offset =3D
>     (uint64_t)(uintptr_t)(host_addr - (void *)rb->host);
>=20
>=20
> > +    return host_addr_offset >> TARGET_PAGE_BITS;
> > +}
> > +
> > +int ramblock_recv_bitmap_test(void *host_addr, RAMBlock *rb)
> > +{
> > +    return test_bit(ramblock_recv_bitmap_offset(host_addr, rb),
> > +                    rb->receivedmap);
> > +}
> > +
> > +void ramblock_recv_bitmap_set(void *host_addr, RAMBlock *rb)
> > +{
> > +    set_bit_atomic(ramblock_recv_bitmap_offset(host_addr, rb),
> > rb->receivedmap);
>=20
> Line is too long?
It shouldn't, I checked patches with checkscript, that line is 80
characters long.

>=20
> > +static void ramblock_recv_bitmap_clear_range(uint64_t start, size_t le=
ngth,
> > +                                             RAMBlock *rb)
> > +{
> > +    int i, range_count;
> > +    range_count =3D length >> TARGET_PAGE_BITS;
> > +    for (i =3D 0; i < range_count; i++) {
> > +        ramblock_recv_bitmap_clear((void *)((uint64_t)(intptr_t)rb->ho=
st +
> > +                                            start), rb);
> > +        start +=3D TARGET_PAGE_SIZE;
>=20
> bitmap_clear(dst, pos, nbits)		Clear specified bit area
>=20
> Looks like the right operation here, no?
yes, we already have an offset here.

>=20
> > +
> > +void ramblock_recv_map_init(void);
> > +int ramblock_recv_bitmap_test(void *host_addr, RAMBlock *rb);
> > +void ramblock_recv_bitmap_set(void *host_addr, RAMBlock *rb);
> > +void ramblock_recv_bitmap_clear(void *host_addr, RAMBlock *rb);
> > +
> >  #endif
>=20
> Later, Juan.
>=20
