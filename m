Received: from eggs.gnu.org ([2001:4830:134:3::10]:58770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCo5o-0000B8-AU
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCo5i-0004iB-Mj
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:46:08 -0500
References: <20171108215703.9295-1-eblake@redhat.com>
	<20171108215703.9295-7-eblake@redhat.com>
	<22a7af7d-6ce4-c73d-1559-58a30ba2115d@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a87d9893-53fa-0dec-79b9-7f1f6a4c3db5@redhat.com>
Date: Thu, 9 Nov 2017 08:45:49 -0600
MIME-Version: 1.0
In-Reply-To: <22a7af7d-6ce4-c73d-1559-58a30ba2115d@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fMAEpg88WsGOcH6swSgnwAQ7eNhPue0wK"
Subject: Re: [Qemu-devel] [PATCH v2 6/7] nbd-client: Stricter enforcing of
 structured reply spec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fMAEpg88WsGOcH6swSgnwAQ7eNhPue0wK
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com,
 Max Reitz <mreitz@redhat.com>
Message-ID: <a87d9893-53fa-0dec-79b9-7f1f6a4c3db5@redhat.com>
Subject: Re: [PATCH v2 6/7] nbd-client: Stricter enforcing of structured reply
 spec
References: <20171108215703.9295-1-eblake@redhat.com>
 <20171108215703.9295-7-eblake@redhat.com>
 <22a7af7d-6ce4-c73d-1559-58a30ba2115d@virtuozzo.com>
In-Reply-To: <22a7af7d-6ce4-c73d-1559-58a30ba2115d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/09/2017 03:37 AM, Vladimir Sementsov-Ogievskiy wrote:
> 09.11.2017 00:57, Eric Blake wrote:
>> Ensure that the server is not sending unexpected chunk lengths
>> for either the NONE or the OFFSET_DATA chunk, nor unexpected
>> hole length for OFFSET_HOLE.=C2=A0 This will flag any server that
>> responds to a zero-length read with an OFFSET_DATA as broken,
>=20
> or OFFSET_HOLE

True, even though our implementation was not doing that.  I can tweak
the commit message.

>=20
>> even though we previously fixed our client to never be able to
>> send such a request over the wire.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>> =C2=A0 block/nbd-client.c | 12 +++++++++---
>> =C2=A0 1 file changed, 9 insertions(+), 3 deletions(-)
>>

>> @@ -281,7 +281,8 @@ static int
>> nbd_co_receive_offset_data_payload(NBDClientSession *s,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(nbd_reply_is_structured(&s->repl=
y));
>>
>> -=C2=A0=C2=A0=C2=A0 if (chunk->length < sizeof(offset)) {
>> +=C2=A0=C2=A0=C2=A0 /* The NBD spec requires at least one byte of payl=
oad */
>> +=C2=A0=C2=A0=C2=A0 if (chunk->length <=3D sizeof(offset)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp=
, "Protocol error: invalid payload for "
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "NBD_REPLY_TYPE_OFFSET_DATA");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;=

>> @@ -293,7 +294,7 @@ static int
>> nbd_co_receive_offset_data_payload(NBDClientSession *s,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be64_to_cpus(&offset);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data_size =3D chunk->length - sizeof(of=
fset);
>> -=C2=A0=C2=A0=C2=A0 if (offset < orig_offset || data_size > qiov->size=
 ||
>> +=C2=A0=C2=A0=C2=A0 if (!data_size || offset < orig_offset || data_siz=
e > qiov->size ||
>=20
> !data_size - always false here (because of previous check), and even if=

> it could be zero it
> isn't correspond to error message.
>=20
> without this, or with an assert instead:

I like the assert instead.

>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
>=20

Thanks for the reviews; I'll queue this series onto my NBD tree with
your suggestions incorporated, and send a pull request for 2.11 shortly.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fMAEpg88WsGOcH6swSgnwAQ7eNhPue0wK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloEah4ACgkQp6FrSiUn
Q2psVwf9ELVdVi2lgTQMyQ0omswru/UMySPW1hP51UY5fpEIyJgrv7vKANgHz3xM
iSRHHOxa20JLg7TiydTQzWquqXZixITPtmU6F88n9Mfc8+xmw+WsiuNFl57MTXRD
5H0wGFmXOKWkv7mnQEwSVEVUFheQv44yFXNFtX0OEz7roJ+ctokG/YUZU3ReuXlN
SbO/7zPcV2+ngWGiWZnCqW7EDVySt7O6d4KED8xAOVJNb1PbJ3jPkNfnfSV5AIsD
mf1e/77kL7OfF2q2nDqU/rqCDllBSKX07/GEf/NqyjqdwjaHB5aTMgdSY2aVe7oU
hACnyXt0vuFf9b8Qek4Yd0uiFbRgxA==
=36jX
-----END PGP SIGNATURE-----

--fMAEpg88WsGOcH6swSgnwAQ7eNhPue0wK--
