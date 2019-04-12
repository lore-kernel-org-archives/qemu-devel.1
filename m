Received: from eggs.gnu.org ([209.51.188.92]:51591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF3OK-00017K-R7
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF3OI-0005UV-U4
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:07:20 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF3OI-0005Tb-7V
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:07:18 -0400
Received: by mail-pf1-x442.google.com with SMTP id b3so5721606pfd.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 14:07:16 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <50db1745-397d-03e0-626a-12d1b2a2a554@linaro.org>
Date: Fri, 12 Apr 2019 11:05:42 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 03/41] s390x/tcg: Implement VECTOR ADD
 COMPUTE CARRY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>

On 4/11/19 12:07 AM, David Hildenbrand wrote:
> +    static const GVecGen3 g[5] = {
> +        { .fni8 = gen_acc8_i64, },
> +        { .fni8 = gen_acc16_i64, },
> +        { .fni8 = gen_acc32_i64, },
> +        { .fni8 = gen_acc_i64, },
> +        { .fno = gen_helper_gvec_vacc128, },
> +    };

Vector versions of the first four are fairly simple too.

static void gen_acc_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
{
    tcgv_vec t = tcg_temp_new_vec_matching(d);

    tcg_gen_add_vec(vece, t, a, b);
    tcg_gen_cmp_vec(TCG_COND_LTU, vece, d, r, a);  /* produces -1 for carry */
    tcg_gen_neg_vec(vece, d, d);                 /* convert to +1 for carry */
}

  { .fni8 = gen_acc8_i64,
    .fniv = gen_acc_vec,
    .opc = INDEX_op_cmp_vec,
    .vece = MO_8 },
  ...


I'm surprised that you're expanding the 128-bit addition out-of-line.
One possible expansion is

  tcg_gen_add2_i64(tl, th, al, zero, bl, zero);
  tcg_gen_add2_i64(tl, th, th, zero, ah, zero);
  tcg_gen_add2_i64(tl, th, tl, th, bl, zero);
  /* carry out in th */


r~
