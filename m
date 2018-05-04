Received: from eggs.gnu.org ([2001:4830:134:3::10]:59192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEW5h-0004i8-Ci
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEW5e-000185-74
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:29:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59174 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fEW5e-00017Q-02
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:29:18 -0400
Date: Fri, 4 May 2018 09:29:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180504082910.GD18897@stefanha-x1.localdomain>
References: <d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<062deb2a-35fc-319f-b159-3b58cbf910df@redhat.com>
	<20180502115844.GO3308@redhat.com>
	<CAFEAcA-e_=08658O8E3CAmYXvBbNWmznnhfMLUW+MXnxb_vKfQ@mail.gmail.com>
	<20180503093329.GF11382@redhat.com>
	<8af696b5-3985-ffd6-43fb-2bcbfe0d0493@redhat.com>
	<222ee475-9eb5-8887-819a-7b093fc269b1@kaod.org>
	<20180503180240.GC13789@stefanha-x1.localdomain>
	<20180503185040.GC2671@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
In-Reply-To: <20180503185040.GC2671@work-vm>
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 07:50:41PM +0100, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > On Thu, May 03, 2018 at 04:16:41PM +0200, C=E9dric Le Goater wrote:
> > > Coming back to the initial motivation that Peter pointed out, would
> > > the goal to be able to run vcpus of different architectures ? It would
> > > certainly be interesting to model a platform, specially if we can=20
> > > synchronize the execution in some ways and find timing issues.
> >=20
> > Yes, there is demand for heterogenous guests.  People have worked on
> > this problem in the past but nothing mergeable came out of it.
> >=20
> > The main issue with a monolithic binary is that today, QEMU builds
> > target-specific object files (see Makefile.target).  That means the same
> > C source file is recompiled for each target with different #defines.  We
> > cannot easily link these "duplicate" object files into a single binary
> > because the symbol names would collide.
> >=20
> > It would be necessary to refactor target-specific #ifdefs.  Here is a
> > trivial example from arch_init.c:
> >=20
> >   #ifdef TARGET_SPARC
> >   int graphic_width =3D 1024;
> >   int graphic_height =3D 768;
> >   int graphic_depth =3D 8;
> >   #else
> >   int graphic_width =3D 800;
> >   int graphic_height =3D 600;
> >   int graphic_depth =3D 32;
> >   #endif
> >=20
> > This can be converted into a runtime check:
> >=20
> >   static void init_graphic_resolution(void)
> >   {
> >       if (arch_type =3D=3D QEMU_ARCH_SPARC) {
> >           graphic_width =3D 1024;
> >           graphic_height =3D 768;
> >           graphic_depth =3D 8;
> >       } else {
> >           graphic_width =3D 800;
> >           graphic_height =3D 600;
> >           graphic_depth =3D 32;
> >       }
> >   }
> >   target_init(init_graphic_resolution)
> >=20
> > I'm assuming target_init() registers functions that will be called once
> > arch_type has been set.
> >=20
> > Of course the meaning of arch_type in a heterogenous system is different
> > since there can be multiple CPUs.  It would mean the overall board (e.g.
> > a SPARC machine).  But that is a separate issue and can only be
> > addressed once target-specific files have been eliminated.
> >=20
> > I also want to point out that a monolithic binary is totally orthogonal
> > to modularity (reducing attack surface, reducing dependencies).  These
> > two issues do not conflict with each other.  We could have a single
> > "qemu-softmmu" binary that dynamically loads needed machine types, CPU,
> > and emulated devices.  That way the monolithic binary can do everything
> > but is still minimal.
> >=20
> > So to clarify, three separate steps:
> >=20
> > 1. Get rid of target-specific #ifdefs
> > 2a. Modular QEMU, single binary
> > 2b. Heterogenous QEMU
> >=20
> > 2a and 2b are independent but both depend on 1.
>=20
> (1) may not be required, if those ifdef's are in target-specific
> builds; but that does require that any target-specific stuff goes
> through a well defined interface to be a loadable module and not
> have a zillion overlapping symbols.

Right, there are many cases that I omitted and the arch_init.c example
was the simplest case.  Each instance needs to be handled on a
case-by-case basis.

We may need to keep multiple copies of object code.  Byteswapping is an
example of this:

  #if defined(HOST_WORDS_BIGENDIAN) !=3D defined(TARGET_WORDS_BIGENDIAN)
  #define BSWAP_NEEDED
  #endif

Adding runtime endianness checks to all guest memory accesses could
impact performance.  This is why everything that includes cpu.h is
currently per-target.

This work is no small task but I think it's necessary.  The starting
point for anyone who'd like to contribute:

Look at obj-y files in the makefiles.  These are the target-specific
object files that need to be investigated.  Everything already in
common-obj-y is only built once and can be ignored.

Stefan

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa7BnWAAoJEJykq7OBq3PIuXAH/0n2vdPCfZS0pi+FRUASToet
mmnH4wFNMdxKq8vONBobGEz8T4heUPaOD1c38yFoF6KdE9q/LCLpdow1HOppiqxj
leOfq721jjQI9xWuTVpxpX1VTQs3qN5QfIJBOLPHo38hkBUIUI8jqbBeGRrc5ePc
3zN9ylT+03zz/KX+OCgIeSI2DVZlwJ42C/VVJ3V48llAC9e0ig9fF0bHJLx6Pavr
/vMcwLtA1x/+/ItMbOSV0MhP41q9FXaMn4q9XiBoMoFXC2usJkMwFl0XUQRgrDa9
JEbXHLNbLTYt5OhHGuhuof6nzx/CrADB3xTwBOoRqMbHD7d3dRHTrezSQvDBLRY=
=BoUN
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
