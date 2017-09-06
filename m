Received: from eggs.gnu.org ([2001:4830:134:3::10]:47414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dpVfO-0006bX-HD
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dpVfK-0001wj-Ed
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:26:34 -0400
Date: Wed, 6 Sep 2017 11:26:22 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170906082622.7idtvai3xpclicrg@postretch>
References: <20170825132028.6184-1-el13635@mail.ntua.gr>
	<20170825132028.6184-7-el13635@mail.ntua.gr>
	<20170905161643.GO4633@localhost.localdomain>
	<20170905190621.GQ4633@localhost.localdomain>
	<a861d95e-553c-4797-486c-2601c2b6e17b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4u6aqqdary3fk24y"
Content-Disposition: inline
In-Reply-To: <a861d95e-553c-4797-486c-2601c2b6e17b@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v9 6/6] qemu-iotests: add 184
 for throttle filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>


--4u6aqqdary3fk24y
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2017 at 04:13:39PM -0500, Eric Blake wrote:
>On 09/05/2017 02:06 PM, Kevin Wolf wrote:
>> Am 05.09.2017 um 18:16 hat Kevin Wolf geschrieben:
>>> Am 25.08.2017 um 15:20 hat Manos Pitsidianakis geschrieben:
>>>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>>>
>>> Does this test actually (still) pass for you? I can't see that it's
>>> related to any recent change in master, but this is the diff that I get.
>>>
>>> I can update the reference output while applying, but obviously if it's
>>> currently passing for you, it will fail after I "fix" it.
>>
>> For the record, we discussed this on IRC. The test works correctly on
>> master, but on my block branch there is a conflict with "block: pass
>> bdrv_* methods to bs->file by default in block filters".
>>
>> The correct action is to merge this throttle driver series after the
>> conflicting patch because throttle doesn't implement .bdrv_get_info and
>> needs the forwarding that the other patch implements.
>>
>> I updated the test output accordingly and applied the series to my block
>> branch.
>
>Could you also squash this in to 5/6? (as long as we're intentionally
>basing throttle on top of defaults, then we should use the right default
>instead of duplicating things)

Yes, this change makes sense, if it's no trouble with Kevin.


>diff --git i/block/throttle.c w/block/throttle.c
>index 7b33613372..5bca76300f 100644
>--- i/block/throttle.c
>+++ w/block/throttle.c
>@@ -197,19 +197,6 @@ static bool
>throttle_recurse_is_first_non_filter(BlockDriverState *bs,
>     return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
> }
>
>-static int64_t coroutine_fn
>throttle_co_get_block_status(BlockDriverState *bs,
>-                                                         int64_t
>sector_num,
>-                                                         int nb_sectors,
>-                                                         int *pnum,
>-
>BlockDriverState **file)
>-{
>-    assert(bs->file && bs->file->bs);
>-    *pnum =3D nb_sectors;
>-    *file =3D bs->file->bs;
>-    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
>-           (sector_num << BDRV_SECTOR_BITS);
>-}
>-
> static BlockDriver bdrv_throttle =3D {
>     .format_name                        =3D   "throttle",
>     .protocol_name                      =3D   "throttle",
>@@ -237,7 +224,7 @@ static BlockDriver bdrv_throttle =3D {
>     .bdrv_reopen_prepare                =3D   throttle_reopen_prepare,
>     .bdrv_reopen_commit                 =3D   throttle_reopen_commit,
>     .bdrv_reopen_abort                  =3D   throttle_reopen_abort,
>-    .bdrv_co_get_block_status           =3D   throttle_co_get_block_statu=
s,
>+    .bdrv_co_get_block_status           =3D
>bdrv_co_get_block_status_from_file,
>
>     .is_filter                          =3D   true,
> };
>
>
>--=20
>Eric Blake, Principal Software Engineer
>Red Hat, Inc.           +1-919-301-3266
>Virtualization:  qemu.org | libvirt.org
>




--4u6aqqdary3fk24y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmvsS4ACgkQc2J8L2kN
9xA8qA//SOIXJ2LcvAe5Kc9D+HjnTV6k0CZqma8ZxAcrQjd4KdcVCHkknJotLWpE
dnhRgYFmpD72tbOkc84g/6y7xEU+4/6jWj/OFEP++nWhPvVpQ7luLGUVXUHEEK/C
nt63OlQ8k6Dw+4de+f/zg+jtf/8TCRrImdGA/cQ4/kgV0mEBwFFxkPS218kuRznT
XzqCtXctWVmZSpm5S2RK6GZ+053pIFeZtDa1KPv0NisiHKPrfPfJuiIwSpdblIIs
2a/R7Q4FeuOPs1L8I/6Xox68aPxGs357BI/gwEbDHCtubDZCv86NUOz9ytIWK4el
FMqVvCrfjnWjIP9121z+7GOnmg+5Q6sp5dnOyxmNo+wVTk80Aik2/iCPL1ETpjMz
4UNrw6Ld7NIA4OYszx/25GGF0aaR7c8Ub7UW5LcbVPp5K8vzy5G+b0z0uR+i7zDy
S/lfQ3s46FD2WFRRIQMmSFRN6+TaHX1gds/OZN7JLAxtjmshMANcVh+OqG/Ld6SN
2Q7G2r0aK/tv5qAIG6CyAWzKGKWgzns1m7JqvspT0Ougkb3NbcHWoqD/Ftj6H9jv
5APRlbNMMTXTLFpwrSDKmdIvdhN3w60HNh9lqlq9u+bcDWpx+YXr5rt82zUOtXHt
9QsnAm/ZvPVJ2VEZU1Hsv8BqBDww5Pb7lQG+IgGxACeBhqbShp4=
=x0a9
-----END PGP SIGNATURE-----

--4u6aqqdary3fk24y--
