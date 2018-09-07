Received: from eggs.gnu.org ([2001:4830:134:3::10]:46899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyIVR-0000ZB-DS
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 11:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyIVL-0005E1-C7
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 11:17:07 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:55560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fyIVL-0005Cq-1G
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 11:17:03 -0400
Received: by mail-wm0-x242.google.com with SMTP id f21-v6so15098546wmc.5
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 08:17:02 -0700 (PDT)
References: <20180817232923.28899-1-cota@braap.org>
	<20180817232923.28899-6-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180817232923.28899-6-cota@braap.org>
Date: Fri, 07 Sep 2018 16:17:00 +0100
Message-ID: <87efe5z6ab.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] test-qht: test deletion of the last
 entry in a bucket
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

> This improves coverage by one (!) LoC in qht.c, bringing the
> coverage rate up from 90.00% to 90.28%.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/test-qht.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/tests/test-qht.c b/tests/test-qht.c
> index 05b1d6807a..77666e8c5f 100644
> --- a/tests/test-qht.c
> +++ b/tests/test-qht.c
> @@ -172,9 +172,20 @@ static void qht_do_test(unsigned int mode, size_t in=
it_entries)
>
>      qht_init(&ht, is_equal, 0, mode);
>      rm_nonexist(0, 4);
> +    /*
> +     * Test that we successfully delete the last element in a bucket.
> +     * This is a hard-to-reach code path when resizing is on, but without
> +     * resizing we can easily hit it if init_entries <=3D 1.
> +     * Given that the number of elements per bucket can be 4 or 6 depend=
ing on
> +     * the host's pointer size, test the removal of the 4th and 6th elem=
ents.
> +     */
>      insert(0, 4);
>      rm_nonexist(5, 6);
> -    insert(4, 6);
> +    rm(3, 4);
> +    check_n(3);
> +    insert(3, 6);
> +    rm(5, 6);
> +    check_n(5);
>      rm_nonexist(7, 8);
>      iter_rm_mod(1);


--
Alex Benn=C3=A9e
