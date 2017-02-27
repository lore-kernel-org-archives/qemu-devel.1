Received: from eggs.gnu.org ([2001:4830:134:3::10]:57478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciLp8-0007Hl-G3
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciLp5-00067U-FT
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:58:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ciLp5-00067H-5w
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:58:43 -0500
Date: Mon, 27 Feb 2017 13:58:35 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170227135835.GN18219@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170223105922.22989-1-berrange@redhat.com>
	<20170227111047.GF28403@stefanha-x1.localdomain>
	<1488203170.4736.24.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1488203170.4736.24.camel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] os: don't corrupt pre-existing
 memory-backend data with prealloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rik van Riel <riel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Jitendra Kolhe <jitendra.kolhe@hpe.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Michal Privoznik <mprivozn@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Mon, Feb 27, 2017 at 08:46:10AM -0500, Rik van Riel wrote:
> On Mon, 2017-02-27 at 11:10 +0000, Stefan Hajnoczi wrote:
> > On Thu, Feb 23, 2017 at 10:59:22AM +0000, Daniel P. Berrange wrote:
> > > When using a memory-backend object with prealloc turned on, QEMU
> > > will memset() the first byte in every memory page to zero. While
> > > this might have been acceptable for memory backends associated
> > > with RAM, this corrupts application data for NVDIMMs.
> > >=20
> > > Instead of setting every page to zero, read the current byte
> > > value and then just write that same value back, so we are not
> > > corrupting the original data.
> > >=20
> > > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > > ---
> > >=20
> > > I'm unclear if this is actually still safe in practice ? Is the
> > > compiler permitted to optimize away the read+write since it doesn't
> > > change the memory value. I'd hope not, but I've been surprised
> > > before...
> > >=20
> > > IMHO this is another factor in favour of requesting an API from
> > > the kernel to provide the prealloc behaviour we want.
> > >=20
> > > =C2=A0util/oslib-posix.c | 3 ++-
> > > =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > > index 35012b9..8f5b656 100644
> > > --- a/util/oslib-posix.c
> > > +++ b/util/oslib-posix.c
> > > @@ -355,7 +355,8 @@ void os_mem_prealloc(int fd, char *area, size_t
> > > memory, Error **errp)
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* MAP_POPULA=
TE silently ignores failures */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0;=
 i < numpages; i++) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0memset(area + (hpagesize * i), 0, 1);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0char val =3D *(area + (hpagesize * i));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0memset(area + (hpagesize * i), 0, val);
> >=20
> > Please include a comment in the final patch explaining why we want to
> > preserve memory contents.
> >=20
> > In the case of NVDIMM I'm not sure if the memset is needed at
> > all.=C2=A0=C2=A0The
> > memory already exists - no new pages need to be allocated by the
> > kernel.
> > We just want the page table entries to be populated for the NVDIMM
> > when
> > -mem-prealloc is used.
> >=20
> > Perhaps Andrea or Rik have ideas on improving the kernel interface
> > and
> > whether mmap(MAP_POPULATE) should be used with NVDIMM instead of this
> > userspace "touch every page" workaround?
>=20
> Why do we need the page table entries to be populated
> in advance at all?

It is a choice apps using QEMU have - they can tell QEMU whether they
want prealloc or not - if they decide they do want it, then we should
not be corrupting the data.

> The high cost of the page fault for regular memory
> is zeroing out the memory pages before we give them
> to userspace.

NVDIMM in the guest might be backed by regular memory in the host - QEMU
doesn't require use of NVDIMM in the host.

> Simply faulting in the NVDIMM memory as it is touched
> may make more sense than treating it like DRAM,
> especially given that with DAX, NVDIMM areas may be
> orders of magnitude larger than RAM, and we really
> do not want to set up all the page tables for every
> part of the guest DAX "disk".



Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|
