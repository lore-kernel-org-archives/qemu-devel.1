Received: from eggs.gnu.org ([2001:4830:134:3::10]:46666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyIUZ-0008Vh-45
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 11:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyIUV-0004NY-4h
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 11:16:15 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fyIUU-0004LV-TQ
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 11:16:11 -0400
Received: by mail-wr1-x42e.google.com with SMTP id e1-v6so6280466wrt.3
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 08:16:10 -0700 (PDT)
References: <20180817232923.28899-1-cota@braap.org>
	<20180817232923.28899-5-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180817232923.28899-5-cota@braap.org>
Date: Fri, 07 Sep 2018 16:16:08 +0100
Message-ID: <87ftylz6br.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/6] test-qht: test removal of non-existent
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> This improves qht.c code coverage from 89.44% to 90.00%.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/test-qht.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/tests/test-qht.c b/tests/test-qht.c
> index 283fb3db39..05b1d6807a 100644
> --- a/tests/test-qht.c
> +++ b/tests/test-qht.c
> @@ -41,7 +41,7 @@ static void insert(int a, int b)
>      }
>  }
>
> -static void rm(int init, int end)
> +static void do_rm(int init, int end, bool exist)
>  {
>      int i;
>
> @@ -49,10 +49,24 @@ static void rm(int init, int end)
>          uint32_t hash;
>
>          hash =3D arr[i];
> -        g_assert_true(qht_remove(&ht, &arr[i], hash));
> +        if (exist) {
> +            g_assert_true(qht_remove(&ht, &arr[i], hash));
> +        } else {
> +            g_assert_false(qht_remove(&ht, &arr[i], hash));
> +        }
>      }
>  }
>
> +static void rm(int init, int end)
> +{
> +    do_rm(init, end, true);
> +}
> +
> +static void rm_nonexist(int init, int end)
> +{
> +    do_rm(init, end, false);
> +}
> +
>  static void check(int a, int b, bool expected)
>  {
>      struct qht_stats stats;
> @@ -157,8 +171,15 @@ static void qht_do_test(unsigned int mode, size_t in=
it_entries)
>      check_n(0);
>
>      qht_init(&ht, is_equal, 0, mode);
> +    rm_nonexist(0, 4);
> +    insert(0, 4);
> +    rm_nonexist(5, 6);
> +    insert(4, 6);
> +    rm_nonexist(7, 8);
> +    iter_rm_mod(1);
>
>      check_n(0);
> +    rm_nonexist(0, 10);
>      insert(0, N);
>      check(0, N, true);
>      check_n(N);
> @@ -183,6 +204,7 @@ static void qht_do_test(unsigned int mode, size_t ini=
t_entries)
>
>      qht_reset(&ht);
>      insert(0, N);
> +    rm_nonexist(N, N + 32);
>      iter_rm_mod(10);
>      iter_rm_mod_check(10);
>      check_n(N * 9 / 10);


--
Alex Benn=C3=A9e
