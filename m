Received: from eggs.gnu.org ([2001:4830:134:3::10]:55509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyImq-0000LG-Sq
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 11:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyIml-0005bd-OU
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 11:35:08 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:41314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fyImk-0005A8-ES
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 11:35:03 -0400
Received: by mail-wr1-x435.google.com with SMTP id z96-v6so15392548wrb.8
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 08:34:57 -0700 (PDT)
References: <20180817232923.28899-1-cota@braap.org>
	<20180817232923.28899-7-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180817232923.28899-7-cota@braap.org>
Date: Fri, 07 Sep 2018 16:34:55 +0100
Message-ID: <87d0tpz5gg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] test-qht: speed up + test qht_resize
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

> Perform first the tests that exercise code paths that are
> easier to hit at small table sizes, and then resize the table
> to speed up subsequent tests. If this resize is not too large,
> we can make the test faster with no code coverage loss.
>
> - With gcov enabled:
>
> Before: 20.568s, 90.28% qht.c coverage
> After:   5.168s, 93.06% qht.c coverage
>
> The coverage increase is entirely due to calling qht_resize,
> which we weren't calling before. Note that the code paths
> that remain to be tested are either error handling or
> can only occur when several threads are accessing the
> hash table concurrently (e.g. seqlock retry, trylock fail).
>
> - Without gcov:
>
> Before: 1.987s
> After:  0.528s
>
> The speedup is almost the same as with gcov, although the
> "before" run is a lot faster.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/test-qht.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tests/test-qht.c b/tests/test-qht.c
> index 77666e8c5f..1ec039d636 100644
> --- a/tests/test-qht.c
> +++ b/tests/test-qht.c
> @@ -189,6 +189,10 @@ static void qht_do_test(unsigned int mode, size_t in=
it_entries)
>      rm_nonexist(7, 8);
>      iter_rm_mod(1);
>
> +    if (!(mode & QHT_MODE_AUTO_RESIZE)) {
> +        qht_resize(&ht, init_entries * 4 + 4);
> +    }
> +
>      check_n(0);
>      rm_nonexist(0, 10);
>      insert(0, N);


--
Alex Benn=C3=A9e
