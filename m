Received: from eggs.gnu.org ([2001:4830:134:3::10]:42229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1clgpI-0007nC-FL
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:00:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1clgpE-0001wQ-Hi
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:00:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1clgpE-0001w2-9H
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:00:40 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 354B381254
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 19:00:40 +0000 (UTC)
References: <20170221115644.28264-1-stefanha@redhat.com>
	<20170221115644.28264-8-stefanha@redhat.com>
	<c27b009c-bdd9-706c-74b3-bc13453c97a5@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a262068f-4c57-beda-d113-98a5e22ce04a@redhat.com>
Date: Wed, 8 Mar 2017 20:00:32 +0100
MIME-Version: 1.0
In-Reply-To: <c27b009c-bdd9-706c-74b3-bc13453c97a5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m5cPtJ6fTRXDnMxvcjDFMKCjvPf5gW0AR"
Subject: Re: [Qemu-devel] [PULL v2 07/24] nbd: convert to use
 qio_channel_yield
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m5cPtJ6fTRXDnMxvcjDFMKCjvPf5gW0AR
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <a262068f-4c57-beda-d113-98a5e22ce04a@redhat.com>
Subject: Re: [Qemu-devel] [PULL v2 07/24] nbd: convert to use
 qio_channel_yield
References: <20170221115644.28264-1-stefanha@redhat.com>
 <20170221115644.28264-8-stefanha@redhat.com>
 <c27b009c-bdd9-706c-74b3-bc13453c97a5@redhat.com>
In-Reply-To: <c27b009c-bdd9-706c-74b3-bc13453c97a5@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 06.03.2017 22:04, Max Reitz wrote:
> On 21.02.2017 12:56, Stefan Hajnoczi wrote:
>> From: Paolo Bonzini <pbonzini@redhat.com>
>>
>> In the client, read the reply headers from a coroutine, switching the
>> read side between the "read header" coroutine and the I/O coroutine th=
at
>> reads the body of the reply.
>>
>> In the server, if the server can read more requests it will create a n=
ew
>> "read request" coroutine as soon as a request has been read.  Otherwis=
e,
>> the new coroutine is created in nbd_request_put.
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
>> Message-id: 20170213135235.12274-8-pbonzini@redhat.com
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>  block/nbd-client.h |   2 +-
>>  block/nbd-client.c | 117 ++++++++++++++++++++++++--------------------=
---------
>>  nbd/client.c       |   2 +-
>>  nbd/common.c       |   9 +----
>>  nbd/server.c       |  94 +++++++++++++-----------------------------
>>  5 files changed, 83 insertions(+), 141 deletions(-)
>=20
> git-bisect tells me this broke qemu-iotest 083 (which hangs now).

And it also breaks 094 by failing an assertion:

> QEMU_PROG: qemu/io/channel.c:306: qio_channel_yield: Assertion `!ioc->r=
ead_coroutine' failed.

That looks a bit worse to me.

(I didn't see it before because I just decided to stop the iotests at
083 and didn't run the ones after it...)

Max


--m5cPtJ6fTRXDnMxvcjDFMKCjvPf5gW0AR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljAVNASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AA8AH+wY7dURzbDLlr6Cw4cmnHzgQo6Otc3HG
vm4BinfEbyL1IPdChOAjGLoVKI/fiMQLL8UPlP8WcZQf4f7Jfv5XQZylUnpT7xFI
r2k9V2lYMD1dtqdwapX8swBosrzeQi6P4BvhT0s02wWZuqbCeoc0wtbRUxsDqCru
pzfoXn+eqmEYsFjLJQTIgGHrFCZIuPQkTihQTzuemy1YkS7OgkKaqD/j0j0Yl4oo
CjjryYfjbhJla0Pqz6UrwDl2CyOir285Z9GLmSB5PSCgihMuxENLuKA4vJTZldDJ
bxnHeB4uXAYCezXJFEaBsEkeAWPYbbdmMsAkP8tD0pCNbxn1FjxHujE=
=OVoF
-----END PGP SIGNATURE-----

--m5cPtJ6fTRXDnMxvcjDFMKCjvPf5gW0AR--
