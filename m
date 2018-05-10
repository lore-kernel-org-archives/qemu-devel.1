Received: from eggs.gnu.org ([2001:4830:134:3::10]:43711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGhpm-0001Wv-U0
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGhpm-0006NM-8D
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:25:58 -0400
Date: Thu, 10 May 2018 10:25:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180510092550.GL1296@stefanha-x1.localdomain>
References: <20180509145815.3330-1-famz@redhat.com>
	<20180509145815.3330-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bPg9NdpM9EETxvqt"
Content-Disposition: inline
In-Reply-To: <20180509145815.3330-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/9] qcow2: Implement copy offloading
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


--bPg9NdpM9EETxvqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2018 at 10:58:09PM +0800, Fam Zheng wrote:
> +static int qcow2_co_copy_range_from(BlockDriverState *bs,
> +                                    BdrvChild *src, uint64_t src_offset,
> +                                    BdrvChild *dst, uint64_t dst_offset,
> +                                    uint64_t bytes, BdrvRequestFlags flags)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    int offset_in_cluster;
> +    int ret;
> +    unsigned int cur_bytes; /* number of bytes in current iteration */
> +    uint64_t cluster_offset = 0;
> +    BdrvChild *child = NULL;
> +
> +    assert(!bs->encrypted);
> +    qemu_co_mutex_lock(&s->lock);
> +
> +    while (bytes != 0) {
> +
> +        /* prepare next request */
> +        cur_bytes = MIN(bytes, INT_MAX);
> +
> +        ret = qcow2_get_cluster_offset(bs, src_offset, &cur_bytes, &cluster_offset);
> +        if (ret < 0) {
> +            goto out;
> +        }
> +
> +        offset_in_cluster = offset_into_cluster(s, src_offset);
> +
> +        switch (ret) {
> +        case QCOW2_CLUSTER_UNALLOCATED:
> +            if (bs->backing) {
> +                child = bs->backing;
> +            } else {
> +                flags |= BDRV_REQ_ZERO_WRITE;
> +            }
> +            break;

Do we need a special case if the backing file is shorter than this
image?

--bPg9NdpM9EETxvqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9BAeAAoJEJykq7OBq3PIa48IAMpUtIbxue+Iqs+xDBwNU855
+GYszDRjQSbGDsOYGiUnksyahifvvaGPRMd9wh39fPLtzHCy0DXivxGbUZAfBsl1
jpjE+Qm0dCPmksZYbz+c8WiJ9d/8TeUnU3yHmDMhG3/AsApazhaqCLZ1Md6WruLv
sjvewQdkSmNkveJgYK7mJzHF9corSkyLcJgymIMWDY0tjnrBEDXlfk+aej4wB/pk
9nu+dWi/8/InhDMoy0Bc9+JkD/kg0AWhl3dX1+2EROtWwMdDaFgq9KhecvTjCRSo
bhqHOshdVcy4gX+9yM7s8W+kOTucTYpVWk+EINOTcds4+phTvMfMEotNkl1eqIk=
=TBff
-----END PGP SIGNATURE-----

--bPg9NdpM9EETxvqt--
