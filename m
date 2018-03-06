Received: from eggs.gnu.org ([2001:4830:134:3::10]:48729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etEZj-0007yH-9I
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:32:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etEZd-0003bG-Bl
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:32:23 -0500
Date: Tue, 6 Mar 2018 15:32:13 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180306153213.GK31045@stefanha-x1.localdomain>
References: <20180207125037.13510-1-vsementsov@virtuozzo.com>
	<20180207125037.13510-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sU4rRG038CsJurvk"
Content-Disposition: inline
In-Reply-To: <20180207125037.13510-2-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] block/accounting: introduce latency
 histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org


--sU4rRG038CsJurvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2018 at 03:50:36PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Introduce latency histogram statics for block devices.
> For each accounted operation type latency region [0, +inf) is
> divided into subregions by several points. Then, calculate
> hits for each subregion.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/accounting.h |  9 +++++
>  block/accounting.c         | 97 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 106 insertions(+)
>=20
> diff --git a/include/block/accounting.h b/include/block/accounting.h
> index b833d26d6c..9679020f64 100644
> --- a/include/block/accounting.h
> +++ b/include/block/accounting.h
> @@ -45,6 +45,12 @@ struct BlockAcctTimedStats {
>      QSLIST_ENTRY(BlockAcctTimedStats) entries;
>  };
> =20
> +typedef struct BlockLatencyHistogram {
> +    int size;
> +    uint64_t *points; /* @size-1 points here (all points, except 0 and +=
inf) */
> +    uint64_t *histogram[BLOCK_MAX_IOTYPE]; /* @size elements for each ty=
pe */

The semantics of these fields is not obvious.  Please include a comment
with an example or ASCII-art diagram so anyone reading the code
understands the purpose of the fields without reading all the code.

According to Wikipedia and Mathworld, "intervals" and "bins" are
commonly used terms:
https://en.wikipedia.org/wiki/Histogram
http://mathworld.wolfram.com/Histogram.html

I suggest:

  typedef struct {
      /* The following histogram is represented like this:
       *
       * 5|           *
       * 4|           *
       * 3| *         *
       * 2| *         *    *
       * 1| *    *    *    *
       *  +------------------
       *      10   50   100
       *
       * BlockLatencyHistogram histogram =3D {
       *     .nbins =3D 4,
       *     .intervals =3D {10, 50, 100},
       *     .bins =3D {3, 1, 5, 2},
       * };
       */
      size_t nbins;

      /* Interval boundaries (there are @nbins - 1 elements) */
      uint64_t *intervals;

      /* Frequency data (there are @nbins elements) */
      uint64_t *bins[BLOCK_MAX_IOTYPE];
  } BlockLatencyHistogram;

> +/* block_latency_histogram_compare_func
> + * Compare @key with interval [@el, @el+1), where @el+1 is a next array =
element
> + * after @el.
> + * Return: -1 if @key < @el
> + *          0 if @key in [@el, @el+1)
> + *         +1 if @key >=3D @el+1

"@el+1" is confusing, usually x+1 means "the value of x plus 1", not
"y" (a different variable!).

I suggest:

  /* block_latency_histogram_compare_func:
   * Compare @key with interval [@it[0], @it[1]).
   * Return: -1 if @key < @it[0]
   *          0 if @key in [@it[0], @it[1])
   *         +1 if @key >=3D @it[1]
   */
  static int block_latency_histogram_compare_func(const void *key, const vo=
id *it)

> +int block_latency_histogram_set(BlockAcctStats *stats, uint64List *laten=
cy)
> +{
> +    BlockLatencyHistogram *hist =3D &stats->latency_histogram;
> +    uint64List *entry;
> +    uint64_t *ptr;
> +    int i;
> +    uint64_t prev =3D 0;
> +
> +    hist->size =3D 1;
> +
> +    for (entry =3D latency; entry; entry =3D entry->next) {
> +        if (entry->value <=3D prev) {
> +            return -EINVAL;
> +        }
> +        hist->size++;
> +        prev =3D entry->value;
> +    }
> +
> +    hist->points =3D g_renew(uint64_t, hist->points, hist->size - 1);
> +    for (entry =3D latency, ptr =3D hist->points; entry;
> +         entry =3D entry->next, ptr++)
> +    {
> +        *ptr =3D entry->value;
> +    }
> +
> +    for (i =3D 0; i < BLOCK_MAX_IOTYPE; i++) {
> +        hist->histogram[i] =3D g_renew(uint64_t, hist->histogram[i], his=
t->size);
> +        memset(hist->histogram[i], 0, hist->size * sizeof(uint64_t));

Is there a reason for using g_renew() and then clearing everything?
This is more concise:

  g_free(hist->histogram[i]);
  hist->histogram[i] =3D g_new0(uint64_t, hist->size);

--sU4rRG038CsJurvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJanrR9AAoJEJykq7OBq3PI6FIH/iL3vfc9B81LoghLSr/DNLy3
LDsNP4cDjSB98ZLdtn0EaPHnPO0+AhxSsZTxUEFwwSgkCeRVS9dhOUliSnTxkYjd
TrhxbYGANkUxOZhIEs6AvhKrlyi7Ii5X8b5o5hk+h2CJWjzZbA/AuD3UgQH2/xiP
jXhOnff9Z7tJploZ1RX7YQjr0RqFpHTAED0aGrSasO1ue0WVFddi6QnkSLidv4o3
B3r9Si9bUCngJfWe1b39bdMF8Y1Hkdh8TAOv+DD2xwupOf+6Ndpbss4PfKmqUlTD
xQ3/KJbhDt8lO9pKmMgpI+3vfK10JqCd5/1zGZP6HNhP3/r7fug87x3LIj8LZMw=
=P2mD
-----END PGP SIGNATURE-----

--sU4rRG038CsJurvk--
