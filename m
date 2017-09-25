Received: from eggs.gnu.org ([2001:4830:134:3::10]:41405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwVTC-0004mV-IV
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwVTB-0005aA-6z
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:38:54 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:17512 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dwVTA-0005ZQ-Qi
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:38:53 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-12-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <23eacf8d-8f80-f912-9b77-c955f8100a5f@virtuozzo.com>
Date: Mon, 25 Sep 2017 18:38:44 +0300
MIME-Version: 1.0
In-Reply-To: <20170913181910.29688-12-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 11/18] hbitmap: Add @advance param to
 hbitmap_iter_next()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

13.09.2017 21:19, Max Reitz wrote:
> This new parameter allows the caller to just query the next dirty
> position without moving the iterator.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/qemu/hbitmap.h |  4 +++-
>   block/dirty-bitmap.c   |  2 +-
>   tests/test-hbitmap.c   | 26 +++++++++++++-------------
>   util/hbitmap.c         | 10 +++++++---
>   4 files changed, 24 insertions(+), 18 deletions(-)
>
> diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
> index d3a74a21fc..6a52575ad5 100644
> --- a/include/qemu/hbitmap.h
> +++ b/include/qemu/hbitmap.h
> @@ -316,11 +316,13 @@ void hbitmap_free_meta(HBitmap *hb);
>   /**
>    * hbitmap_iter_next:
>    * @hbi: HBitmapIter to operate on.
> + * @advance: If true, advance the iterator.  Otherwise, the next call
> + *           of this function will return the same result.

it's not quit right, as hbitmap iterator allows concurrent resetting of 
bits, and in
this case next call may return some other result. (see f63ea4e92bad1db)

>    *
>    * Return the next bit that is set in @hbi's associated HBitmap,
>    * or -1 if all remaining bits are zero.
>    */
> -int64_t hbitmap_iter_next(HBitmapIter *hbi);
> +int64_t hbitmap_iter_next(HBitmapIter *hbi, bool advance);
>   
>   /**
>    * hbitmap_iter_next_word:
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 30462d4f9a..aee57cf8c8 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -547,7 +547,7 @@ void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter)
>   
>   int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
>   {
> -    return hbitmap_iter_next(&iter->hbi);
> +    return hbitmap_iter_next(&iter->hbi, true);
>   }
>   
>   /* Called within bdrv_dirty_bitmap_lock..unlock */
> diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
> index 1acb353889..e6d4d563cb 100644
> --- a/tests/test-hbitmap.c
> +++ b/tests/test-hbitmap.c
> @@ -46,7 +46,7 @@ static void hbitmap_test_check(TestHBitmapData *data,
>   
>       i = first;
>       for (;;) {
> -        next = hbitmap_iter_next(&hbi);
> +        next = hbitmap_iter_next(&hbi, true);
>           if (next < 0) {
>               next = data->size;
>           }
> @@ -435,25 +435,25 @@ static void test_hbitmap_iter_granularity(TestHBitmapData *data,
>       /* Note that hbitmap_test_check has to be invoked manually in this test.  */
>       hbitmap_test_init(data, 131072 << 7, 7);
>       hbitmap_iter_init(&hbi, data->hb, 0);
> -    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
>   
>       hbitmap_test_set(data, ((L2 + L1 + 1) << 7) + 8, 8);
>       hbitmap_iter_init(&hbi, data->hb, 0);
> -    g_assert_cmpint(hbitmap_iter_next(&hbi), ==, (L2 + L1 + 1) << 7);
> -    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, (L2 + L1 + 1) << 7);
> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
>   
>       hbitmap_iter_init(&hbi, data->hb, (L2 + L1 + 2) << 7);
> -    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
>   
>       hbitmap_test_set(data, (131072 << 7) - 8, 8);
>       hbitmap_iter_init(&hbi, data->hb, 0);
> -    g_assert_cmpint(hbitmap_iter_next(&hbi), ==, (L2 + L1 + 1) << 7);
> -    g_assert_cmpint(hbitmap_iter_next(&hbi), ==, 131071 << 7);
> -    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, (L2 + L1 + 1) << 7);
> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, 131071 << 7);
> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
>   
>       hbitmap_iter_init(&hbi, data->hb, (L2 + L1 + 2) << 7);
> -    g_assert_cmpint(hbitmap_iter_next(&hbi), ==, 131071 << 7);
> -    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, 131071 << 7);
> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
>   }
>   
>   static void hbitmap_test_set_boundary_bits(TestHBitmapData *data, ssize_t diff)
> @@ -893,7 +893,7 @@ static void test_hbitmap_serialize_zeroes(TestHBitmapData *data,
>       for (i = 0; i < num_positions; i++) {
>           hbitmap_deserialize_zeroes(data->hb, positions[i], min_l1, true);
>           hbitmap_iter_init(&iter, data->hb, 0);
> -        next = hbitmap_iter_next(&iter);
> +        next = hbitmap_iter_next(&iter, true);
>           if (i == num_positions - 1) {
>               g_assert_cmpint(next, ==, -1);
>           } else {
> @@ -919,10 +919,10 @@ static void test_hbitmap_iter_and_reset(TestHBitmapData *data,
>   
>       hbitmap_iter_init(&hbi, data->hb, BITS_PER_LONG - 1);
>   
> -    hbitmap_iter_next(&hbi);
> +    hbitmap_iter_next(&hbi, true);
>   
>       hbitmap_reset_all(data->hb);
> -    hbitmap_iter_next(&hbi);
> +    hbitmap_iter_next(&hbi, true);
>   }
>   
>   int main(int argc, char **argv)
> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index 21535cc90b..96525983ce 100644
> --- a/util/hbitmap.c
> +++ b/util/hbitmap.c
> @@ -141,7 +141,7 @@ unsigned long hbitmap_iter_skip_words(HBitmapIter *hbi)
>       return cur;
>   }
>   
> -int64_t hbitmap_iter_next(HBitmapIter *hbi)
> +int64_t hbitmap_iter_next(HBitmapIter *hbi, bool advance)
>   {
>       unsigned long cur = hbi->cur[HBITMAP_LEVELS - 1] &
>               hbi->hb->levels[HBITMAP_LEVELS - 1][hbi->pos];
> @@ -154,8 +154,12 @@ int64_t hbitmap_iter_next(HBitmapIter *hbi)
>           }
>       }
>   
> -    /* The next call will resume work from the next bit.  */
> -    hbi->cur[HBITMAP_LEVELS - 1] = cur & (cur - 1);
> +    if (advance) {
> +        /* The next call will resume work from the next bit.  */
> +        hbi->cur[HBITMAP_LEVELS - 1] = cur & (cur - 1);
> +    } else {
> +        hbi->cur[HBITMAP_LEVELS - 1] = cur;
> +    }
>       item = ((uint64_t)hbi->pos << BITS_PER_LEVEL) + ctzl(cur);
>   
>       return item << hbi->granularity;


-- 
Best regards,
Vladimir
