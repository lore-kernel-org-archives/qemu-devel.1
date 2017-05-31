Received: from eggs.gnu.org ([2001:4830:134:3::10]:42878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dG3hz-00005B-31
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dG3hv-0002LC-Pu
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:30:43 -0400
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:34941)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dG3hv-0002KR-JV
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:30:39 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id EB458FFBAC
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 15:30:37 +0200 (CEST)
Date: Wed, 31 May 2017 15:30:27 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170531153027.6133baef@bahia.lan>
In-Reply-To: <32546ddf-a725-5dd4-95cb-75a41da8e6ec@redhat.com>
References: <149615665491.28067.17765793725374594694.stgit@bahia.lan>
	<e8fdae1c-9d3c-1059-509a-6b85000e83a9@de.ibm.com>
	<20170530185618.2e875ebb@bahia.ttt.fr.ibm.com>
	<32546ddf-a725-5dd4-95cb-75a41da8e6ec@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/w6Qx23FL5Qi8A.0tYGi_Bgl";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] pc-bios/s390-ccw: use STRIP
 variable in Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-trivial@nongnu.org, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

--Sig_/w6Qx23FL5Qi8A.0tYGi_Bgl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 31 May 2017 15:15:56 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> On 30/05/2017 18:56, Greg Kurz wrote:
> > On Tue, 30 May 2017 18:34:46 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >  =20
> >> On 05/30/2017 05:04 PM, Greg Kurz wrote: =20
> >>> The docker-run-test-build@debian-s390x-cross target fails with:
> >>>
> >>> strip --strip-unneeded s390-ccw.elf -o s390-ccw.img
> >>> strip: Unable to recognise the format of the input file `s390-ccw.elf'
> >>>
> >>> The configure script defines a STRIP makefile variable whose default
> >>> value is ${cross_prefix}strip. Let's use it.
> >>>
> >>> Signed-off-by: Greg Kurz <groug@kaod.org>
> >>> ---
> >>>  pc-bios/s390-ccw/Makefile |    2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> >>> index 79a46b67356f..7af57dad109c 100644
> >>> --- a/pc-bios/s390-ccw/Makefile
> >>> +++ b/pc-bios/s390-ccw/Makefile
> >>> @@ -22,7 +22,7 @@ s390-ccw.elf: $(OBJECTS)
> >>>  	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $(OBJECTS),"BUILD","$(T=
ARGET_DIR)$@")
> >>>
> >>>  s390-ccw.img: s390-ccw.elf
> >>> -	$(call quiet-command,strip --strip-unneeded $< -o $@,"STRIP","$(TAR=
GET_DIR)$@")
> >>> +	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,"STRIP","$(=
TARGET_DIR)$@")
> >>>
> >>>  $(OBJECTS): Makefile
> >>>
> >>>    =20
> >>
> >> I was going to apply this, but it fails with --disable-strip like
> >>
> >>     /bin/sh: --strip-unneeded: command not found
> >>     Makefile:25: recipe for target 's390-ccw.img' failed
> >>     make[1]: *** [s390-ccw.img] Error 127
> >>     Makefile:354: recipe for target 'romsubdir-s390-ccw' failed
> >>     make: *** [romsubdir-s390-ccw] Error 2
> >>
> >> Not yet sure whats going on.
> >> =20
> >=20
> > configure doesn't generate STRIP when --disable-strip or --enable-debug=
... so
> > I guess we shouldn't use it here, but rather generate a s390_cross_pref=
ix like
> > in roms/Makefile ?
> >  =20
>=20
> I experimented the problem when I played with docker, and fixed the
> problem as you did (with STRIP).
>=20

I've sent a v2 with a 'STRIP ?=3D strip' line to handle the issue reported
by Christian.

> But I think it's a good idea to compile s390 rom as it is done for ppc64
> and ppc roms.
>=20

Yeah, I was thinking about that too but I don't know all the ins and outs.

> Laurent


--Sig_/w6Qx23FL5Qi8A.0tYGi_Bgl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkuxXQACgkQAvw66wEB28K00wCfdjhi2dR+/3cR0iZQBmtlKBDB
ND0Anjr+Q7vGgjXN5nOq2tHDPwEXAGur
=Fbi9
-----END PGP SIGNATURE-----

--Sig_/w6Qx23FL5Qi8A.0tYGi_Bgl--
