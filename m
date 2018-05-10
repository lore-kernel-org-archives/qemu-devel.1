Received: from eggs.gnu.org ([2001:4830:134:3::10]:39721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGhVE-0005by-Ef
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGhVA-0005YI-O9
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:04:44 -0400
Date: Thu, 10 May 2018 10:04:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180510090434.GI1296@stefanha-x1.localdomain>
References: <20180509145815.3330-1-famz@redhat.com>
	<20180509145815.3330-8-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k9xkV0rc9XGsukaG"
Content-Disposition: inline
In-Reply-To: <20180509145815.3330-8-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 7/9] iscsi: Implement copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>


--k9xkV0rc9XGsukaG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2018 at 10:58:13PM +0800, Fam Zheng wrote:
> +static int iscsi_populate_target_desc(unsigned char *desc, IscsiLun *lun)

The return values of these iscsi_populate_*() functions are unused and
don't make sense since the caller must already know the size ahead of
time.  I suggest removing them to simplify the code.

> +{
> +    struct scsi_inquiry_device_designator *dd = lun->dd;
> +
> +    memset(desc, 0, 32);
> +    desc[0] = IDENT_DESCR_TGT_DESCR;
> +    desc[4] = dd->code_set;
> +    desc[5] = (dd->designator_type & 0xF)
> +        | ((dd->association & 3) << 4);
> +    desc[7] = dd->designator_length;
> +    memcpy(desc + 8, dd->designator, dd->designator_length);
> +
> +    desc[28] = 0;
> +    desc[29] = (lun->block_size >> 16) & 0xFF;
> +    desc[30] = (lun->block_size >> 8) & 0xFF;
> +    desc[31] = lun->block_size & 0xFF;
> +
> +    return 32;
> +}
> +
> +static int iscsi_xcopy_desc_hdr(uint8_t *hdr, int dc, int cat, int src_index,
> +                                int dst_index)
> +{
> +    int desc_len = 28;

s/desc_len/XCOPY_BLK2BLK_SEG_DESC_SIZE/ ?

Then the 28 constant doesn't need to be duplicated.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--k9xkV0rc9XGsukaG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9AsiAAoJEJykq7OBq3PIMEIH/3JynztBKwyRU4ZLpAIarckQ
mEiy6z5BDzHdS97MJKo66ZQ9GuwOhmvb0p1BM3WhFijgxgMFnK1j/okBLotB4QXN
7oLxiWnKKWdd3eF6JFPEDFXOdNYt8iG+7YMK3EbSpMrvACZpB8SCsdtCWe+VqX2c
kbjnMhguIX6JwhJWNMx7uFr7EAxkKK+2EAkrmTfPTkNrpLZrPG4x2zfZvHsxlXIp
o0iozZr1MGawZtLY5zSIdQ7HWBCOS4zv7x6fHJ0O3NjfFzLCkIgJaWSAYwPN8oZ/
HD4sxPovignowAgJyT92OhEimYgC994bSgJmBf3g/zPi66WGETaRNAug+07ugB8=
=dlva
-----END PGP SIGNATURE-----

--k9xkV0rc9XGsukaG--
