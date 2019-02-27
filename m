Received: from eggs.gnu.org ([209.51.188.92]:35558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8Cy-0003nm-5P
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8Cw-00026D-6w
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:01:48 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:43634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8Cu-00024S-CC
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:01:44 -0500
Received: by mail-pf1-x432.google.com with SMTP id q17so8709360pfh.10
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:01:44 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-9-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <23a43b55-4902-0440-8243-62aaff19c83a@linaro.org>
Date: Wed, 27 Feb 2019 07:39:47 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-9-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 08/33] s390x/tcg: Implement VECTOR LOAD
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

On 2/26/19 3:38 AM, David Hildenbrand wrote:
> +static DisasJumpType op_vl(DisasContext *s, DisasOps *o)
> +{
> +    load_vec_element(s, TMP_VREG_0, 0, o->addr1, MO_64);
> +    gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
> +    load_vec_element(s, TMP_VREG_0, 1, o->addr1, MO_64);
> +    gen_gvec_mov(get_field(s->fields, v1), TMP_VREG_0);
> +    return DISAS_NEXT;
> +}

Isn't it just as easy to load two TCGv_i64 temps and store into the correct
vector afterward?

Also, it is easy to honor the required alignment:

    TCGMemOp mop1, mop2;

    if (m3 < 3) {
        mop1 = mop2 = MO_TEQ;
    } else if (m3 == 3) {
        mop1 = mop2 = MO_TEQ | MO_ALIGN;
    } else {
        mop1 = MO_TEQ | MO_ALIGN_16;
        mop2 = MO_TEQ | MO_ALIGN;
    }
    tcg_gen_qemu_ld_i64(tmp1, o->addr1, mem_idx, mop1);
    gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
    tcg_gen_qemu_ld_i64(tmp2, o->addr1, mem_idx, mop2);
    write_vec_element_i64(tmp1, v1, 0, MO_64);
    write_vec_element_i64(tmp2, v1, 1, MO_64);


r~
