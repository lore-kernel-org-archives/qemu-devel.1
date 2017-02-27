Received: from eggs.gnu.org ([2001:4830:134:3::10]:46797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ciOIw-0001to-1y
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ciOIv-00016N-2w
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:37:42 -0500
References: <20170227004545.hzpr266jzturlxdh@var.youpi.perso.aquilenet.fr>
	<4bbc4d50-3c87-bd83-b74d-6aa8b020f2c1@redhat.com>
	<20170227163312.jzszc2ajn3tslrdf@var.youpi.perso.aquilenet.fr>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <877ed8ce-7c47-35d2-444c-d860a480de38@redhat.com>
Date: Mon, 27 Feb 2017 17:37:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170227163312.jzszc2ajn3tslrdf@var.youpi.perso.aquilenet.fr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8qsGsSsQLC1x5JJ7KP7f2fm8IRWVtLLHl"
Subject: Re: [Qemu-devel] [PATCH] blk: Add discard=sparse mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8qsGsSsQLC1x5JJ7KP7f2fm8IRWVtLLHl
From: Max Reitz <mreitz@redhat.com>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <877ed8ce-7c47-35d2-444c-d860a480de38@redhat.com>
Subject: Re: [PATCH] blk: Add discard=sparse mode
References: <20170227004545.hzpr266jzturlxdh@var.youpi.perso.aquilenet.fr>
 <4bbc4d50-3c87-bd83-b74d-6aa8b020f2c1@redhat.com>
 <20170227163312.jzszc2ajn3tslrdf@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20170227163312.jzszc2ajn3tslrdf@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27.02.2017 17:33, Samuel Thibault wrote:
> Hello,
>=20
> Max Reitz, on lun. 27 f=E9vr. 2017 17:12:47 +0100, wrote:
>>>  #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>>> -    if (s->has_discard && s->has_fallocate) {
>>> +    if (s->has_discard && (s->has_fallocate || open_flags & BDRV_O_S=
PARSE)) {
>>
>> s->has_fallocate has a meaning. I wouldn't try to call do_fallocate() =
if
>> s->has_fallocate is false.
>=20
> Ah, sorry, I didn't realize that that test wasn't only to check that
> we'll be able to call fallocate(0) further down.
>=20
>> Therefore, I consider this to effectively be a no-op.
>=20
> Yes.
>=20
>>> @@ -1098,7 +1102,8 @@ static ssize_t handle_aiocb_write_zeroes(RawPos=
ixAIOData *aiocb)
>>>  #endif
>>> =20
>>>  #ifdef CONFIG_FALLOCATE
>>> -    if (s->has_fallocate && aiocb->aio_offset >=3D bdrv_getlength(ai=
ocb->bs)) {
>>> +    if (s->has_fallocate && !(open_flags & BDRV_O_SPARSE)
>>> +            && aiocb->aio_offset >=3D bdrv_getlength(aiocb->bs)) {
>>
>> First, this part is only invoked if everything before it has failed.
>=20
> I misread the code indeed.
>=20
>> Unless I'm mistaken, unmap/trim requests from the guest should result =
in
>> a discard request in the block layer. This should always trigger
>> handle_aiocb_discard() here and that should do what you want it to.
>=20
> Mmm, indeed.  I guess I got lost in the hairy block code.

I can understand that very well. ;-)

>> Could you maybe give me the configuration that results in the issue
>> you're describing in the commit message?
>=20
> Actually I can't reproduce the issue any more.  I'm now wondering how I=

> ended up there.
>=20
> Anyway, I'm really sorry for the noise, and thanks for the good work :)=


Not a problem at all. In case you happen to encounter the issue again,
just send a report to the qemu-block list.

Max


--8qsGsSsQLC1x5JJ7KP7f2fm8IRWVtLLHl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli0VcwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AxjUH/A1CanHmACODKgTE00u3bLb01nuhseov
HwFsuZM1lZKv/Eei8zl3jcZmGe3QCtLYn+Qiz17xBU3jxAI7kmVKeVrSSIjd5dUK
6zofFimiCaV3/0FlXq/4Fb9M5K+cS2HIk3tElkuu3I5mf2nTYdpfg83/SWM7+BwZ
8l7iJ6KScd6g2FkGVwEdxnsjM/b25iwALO2B19gpNurRPE14HViLWIUkG5U41yCr
piH8XIuTKkd4aWnFVpooWoyqjKYBDPnovQ11kNljY4V3xShxPU8bsEYWVEkdEbLQ
O/eFaLHw69WwY0NvS2b7NKizWX7QYIiN+6A6T6q6AjT87/3sht45Ec0=
=O5tH
-----END PGP SIGNATURE-----

--8qsGsSsQLC1x5JJ7KP7f2fm8IRWVtLLHl--
