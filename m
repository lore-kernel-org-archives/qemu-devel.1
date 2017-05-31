Received: from eggs.gnu.org ([2001:4830:134:3::10]:55719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG14A-0001O3-Sq
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG149-0004DF-Pf
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:41:26 -0400
Date: Wed, 31 May 2017 11:41:16 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531104116.GA16733@stefanha-x1.localdomain>
References: <20170526165518.7580-1-mreitz@redhat.com>
	<20170526165518.7580-15-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20170526165518.7580-15-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 14/16] block/qcow2:
 falloc/full preallocating growth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 06:55:16PM +0200, Max Reitz wrote:
> @@ -2677,6 +2679,102 @@ static int qcow2_truncate(BlockDriverState *bs, i=
nt64_t offset,
>          }
>          break;
> =20
> +    case PREALLOC_MODE_FALLOC:
> +    case PREALLOC_MODE_FULL:
> +    {
> +        int64_t allocation_start, host_offset, guest_offset;
> +        int64_t clusters_allocated;
> +        int64_t old_file_size, new_file_size;
> +        uint64_t nb_new_data_clusters, nb_new_l2_tables;
> +
> +        old_file_size =3D bdrv_getlength(bs->file->bs);
> +        if (old_file_size < 0) {
> +            error_setg_errno(errp, -old_file_size,
> +                             "Failed to inquire current file length");
> +            return ret;
> +        }
> +
> +        nb_new_data_clusters =3D DIV_ROUND_UP(offset - old_length,
> +                                            s->cluster_size);
> +
> +        /* This is an overestimation; we will not actually allocate spac=
e for
> +         * these in the file but just make sure the new refcount structu=
res are
> +         * able to cover them so we will not have to allocate new refblo=
cks
> +         * while entering the data blocks in the potentially new L2 tabl=
es.
> +         * (We do not actually care where the L2 tables are placed. Mayb=
e they
> +         *  are already allocated or they can be placed somewhere before
> +         *  @old_file_size. It does not matter because they will be fully
> +         *  allocated automatically, so they do not need to be covered b=
y the
> +         *  preallocation. All that matters is that we will not have to =
allocate
> +         *  new refcount structures for them.) */
> +        nb_new_l2_tables =3D DIV_ROUND_UP(nb_new_data_clusters,
> +                                        s->cluster_size / sizeof(uint64_=
t));
> +        /* The cluster range may not be aligned to L2 boundaries, so add=
 one L2
> +         * table for a potential head/tail */
> +        nb_new_l2_tables++;
> +
> +        allocation_start =3D qcow2_refcount_area(bs, old_file_size,
> +                                               nb_new_data_clusters +
> +                                               nb_new_l2_tables,
> +                                               true, 0, 0);
> +        if (allocation_start < 0) {
> +            error_setg_errno(errp, -allocation_start,
> +                             "Failed to resize refcount structures");
> +            return -allocation_start;
> +        }
> +
> +        clusters_allocated =3D qcow2_alloc_clusters_at(bs, allocation_st=
art,
> +                                                     nb_new_data_cluster=
s);
> +        if (clusters_allocated < 0) {
> +            error_setg_errno(errp, -clusters_allocated,
> +                             "Failed to allocate data clusters");
> +            return -clusters_allocated;
> +        }
> +
> +        assert(clusters_allocated =3D=3D nb_new_data_clusters);
> +
> +        /* Allocate the data area */
> +        new_file_size =3D allocation_start +
> +                        nb_new_data_clusters * s->cluster_size;
> +        ret =3D bdrv_truncate(bs->file, new_file_size, prealloc, errp);
> +        if (ret < 0) {
> +            error_prepend(errp, "Failed to resize underlying file: ");
> +            qcow2_free_clusters(bs, allocation_start,
> +                                nb_new_data_clusters * s->cluster_size,
> +                                QCOW2_DISCARD_OTHER);
> +            return ret;
> +        }
> +
> +        /* Create the necessary L2 entries */
> +        host_offset =3D allocation_start;
> +        guest_offset =3D old_length;
> +        while (nb_new_data_clusters) {
> +            int64_t guest_cluster =3D guest_offset >> s->cluster_bits;
> +            int64_t nb_clusters =3D MIN(nb_new_data_clusters,
> +                                      s->l2_size - guest_cluster % s->l2=
_size);
> +            QCowL2Meta allocation =3D {
> +                .offset       =3D guest_offset,
> +                .alloc_offset =3D host_offset,
> +                .nb_clusters  =3D nb_clusters,
> +            };
> +            qemu_co_queue_init(&allocation.dependent_requests);
> +
> +            ret =3D qcow2_alloc_cluster_link_l2(bs, &allocation);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret, "Failed to update L2 tables=
");
> +                qcow2_free_clusters(bs, host_offset,
> +                                    nb_new_data_clusters * s->cluster_si=
ze,
> +                                    QCOW2_DISCARD_OTHER);
> +                return ret;
> +            }
> +
> +            guest_offset +=3D nb_clusters * s->cluster_size;
> +            host_offset +=3D nb_clusters * s->cluster_size;
> +            nb_new_data_clusters -=3D nb_clusters;
> +        }
> +        break;
> +    }

Flush L1/L2 tables?

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLp3MAAoJEJykq7OBq3PIF9EIAMMgbE6IukQlNEQvAd3Cs+jg
GkTSZ0hvlGYdlcPcshB35X0Clb7qd5hyGpe/V92wfaPwRvf7yoefeGD1neDf9+tE
y4+kNVf6mBsoCRokRQja//rgvf98cxwpfEJ2KN8QtYshEqeGfs2wQgUZOwxzv075
//ug1JYaTUQVpU0iKRtU3gyBKmw32Sey5CANWdGIP5U2SD7k/o4Dyg7gVEpQ5QPX
AqQPjgB+/h+TiOMPc3hI7w3ktbcgdqdlULHDuVDsi+zKI1nNeaOQwoTbWMlDisqT
ZLl22wL/nZmXrY1qs3zDkbkWJlDY8nUUaQ5u6cOqyjInPFYvb2cXEcQn6oYobNw=
=bcKa
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
