Received: from eggs.gnu.org ([2001:4830:134:3::10]:54836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dlGX8-0003cj-Bs
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dlGX5-0008Ea-76
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:28:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dlGX4-0008EB-TS
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:28:27 -0400
Date: Fri, 25 Aug 2017 16:28:07 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170825152806.GI2090@work-vm>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-5-dgilbert@redhat.com>
	<bc715b25-2a2c-d692-6bed-1f8364634e1b@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <bc715b25-2a2c-d692-6bed-1f8364634e1b@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 04/32] qemu_ram_block_host_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com, peterx@redhat.com, quintela@redhat.com

* Philippe Mathieu-Daud=E9 (f4bug@amsat.org) wrote:
> Hi David,
>=20
> On 08/24/2017 04:27 PM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Utility to give the offset of a host pointer within a RAMBlock
> > (assuming we already know it's in that RAMBlock)
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >   exec.c                    | 10 ++++++++++
> >   include/exec/cpu-common.h |  1 +
> >   2 files changed, 11 insertions(+)
> >=20
> > diff --git a/exec.c b/exec.c
> > index 67df2909ce..35b4cea2ed 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -2231,6 +2231,16 @@ static void *qemu_ram_ptr_length(RAMBlock *ram=
_block, ram_addr_t addr,
> >       return ramblock_ptr(block, addr);
> >   }
> > +/* Return the offset of a hostpointer within a ramblock */
> > +ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)
> > +{
> > +    ram_addr_t res =3D (uint8_t *)host - (uint8_t *)rb->host;
>=20
> What about using ptrdiff_t here,

We tend to use ram_addr_t for offsets in RAM, and so that's
the return type of the function, and we're also comparing this
value to rb->max_length below which is also a ram_addr_t.

> > +    assert((uint8_t *)host >=3D (uint8_t *)rb->host);
>=20
> and uintptr_t here?

Done.

Thanks,

Dave

> > +    assert(res < rb->max_length);
> > +
> > +    return res;
> > +}
> > +
> >   /*
> >    * Translates a host ptr back to a RAMBlock, a ram_addr and an offs=
et
> >    * in that RAMBlock.
> > diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> > index 74341b19d2..0d861a6289 100644
> > --- a/include/exec/cpu-common.h
> > +++ b/include/exec/cpu-common.h
> > @@ -68,6 +68,7 @@ ram_addr_t qemu_ram_addr_from_host(void *ptr);
> >   RAMBlock *qemu_ram_block_by_name(const char *name);
> >   RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
> >                                      ram_addr_t *offset);
> > +ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
> >   void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceSt=
ate *dev);
> >   void qemu_ram_unset_idstr(RAMBlock *block);
> >   const char *qemu_ram_get_idstr(RAMBlock *rb);
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
