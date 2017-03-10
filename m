Received: from eggs.gnu.org ([2001:4830:134:3::10]:59856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cnJsx-0003Zy-Oz
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cnJst-0004RM-SH
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:55:15 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cnJst-0004Qn-JL
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:55:11 -0400
Received: by mail-pf0-x241.google.com with SMTP id 67so18077358pfg.2
	for <qemu-devel@nongnu.org>; Sun, 12 Mar 2017 23:55:09 -0700 (PDT)
Date: Fri, 10 Mar 2017 15:58:02 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170310075802.GF4589@stefanha-x1.localdomain>
References: <20170303135150.12145-1-stefanha@redhat.com>
	<CAMRbyysV54S0Sn42WuYFKfNSTMzQxk1yf1PSdrYXSUhiVr9Jjg@mail.gmail.com>
	<f8913ef5-b949-c330-1737-9382e31dcc48@redhat.com>
	<CAMr-obvWX5KSh2bk80Hb07qMrtJzg4PxkRahnJXzbk9HLdbYAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
Content-Disposition: inline
In-Reply-To: <CAMr-obvWX5KSh2bk80Hb07qMrtJzg4PxkRahnJXzbk9HLdbYAQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC 0/4] qemu-img: add max-size subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 04, 2017 at 12:15:00AM +0200, Nir Soffer wrote:
> On Sat, Mar 4, 2017 at 12:02 AM, John Snow <jsnow@redhat.com> wrote:
> >
> >
> > On 03/03/2017 04:38 PM, Nir Soffer wrote:
> >> On Fri, Mar 3, 2017 at 3:51 PM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
> >>>
> >>> RFCv1:
> >>>  * Publishing patch series with just raw support, no qcow2 yet.  Plea=
se review
> >>>    the command-line interface and let me know if you are happy with t=
his
> >>>    approach.
> >>>
> >>> Users and management tools sometimes need to know the size required f=
or a new
> >>> disk image so that an LVM volume, SAN LUN, etc can be allocated ahead=
 of time.
> >>> Image formats like qcow2 have non-trivial metadata that makes it hard=
 to
> >>> estimate the exact size without knowledge of file format internals.
> >>>
> >>> This patch series introduces a new qemu-img subcommand that calculate=
s the
> >>> required size for both image creation and conversion scenarios.
> >>>
> >>> The conversion scenario is:
> >>>
> >>>   $ qemu-img max-size -f raw -O qcow2 input.img
> >>>   107374184448
> >>
> >> Isn't this the minimal size required to convert input.img?
> >>
> >
> > It's an upper bound for the property being measured, which is current
> > allocation size, not maximum potential size after growth.
>=20
> From my point of view, this is the minimal size you must allocate if you
> want to convert the image to logical volume.
>=20
> >
> >>>
> >>> Here an existing image file is taken and the output includes the spac=
e required
> >>> for data from the input image file.
> >>>
> >>> The creation scenario is:
> >>>
> >>>   $ qemu-img max-size -O qcow2 --size 5G
> >>>   196688
> >>
> >> Again, this is the minimal size.
> >>
> >> So maybe use min-size?
> >>
> >> Or:
> >>
> >>     qemu-img measure -f raw -O qcow2 input.img
> >>
> >> Works nicely with other verbs like create, convert, check.
> >>
> >
> > Measure what? This is strictly less descriptive even if "max-size" isn't
> > a verb.
>=20
> measure-size?

You're right, the sub-command should be a verb.

> >> Now about the return value, do we want to return both the minimum size
> >> and the maximum size?
> >>
> >> For ovirt use case, we currently calculate the maximum size by multipl=
ying
> >> by 1.1. We use this when doing automatic extending of ovirt thin provi=
sioned
> >> disk. We start with 1G lv, and extend it each time it becomes full, st=
opping
> >> when we reach virtual size * 1.1. Using more accurate calculation inst=
ead
> >> can be nicer.
> >>
> >> So we can retrun:
> >>
> >> {
> >>     "min-size": 196688,
> >>     "max-size": 5905580032
> >> }
> >>
> >> Anyway thanks for working on this!
> >>
> >
> > It sounds like you want something different from what was intuited by
> > Maor Lipchuck. There are two things to estimate:
> >
> > (A) An estimate of the possible size of an image after conversion to a
> > different format, and
> > (B) An estimate of the possible size after full allocation.
> >
> > I got the sense that Maor was asking for (A), but perhaps I am wrong
> > about that. However, both are "maximums" in different senses.
>=20
> Both are minimum when you have to allocate the space.
>=20
> Maor ask about A because he is working on fixing allocation when
> converting existing files, but we also have other use cases like B.

Daniel Berrange is also interested in the size of a fully populated
image file.  I'll expand the patch series to report both sizes.

Stefan

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYwlyKAAoJEJykq7OBq3PIQMAIALEC2dVtxXks88YDNzj44WU/
jEOBkk15q9lh2PV92EC6CYsjcAgSLvO0rsqfOpgzF2MxNa07d6lAbdFGq1aS0fnZ
4pJrf1VtXxg38YEYH/kD+SmladCHR9oyKsr9TP42jlRtsZBRiJdKMPvc3yQwX2RS
89xKPfwTWj78q8GEFlSsCOH+uKo0PXsa2pcDOn5CDJdTC8GQWsLDT67LDbNAikhe
ATwX6Muha3lWlrY8nDkd47YuYBtAZ7ED/9Au7ejh0vIiPJpPXD87uuvBncNGOqgU
ONRsgJMw5NFUQj/2wgcFHBhKW+UsGr1Ds5m130EpVkjiFEsGGksvQ4/TTkWtXRI=
=p+5U
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--
