Received: from eggs.gnu.org ([2001:4830:134:3::10]:60645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfnqb-000236-UY
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfnqa-0005dH-V3
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:17:45 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-21-git-send-email-kwolf@redhat.com>
	<6f790f11-1427-7f23-83d1-d3212fb74ddc@redhat.com>
	<20170220130525.GE4814@noname.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6279f1e2-0e1d-fba8-5e04-0b6034a1be16@redhat.com>
Date: Mon, 20 Feb 2017 14:17:34 +0100
MIME-Version: 1.0
In-Reply-To: <20170220130525.GE4814@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3VbWxTBMj25uhTOV11kuAvGtHsUWks0Hk"
Subject: Re: [Qemu-devel] [RFC PATCH 20/41] hw/block: Introduce share-rw
 qdev property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3VbWxTBMj25uhTOV11kuAvGtHsUWks0Hk
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <6279f1e2-0e1d-fba8-5e04-0b6034a1be16@redhat.com>
Subject: Re: [RFC PATCH 20/41] hw/block: Introduce share-rw qdev property
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-21-git-send-email-kwolf@redhat.com>
 <6f790f11-1427-7f23-83d1-d3212fb74ddc@redhat.com>
 <20170220130525.GE4814@noname.redhat.com>
In-Reply-To: <20170220130525.GE4814@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20.02.2017 14:05, Kevin Wolf wrote:
> Am 20.02.2017 um 13:28 hat Max Reitz geschrieben:
>> On 13.02.2017 18:22, Kevin Wolf wrote:
>>> By default, don't allow another writer for block devices that are
>>> attached to a guest device. For the cases where this setup is intende=
d
>>> (e.g. using a cluster filesystem on the disk), the new option can be
>>> used to allow it.
>>>
>>> This change affects only devices using DEFINE_BLOCK_PROPERTIES().
>>> Devices directly using DEFINE_PROP_DRIVE() still accept writers
>>> unconditionally.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  hw/block/block.c           | 14 ++++++------
>>>  include/hw/block/block.h   |  4 +++-
>>>  tests/qemu-iotests/172.out | 53 ++++++++++++++++++++++++++++++++++++=
++++++++++
>>>  3 files changed, 64 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/hw/block/block.c b/hw/block/block.c
>>> index c3d3901..3c218eb 100644
>>> --- a/hw/block/block.c
>>> +++ b/hw/block/block.c
>>> @@ -56,7 +56,7 @@ void blkconf_apply_backend_options(BlockConf *conf,=
 bool readonly,
>>>  {
>>>      BlockBackend *blk =3D conf->blk;
>>>      BlockdevOnError rerror, werror;
>>> -    uint64_t perm;
>>> +    uint64_t perm, shared_perm;
>>>      bool wce;
>>>      int ret;
>>> =20
>>> @@ -65,11 +65,13 @@ void blkconf_apply_backend_options(BlockConf *con=
f, bool readonly,
>>>          perm |=3D BLK_PERM_WRITE;
>>>      }
>>> =20
>>> -    /* TODO Remove BLK_PERM_WRITE unless explicitly configured so */=

>>> -    ret =3D blk_set_perm(blk, perm,
>>> -                       BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNC=
HANGED |
>>> -                       BLK_PERM_GRAPH_MOD | BLK_PERM_RESIZE | BLK_PE=
RM_WRITE,
>>> -                       errp);
>>> +    shared_perm =3D BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHAN=
GED |
>>> +                  BLK_PERM_GRAPH_MOD | BLK_PERM_RESIZE;
>>
>> I'm not so sure BLK_PERM_RESIZE belongs here.
>=20
> Where does it belong in your opinion?

Not unconditionally here, probably.

> An option that I considered was adding BLK_PERM_RESIZE in
> blk_set_dev_ops() if op.resize_cb !=3D NULL, but it felt a bit too
> implicit to me.
>=20
> Or I guess we can just add another bool parameter?

It all depends on whether the device model can handle online resizes. I
think a bool parameter would be fine.

Max


--3VbWxTBMj25uhTOV11kuAvGtHsUWks0Hk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliq7G4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AeCYH/i2IlRpHxi5ZSASTDVnKjurdGnKwbh8R
cOdqwbqfNYtopMniRBapr0I4t+8R5EdtjMo4vqCqSGXB8yho700/zuHr4qvVA+Le
HZJOHOkQ1PK96ODFyb6LVBT6be2+7J4WBYoW7pxq1GBeAhVsljxiWTKg0+fTj/7a
cWBkyi1gNUcKNU0T2s25QZ2UjFp9s91xwc+zimaKjd0nW/39PGxs62r+sa80q6Ru
/DSZQvYApCdxNBCOvYnYoc6HfVY23WJyjgcBlak1/gFys9Tb0sqUe/Inm47N4xXo
LAek9yvzcenmePhMo7E9oEiUeNk27V2eFodEcHaMnkBWEGobilplkvk=
=/Vcu
-----END PGP SIGNATURE-----

--3VbWxTBMj25uhTOV11kuAvGtHsUWks0Hk--
