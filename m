Received: from eggs.gnu.org ([2001:4830:134:3::10]:56972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1esrEd-0007FY-17
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 09:37:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1esrEb-0004xp-PX
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 09:37:03 -0500
References: <20180207125037.13510-1-vsementsov@virtuozzo.com>
	<20180207125037.13510-2-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6599c628-9b24-52ca-32cc-dbac23b44bdc@virtuozzo.com>
Date: Mon, 5 Mar 2018 17:36:47 +0300
MIME-Version: 1.0
In-Reply-To: <20180207125037.13510-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com

07.02.2018 15:50, Vladimir Sementsov-Ogievskiy wrote:
> Introduce latency histogram statics for block devices.
> For each accounted operation type latency region [0, +inf) is
> divided into subregions by several points. Then, calculate
> hits for each subregion.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/accounting.h |  9 +++++
>   block/accounting.c         | 97 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 106 insertions(+)
>
> diff --git a/include/block/accounting.h b/include/block/accounting.h
> index b833d26d6c..9679020f64 100644
> --- a/include/block/accounting.h
> +++ b/include/block/accounting.h
> @@ -45,6 +45,12 @@ struct BlockAcctTimedStats {
>       QSLIST_ENTRY(BlockAcctTimedStats) entries;
>   };
>   
> +typedef struct BlockLatencyHistogram {
> +    int size;
> +    uint64_t *points; /* @size-1 points here (all points, except 0 and +inf) */
> +    uint64_t *histogram[BLOCK_MAX_IOTYPE]; /* @size elements for each type */
> +} BlockLatencyHistogram;
> +
>   struct BlockAcctStats {
>       QemuMutex lock;
>       uint64_t nr_bytes[BLOCK_MAX_IOTYPE];
> @@ -57,6 +63,7 @@ struct BlockAcctStats {
>       QSLIST_HEAD(, BlockAcctTimedStats) intervals;
>       bool account_invalid;
>       bool account_failed;
> +    BlockLatencyHistogram latency_histogram;
>   };
>   
>   typedef struct BlockAcctCookie {
> @@ -82,5 +89,7 @@ void block_acct_merge_done(BlockAcctStats *stats, enum BlockAcctType type,
>   int64_t block_acct_idle_time_ns(BlockAcctStats *stats);
>   double block_acct_queue_depth(BlockAcctTimedStats *stats,
>                                 enum BlockAcctType type);
> +int block_latency_histogram_set(BlockAcctStats *stats, uint64List *latency);
> +void block_latency_histogram_clear(BlockAcctStats *stats);
>   
>   #endif
> diff --git a/block/accounting.c b/block/accounting.c
> index 87ef5bbfaa..0051ff0c24 100644
> --- a/block/accounting.c
> +++ b/block/accounting.c
> @@ -94,6 +94,100 @@ void block_acct_start(BlockAcctStats *stats, BlockAcctCookie *cookie,
>       cookie->type = type;
>   }
>   
> +/* block_latency_histogram_compare_func
> + * Compare @key with interval [@el, @el+1), where @el+1 is a next array element
> + * after @el.
> + * Return: -1 if @key < @el
> + *          0 if @key in [@el, @el+1)
> + *         +1 if @key >= @el+1
> + */
> +static int block_latency_histogram_compare_func(const void *key, const void *el)
> +{
> +    uint64_t k = *(uint64_t *)key;
> +    uint64_t a = *(uint64_t *)el;
> +    uint64_t b = *((uint64_t *)el + 1);
> +
> +    return k < a ? -1 : (k < b ? 0 : 1);
> +}
> +
> +static void block_latency_histogram_account(BlockLatencyHistogram *hist,
> +                                            enum BlockAcctType type,
> +                                            int64_t latency_ns)
> +{
> +    uint64_t *data, *pos;
> +
> +    if (hist->points == NULL) {
> +        /* histogram disabled */
> +        return;
> +    }
> +
> +    data = hist->histogram[type];
> +
> +    if (latency_ns < hist->points[0]) {
> +        data[0]++;
> +        return;
> +    }
> +
> +    if (latency_ns >= hist->points[hist->size - 2]) {
> +        data[hist->size - 1]++;
> +        return;
> +    }
> +
> +    pos = bsearch(&latency_ns, hist->points, hist->size - 2,
> +                  sizeof(hist->points[0]),
> +                  block_latency_histogram_compare_func);
> +    assert(pos != NULL);
> +
> +    data[pos - hist->points + 1]++;
> +}
> +
> +int block_latency_histogram_set(BlockAcctStats *stats, uint64List *latency)
> +{
> +    BlockLatencyHistogram *hist = &stats->latency_histogram;
> +    uint64List *entry;
> +    uint64_t *ptr;
> +    int i;
> +    uint64_t prev = 0;
> +
> +    hist->size = 1;

bug here. we can fail, so separate variable new_size is needed to 
calculate new size.

> +
> +    for (entry = latency; entry; entry = entry->next) {
> +        if (entry->value <= prev) {
> +            return -EINVAL;
> +        }
> +        hist->size++;
> +        prev = entry->value;
> +    }
> +
> +    hist->points = g_renew(uint64_t, hist->points, hist->size - 1);
> +    for (entry = latency, ptr = hist->points; entry;
> +         entry = entry->next, ptr++)
> +    {
> +        *ptr = entry->value;
> +    }
> +
> +    for (i = 0; i < BLOCK_MAX_IOTYPE; i++) {
> +        hist->histogram[i] = g_renew(uint64_t, hist->histogram[i], hist->size);
> +        memset(hist->histogram[i], 0, hist->size * sizeof(uint64_t));
> +    }
> +
> +    return 0;
> +}
> +
> +void block_latency_histogram_clear(BlockAcctStats *stats)
> +{
> +    BlockLatencyHistogram *hist = &stats->latency_histogram;
> +    int i;
> +
> +    g_free(hist->points);
> +    hist->points = NULL;
> +
> +    for (i = 0; i < BLOCK_MAX_IOTYPE; i++) {
> +        g_free(hist->histogram[i]);
> +        hist->histogram[i] = NULL;
> +    }
> +}
> +
>   static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
>                                    bool failed)
>   {
> @@ -116,6 +210,9 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
>           stats->nr_ops[cookie->type]++;
>       }
>   
> +    block_latency_histogram_account(&stats->latency_histogram, cookie->type,
> +                                    latency_ns);
> +
>       if (!failed || stats->account_failed) {
>           stats->total_time_ns[cookie->type] += latency_ns;
>           stats->last_access_time_ns = time_ns;


-- 
Best regards,
Vladimir
