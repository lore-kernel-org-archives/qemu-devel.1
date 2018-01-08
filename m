Received: from eggs.gnu.org ([2001:4830:134:3::10]:53735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYYzj-0003JB-Mn
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYYzi-0007iJ-Or
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:05:47 -0500
References: <20180108030946.14991-1-famz@redhat.com>
	<30369c9b-974f-67d4-322f-00d30a25519a@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eaac6aa1-5913-df92-b951-56badd872b83@redhat.com>
Date: Mon, 8 Jan 2018 09:05:34 -0600
MIME-Version: 1.0
In-Reply-To: <30369c9b-974f-67d4-322f-00d30a25519a@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MSAbsnZQbOTrq81o5zm7FN1ItsPuQfiaQ"
Subject: Re: [Qemu-devel] [PATCH] scsi: Don't check uninitialized local
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MSAbsnZQbOTrq81o5zm7FN1ItsPuQfiaQ
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Message-ID: <eaac6aa1-5913-df92-b951-56badd872b83@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi: Don't check uninitialized local
 variable
References: <20180108030946.14991-1-famz@redhat.com>
 <30369c9b-974f-67d4-322f-00d30a25519a@kamp.de>
In-Reply-To: <30369c9b-974f-67d4-322f-00d30a25519a@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/08/2018 07:20 AM, Peter Lieven wrote:
> Am 08.01.2018 um 04:09 schrieb Fam Zheng:
>> After the out label there is a check on iTask.task but it is not
>> initialized yet.
>>
>> Fixes: e38bc23454ef763deb4405ebdee6a1081aa00bc8
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> ---
>> =C2=A0 block/iscsi.c | 3 +--
>> =C2=A0 1 file changed, 1 insertion(+), 2 deletions(-)
>>

> If lbpme is 0 we run into the same error. And this is even more likely
> than an unaligned request.

In fact, my byte-based series adds an assertion that unaligned requests
aren't possible.

>=20
> I think the right patch is to move the init of iTask up again where it =
was:

I had to rebase v7 of my byte-based series on top of the late iTask
initialization; moving it back to early initialization makes sense.

>=20
>=20
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 5c0a9e5..6a1c537 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -658,6 +658,8 @@ static int64_t coroutine_fn
> iscsi_co_get_block_status(BlockDriverState *bs,
> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t lba;
> =C2=A0=C2=A0=C2=A0=C2=A0 int64_t ret;
>=20
> +=C2=A0=C2=A0=C2=A0 iscsi_co_init_iscsitask(iscsilun, &iTask);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 if (!is_sector_request_lun_aligned(sector_num,=
 nb_sectors,
> iscsilun)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> @@ -675,7 +677,6 @@ static int64_t coroutine_fn
> iscsi_co_get_block_status(BlockDriverState *bs,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 lba =3D sector_qemu2lun(sector_num, iscsilun);=

>=20
> -=C2=A0=C2=A0=C2=A0 iscsi_co_init_iscsitask(iscsilun, &iTask);
> =C2=A0=C2=A0=C2=A0=C2=A0 qemu_mutex_lock(&iscsilun->mutex);
> =C2=A0retry:
> =C2=A0=C2=A0=C2=A0=C2=A0 if (iscsi_get_lba_status_task(iscsilun->iscsi,=
 iscsilun->lun,

If you resubmit this as a formal patch, you can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MSAbsnZQbOTrq81o5zm7FN1ItsPuQfiaQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpTiL4ACgkQp6FrSiUn
Q2qSBQf9Edsg9bfvCCJy8EE4nABY+RpI5N/tuU0UzAyEN24WLO05IPZIQlx2L5z2
gm1yTz3PchWRY2wKDHHunbObvnwJtjVi6DLeGTaWbEQMR7ZOBSvAzq59ssWeEykX
ff0n3XHnmU9b0OUK/CIAyS0v78mUM7KHGYs1ZuijFaoT4I7kRbWR6O/qCOoDgwb3
eK5ug/g2AjC4kV4PpCpAfzSmXt7aCL7yDSV3pCkbGknQIdmM1kYTFY3TgE/MuwK6
1cV9wCeJ/OdFL8FVRIKi9Rt6awI6/iVYyDGZVxiCwYN2PHi/WWCBPQdg/4WxL8ed
1z7yt/S8Eap7WZXhFJaA6C3hS4qZTg==
=FWwy
-----END PGP SIGNATURE-----

--MSAbsnZQbOTrq81o5zm7FN1ItsPuQfiaQ--
