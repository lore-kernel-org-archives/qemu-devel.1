Received: from eggs.gnu.org ([209.51.188.92]:46525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyzDv-0002Tz-2J
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:26:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyzDu-0001Ia-1z
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:26:10 -0500
References: <1549974951-731285-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<5c72aad4-d1bc-7241-a972-32dd07ef23b0@virtuozzo.com>
	<efdc687a-239e-3f30-c2d8-e46a47029496@redhat.com>
	<7414a532-3005-5cfe-6f29-77cf95eeb4d2@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7dc5a22b-88fe-883d-0dd8-1101d67891f5@redhat.com>
Date: Wed, 27 Feb 2019 14:25:54 +0100
MIME-Version: 1.0
In-Reply-To: <7414a532-3005-5cfe-6f29-77cf95eeb4d2@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jnEdEmSIIdmiU37CzooCDKFPqBrQyzn2t"
Subject: Re: [Qemu-devel] [PATCH] Discard old bitmap directories in QCOW2
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jnEdEmSIIdmiU37CzooCDKFPqBrQyzn2t
From: Max Reitz <mreitz@redhat.com>
To: Denis Lunev <den@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>
Message-ID: <7dc5a22b-88fe-883d-0dd8-1101d67891f5@redhat.com>
Subject: Re: [PATCH] Discard old bitmap directories in QCOW2 image
References: <1549974951-731285-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <5c72aad4-d1bc-7241-a972-32dd07ef23b0@virtuozzo.com>
 <efdc687a-239e-3f30-c2d8-e46a47029496@redhat.com>
 <7414a532-3005-5cfe-6f29-77cf95eeb4d2@virtuozzo.com>
In-Reply-To: <7414a532-3005-5cfe-6f29-77cf95eeb4d2@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.02.19 14:16, Denis Lunev wrote:
> On 2/27/19 4:00 PM, Max Reitz wrote:
>> On 18.02.19 16:36, Vladimir Sementsov-Ogievskiy wrote:
>>> 12.02.2019 15:35, Andrey Shinkevich wrote:
>>>> Clean QCOW2 image from bitmap obsolete directory when a new one
>>>> is allocated and stored. It slows down the image growth a little bit=
=2E
>>>> The flag QCOW2_DISCARD_ALWAYS allows a call to raw_co_pdiscard()
>>>> that does the actual cleaning of the image on disk.
>>>> With the flag QCOW2_DISCARD_OTHER, a reference count of the cluster
>>>> is updated only.
>>>>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>
>>> side question: should not we change discard_passthrough[QCOW2_DISCARD=
_OTHER] to
>>> true or at least flags&BDRV_O_UNMAP by default? What is the reason of=
 not discarding
>>> things in qcow2-cluster?
>> As far as I remember the reason is that whenever you clean up somethin=
g
>> its cluster is probably going to be reused rather soon.  So cleaning u=
p
>> takes longer, repopulating that cluster takes longer, and you save onl=
y
>> rather little space.
>>
>> This is also why I don't know whether this patch makes much sense.
>>
>> Max
>>
> This depands upon the amount of actually free clusters in the image.
> If there a lot of them at the moment, this one could be refilled
> any time later on.

Well, it's a trade-off.  For small structures like the bitmap directory,
I don't see the point in forcefully unmapping them.  We don't do it for
the old L1 table either when that has to be resized.

Discarding a whole bitmap (like in clear_bitmap_table()) is something
else, though.  So I was too quick to dismiss the whole patch; parts of
it do make sense.

For bitmap tables...  I don't know exactly.  I don't think a bitmap
table is ever going to be larger than the L1 table, so it should
probably be handled the same way -- which is to keep QCOW2_DISCARD_OTHER.=


Max


--jnEdEmSIIdmiU37CzooCDKFPqBrQyzn2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlx2j+IACgkQ9AfbAGHV
z0CKrAf/X7Lw67sAlbGhIs0IbjSQNwH5IMWqjwyrLm2/ue3MFCTAZT3ZVaDyjhXy
uaLFMt8CDWqzLtyb+lUNsZDUCKjSyDhF/ojuShlaSwTXUBqal+MrsqN9tdeiYGCE
S+se5SfVfWbnislJNrDJSAHXlwZd64IpfGbA9sHSbSSgoHZY91q+5Pi7CG/RsqEk
RmlZ1po0sIFqFdNaR1HAgJwW0ArOFKimSBIW7RWq+dhMQUDA+3ruajSSW4nxd4mz
4VjvL9cQnGAp6KuAKu3+XfkUPtn94daUW/RWimFyoLEejPa0GaxzA1St7zU2xloC
NfFKA4PudLiF9fdd+lxH3TfsUHbh5g==
=lJsK
-----END PGP SIGNATURE-----

--jnEdEmSIIdmiU37CzooCDKFPqBrQyzn2t--
