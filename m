Received: from eggs.gnu.org ([2001:4830:134:3::10]:34592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dMvbh-0004lW-KW
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dMvbc-0002cL-QC
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:16:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dMvbc-0002bs-GP
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:16:32 -0400
Date: Mon, 19 Jun 2017 13:00:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170619120057.GF17304@stefanha-x1.localdomain>
References: <20170609151615.2589-1-stefanha@redhat.com>
	<20170616131956.GA6770@stefanha-x1.localdomain>
	<20170616170331-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KJY2Ze80yH5MUxol"
Content-Disposition: inline
In-Reply-To: <20170616170331-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] hw/i386: fix nvdimm check error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 05:03:48PM +0300, Michael S. Tsirkin wrote:
> On Fri, Jun 16, 2017 at 02:19:56PM +0100, Stefan Hajnoczi wrote:
> > On Fri, Jun 09, 2017 at 04:16:15PM +0100, Stefan Hajnoczi wrote:
> > > Commit e987c37aee1752177906847630d32477da57e705 ("hw/i386: check if
> > > nvdimm is enabled before plugging") introduced a check to reject nvdi=
mm
> > > hotplug if -machine pc,nvdimm=3Don was not given.
> > >=20
> > > This check executes after pc_dimm_memory_plug() has already completed
> > > and does not reverse the effect of this function in the case of failu=
re.
> > >=20
> > > Perform the check before calling pc_dimm_memory_plug().  This fixes t=
he
> > > following abort:
> > >=20
> > >   $ qemu -M accel=3Dkvm -m 1G,slots=3D4,maxmem=3D8G \
> > >          -object memory-backend-file,id=3Dmem1,share=3Don,mem-path=3D=
nvdimm.dat,size=3D1G
> > >   (qemu) device_add nvdimm,memdev=3Dmem1
> > >   nvdimm is not enabled: missing 'nvdimm' in '-M'
> > >   (qemu) device_add nvdimm,memdev=3Dmem1
> > >   Core dumped
> > >=20
> > > The backtrace is:
> > >=20
> > >   #0  0x00007fffdb5b191f in raise () at /lib64/libc.so.6
> > >   #1  0x00007fffdb5b351a in abort () at /lib64/libc.so.6
> > >   #2  0x00007fffdb5a9da7 in __assert_fail_base () at /lib64/libc.so.6
> > >   #3  0x00007fffdb5a9e52 in  () at /lib64/libc.so.6
> > >   #4  0x000055555577a5fa in qemu_ram_set_idstr (new_block=3D0x5555567=
47a00, name=3D<optimized out>, dev=3Ddev@entry=3D0x555556705590) at qemu/ex=
ec.c:1709
> > >   #5  0x0000555555a0fe86 in vmstate_register_ram (mr=3Dmr@entry=3D0x5=
5555673a0e0, dev=3Ddev@entry=3D0x555556705590) at migration/savevm.c:2293
> > >   #6  0x0000555555965088 in pc_dimm_memory_plug (dev=3Ddev@entry=3D0x=
555556705590, hpms=3Dhpms@entry=3D0x5555566bb0e0, mr=3Dmr@entry=3D0x5555567=
05630, align=3D<optimized out>, errp=3Derrp@entry=3D0x7fffffffc660)
> > >       at hw/mem/pc-dimm.c:110
> > >   #7  0x000055555581d89b in pc_dimm_plug (errp=3D0x7fffffffc6c0, dev=
=3D0x555556705590, hotplug_dev=3D<optimized out>) at qemu/hw/i386/pc.c:1713
> > >   #8  0x000055555581d89b in pc_machine_device_plug_cb (hotplug_dev=3D=
<optimized out>, dev=3D0x555556705590, errp=3D0x7fffffffc6c0) at qemu/hw/i3=
86/pc.c:2004
> > >   #9  0x0000555555914da6 in device_set_realized (obj=3D<optimized out=
>, value=3D<optimized out>, errp=3D0x7fffffffc7e8) at hw/core/qdev.c:926
> > >=20
> > > Cc: Haozhong Zhang <haozhong.zhang@intel.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  hw/i386/pc.c | 14 ++++++++------
> > >  1 file changed, 8 insertions(+), 6 deletions(-)
> >=20
> > Michael: Do you want to take this through your tree?
>=20
> Yes - it will be in the next pull.

Thank you!

Stefan

--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZR7z5AAoJEJykq7OBq3PI7IEIAILsasvSwDFF72qJ0L9Mak3u
/W3OtEsbTQd2cKBAy+daR/asHEhYUlPlsE0GIc9X8cwBElLJGA82Qq7vr5w7E0Yo
FNLAt4OBF9fyv0fKh8fD/EAxZLsUB1Kj7PapZB+rI74cXrUy1tSLjP6tosmTqbtk
dUBbGzDtc61SEbhJs6mYxy6AYcEn6chnLMrMftVwDdr6xoDqlAv9pSZ83n0hT7Ng
5Is049Ojxx1FGQlBkLgF6j9Pbqi2pbE3XzFT4P0GryaLfIxtlw441Z+gO1bYTIYg
fEjyecge8+LMkRLaWkGgABINd1afkkFPI/IEtnCdLk/6JBv8MVGS3YyLW7DdXEM=
=RF4b
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--
