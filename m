Received: from eggs.gnu.org ([209.51.188.92]:57753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6Xy-0004KF-RA
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6Xx-0000Cv-Jb
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:29:30 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:36772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6Xx-0000C4-5i
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:29:29 -0400
Received: by mail-pg1-x534.google.com with SMTP id 85so5938350pgc.3
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:29:28 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-29-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <604e8d87-44dd-f27e-171d-d3de05b9d183@linaro.org>
Date: Fri, 12 Apr 2019 14:29:22 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-29-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 28/41] s390x/tcg: Implement VECTOR
 ELEMENT ROTATE AND INSERT UNDER MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> +static void gen_rim_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b, int32_t c)
> +{
> +    TCGv_i32 t0 = tcg_temp_new_i32();
> +    TCGv_i32 t1 = tcg_temp_new_i32();
> +
> +    tcg_gen_andc_i32(t0, a, b);
> +    tcg_gen_rotli_i32(t1, a, c & 31);
> +    tcg_gen_and_i32(t1, t1, b);
> +    tcg_gen_or_i32(d, t0, t1);

The ANDC and ROTL look to be in the wrong order.

"For each bit in the third operand (b) that is one,
the corresponding bit *of the rotated elements* in
the second operand replaces the corresponding bit in
the first operand".

I think you need

    tcg_gen_rotli_i32(a, a, c & 31);
    tcg_gen_and_i32(a, a, b);
    tcg_gen_andc_i32(d, d, b);
    tcg_gen_or_i32(d, d, a);

with

  { .fni4 = gen_rim_32, .load_dest = true },

> +     const uint##BITS##_t a = s390_vec_read_element##BITS(v2, i);           \
> +     const uint##BITS##_t mask = s390_vec_read_element##BITS(v3, i);        \
> +     const uint##BITS##_t d = (a & ~mask) | (rotl##BITS(a, count) & mask);  \

Again, this seems to be missing the insert into "the first operand", i.e.
loading from v1 as well.


r~
