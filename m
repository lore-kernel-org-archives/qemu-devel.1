Received: from eggs.gnu.org ([2001:4830:134:3::10]:39087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fpwdH-0004Bd-5H
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fpwdG-0006dq-00
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:18:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180803144721.17036-1-stefanha@redhat.com>
	<20180803144721.17036-6-stefanha@redhat.com>
	<1a84a9fc-93f8-3573-c27e-bb60d9c48a7a@amsat.org>
	<20180813155622.GA18429@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ba150247-7c07-b7fd-f1e8-0c07b5358999@amsat.org>
Date: Wed, 15 Aug 2018 11:18:25 -0300
MIME-Version: 1.0
In-Reply-To: <20180813155622.GA18429@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="UuDcRjS7Zez0TYfEyWAZkHWkYt74ftEMM"
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Su Hang <suhang16@mails.ucas.ac.cn>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, jim@groklearning.com, mail@steffen-goertz.de, ilg@livius.net, Alistair Francis <alistair@alistair23.me>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, jusual@mail.ru

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UuDcRjS7Zez0TYfEyWAZkHWkYt74ftEMM
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Su Hang <suhang16@mails.ucas.ac.cn>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, jim@groklearning.com,
 mail@steffen-goertz.de, ilg@livius.net,
 Alistair Francis <alistair@alistair23.me>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, jusual@mail.ru
Message-ID: <ba150247-7c07-b7fd-f1e8-0c07b5358999@amsat.org>
Subject: Re: [Qemu-arm] [PATCH v4 5/6] loader: Implement .hex file loader
References: <20180803144721.17036-1-stefanha@redhat.com>
 <20180803144721.17036-6-stefanha@redhat.com>
 <1a84a9fc-93f8-3573-c27e-bb60d9c48a7a@amsat.org>
 <20180813155622.GA18429@stefanha-x1.localdomain>
In-Reply-To: <20180813155622.GA18429@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/13/2018 12:56 PM, Stefan Hajnoczi wrote:
> On Fri, Aug 10, 2018 at 02:00:44AM -0300, Philippe Mathieu-Daud=E9 wrot=
e:
>> On 08/03/2018 11:47 AM, Stefan Hajnoczi wrote:
>>> +        parser->rom_start_address =3D parser->next_address_to_write;=

>>> +        parser->current_rom_index =3D 0;
>>> +        break;
>>> +
>>> +    case START_SEG_ADDR_RECORD:
>>> +        if (line->byte_count !=3D 4 && line->address !=3D 0) {
>>> +            return -1;
>>> +        }
>>> +
>>> +        /* x86 16-bit CS:IP segmented addressing */
>>> +        *(parser->start_addr) =3D (((line->data[0] << 8) | line->dat=
a[1]) << 4) |
>>> +                                (line->data[2] << 8) | line->data[3]=
;
>>
>> Can you add a qtest for this case?
>> For the HEX loader I understand the specs as this is the same parsing =
as
>> the START_LINEAR_ADDR_RECORD case; so I disagree with data[0] and
>> data[1] shifts.
>=20
> x86 real-mode CS:IP addressing means (CS << 4) + IP.  It produces 24-bi=
t
> addresses on 80286 and later.  This is not the same as
> START_LINEAR_ADDR_RECORD.

OK!

>=20
> GNU bfd implements it as follows:
>=20
>   abfd->start_address +=3D (HEX4 (buf) << 4) + HEX4 (buf + 4);

Hmm any idea why they use +4 ?

>=20
> https://sourceware.org/git/?p=3Dbinutils.git;a=3Dblob;f=3Dbfd/ihex.c;h=3D=
09f756a1c2c11e57c5da15a6ff96491275575b86;hb=3DHEAD#l415
>=20
> Thanks for commenting on this, I had written (CS << 4) | IP instead of
> (CS << 4) + IP.  This will be fixed in the next revision.
>=20
>> This is different for the consumer (i386 expects 2 16-bit registers bu=
t
>> HexParser->start_addr is a hwaddr, used as a single (at least) 32-bit
>> register.
>=20
> I think you're saying that on x86 the guest CS:IP registers should be
> set.  This loader is never called from hw/i386/ so it doesn't matter at=

> this time.

OK.

>=20
> GNU bfd uses START_SEG_ADDR_RECORD records on non-x86 architectures
> where there are no segment registers and that's where we've encountered=

> them.
>=20


--UuDcRjS7Zez0TYfEyWAZkHWkYt74ftEMM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlt0NjIACgkQ4+MsLN6t
wN4F8A//SCak8dOCJ1TDvHVZwz8dbBSmkf1ag8MypGWL+3ytETg0Fs4fUydOqRty
rL7avDtYE7EQIz5aps/sOzeNtnNqbudNkgNkudzIaAywxIMF17PBta+0IueKQoWX
btgu+Gq/OdQeEWC4bz9Ez8BH0/I+9kJAjuzfSAR2yJXA8zc70qZ+lWC4iTfJ/+Wi
xqulS/C6PC9K68L+8Fxa2CyiA86BA+sc28cdwOuQogYVjS6a3wwZe3deYmWMvLxX
3cmqOTq+Twjp+A9bdbGyEVz15p+dA1xvNvJlxTYN+IaQ8Yg5PIbxUdB1tAOWivE2
mt7G7Qex+1vG8jGS5Ae+9ZLDhtQsv/uQGXFBLphopc8Q3S4Tjz2WHEyXmG6FYxFi
3fVsmxVwAGxjDusl6N0LWqvq/BhU/eAFBK0l+WPVhClI3gRpiW6YZd9XVx+4yX+n
SmV+hWpENDbUyLccfyrPVZ2fswkMxXT3o/F7kPw0JNIPQx2MDg1SuKiHBjWjCeeZ
HTaFf8UWSZ4lrLCAjjssnsQNIelvQiVxJzyP6WBXEUFAhlQH/xD0DEy6AJxWyrYn
+zFNHgb6ijNYX07MNJ0fq5z5ANb3fFtpA0GVumJezXxc780RBVonVBwIkAtEp169
b3oPTPCDxnbL4ZcGDZR79GUCT8EfBOq07z6GsVzeJnjDukPkEOM=
=z7DE
-----END PGP SIGNATURE-----

--UuDcRjS7Zez0TYfEyWAZkHWkYt74ftEMM--
