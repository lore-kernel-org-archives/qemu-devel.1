Received: from eggs.gnu.org ([209.51.188.92]:33978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6wk-0002vS-7E
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6wj-0004xN-9E
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:55:06 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:35901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6wi-0004uj-DL
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:55:05 -0400
Received: by mail-pf1-x42f.google.com with SMTP id z5so5908763pfn.3
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:55:04 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-32-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6594280f-cefb-cfb0-35b4-fcf53c32d871@linaro.org>
Date: Fri, 12 Apr 2019 14:54:57 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-32-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 31/41] s390x/tcg: Implement VECTOR SHIFT
 LEFT DOUBLE BY BYTE
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
> +static DisasJumpType op_vsldb(DisasContext *s, DisasOps *o)
> +{
> +    int src_idx = get_field(s->fields, i4) & 0xf;
> +
> +    if (src_idx == 0) {
> +        gen_gvec_mov(get_field(s->fields, v1), get_field(s->fields, v2));
> +    } else {
> +        gen_gvec_3_ool(get_field(s->fields, v1), get_field(s->fields, v2),
> +                       get_field(s->fields, v3), src_idx,
> +                       gen_helper_gvec_vsldb);
> +        return DISAS_NEXT;

You could also expand this inline using your new extract2 primitive.

  int i4 = get_field(s->fields, i4);
  int left_shift, right_shift;

  left_shift = (i4 & 7) * 8;
  right_shift = 64 - left_shift;

  if ((i4 & 8) == 0) {
      read_vec_element_i64(t0, get_field(s->fields, v2), 0, ES_64);
      read_vec_element_i64(t1, get_field(s->fields, v2), 1, ES_64);
      read_vec_element_i64(t2, get_field(s->fields, v3), 0, ES_64);
  } else {
      read_vec_element_i64(t0, get_field(s->fields, v2), 1, ES_64);
      read_vec_element_i64(t1, get_field(s->fields, v3), 0, ES_64);
      read_vec_element_i64(t2, get_field(s->fields, v3), 1, ES_64);
  }
  tcg_gen_extract2_i64(t0, t1, t0, right_shift);
  tcg_gen_extract2_i64(t1, t2, t1, right_shift);
  write_vec_element_i64(t0, get_field(s->fields, v1), 0, ES_64);
  write_vec_element_i64(t1, get_field(s->fields, v1), 1, ES_64);


r~
