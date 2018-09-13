Received: from eggs.gnu.org ([2001:4830:134:3::10]:57439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0Ra7-0008AO-Bj
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0Ra1-0004zx-IY
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:22:50 -0400
References: <CAB3eZfsvnyyo0C4nU=Mucg51krnN9Q9ExKA0t4AEEA3DiOd2aA@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ce6e31f1-0190-89ea-3aae-90ccdf81c585@redhat.com>
Date: Thu, 13 Sep 2018 15:22:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAB3eZfsvnyyo0C4nU=Mucg51krnN9Q9ExKA0t4AEEA3DiOd2aA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GMIUfqulvemB1ATtCOqztPNivgEMV3oMc"
Subject: Re: [Qemu-devel] Can I only commit from active image to
 corresponding range of its backing file by qemu cmd?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lampahome <pahome.chen@mirlab.org>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GMIUfqulvemB1ATtCOqztPNivgEMV3oMc
From: Max Reitz <mreitz@redhat.com>
To: lampahome <pahome.chen@mirlab.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Message-ID: <ce6e31f1-0190-89ea-3aae-90ccdf81c585@redhat.com>
Subject: Re: [Qemu-devel] Can I only commit from active image to corresponding
 range of its backing file by qemu cmd?
References: <CAB3eZfsvnyyo0C4nU=Mucg51krnN9Q9ExKA0t4AEEA3DiOd2aA@mail.gmail.com>
In-Reply-To: <CAB3eZfsvnyyo0C4nU=Mucg51krnN9Q9ExKA0t4AEEA3DiOd2aA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.09.18 05:33, lampahome wrote:
> I split data to 3 chunks and save it in 3 independent backing files lik=
e
> below:
> img.000 <-- img.001 <-- img.002
> img.000 is the backing file of img.001 and 001 is the backing file of 0=
02.
> img.000 saves the 1st chunk of data and img.001 saves the 2nd chunk of
> data, and img.002 saves the 3rd chunk of data.
>=20
> Now I have img.003 stores cow data of 1st chunk and img.002 is the back=
ing
> file of img.003.
> The backing chain is like this:
>   img.000 <-- img.001 <-- img.002 <-- img.003
>=20
> So that means the data of img.003 saves the same range with img.000 but=

> different data.
>=20
> I know I can use *`qemu-img commit'* but it only commit the data from
> img.003 to img.002.
>=20
> If I use *`qemu-img rebase -b img.000 img.003`*, the data of img.001 an=
d
> img.002 will merge into img.003.
>=20
> What I want is only commit the data in img.003 into img.000 because the=

> data of the two image are the same range(1st chunk)
>=20
> Is there anyway to commit(or merge) data of active image into correspon=
ding
> backing file?

So img.000, img.001, and img.002 all contain data at completely
different areas, and img.003 only contains data where img.000 contains
data as well?

Say like so:

$ qemu-img create -f qcow2 img.000 3M
$ qemu-img create -f qcow2 -b img.000 img.001
$ qemu-img create -f qcow2 -b img.001 img.002
$ qemu-img create -f qcow2 -b img.002 img.003
$ qemu-io -c 'write -P 1 0M 1M' img.000
$ qemu-io -c 'write -P 2 1M 1M' img.001
$ qemu-io -c 'write -P 3 2M 1M' img.002
$ qemu-io -c 'write -P 4 0M 1M' img.003

(img.000 contains 1s from 0M to 1M;
 img.001 contains 2s from 1M to 2M;
 img.002 contains 3s from 2M to 3M;
 img.003 contains 4s from 0M to 1M (the range of img.000))

In that case, rebase -u might be what you want, so the following should
work (although it can easily corrupt your data if it isn't the case[1]):

$ qemu-img rebase -u -b img.000 img.003
$ qemu-img commit img.003

(And then maybe
$ qemu-img rebase -u -b img.002 img.003
to return to the previous backing chain.)

Max


[1] It will corrupt your data if img.001 or img.002 contain any data
where img.003 also contains data; because then that data of img.003 will
be hidden when viewed through img.001 and img.002.


--GMIUfqulvemB1ATtCOqztPNivgEMV3oMc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluaZJUACgkQ9AfbAGHV
z0DiowgArqx1l9h0O3v8Ahfy919/FtgCU6mkqaX6k1I0NDgJPRJhm80njlZJySp6
ucCUurs8acaZPCeviyynvST59gjW5sEZlkGeqiPEc89cJQYHq+K1YIHYepkwW57S
qDuaDY7pH62QYJXeAHvyzLSA4j9MDoqZkfM7QsG1AuvdNoH1B5/CA7dikcbpXPmW
zWEPJ0G2DxGeFyuBZkWKCXRkyGCV574zo0NMt1nX3OLN2iXs88MfCG2o5+rQ3ncX
8kFHcdkQu/LYw5NfkeEm5iGLHpSbzOQ1iAB03MveGpoQ3sCShzVtZJHWK5scv6Ro
j5Gl8nItz037keJ14beBrYSk9wGlZg==
=K7MZ
-----END PGP SIGNATURE-----

--GMIUfqulvemB1ATtCOqztPNivgEMV3oMc--
