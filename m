Received: from eggs.gnu.org ([2001:4830:134:3::10]:43633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFNj4-0005sU-O1
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFNj0-0008CW-MS
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:08:46 -0500
Received: from mail-wj0-f169.google.com ([209.85.210.169]:35787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cFNj0-0008CM-G6
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:08:42 -0500
Received: by mail-wj0-f169.google.com with SMTP id v7so18320767wjy.2
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 08:08:42 -0800 (PST)
References: <1479906121-12211-1-git-send-email-rth@twiddle.net>
	<1479906121-12211-63-git-send-email-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1479906121-12211-63-git-send-email-rth@twiddle.net>
Date: Fri, 09 Dec 2016 16:07:39 +0000
Message-ID: <87r35hxf04.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 62/64] tcg: Use ctpop to generate ctz if
 needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> Particularly when andc is also available, this is two insns
> shorter than using clz to compute ctz.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  tcg/tcg-op.c | 107 ++++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 65 insertions(+), 42 deletions(-)
>
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 6f4b1b6..d1debde 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -497,43 +497,46 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
<snip>
>      } else {
> -        gen_helper_ctz_i32(ret, arg1, arg2);
> +        TCGv_i32 z, t;
> +        if (TCG_TARGET_HAS_ctpop_i32 && TCG_TARGET_HAS_andc_i32) {
> +            t = tcg_temp_new_i32();
> +            tcg_gen_subi_i32(t, arg1, 1);
> +            tcg_gen_andc_i32(t, t, arg1);
> +            tcg_gen_ctpop_i32(t, t);
> +        do_movc:

Hmmm and...

<snip>
>  void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
> @@ -1842,18 +1845,29 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
>  {
>      if (TCG_TARGET_HAS_ctz_i64) {
>          tcg_gen_op3_i64(INDEX_op_ctz_i64, ret, arg1, arg2);
<snip>
>      } else {
> -        gen_helper_ctz_i64(ret, arg1, arg2);
> +        TCGv_i64 z, t;
> +        if (TCG_TARGET_HAS_ctpop_i64 && TCG_TARGET_HAS_andc_i64) {
> +            t = tcg_temp_new_i64();
> +            tcg_gen_subi_i64(t, arg1, 1);
> +            tcg_gen_andc_i64(t, t, arg1);
> +            tcg_gen_ctpop_i64(t, t);
> +        do_movc:

Hmmm.

So I'm not a goto hater as it makes sense for a bunch of things. But
this seems just a little too liberal usage to my eyes. What's wrong with
a little extra nesting (seeing the compiler sorts it all out in the
end):

        if ((TCG_TARGET_HAS_ctpop_i32 && TCG_TARGET_HAS_andc_i32)
            || TCG_TARGET_HAS_clz_i32 || TCG_TARGET_HAS_clz_i64) {

            TCGv_i32 z, t;

            if (TCG_TARGET_HAS_ctpop_i32 && TCG_TARGET_HAS_andc_i32) {
                t = tcg_temp_new_i32();
                tcg_gen_subi_i32(t, arg1, 1);
                tcg_gen_andc_i32(t, t, arg1);
                tcg_gen_ctpop_i32(t, t);
            } else if (TCG_TARGET_HAS_clz_i32 || TCG_TARGET_HAS_clz_i64) {
                /* Since all non-x86 hosts have clz(0) == 32, don't fight it.  */
                t = tcg_temp_new_i32();
                tcg_gen_neg_i32(t, arg1);
                tcg_gen_and_i32(t, t, arg1);
                tcg_gen_clzi_i32(t, t, 32);
                tcg_gen_xori_i32(t, t, 31);
            }
            /* final movc */
            z = tcg_const_i32(0);
            tcg_gen_movcond_i32(TCG_COND_EQ, ret, arg1, z, arg2, t);
            tcg_temp_free_i32(t);
            tcg_temp_free_i32(z);
        } else {
            gen_helper_ctz_i32(ret, arg1, arg2);
        }

--
Alex Bennée
