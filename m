Received: from eggs.gnu.org ([2001:4830:134:3::10]:46467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyITf-00081Y-Az
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 11:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyITb-0003Wp-BE
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 11:15:19 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:34184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fyITX-0003Sx-Qq
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 11:15:13 -0400
Received: by mail-wm0-x22c.google.com with SMTP id j25-v6so19425652wmc.1
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 08:15:11 -0700 (PDT)
References: <20180817232923.28899-1-cota@braap.org>
	<20180817232923.28899-4-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180817232923.28899-4-cota@braap.org>
Date: Fri, 07 Sep 2018 16:15:08 +0100
Message-ID: <87h8j1z6df.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] test-qht: test qht_iter_remove
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

> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/test-qht.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)
>
> diff --git a/tests/test-qht.c b/tests/test-qht.c
> index dda6a067be..283fb3db39 100644
> --- a/tests/test-qht.c
> +++ b/tests/test-qht.c
> @@ -108,6 +108,49 @@ static void iter_check(unsigned int count)
>      g_assert_cmpuint(curr, =3D=3D, count);
>  }
>
> +static void sum_func(struct qht *ht, void *p, uint32_t hash, void *userp)
> +{
> +    uint32_t *sum =3D userp;
> +    uint32_t a =3D *(uint32_t *)p;
> +
> +    *sum +=3D a;
> +}
> +
> +static void iter_sum_check(unsigned int expected)
> +{
> +    unsigned int sum =3D 0;
> +
> +    qht_iter(&ht, sum_func, &sum);
> +    g_assert_cmpuint(sum, =3D=3D, expected);
> +}
> +
> +static bool rm_mod_func(struct qht *ht, void *p, uint32_t hash, void *us=
erp)
> +{
> +    uint32_t a =3D *(uint32_t *)p;
> +    unsigned int mod =3D *(unsigned int *)userp;
> +
> +    return a % mod =3D=3D 0;
> +}
> +
> +static void iter_rm_mod(unsigned int mod)
> +{
> +    qht_iter_remove(&ht, rm_mod_func, &mod);
> +}
> +
> +static void iter_rm_mod_check(unsigned int mod)
> +{
> +    unsigned int expected =3D 0;
> +    unsigned int i;
> +
> +    for (i =3D 0; i < N; i++) {
> +        if (i % mod =3D=3D 0) {
> +            continue;
> +        }
> +        expected +=3D i;
> +    }
> +    iter_sum_check(expected);
> +}
> +
>  static void qht_do_test(unsigned int mode, size_t init_entries)
>  {
>      /* under KVM we might fetch stats from an uninitialized qht */
> @@ -138,8 +181,11 @@ static void qht_do_test(unsigned int mode, size_t in=
it_entries)
>      insert(10, 150);
>      check_n(N);
>
> -    rm(1, 2);
> -    check_n(N - 1);
> +    qht_reset(&ht);
> +    insert(0, N);
> +    iter_rm_mod(10);
> +    iter_rm_mod_check(10);
> +    check_n(N * 9 / 10);
>      qht_reset_size(&ht, 0);
>      check_n(0);
>      check(0, N, false);


--
Alex Benn=C3=A9e
