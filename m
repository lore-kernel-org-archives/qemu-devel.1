Received: from eggs.gnu.org ([2001:4830:134:3::10]:33936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fpFCr-0005tE-KJ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fpFCq-0002uo-NK
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:56:33 -0400
Date: Mon, 13 Aug 2018 16:56:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180813155622.GA18429@stefanha-x1.localdomain>
References: <20180803144721.17036-1-stefanha@redhat.com>
	<20180803144721.17036-6-stefanha@redhat.com>
	<1a84a9fc-93f8-3573-c27e-bb60d9c48a7a@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <1a84a9fc-93f8-3573-c27e-bb60d9c48a7a@amsat.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v4 5/6] loader: Implement .hex
 file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Su Hang <suhang16@mails.ucas.ac.cn>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, jim@groklearning.com, mail@steffen-goertz.de, ilg@livius.net, Alistair Francis <alistair@alistair23.me>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, jusual@mail.ru


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 02:00:44AM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 08/03/2018 11:47 AM, Stefan Hajnoczi wrote:
> > +        parser->rom_start_address =3D parser->next_address_to_write;
> > +        parser->current_rom_index =3D 0;
> > +        break;
> > +
> > +    case START_SEG_ADDR_RECORD:
> > +        if (line->byte_count !=3D 4 && line->address !=3D 0) {
> > +            return -1;
> > +        }
> > +
> > +        /* x86 16-bit CS:IP segmented addressing */
> > +        *(parser->start_addr) =3D (((line->data[0] << 8) | line->data[=
1]) << 4) |
> > +                                (line->data[2] << 8) | line->data[3];
>=20
> Can you add a qtest for this case?
> For the HEX loader I understand the specs as this is the same parsing as
> the START_LINEAR_ADDR_RECORD case; so I disagree with data[0] and
> data[1] shifts.

x86 real-mode CS:IP addressing means (CS << 4) + IP.  It produces 24-bit
addresses on 80286 and later.  This is not the same as
START_LINEAR_ADDR_RECORD.

GNU bfd implements it as follows:

  abfd->start_address +=3D (HEX4 (buf) << 4) + HEX4 (buf + 4);

https://sourceware.org/git/?p=3Dbinutils.git;a=3Dblob;f=3Dbfd/ihex.c;h=3D09=
f756a1c2c11e57c5da15a6ff96491275575b86;hb=3DHEAD#l415

Thanks for commenting on this, I had written (CS << 4) | IP instead of
(CS << 4) + IP.  This will be fixed in the next revision.

> This is different for the consumer (i386 expects 2 16-bit registers but
> HexParser->start_addr is a hwaddr, used as a single (at least) 32-bit
> register.

I think you're saying that on x86 the guest CS:IP registers should be
set.  This loader is never called from hw/i386/ so it doesn't matter at
this time.

GNU bfd uses START_SEG_ADDR_RECORD records on non-x86 architectures
where there are no segment registers and that's where we've encountered
them.

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbcaomAAoJEJykq7OBq3PIu8kH/i5D2D7Ej20E40WFfZQUrdit
uDgjAyam/swlhU47rMEC4dcjHKnQQu4AXwygERHn6Xym2WP7X3THXU/5N5UgOBu1
uTcSoGq9u9y3cm3y6zLVqBDpl6n5Kfcsr85JnMEa5M9xjEqq3cG96XFB9xWggkYK
B7tgaSRWaEtSNiMCQqqgny+nboOxRMr/Edsu+IPkHjoVfMfsm9FERgRVzfhezZpp
IiVJ4eKn7DiOH5tkesXrxgkYzzRWaqfecQ5tbY4KZ0mpLvwqapr2HwoAuKo+kfO+
6g4vdbvuPJymZY7Q+DMqfMhGFBLKgMmWnlY3eQWjcvBw8XFXHJzMhCy6kqc6ttw=
=dYus
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
