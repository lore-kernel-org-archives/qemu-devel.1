Received: from eggs.gnu.org ([2001:4830:134:3::10]:48302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAWxL-0003ML-Bx
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAWxI-0008Dt-5P
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:08:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gAWxH-0008DN-Sl
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:08:28 -0400
Date: Thu, 11 Oct 2018 10:08:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181011090821.GC2483@work-vm>
References: <20181009205652.10605-1-david@redhat.com>
	<20181009205652.10605-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009205652.10605-5-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 4/7] range: add some more functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>

* David Hildenbrand (david@redhat.com) wrote:
> Add some more functions that will be used in memory-device context.
> 
> range_init(): Init using lower bound and size
> range_valid(): Check if there would be an overflow when initializin
> range_size(): Extract the size of a range
> range_overlaps_range(): Check for overlaps of two ranges
> range_contains_range(): Check if one range is contained in the other
> range_starts_before_range(): Check if one range starts before another
> range_ends_after_range(): Check if one range ends after another
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/qemu/range.h | 80 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/include/qemu/range.h b/include/qemu/range.h
> index 7e75f4e655..18e8acf22f 100644
> --- a/include/qemu/range.h
> +++ b/include/qemu/range.h
> @@ -112,6 +112,86 @@ static inline uint64_t range_upb(Range *range)
>      return range->upb;
>  }
>  
> +/*
> + * Initialize @range to span the interval [@lob,@lob + @size - 1].
> + * @size may be 0.
> + */
> +static inline void range_init(Range *range, uint64_t lob, uint64_t size)
> +{
> +    range->lob = lob;
> +    range->upb = lob + size - 1;
> +    range_invariant(range);
> +}
> +
> +/*
> + * Check if the interval [@lob,@lob + @size - 1] would be valid or not
> + * (result in an overflow).
> + */
> +static inline bool range_valid(uint64_t lob, uint64_t size)
> +{
> +    return lob + size >= lob;
> +}

That name confused me, I'd expected that to have taken a range and check
it for something (like a non-asserting version of the invariant).

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
> +    return range1->lob <= range2->lob && range1->upb >= range2->upb;
> +}
> +
> +/*
> + * Check if @range1 starts before @range2. If one of the ranges is empty,
> + * the result is alsways "false".
> + */
> +static inline bool range_starts_before_range(const Range *range1,
> +                                             const Range *range2)
> +{
> +    if (range_is_empty(range1) || range_is_empty(range2)) {
> +        return false;
> +    }
> +    return range1->lob < range2->lob;
> +}
> +
> +/*
> + * Check if @range1 ends after @range2. If one of the ranges is empty,
> + * the result is alsways "false".
> + */
> +static inline bool range_ends_after_range(const Range *range1,
> +                                          const Range *range2)
> +{
> +    if (range_is_empty(range1) || range_is_empty(range2)) {
> +        return false;
> +    }
> +    return range1->upb > range2->upb;
> +}
> +
>  /*
>   * Extend @range to the smallest interval that includes @extend_by, too.
>   */
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
