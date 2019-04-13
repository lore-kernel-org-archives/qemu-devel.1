Received: from eggs.gnu.org ([209.51.188.92]:46290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBt1-0005FU-3j
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBt0-0007FC-8b
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:11:35 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:38439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFBsz-0007ER-HA
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:11:34 -0400
Received: by mail-pl1-x635.google.com with SMTP id f36so6129093plb.5
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 23:11:33 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-38-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9ecb39e2-99e3-4d48-2582-8962005ed940@linaro.org>
Date: Fri, 12 Apr 2019 20:11:27 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-38-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 37/41] s390x/tcg: Implement VECTOR
 SUBTRACT WITH BORROW COMPUTE BORROW INDICATION
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
> +static DisasJumpType op_vsbcbi(DisasContext *s, DisasOps *o)
> +{
> +    if (get_field(s->fields, m5) != ES_128) {
> +        gen_program_exception(s, PGM_SPECIFICATION);
> +        return DISAS_NORETURN;
> +    }
> +
> +    gen_gvec_4_ool(get_field(s->fields, v1), get_field(s->fields, v2),
> +                   get_field(s->fields, v3), get_field(s->fields, v4), 0,
> +                   gen_helper_gvec_vsbcbi128);
> +    return DISAS_NEXT;
> +}


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I'm sure this can be done similarly to add with carry compute carry, but it's
harder to reason with sub2.  Something like

	tcg_gen_andi_i64(tl, cl, 1);
	tcg_gen_sub2_i64(tl, th, al, zero, tl, zero);
	tcg_gen_sub2_i64(tl, th, tl, th, bl, zero);
	tcg_gen_andi_i64(tl, th, 1);
	tcg_gen_sub2_i64(tl, th, ah, zero, tl, zero);
	tcg_gen_sub2_i64(tl, th, tl, th, bh, zero);
	tcg_gen_andi_i64(tl, th, 1);
	/* result in tl */


r~
