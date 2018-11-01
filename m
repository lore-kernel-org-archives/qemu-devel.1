Received: from eggs.gnu.org ([2001:4830:134:3::10]:53282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gI9mf-0004J0-3l
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gI9mb-0003uq-Tg
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:01:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gI9mb-0003td-LH
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:00:57 -0400
Date: Thu, 1 Nov 2018 11:00:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181101110051.67ffb084@redhat.com>
In-Reply-To: <20181023152306.3123-5-david@redhat.com>
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/7] range: add some more functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, 23 Oct 2018 17:23:03 +0200
David Hildenbrand <david@redhat.com> wrote:

> Add some more functions that will be used in memory-device context.
>=20
> range_init(): Init using lower bound and size, check for validity
> range_init_nofail(): Init using lower bound and size, validity asserted
> range_size(): Extract the size of a range
> range_overlaps_range(): Check for overlaps of two ranges
> range_contains_range(): Check if one range is contained in the other
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/qemu/range.h | 62 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>=20
> diff --git a/include/qemu/range.h b/include/qemu/range.h
> index 7e75f4e655..ba606c6bc0 100644
> --- a/include/qemu/range.h
> +++ b/include/qemu/range.h
> @@ -112,6 +112,68 @@ static inline uint64_t range_upb(Range *range)
>      return range->upb;
>  }
> =20
> +/*
> + * Initialize @range to span the interval [@lob,@lob + @size - 1].
> + * @size may be 0. If the range would overflow, returns -ERANGE, otherwi=
se
> + * 0.
> + */
> +static inline int QEMU_WARN_UNUSED_RESULT range_init(Range *range, uint6=
4_t lob,
> +                                                     uint64_t size)
> +{
> +    if (lob + size < lob) {
> +        return -ERANGE;
> +    }
> +    range->lob =3D lob;
> +    range->upb =3D lob + size - 1;
> +    range_invariant(range);
> +    return 0;
> +}
> +
> +/*
> + * Initialize @range to span the interval [@lob,@lob + @size - 1].
> + * @size may be 0. Range must not overflow.
> + */
> +static inline void range_init_nofail(Range *range, uint64_t lob, uint64_=
t size)
> +{
> +    range->lob =3D lob;
> +    range->upb =3D lob + size - 1;
> +    range_invariant(range);
> +}
> +
> +/*
> + * Get the size of @range.
> + */
> +static inline uint64_t range_size(const Range *range)
> +{
> +    return range->upb - range->lob + 1;
> +}
> +
> +/*
> + * Check if @range1 overlaps with @range2. If one of the ranges is empty,
> + * the result is always "false".
> + */
> +static inline bool range_overlaps_range(const Range *range1,
> +                                        const Range *range2)
> +{
> +    if (range_is_empty(range1) || range_is_empty(range2)) {
compilation fails with:
 "error: passing argument 1 of =E2=80=98range_is_empty=E2=80=99 discards =
=E2=80=98const=E2=80=99 qualifier from pointer target type [-Werror]"

the same for range_invariant,
following should fix issues:

diff --git a/include/qemu/range.h b/include/qemu/range.h
index 3586eb1..4b05bd1 100644
--- a/include/qemu/range.h
+++ b/include/qemu/range.h
@@ -39,7 +39,7 @@ struct Range {
     uint64_t upb;        /* inclusive upper bound */
 };
=20
-static inline void range_invariant(Range *range)
+static inline void range_invariant(const Range *range)
 {
     assert(range->lob <=3D range->upb || range->lob =3D=3D range->upb + 1);
 }
@@ -48,7 +48,7 @@ static inline void range_invariant(Range *range)
 #define range_empty ((Range){ .lob =3D 1, .upb =3D 0 })
=20
 /* Is @range empty? */
-static inline bool range_is_empty(Range *range)
+static inline bool range_is_empty(const Range *range)
 {
     range_invariant(range);
     return range->lob > range->upb;



> +        return false;
> +    }
> +    return !(range2->upb < range1->lob || range1->upb < range2->lob);
> +}
> +
> +/*
> + * Check if @range1 contains @range2. If one of the ranges is empty,
> + * the result is always "false".
> + */
> +static inline bool range_contains_range(const Range *range1,
> +                                        const Range *range2)
> +{
> +    if (range_is_empty(range1) || range_is_empty(range2)) {
> +        return false;
> +    }
> +    return range1->lob <=3D range2->lob && range1->upb >=3D range2->upb;
> +}
> +
>  /*
>   * Extend @range to the smallest interval that includes @extend_by, too.
>   */
