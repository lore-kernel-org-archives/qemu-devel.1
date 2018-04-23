Received: from eggs.gnu.org ([2001:4830:134:3::10]:38179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fAjj1-0003Jk-95
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 18:14:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fAjj0-0005cP-2f
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 18:14:19 -0400
References: <20180423211420.6917-1-karl.beldan+oss@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <adc0b504-419f-ae24-c1dc-7f303f3844f9@redhat.com>
Date: Mon, 23 Apr 2018 17:14:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180423211420.6917-1-karl.beldan+oss@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BmaQdyrW8GknWArxK0sraG5ieZqWZcFiB"
Subject: Re: [Qemu-devel] [PATCH] hw/block/nand: Fix bad offset in
 nand_blk_load for on-drive OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Karl Beldan <karl.beldan@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BmaQdyrW8GknWArxK0sraG5ieZqWZcFiB
From: Eric Blake <eblake@redhat.com>
To: Karl Beldan <karl.beldan@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
Message-ID: <adc0b504-419f-ae24-c1dc-7f303f3844f9@redhat.com>
Subject: Re: [PATCH] hw/block/nand: Fix bad offset in nand_blk_load for
 on-drive OOB
References: <20180423211420.6917-1-karl.beldan+oss@gmail.com>
In-Reply-To: <20180423211420.6917-1-karl.beldan+oss@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/23/2018 04:14 PM, Karl Beldan wrote:
> The logic wants 512-byte aligned blk ops.

The commit you are referencing mentions that the code permits 256, 512,
or 2048-byte alignment, based on the configuration of the hardware it is
emulating.  The whole file is hard to read, and I'm not surprised if
what I thought was a patch with no semantic change didn't quite succeed.

> To switch to byte-based block accesses, the fixed commit changed the
> blk read offset,
> 	PAGE_START(addr) >> 9
> with
> 	PAGE_START(addr)
> which min alignment, for on-drive OOB, is the min OOB size.
> Consequently the reads are offset by PAGE_START(addr) & 0x1ff.

Do you have a call trace where a caller is passing in an addr that is
not aligned to 512?  I agree that the old code was 512-aligned by virtue
of the old interface; but the new code SHOULD be able to call into the
block layer with whatever alignment it needs, where the block layer will
do a larger read to satisfy block constraints, as needed (that is, if a
caller requests a 256-byte read of a device that requires 512-alignment,
blk_pread() will automatically widen out to a 512-byte read).

>=20
> Fixes: 9fc0d361cc41 ("nand: Switch to byte-based block access")
> Cc: Eric Blake <eblake@redhat.com>
> Signed-off-by: Karl Beldan <karl.beldan+oss@gmail.com>

CC: qemu-stable@nongnu.org

> ---
>  hw/block/nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/block/nand.c b/hw/block/nand.c
> index 919cb9b803..ed587f60f0 100644
> --- a/hw/block/nand.c
> +++ b/hw/block/nand.c
> @@ -788,7 +788,7 @@ static void glue(nand_blk_load_, PAGE_SIZE)(NANDFla=
shState *s,
>                              OOB_SIZE);
>              s->ioaddr =3D s->io + SECTOR_OFFSET(s->addr) + offset;
>          } else {
> -            if (blk_pread(s->blk, PAGE_START(addr), s->io,
> +            if (blk_pread(s->blk, PAGE_START(addr) & ~0x1ff, s->io,
>                            (PAGE_SECTORS + 2) << BDRV_SECTOR_BITS) < 0)=
 {

I don't like the magic number masking.  This should probably be written
QEMU_ALIGN_DOWN(PAGE_START(addr), BDRV_SECTOR_SIZE).

I would like to see some actual numbers from a backtrace to make sure
we're doing this right, but my initial evaluation is done by assuming,
for the sake of argument, that we're using a 256-byte page size (as that
is most likely to be unaligned to a 512-byte boundary).  I see that we
can call into nand_blk_load_256() during processing of
NAND_CMD_RANDOMREAD2 from nand_command(), although it gets harder to
audit without an actual call trace whether addr and offset have 512-byte
alignments at that point.  But without analysis of whether this is an
actual possibility, let's assume we can somehow trigger a code path that
calls nand_blk_load_256(s, 768, 1).

Before 9fc0d361cc41, this called:

            if (blk_read(s->blk, PAGE_START(addr) >> 9,
                         s->io, (PAGE_SECTORS + 2)) < 0) {

or, tracing macro-expansion

blk_read(s->blk, (PAGE(addr) * (PAGE_SIZE + OOB_SIZE)) >> 9,
                  s->io, (1 + 2))

blk_read(s->blk, (((addr) >> 8) * (256 + (1 << (PAGE_SHIFT - 5)))) >> 9,
                  s->io, (1 + 2))

blk_read(s->blk, (((addr) >> 8) * (256 + 8)) >> 9,
                  s->io, 3)


which, for our given addr of 768, results in
blk_read(s->blk, 792 >> 9, s->io, 3)

or the 1536 bytes starting at offset 512 (which includes offset 792 that
we are interested in).

And indeed, post-patch, it now results in trying to read 1536 bytes, but
starting at offset 792 rather than offset 512.

So it looks like the fix is correct, once it is spelled in a more
obvious way rather than with a magic number, and that the fact that this
has been broken since 2.7 means that this device is not getting much
actual testing :(

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BmaQdyrW8GknWArxK0sraG5ieZqWZcFiB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlreWqsACgkQp6FrSiUn
Q2qacQf5AVJe2klviPoZRs8OOMz8sfbjBgW1/PGty1pVfHL/5H4WBkh3IGMEGMJ5
wimaot6mSpu/dX+wIBEIqgBiBQvvKpOTmy8p8xbrNW0ENJwXJNde8RKJjo9qbeK1
jojtw+6hZcigNzkxCppCgfsPO3G7vdP7FU2s5ItirgC3jzT9BmTNa5IYeKrnmOW4
M+NJdSFsiKpPF6xK+ZjQQmWCLmXDftTMF75yV7PkPVKXxhppQBEZmf8wgqg3gKA6
RQGEwC6V/HqGnSqWLFGY/D3l03NbUcVJ5CpCjsyehe6VT7WG/dH/+FRrAnsS6Qza
8XlM/VRw7tuYlO7FdZ3yU25+UevNXA==
=Qi5x
-----END PGP SIGNATURE-----

--BmaQdyrW8GknWArxK0sraG5ieZqWZcFiB--
