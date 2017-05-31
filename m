Received: from eggs.gnu.org ([2001:4830:134:3::10]:49797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG2b4-00058k-9C
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG2b3-000438-7j
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:19:30 -0400
References: <20170526165518.7580-1-mreitz@redhat.com>
	<20170526165518.7580-15-mreitz@redhat.com>
	<20170531104116.GA16733@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2172cd29-50ee-43bf-3935-b5bcc8b55c32@redhat.com>
Date: Wed, 31 May 2017 14:19:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170531104116.GA16733@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LRmAAFeAqC9DvQ6suFLgxHrrsEBhJNekF"
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LRmAAFeAqC9DvQ6suFLgxHrrsEBhJNekF
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <2172cd29-50ee-43bf-3935-b5bcc8b55c32@redhat.com>
Subject: Re: [Qemu-block] [PATCH v3 14/16] block/qcow2: falloc/full
 preallocating growth
References: <20170526165518.7580-1-mreitz@redhat.com>
 <20170526165518.7580-15-mreitz@redhat.com>
 <20170531104116.GA16733@stefanha-x1.localdomain>
In-Reply-To: <20170531104116.GA16733@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2017-05-31 12:41, Stefan Hajnoczi wrote:
> On Fri, May 26, 2017 at 06:55:16PM +0200, Max Reitz wrote:
>> @@ -2677,6 +2679,102 @@ static int qcow2_truncate(BlockDriverState *bs=
, int64_t offset,
>>          }
>>          break;
>> =20
>> +    case PREALLOC_MODE_FALLOC:
>> +    case PREALLOC_MODE_FULL:
>> +    {
>> +        int64_t allocation_start, host_offset, guest_offset;
>> +        int64_t clusters_allocated;
>> +        int64_t old_file_size, new_file_size;
>> +        uint64_t nb_new_data_clusters, nb_new_l2_tables;
>> +
>> +        old_file_size =3D bdrv_getlength(bs->file->bs);
>> +        if (old_file_size < 0) {
>> +            error_setg_errno(errp, -old_file_size,
>> +                             "Failed to inquire current file length")=
;
>> +            return ret;
>> +        }
>> +
>> +        nb_new_data_clusters =3D DIV_ROUND_UP(offset - old_length,
>> +                                            s->cluster_size);
>> +
>> +        /* This is an overestimation; we will not actually allocate s=
pace for
>> +         * these in the file but just make sure the new refcount stru=
ctures are
>> +         * able to cover them so we will not have to allocate new ref=
blocks
>> +         * while entering the data blocks in the potentially new L2 t=
ables.
>> +         * (We do not actually care where the L2 tables are placed. M=
aybe they
>> +         *  are already allocated or they can be placed somewhere bef=
ore
>> +         *  @old_file_size. It does not matter because they will be f=
ully
>> +         *  allocated automatically, so they do not need to be covere=
d by the
>> +         *  preallocation. All that matters is that we will not have =
to allocate
>> +         *  new refcount structures for them.) */
>> +        nb_new_l2_tables =3D DIV_ROUND_UP(nb_new_data_clusters,
>> +                                        s->cluster_size / sizeof(uint=
64_t));
>> +        /* The cluster range may not be aligned to L2 boundaries, so =
add one L2
>> +         * table for a potential head/tail */
>> +        nb_new_l2_tables++;
>> +
>> +        allocation_start =3D qcow2_refcount_area(bs, old_file_size,
>> +                                               nb_new_data_clusters +=

>> +                                               nb_new_l2_tables,
>> +                                               true, 0, 0);
>> +        if (allocation_start < 0) {
>> +            error_setg_errno(errp, -allocation_start,
>> +                             "Failed to resize refcount structures");=

>> +            return -allocation_start;
>> +        }
>> +
>> +        clusters_allocated =3D qcow2_alloc_clusters_at(bs, allocation=
_start,
>> +                                                     nb_new_data_clus=
ters);
>> +        if (clusters_allocated < 0) {
>> +            error_setg_errno(errp, -clusters_allocated,
>> +                             "Failed to allocate data clusters");
>> +            return -clusters_allocated;
>> +        }
>> +
>> +        assert(clusters_allocated =3D=3D nb_new_data_clusters);
>> +
>> +        /* Allocate the data area */
>> +        new_file_size =3D allocation_start +
>> +                        nb_new_data_clusters * s->cluster_size;
>> +        ret =3D bdrv_truncate(bs->file, new_file_size, prealloc, errp=
);
>> +        if (ret < 0) {
>> +            error_prepend(errp, "Failed to resize underlying file: ")=
;
>> +            qcow2_free_clusters(bs, allocation_start,
>> +                                nb_new_data_clusters * s->cluster_siz=
e,
>> +                                QCOW2_DISCARD_OTHER);
>> +            return ret;
>> +        }
>> +
>> +        /* Create the necessary L2 entries */
>> +        host_offset =3D allocation_start;
>> +        guest_offset =3D old_length;
>> +        while (nb_new_data_clusters) {
>> +            int64_t guest_cluster =3D guest_offset >> s->cluster_bits=
;
>> +            int64_t nb_clusters =3D MIN(nb_new_data_clusters,
>> +                                      s->l2_size - guest_cluster % s-=
>l2_size);
>> +            QCowL2Meta allocation =3D {
>> +                .offset       =3D guest_offset,
>> +                .alloc_offset =3D host_offset,
>> +                .nb_clusters  =3D nb_clusters,
>> +            };
>> +            qemu_co_queue_init(&allocation.dependent_requests);
>> +
>> +            ret =3D qcow2_alloc_cluster_link_l2(bs, &allocation);
>> +            if (ret < 0) {
>> +                error_setg_errno(errp, -ret, "Failed to update L2 tab=
les");
>> +                qcow2_free_clusters(bs, host_offset,
>> +                                    nb_new_data_clusters * s->cluster=
_size,
>> +                                    QCOW2_DISCARD_OTHER);
>> +                return ret;
>> +            }
>> +
>> +            guest_offset +=3D nb_clusters * s->cluster_size;
>> +            host_offset +=3D nb_clusters * s->cluster_size;
>> +            nb_new_data_clusters -=3D nb_clusters;
>> +        }
>> +        break;
>> +    }
>=20
> Flush L1/L2 tables?

Right. It would be good to actually have the area allocated for sure
before writing the new size. :-)

The same applies to the metadata-only preallocate(), though. So this
should probably be added in patch 11.

Thanks for spotting this, and thanks for reviewing!

Max


--LRmAAFeAqC9DvQ6suFLgxHrrsEBhJNekF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLrTFEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQFW7
CAC/Y2UQny3A5gyDKPetmo0ZRagXAij8IcnN2wtjzm7V0gyccmWoNc7fsqDL5ZEz
OSmV+yrHhofvFkCS79zcFkDzFnwUmwklkPCDNh2arcwT+eZGh2EJIzGjk7as10Nd
IDqJf2S3kHB7B+I64bfKjKD6cRiosDyRSjCF4adTBiyA8Q3JrUT5+GC+gPRIPO88
DdOOUI4ChuOCoYBK2Wx7/mfWsWuWy83ueArYI+1HbCL41UBac+NtxyktNGbxL8jP
etrvALB3qCp0BQ1dJllOfQOi0CdyLiYgjrSrydEZ1QDNpjljQ/gJjQwZ5GPCYIOG
VKPz2tmcJLtO2HIjYwObdHrd
=74rq
-----END PGP SIGNATURE-----

--LRmAAFeAqC9DvQ6suFLgxHrrsEBhJNekF--
