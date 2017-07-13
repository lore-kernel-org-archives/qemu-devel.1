Received: from eggs.gnu.org ([2001:4830:134:3::10]:49525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVcTB-0000zN-0D
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVcT9-0000Zy-UT
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:39:45 -0400
Date: Thu, 13 Jul 2017 14:39:30 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170713113930.flwiauhw25gv7nbp@postretch>
References: <20170713100117.11961-1-el13635@mail.ntua.gr>
	<20170713100117.11961-2-el13635@mail.ntua.gr>
	<61c88e57-e607-a0fc-6441-175b24d55b74@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j57vuuaxy5mffgcp"
Content-Disposition: inline
In-Reply-To: <61c88e57-e607-a0fc-6441-175b24d55b74@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/4] block: pass bdrv_* methods to
 bs->file by default in block filters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--j57vuuaxy5mffgcp
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 06:23:14AM -0500, Eric Blake wrote:
>On 07/13/2017 05:01 AM, Manos Pitsidianakis wrote:
>> The following functions fail if bs->drv is a filter and does not
>> implement them:
>>
>> bdrv_probe_blocksizes
>> bdrv_probe_geometry
>> bdrv_truncate
>> bdrv_has_zero_init
>> bdrv_get_info
>>
>> Instead, the call should be passed to bs->file if it exists, to allow
>> filter drivers to support those methods without implementing them. This
>> commit makes `drv->is_filter =3D true` imply that these callbacks will be
>> forwarded to bs->file by default, so disabling support for these
>> functions must be done explicitly.
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>I would have dropped R-b on the grounds that you added comments to
>'is_filter' (good! but non-trivial), to make sure it gets a
>grammar/wording review of the new content.  Furthermore, your patch had
>a semantic change due to the rebase, and looking at that change...
>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>> ---
>
>> @@ -3420,11 +3424,15 @@ int bdrv_truncate(BdrvChild *child, int64_t offs=
et, PreallocMode prealloc,
>>
>>      assert(child->perm & BLK_PERM_RESIZE);
>>
>> +    /* if bs->drv =3D=3D NULL, bs is closed, so there's nothing to do h=
ere */
>>      if (!drv) {
>>          error_setg(errp, "No medium inserted");
>>          return -ENOMEDIUM;
>>      }
>>      if (!drv->bdrv_truncate) {
>> +        if (bs->file && drv->is_filter) {
>> +            return bdrv_truncate(bs->file, prealloc, offset, errp);
>
>...ouch - you got it wrong.  s/prealloc, offset/offset, prealloc/
>
>> +++ b/include/block/block_int.h
>> @@ -87,7 +87,11 @@ struct BlockDriver {
>>      const char *format_name;
>>      int instance_size;
>>
>> -    /* set to true if the BlockDriver is a block filter */
>> +    /* set to true if the BlockDriver is a block filter. Block filters =
pass
>> +     * certain callbacks that refer to data (see block.c) to their bs->=
file if
>> +     * the driver doesn't implement them. Drivers that do not wish to f=
orward
>> +     * must implement them and return -ENOTSUP.
>> +     */
>>      bool is_filter;
>
>I'm okay with the new comment.
>
>With the swapped parameter order fixed (the maintainer can probably do
>that),
>Reviewed-by: Eric Blake <eblake@redhat.com>

Oh, this compiled correctly because PreallocMode is an enum. Sorry for=20
the inconvenience, that was rushed. I will send a new version to be=20
typical.

--j57vuuaxy5mffgcp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllnW/IACgkQc2J8L2kN
9xC8cg/8CIJLkyw2KEjyGr4yveAtSvnpxoxqarC2D6AzEkukdOk0W27MKE1Z5gD7
lsqUI/5uMl3aJYS2nQQHnQHfW3YRl5clbq/doATmjIAj1XyVIOkuxEy6HL30M+BJ
XF7DCTv92zlFCzVV56mhMNyE70MUGfvUwNJEqf9DSGewafcNBk7uSzkGw1P4G5Rk
j67hkID072PlNzU/cN8r0gsQvWTBcjb4SZx4LWnjD9tB51cvgW3KUjipu+55Y3rm
ycCVwJmnJnO3gM4wQ45SBoxP9CU0f9LliSCVW02BD2XiyljBwWOrSHwQZyCQvsoi
eqlAtO4KUU3JuM2suFet9XgtU9XvmNDzX4LAKDrgr7wgIs04pMzxCMCdGQHMJ61i
1hSvktxDkNDDUDNzXyUo6QIoYf2qBoYVJeiyttsDklSDgvGQ5OsWlsawHmZ4UZNR
zJbd+jVKR2mIZGuRIP9VjpWi21C92ySkc31H3fsDIoiKsNFI4JtqrMnICNi6c21w
R85OcmlReKwfPx0oVmyjukl2Lw0ZV10IY/pK4kZobsYpd2cVCQZ3nnXRcZBXZDhr
veaJus71nqq2wlDmxskiRh18Ln9ugHQa71gi0TXL/P8/0fk5N7UbRaSGTHyYbxp6
XLvJYej4yAgTEWQUIVRZ/CUFZAjCxg7suPP1VTEGDsHSv3SFjUw=
=As6b
-----END PGP SIGNATURE-----

--j57vuuaxy5mffgcp--
