Received: from eggs.gnu.org ([2001:4830:134:3::10]:33792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fyOj3-0004cM-Tm
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fyOj3-0004Dc-2V
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:55:37 -0400
References: <20180814121443.33114-1-vsementsov@virtuozzo.com>
	<20180814121443.33114-3-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <7409398a-cb3e-b826-df51-be5f4089c49c@redhat.com>
Date: Fri, 7 Sep 2018 17:55:28 -0400
MIME-Version: 1.0
In-Reply-To: <20180814121443.33114-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/8] tests: add tests for
 hbitmap_next_zero with specified end parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com, Eric Blake <eblake@redhat.com>



On 08/14/2018 08:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/test-hbitmap.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
> index 6b6a40bddd..dddb67c3c5 100644
> --- a/tests/test-hbitmap.c
> +++ b/tests/test-hbitmap.c
> @@ -937,31 +937,49 @@ static void test_hbitmap_iter_and_reset(TestHBitmapData *data,
>      check_hbitmap_iter_next(&hbi);
>  }
>  
> -static void test_hbitmap_next_zero_check(TestHBitmapData *data, int64_t start)
> +static void test_hbitmap_next_zero_check_range(TestHBitmapData *data,
> +                                               int64_t start,
> +                                               int64_t count)

Should this interface match the implementation? Because ...

>  {
> -    int64_t ret1 = hbitmap_next_zero(data->hb, start, -1);
> +    int64_t ret1 = hbitmap_next_zero(data->hb, start,
> +                                     count == -1 ? -1 : start + count);

I find it confusing that we use 0 as a sentinel value here and have to
swap it out with -1. If the interfaces matched this would read a little
cleaner, wouldn't it?

>      int64_t ret2 = start;
> -    for ( ; ret2 < data->size && hbitmap_get(data->hb, ret2); ret2++) {
> +    int64_t end = count == -1 ? data->size : start + count;
> +
> +    for ( ; ret2 < end && hbitmap_get(data->hb, ret2); ret2++) {
>          ;
>      }
> -    if (ret2 == data->size) {
> +    if (ret2 == end) {
>          ret2 = -1;
>      }
>  
>      g_assert_cmpint(ret1, ==, ret2);
>  }
>  
> +static void test_hbitmap_next_zero_check(TestHBitmapData *data, int64_t start)
> +{
> +    test_hbitmap_next_zero_check_range(data, start, 0);
> +}
> +
>  static void test_hbitmap_next_zero_do(TestHBitmapData *data, int granularity)
>  {
>      hbitmap_test_init(data, L3, granularity);
>      test_hbitmap_next_zero_check(data, 0);
>      test_hbitmap_next_zero_check(data, L3 - 1);
> +    test_hbitmap_next_zero_check_range(data, 0, 1);
> +    test_hbitmap_next_zero_check_range(data, L3 - 1, 1);
>  
>      hbitmap_set(data->hb, L2, 1);
>      test_hbitmap_next_zero_check(data, 0);
>      test_hbitmap_next_zero_check(data, L2 - 1);
>      test_hbitmap_next_zero_check(data, L2);
>      test_hbitmap_next_zero_check(data, L2 + 1);
> +    test_hbitmap_next_zero_check_range(data, 0, 1);
> +    test_hbitmap_next_zero_check_range(data, 0, L2);
> +    test_hbitmap_next_zero_check_range(data, L2 - 1, 1);
> +    test_hbitmap_next_zero_check_range(data, L2 - 1, 2);
> +    test_hbitmap_next_zero_check_range(data, L2, 1);
> +    test_hbitmap_next_zero_check_range(data, L2 + 1, 1);
>  
>      hbitmap_set(data->hb, L2 + 5, L1);
>      test_hbitmap_next_zero_check(data, 0);
> @@ -970,6 +988,10 @@ static void test_hbitmap_next_zero_do(TestHBitmapData *data, int granularity)
>      test_hbitmap_next_zero_check(data, L2 + 5);
>      test_hbitmap_next_zero_check(data, L2 + L1 - 1);
>      test_hbitmap_next_zero_check(data, L2 + L1);
> +    test_hbitmap_next_zero_check_range(data, L2, 6);
> +    test_hbitmap_next_zero_check_range(data, L2 + 1, 3);
> +    test_hbitmap_next_zero_check_range(data, L2 + 4, L1);
> +    test_hbitmap_next_zero_check_range(data, L2 + 5, L1);
>  
>      hbitmap_set(data->hb, L2 * 2, L3 - L2 * 2);
>      test_hbitmap_next_zero_check(data, L2 * 2 - L1);
> @@ -977,6 +999,8 @@ static void test_hbitmap_next_zero_do(TestHBitmapData *data, int granularity)
>      test_hbitmap_next_zero_check(data, L2 * 2 - 1);
>      test_hbitmap_next_zero_check(data, L2 * 2);
>      test_hbitmap_next_zero_check(data, L3 - 1);
> +    test_hbitmap_next_zero_check_range(data, L2 * 2 - L1, L1 + 1);
> +    test_hbitmap_next_zero_check_range(data, L2 * 2, L2);
>  
>      hbitmap_set(data->hb, 0, L3);
>      test_hbitmap_next_zero_check(data, 0);
> 
