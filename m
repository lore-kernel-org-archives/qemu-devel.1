Received: from eggs.gnu.org ([2001:4830:134:3::10]:42502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dipRk-0007Q4-IX
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 18:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dipRg-0002Tv-UT
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 18:08:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dipRg-0002TJ-K2
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 18:08:48 -0400
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-8-eblake@redhat.com>
	<a12d0bfc-4112-414c-6d19-8f9071b5f936@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c8880b01-c9dd-50f9-66c4-db79e69b836e@redhat.com>
Date: Fri, 18 Aug 2017 17:08:45 -0500
MIME-Version: 1.0
In-Reply-To: <a12d0bfc-4112-414c-6d19-8f9071b5f936@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AGHU91NNTBVoMNMbs5Aln0x2LrJHJ98ks"
Subject: Re: [Qemu-devel] [PATCH v5 07/13] libqtest: Inline
 qtest_query_target_endianness()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AGHU91NNTBVoMNMbs5Aln0x2LrJHJ98ks
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <c8880b01-c9dd-50f9-66c4-db79e69b836e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 07/13] libqtest: Inline
 qtest_query_target_endianness()
References: <20170818211542.5380-1-eblake@redhat.com>
 <20170818211542.5380-8-eblake@redhat.com>
 <a12d0bfc-4112-414c-6d19-8f9071b5f936@amsat.org>
In-Reply-To: <a12d0bfc-4112-414c-6d19-8f9071b5f936@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/18/2017 04:46 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 08/18/2017 06:15 PM, Eric Blake wrote:
>> There was only one caller; it's easier to inline things.
>=20
> What's the benefit of this change? Having a separate function ease code=

> reading. You might add the 'inline' qualifier but the compiler is smart=

> enough to inline it.
>=20
> Instead of this change I'd inline it and remove the return value, havin=
g
> a void function initializing s->big_endian. Matter of taste I think :)
>=20
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   tests/libqtest.c | 22 ++++++----------------
>>   1 file changed, 6 insertions(+), 16 deletions(-)

I think the diffstat shows that inlining is a win.  My other reason that
it is a win:

>> @@ -351,8 +338,11 @@ QTestState
>> *qtest_init_without_qmp_handshake(const char *extra_args)
>>       }
>>
>>       /* ask endianness of the target */
>> -
>> -    s->big_endian =3D qtest_query_target_endianness(s);
>> +    qtest_sendf(s, "endianness\n");
>> +    args =3D qtest_rsp(s, 1);

The old code has to pass an arbitrary QTestState *s down to a helper
function.  But I'm trying to get rid of as many functions as possible
that depend on arbitrary QTestState *s, particularly when callers end up
passing 'global_qtest' for 's'.  Inlining it makes it more obvious that
the changes in 10/13 are safely operating on global_qtest, which in turn
makes it possible for 12/13 to drop QTestState *s parameters from
qtest_sendf() and qtest_rsp().  If the function were not inlined, those
later cleanups would not be as trivial.  (Or put another way - I rebased
this patch to be earlier in the series precisely because of what I ran
into while writing those patches)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AGHU91NNTBVoMNMbs5Aln0x2LrJHJ98ks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmXZW0ACgkQp6FrSiUn
Q2oUXwgAn7bzc42JEQ//5JdjTVkM0v58dGfctA/dfenSHu7H6wCFti8FGyJDRJUn
QfzM6w/m0l7cgorY2GL234pmGW6UBoL7JitGXx3prWherNTc7eelkrQnmwMF8Xjy
fCGUg9JTla1QnmnZfO/Vgwh0xOpI5xSix+/HL7PdqK+KmECyQ0lGE2bKzs2tqw4U
5hTm6QZMP6VFBrERb49z1Vf+WCQyxVmqt37CSdkkQ7aagZE8sjdAVD95wxcptj6X
4yNSxlyKVdm1pm9RJmEkbG7UMz9joYDG93M3APFY6A6FHuDVLiu2v8geqi+BGRVB
Ll9YAEX0lTW7/NSXvblU7ry0URLuNw==
=i6eM
-----END PGP SIGNATURE-----

--AGHU91NNTBVoMNMbs5Aln0x2LrJHJ98ks--
