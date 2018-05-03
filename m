Received: from eggs.gnu.org ([2001:4830:134:3::10]:45442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEIZ8-00020t-N8
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEIZ4-0007v8-QB
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:02:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fEIZ4-0007uy-Jv
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:02:46 -0400
Date: Thu, 3 May 2018 19:02:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180503180240.GC13789@stefanha-x1.localdomain>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<062deb2a-35fc-319f-b159-3b58cbf910df@redhat.com>
	<20180502115844.GO3308@redhat.com>
	<CAFEAcA-e_=08658O8E3CAmYXvBbNWmznnhfMLUW+MXnxb_vKfQ@mail.gmail.com>
	<20180503093329.GF11382@redhat.com>
	<8af696b5-3985-ffd6-43fb-2bcbfe0d0493@redhat.com>
	<222ee475-9eb5-8887-819a-7b093fc269b1@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <222ee475-9eb5-8887-819a-7b093fc269b1@kaod.org>
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
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Thomas Huth <thuth@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 04:16:41PM +0200, C=E9dric Le Goater wrote:
> Coming back to the initial motivation that Peter pointed out, would
> the goal to be able to run vcpus of different architectures ? It would
> certainly be interesting to model a platform, specially if we can=20
> synchronize the execution in some ways and find timing issues.

Yes, there is demand for heterogenous guests.  People have worked on
this problem in the past but nothing mergeable came out of it.

The main issue with a monolithic binary is that today, QEMU builds
target-specific object files (see Makefile.target).  That means the same
C source file is recompiled for each target with different #defines.  We
cannot easily link these "duplicate" object files into a single binary
because the symbol names would collide.

It would be necessary to refactor target-specific #ifdefs.  Here is a
trivial example from arch_init.c:

  #ifdef TARGET_SPARC
  int graphic_width =3D 1024;
  int graphic_height =3D 768;
  int graphic_depth =3D 8;
  #else
  int graphic_width =3D 800;
  int graphic_height =3D 600;
  int graphic_depth =3D 32;
  #endif

This can be converted into a runtime check:

  static void init_graphic_resolution(void)
  {
      if (arch_type =3D=3D QEMU_ARCH_SPARC) {
          graphic_width =3D 1024;
          graphic_height =3D 768;
          graphic_depth =3D 8;
      } else {
          graphic_width =3D 800;
          graphic_height =3D 600;
          graphic_depth =3D 32;
      }
  }
  target_init(init_graphic_resolution)

I'm assuming target_init() registers functions that will be called once
arch_type has been set.

Of course the meaning of arch_type in a heterogenous system is different
since there can be multiple CPUs.  It would mean the overall board (e.g.
a SPARC machine).  But that is a separate issue and can only be
addressed once target-specific files have been eliminated.

I also want to point out that a monolithic binary is totally orthogonal
to modularity (reducing attack surface, reducing dependencies).  These
two issues do not conflict with each other.  We could have a single
"qemu-softmmu" binary that dynamically loads needed machine types, CPU,
and emulated devices.  That way the monolithic binary can do everything
but is still minimal.

So to clarify, three separate steps:

1. Get rid of target-specific #ifdefs
2a. Modular QEMU, single binary
2b. Heterogenous QEMU

2a and 2b are independent but both depend on 1.

Stefan

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa607AAAoJEJykq7OBq3PIr5sH/AnT9iXdF9pr3wmieJzu10MK
+aJmkpqo6dkLqa8uZt2UrtZGDlwCDeR3kyqoULCAfm6vkw2hvh4TPllYnLVUOuEQ
ilfHE5FMkdzdwXmnz1cg6NQauQPCVsJPDyN0uvGLHePUE7CoMIlIdNeSqPTpVpBv
KtKEnmnoN4Z8M1PHKB1LaY2tE7zQVmhLnMo2KvRCP+P5blPtED4hLDTIRqQpddb+
u1lOwNolBXc9gCwJ8Wl7pannZe5IJKDkXoLSm/pDmemCB72MRaDmbBp0GXB5PVZW
+Ca7+eq/AmeQCPqQBulXQVFASsBehtyZUKr3eVrVPfroSjwBGqbtHo+gR4qt8Mg=
=K5I5
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
