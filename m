Received: from eggs.gnu.org ([209.51.188.92]:57382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjQjK-0007lt-5d
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:34:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjQjD-0006mg-VS
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:34:18 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-6-eblake@redhat.com>
	<acc77355-221d-0497-4b14-6b3c1bb79c7d@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f42d51fa-1268-0abf-11b8-7661655e995d@redhat.com>
Date: Tue, 15 Jan 2019 09:33:57 -0600
MIME-Version: 1.0
In-Reply-To: <acc77355-221d-0497-4b14-6b3c1bb79c7d@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ICc6Is9oXSZVAr15yJUlIWdwKR0Qnj9DF"
Subject: Re: [Qemu-devel] [PATCH v3 05/19] nbd/server: Favor [u]int64_t over
 off_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ICc6Is9oXSZVAr15yJUlIWdwKR0Qnj9DF
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <f42d51fa-1268-0abf-11b8-7661655e995d@redhat.com>
Subject: Re: [PATCH v3 05/19] nbd/server: Favor [u]int64_t over off_t
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-6-eblake@redhat.com>
 <acc77355-221d-0497-4b14-6b3c1bb79c7d@virtuozzo.com>
In-Reply-To: <acc77355-221d-0497-4b14-6b3c1bb79c7d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/15/19 4:19 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.01.2019 20:57, Eric Blake wrote:
>> Although our compile-time environment is set up so that we always
>> support long files with 64-bit off_t, we have no guarantee whether
>> off_t is the same type as int64_t.  This requires casts when
>> printing values, and prevents us from directly using qemu_strtoi64().
>> Let's just flip to [u]int64_t (signed for length, because we have to
>> detect failure of blk_getlength()
>=20
> we have not, after previous patch

nbd/server.c no longer has to check for blk_getlength() failures, but
blockdev-nbd.c and qemu-nbd.c still do.  Since the callers have to use
an int64_t type for the length as part of their error checking, it's
easier to accept an int64_t length to nbd_export_new(), even if
nbd_export_new() could also use an unsigned type.

>=20
> and because off_t was signed;
>> unsigned for offset because it lets us simplify some math without
>> having to worry about signed overflow).
>>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v3: new patch
>> ---
>>   include/block/nbd.h |  4 ++--
>>   nbd/server.c        | 14 +++++++-------
>>   qemu-nbd.c          | 26 ++++++++++----------------
>>   3 files changed, 19 insertions(+), 25 deletions(-)
>>
>> diff --git a/include/block/nbd.h b/include/block/nbd.h
>> index 1971b557896..0f252829376 100644
>> --- a/include/block/nbd.h
>> +++ b/include/block/nbd.h
>> @@ -294,8 +294,8 @@ int nbd_errno_to_system_errno(int err);
>>   typedef struct NBDExport NBDExport;
>>   typedef struct NBDClient NBDClient;
>>
>> -NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off=
_t size,
>> -                          const char *name, const char *description,
>> +NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
>> +                          int64_t size, const char *name, const char =
*desc,
>=20
> in previous patch you drop use of negative @size parameter, so it looks=
 better
> to use unsigned for size like for offset

You can't have a size larger than 2^63; but an unsigned type holds
nearly 2^64.  I prefer a signed size, for the same reason that off_t is
signed, in that checking for a negative size is easier to rule out sizes
that are too large.


>>
>>   static int find_partition(BlockBackend *blk, int partition,
>> -                          off_t *offset, off_t *size)
>> +                          uint64_t *offset, int64_t *size)
>=20
> function never return negative @size, so what is the reason to keep it =
signed?

Because the C compiler does NOT like:

int64_t len;
find_partition(..., &len);

with a uint64_t* parameter type - you HAVE to match the signed-ness of
your caller's parameter with your pointer type. Since the caller already
has to use a signed type (to check for blk_getlength() failure AND
because sizes really cannot exceed 2^63), it's easier to keep it signed
here.

>=20
> Also, type conversion (uint64_t) should be dropped from the function co=
de I think.

Are you talking about this part:

                if ((ext_partnum + j + 1) =3D=3D partition) {
                    *offset =3D (uint64_t)ext[j].start_sector_abs << 9;
                    *size =3D (uint64_t)ext[j].nb_sectors_abs << 9;
                    return 0;
                }
            }
            ext_partnum +=3D 4;
        } else if ((i + 1) =3D=3D partition) {
            *offset =3D (uint64_t)mbr[i].start_sector_abs << 9;
            *size =3D (uint64_t)mbr[i].nb_sectors_abs << 9;
            return 0;

No - that has to keep the cast, because .start_sector_abs and
=2Enb_sectors_abs are uint32_t values, but we want to shift into 64-bit
results.  You need the cast to force the correct arithmetic rather than
truncating into a 32-bit value that then gets widened into 64-bit storage=
=2E

>> @@ -665,10 +665,6 @@ int main(int argc, char **argv)
>>                   error_report("Invalid offset `%s'", optarg);
>>                   exit(EXIT_FAILURE);
>>               }
>> -            if (dev_offset < 0) {
>> -                error_report("Offset must be positive `%s'", optarg);=

>> -                exit(EXIT_FAILURE);
>> -            }
>=20
> hm, then, may be, s/strtoll/strtoull before this?

I clean that up in patch 6/19.

>=20
>>               break;
>>           case 'l':
>>               if (strstart(optarg, SNAPSHOT_OPT_BASE, NULL)) {
>> @@ -1005,15 +1001,14 @@ int main(int argc, char **argv)
>>       }
>>
>>       if (dev_offset >=3D fd_size) {
>> -        error_report("Offset (%lld) has to be smaller than the image =
size "
>> -                     "(%lld)",
>> -                     (long long int)dev_offset, (long long int)fd_siz=
e);
>> +        error_report("Offset (%" PRIu64 ") has to be smaller than the=
 image "
>> +                     "size (%" PRIu64 ")", dev_offset, fd_size);
>=20
> PRId64 for fd_size

Sure.


>> @@ -1026,12 +1021,11 @@ int main(int argc, char **argv)
>>               exit(EXIT_FAILURE);
>>           }
>>           /* partition limits are (32-bit << 9); can't overflow 64 bit=
s */
>> -        assert(dev_offset >=3D 0 && dev_offset + limit >=3D dev_offse=
t);
>> +        assert(dev_offset + limit >=3D dev_offset);
>>           if (dev_offset + limit > fd_size) {
>> -            error_report("Discovered partition %d at offset %lld size=
 %lld, "
>> -                         "but size exceeds file length %lld", partiti=
on,
>> -                         (long long int) dev_offset, (long long int) =
limit,
>> -                         (long long int) fd_size);
>> +            error_report("Discovered partition %d at offset %" PRIu64=

>> +                         " size %" PRId64 ", but size exceeds file le=
ngth %"
>> +                         PRId64, partition, dev_offset, limit, fd_siz=
e);
>>               exit(EXIT_FAILURE);
>=20
> hmm, it may be better to place this patch before [03], to squash this c=
hunk into [03]

I didn't mind the churn; also, I prefer patch 3 first, because it's more
likely to get backported as a bug fix than the rest of the series (and
the earlier you stick backport candidates in a series, the easier it is
to backport).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ICc6Is9oXSZVAr15yJUlIWdwKR0Qnj9DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw9/WUACgkQp6FrSiUn
Q2rhEgf2L/uUQBp0TA2RCMx3XuEHoG+JaBr5A795MZeK702aTjXp4sPiHIJW4jnC
8QQGgT0eBcJu+3I5sPeuI2j9lzo16h0Ooll2BAtBrVKU7B3lLCPinnYkqjszjBNy
6DgJpyoE/cAOQpZI5yEBKxK2Tc9sSKvZyO++hi/ZcEbmxevAjzC/arcPnHngnc7P
9QiGii57Tx3lWtrhfz4RjNgQeAFcysjjo6uut28ZD9uzydOc+Y2zw8+/zHWhI4Dd
CiBt78qKvD3RDihh9d/z12s2t+zNKu3/0sGFEWsk9NyhAHLOXLmZVo2TsIKV44cf
jLymcnQLveqJGa+J0l81Nz7mjJsf
=PyjA
-----END PGP SIGNATURE-----

--ICc6Is9oXSZVAr15yJUlIWdwKR0Qnj9DF--
