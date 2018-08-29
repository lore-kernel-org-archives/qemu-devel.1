Received: from eggs.gnu.org ([2001:4830:134:3::10]:45410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuvrb-0006so-OR
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 04:30:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuvra-0007Rg-Kw
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 04:30:07 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-6-jsnow@redhat.com>
	<553da197-ebd0-1eda-909c-aa0740332737@redhat.com>
	<0b63f8aa-16eb-b719-b903-dff693753e8b@redhat.com>
	<70d6a96e-ac23-101c-bf10-d9855fe2ec9e@redhat.com>
	<1920b33f-6773-b224-23b6-74874641f639@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <595465e4-2450-25b1-2095-1217f34fb50f@redhat.com>
Date: Wed, 29 Aug 2018 10:28:57 +0200
MIME-Version: 1.0
In-Reply-To: <1920b33f-6773-b224-23b6-74874641f639@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JqQSDrrM5wUg3wQwL9WeggThprnRlx2HH"
Subject: Re: [Qemu-devel] [PATCH 5/7] block/mirror: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JqQSDrrM5wUg3wQwL9WeggThprnRlx2HH
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com,
 Fam Zheng <famz@redhat.com>
Message-ID: <595465e4-2450-25b1-2095-1217f34fb50f@redhat.com>
Subject: Re: [PATCH 5/7] block/mirror: utilize job_exit shim
References: <20180817190457.8292-1-jsnow@redhat.com>
 <20180817190457.8292-6-jsnow@redhat.com>
 <553da197-ebd0-1eda-909c-aa0740332737@redhat.com>
 <0b63f8aa-16eb-b719-b903-dff693753e8b@redhat.com>
 <70d6a96e-ac23-101c-bf10-d9855fe2ec9e@redhat.com>
 <1920b33f-6773-b224-23b6-74874641f639@redhat.com>
In-Reply-To: <1920b33f-6773-b224-23b6-74874641f639@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-28 22:25, John Snow wrote:
>=20
>=20
> On 08/25/2018 11:02 AM, Max Reitz wrote:
>> If you say so...  I have to admit I don't really understand.  The
>> comment doesn't explain why it's so important to keep src around until=

>> job_completed(), so I don't know.  I thought AioContexts are recursive=

>> so it doesn't matter whether you take them recursively or not.
>=20
> bdrv_flush has troubles under a recursive lock if it is invoked from a
> different thread. It tries to poll for flush completion but the
> coroutine which gets scheduled (instead of entered) can't actually run
> if we hold the lock twice from, say, the main thread -- which is where
> we're doing the graph manipulation from.
>=20
>>        co =3D qemu_coroutine_create(bdrv_flush_co_entry, &flush_co);
>>        bdrv_coroutine_enter(bs, co);
>>        BDRV_POLL_WHILE(bs, flush_co.ret =3D=3D NOT_DONE);
>=20
> BDRV_POLL_WHILE there causes us the grief via AIO_WAIT_WHILE, which onl=
y
> puts down one reference, so we deadlock in bdrv_flush in a recursive
> context.
>=20
> Kevin helped me figure it out; I CC'd him off-list on a mail that you
> were also CC'd on ("hang in mirror_exit") that's probably pretty helpfu=
l:
>=20
>> Took a little more than five minutes, but I think I've got it now. The=

>> important thing is that the test case is for dataplane, i.e. the job
>> runs in an I/O thread AioContext. Job completion, however, happens in
>> the main loop thread.
>>
>> Therefore, when bdrv_delete() wants to flush the node first, it needs =
to
>> run bdrv_co_flush() in a foreign AioContext, so the coroutine is
>> scheduled. The I/O thread backtrace shows that it's waiting for the
>> AioContext lock before it can actually enter the bdrv_co_flush()
>> coroutine, so we must have deadlocked:

OK, that makes more sense.  I still would have thought that you should
always be allowed to take an AioContext lock more than once in a single
other AioContext, but on my way through the commit log, I found
bd6458e410c1e7, d79df2a2ceb3cb07711, and maybe most importantly
17e2a4a47d4.  So maybe not.

So at some point we decided that, yeah, you can take them multiple times
in a single context, and, yeah, that was how it was designed, but don't
do that if you expect a BDRV_POLL_WHILE().

OK.  Got it now.

Max


--JqQSDrrM5wUg3wQwL9WeggThprnRlx2HH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGWUkACgkQ9AfbAGHV
z0Arbgf+OtaUVo8Mu4NMgkTqQfhs/WXeiUy/YJ9AKfHsI9djUIGjCBitg+NNSWOr
4ucVyN/fUPfm0A0PHDmPZh4iHcUY8NCRTyuZ0aEVibLV6+n6uvFNF6yrmwttfH1a
V/9Zi7R3l6jqaxtbRx9BIU0s2fjgAsGG8NyhoQV2UnTQ4OwuW1YyVxCr2IUz7Wj9
oyH3pTsabdKjyDODmycLgmfgm0AmykGXDEJJszOCHcszRXbohSz531HDDUbigvRg
A1rdP+42K1bpDS6Cfxptgizxk7QCctN85/3ceJKEOJSM97sUYIc9H2vecjjFoPlU
4bcYXuCJxBo3SZwrvPbFhJDAKU9AQw==
=UuaQ
-----END PGP SIGNATURE-----

--JqQSDrrM5wUg3wQwL9WeggThprnRlx2HH--
