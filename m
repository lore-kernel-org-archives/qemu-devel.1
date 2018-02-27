Received: from eggs.gnu.org ([2001:4830:134:3::10]:56266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eqb6o-0000N4-Ck
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:59:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eqb6n-0002VG-Hx
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:59:38 -0500
Date: Tue, 27 Feb 2018 16:59:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180227085910.GB25412@lemon.usersys.redhat.com>
References: <20180122220806.22154-1-mreitz@redhat.com>
	<20180122220806.22154-11-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180122220806.22154-11-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 10/16] hbitmap: Add @advance param to
 hbitmap_iter_next()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, 01/22 23:08, Max Reitz wrote:
> diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
> index 9091c639b3..2a2aa5bd43 100644
> --- a/tests/test-hbitmap.c
> +++ b/tests/test-hbitmap.c
> @@ -46,7 +46,7 @@ static void hbitmap_test_check(TestHBitmapData *data,
>  
>      i = first;
>      for (;;) {
> -        next = hbitmap_iter_next(&hbi);
> +        next = hbitmap_iter_next(&hbi, true);
>          if (next < 0) {
>              next = data->size;
>          }
> @@ -435,25 +435,25 @@ static void test_hbitmap_iter_granularity(TestHBitmapData *data,
>      /* Note that hbitmap_test_check has to be invoked manually in this test.  */
>      hbitmap_test_init(data, 131072 << 7, 7);
>      hbitmap_iter_init(&hbi, data->hb, 0);
> -    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
>  
>      hbitmap_test_set(data, ((L2 + L1 + 1) << 7) + 8, 8);
>      hbitmap_iter_init(&hbi, data->hb, 0);
> -    g_assert_cmpint(hbitmap_iter_next(&hbi), ==, (L2 + L1 + 1) << 7);
> -    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, (L2 + L1 + 1) << 7);
> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
>  
>      hbitmap_iter_init(&hbi, data->hb, (L2 + L1 + 2) << 7);
> -    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
>  
>      hbitmap_test_set(data, (131072 << 7) - 8, 8);
>      hbitmap_iter_init(&hbi, data->hb, 0);
> -    g_assert_cmpint(hbitmap_iter_next(&hbi), ==, (L2 + L1 + 1) << 7);
> -    g_assert_cmpint(hbitmap_iter_next(&hbi), ==, 131071 << 7);
> -    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, (L2 + L1 + 1) << 7);
> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, 131071 << 7);
> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
>  
>      hbitmap_iter_init(&hbi, data->hb, (L2 + L1 + 2) << 7);
> -    g_assert_cmpint(hbitmap_iter_next(&hbi), ==, 131071 << 7);
> -    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), ==, 131071 << 7);
> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
>  }

Please add tests for advance=false too.
