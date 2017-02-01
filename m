Received: from eggs.gnu.org ([2001:4830:134:3::10]:33622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYxxq-00081g-Ku
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 11:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYxxm-0006oB-L4
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 11:40:58 -0500
Date: Wed, 1 Feb 2017 16:40:50 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170201164050.GD12283@stefanha-x1.localdomain>
References: <1485800032-24404-1-git-send-email-hch@lst.de>
	<1485800032-24404-2-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline
In-Reply-To: <1485800032-24404-2-git-send-email-hch@lst.de>
Subject: Re: [Qemu-devel] [PATCH 1/2] nvme: implement the DSM command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoph Hellwig <hch@lst.de>
Cc: qemu-devel@nongnu.org, keith.busch@intel.com, qemu-block@nongnu.org


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 30, 2017 at 07:13:51PM +0100, Christoph Hellwig wrote:
> +static uint16_t nvme_dsm_discard(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
> +    NvmeRequest *req)
> +{
> +    uint16_t nr = (le32_to_cpu(cmd->cdw10) & 0xff) + 1;
> +    uint8_t lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
> +    uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds - BDRV_SECTOR_BITS;
> +    NvmeDsmRange *range;
> +    QEMUSGList qsg;
> +    int i;
> +
> +    range = g_new(NvmeDsmRange, nr);
> +
> +    if (nvme_map_prp(&qsg, le64_to_cpu(cmd->prp1), le64_to_cpu(cmd->prp2),
> +            sizeof(range), n)) {
> +        goto out_free_range;
> +    }
> +
> +    if (dma_buf_write((uint8_t *)range, sizeof(range), &qsg)) {

Did you mean sizeof(*range) * nr?

> +        goto out_destroy_qsg;
> +    }
> +
> +    qemu_sglist_destroy(&qsg);
> +
> +    req->status = NVME_SUCCESS;
> +    req->has_sg = false;
> +    req->aio_inflight = 1;
> +
> +    for (i = 0; i < nr; i++) {
> +        uint64_t slba = le64_to_cpu(range[i].slba);
> +        uint32_t nlb = le32_to_cpu(range[i].nlb);
> +
> +        if (slba + nlb > le64_to_cpu(ns->id_ns.nsze)) {
> +            return NVME_LBA_RANGE | NVME_DNR;

aio requests are potentially in flight, range is still allocated, and
req->aio_inflight still needs to be decremented once.  Is there cleanup
code missing here at least so range will be freed?

> +        }
> +
> +        req->aio_inflight++;
> +        req->aiocb = blk_aio_pdiscard(n->conf.blk, slba << data_shift,
> +                                      nlb << data_shift, nvme_discard_cb, req);
> +    }
> +
> +    g_free(range);
> +
> +    if (--req->aio_inflight > 0) {
> +        return NVME_NO_COMPLETE;
> +    }
> +
> +    return NVME_SUCCESS;
> +
> +out_destroy_qsg:
> +    qemu_sglist_destroy(&qsg);
> +out_free_range:
> +    g_free(range);
> +    return NVME_INVALID_FIELD | NVME_DNR;
> +}

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkg+SAAoJEJykq7OBq3PIHr0IALLUX4RXRvB91PzVeDKYkiFF
YMplL+uEF+0ypya0PxCDNbP/X4/JUuoRFAfO/RPbod7oB1pSjfLeVwdhsF7lza/5
nMEU4bhNffb0ZbtkqMCTEbkdONDUXcrpFCn7+jkIfyMb7oyQIiJW7ooNRJVbVKlZ
wHI28ajjDluZLmCgIT6qpWEN9t/Dh26Uz8TSYTeFf/G3EwR/VZ84Hz6Xlk0Y5PNO
QgUBGVfYDiTM2Mex82BK0oc7XpIhizKB6AMG3orAkBqyS1kFkMyu0U2FVl1MHBj9
u1EwIHCrwd12pkSMo8grW585aIwHi4qhWKeBBwTcOIY55qeSuuNQMB6U8tYaiu8=
=yNK6
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
