Received: from eggs.gnu.org ([2001:4830:134:3::10]:58006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDst4-0005kV-NL
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDst0-0007Sv-3W
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:37:42 -0400
References: <1525268093-531-1-git-send-email-ivanren@tencent.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <44cdffb1-e5f5-d324-8880-1ee2e07c3954@redhat.com>
Date: Wed, 2 May 2018 16:37:20 +0200
MIME-Version: 1.0
In-Reply-To: <1525268093-531-1-git-send-email-ivanren@tencent.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FXzJ9zWmCuyofMqtVM73Khg9KpgooTQXN"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: return allocated size for block
 device with qcow2 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ivan Ren <renyime@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FXzJ9zWmCuyofMqtVM73Khg9KpgooTQXN
From: Max Reitz <mreitz@redhat.com>
To: Ivan Ren <renyime@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <44cdffb1-e5f5-d324-8880-1ee2e07c3954@redhat.com>
Subject: Re: [PATCH] qemu-img: return allocated size for block device with
 qcow2 format
References: <1525268093-531-1-git-send-email-ivanren@tencent.com>
In-Reply-To: <1525268093-531-1-git-send-email-ivanren@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

[replying to this version because the previous mail doesn't seem to have
made it to the mailing lists for whatever reason]

On 2018-05-02 15:34, Ivan Ren wrote:
> qemu-img info with a block device which has a qcow2 format always
> return 0 for disk size, and this can not reflect the qcow2 size
> and the used space of the block device. This patch return the
> allocated size of qcow2 as the disk size.

I'm not quite sure whether you really need this information for block
devices (I tend to agree with Eric that wr_highest_cluster is the more
important information there), but I can imagine it just being nice to hav=
e.

So the basic idea makes sense to me, but I think the implementation can
be simplified and the reporting in qemu-img should be done differently.

>=20
> Signed-off-by: Ivan Ren <ivanren@tencent.com>
> ---
>  block/qcow2-bitmap.c |  69 +++++++++++++++++
>  block/qcow2.c        | 212 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.h        |  42 ++++++++++
>  3 files changed, 323 insertions(+)

The whole implementation reminds me a lot of qcow2's check function,
which basically just recalculates the refcounts.  So I'm wondering
whether you could just count how many clusters with non-0 refcount there
are and thus simplify the implementation dramatically.

[...]

> +static int64_t qcow2_get_allocated_file_size(BlockDriverState *bs)
> +{
> +    struct stat st;
> +    if (stat(bs->filename, &st) < 0 || !S_ISBLK(st.st_mode)) {
> +        goto get_file_size;
> +    }

This definitely doesn't work because nobody guarantees that bs->filename
is something that stat() can work with.  I'm aware that you need to do
the S_ISBLK() check somewhere, but the qcow2 driver is not the right plac=
e.

I don't really have a good way around this, though.  These things come
to mind:

(1) We could let file-posix report an error for S_ISBLK because the
information is known to be usually useless -- but I think that is not
quite the right thing to do because maybe some block devices do report
useful information there, I don't know.

(2) Or we introduce a new field in qemu-img info (and thus in ImageInfo,
too, I suppose?).  qemu-img info (or rather bdrv_query_image_info())
could detect whether the format layer supports
bdrv_get_allocated_file_size, and if so, it emits that information
separately from the allocated size of bs->file->bs.  But that would
break vmdk...

(3) As a hack, qcow2_get_allocated_file_size() could first always call
bdrv_get_allocated_file_size(bs->file->bs), and if that returns 0 (which
is absolutely impossible for qcow2 files because they have an image
header that takes up some space), we fall back to
qcow2_get_block_allocated_size().  While I consider it a hack, I can't
come up with a scenario where it wouldn't work.

Max

> +
> +    return qcow2_get_block_allocated_size(bs);
> +
> +get_file_size:
> +    if (bs->file) {
> +        return bdrv_get_allocated_file_size(bs->file->bs);
> +    }
> +    return -ENOTSUP;
> +}
> +


--FXzJ9zWmCuyofMqtVM73Khg9KpgooTQXN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrpzSAACgkQ9AfbAGHV
z0AMFgf/RBilbyY60JnPXWEsnljZxuFWLmFuyD+Mmif0z40h+mUMveRGMrSEvO36
TRkZA8MvUgRxWOGe7pEz1Asp9MxuwAt5E/FaRIC0XiBoeobCoWDPBkLPgm+sS91x
+gIjoteGo/UMlTTBXSmsqPh2fY1LtRjlwEH9qZOj9ZOw9rfE8M1B07TvQ+Fi4ia4
YzVgBc1aC9zpz3NmbJe4YXsPKjpJyf8H7Wa9UBCYQ1m4zrcV8cwsw6egcIAzSP/Y
QPA2PsCQnS/QsAZZDbuMEMKKgez03o7QEY9cP4UtuXGPbLo/zkp7zcN1vD2vdcah
mM5J/Ld1yDHHcMe5g+yhXZ8KS/oHOA==
=rdOD
-----END PGP SIGNATURE-----

--FXzJ9zWmCuyofMqtVM73Khg9KpgooTQXN--
