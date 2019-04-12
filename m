Received: from eggs.gnu.org ([209.51.188.92]:43363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5BK-0002Hz-Se
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5BI-00014W-TC
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:02:02 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5BH-00013D-05
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:01:59 -0400
Received: by mail-pl1-x644.google.com with SMTP id y6so5817795plt.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:01:57 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-10-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <71ce854d-da00-565e-0b36-9458a7bc9183@linaro.org>
Date: Fri, 12 Apr 2019 13:01:51 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-10-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 09/41] s390x/tcg: Implement VECTOR
 CHECKSUM
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
> +    read_vec_element_i32(sum, get_field(s->fields, v3), 1, ES_32);
> +    for (i = 0; i < 4; i++) {
> +        read_vec_element_i32(tmp, get_field(s->fields, v2), i, ES_32);
> +        tcg_gen_add_i32(sum, sum, tmp);
> +        tcg_gen_setcond_i32(TCG_COND_LTU, tmp, sum, tmp);
> +        tcg_gen_add_i32(sum, sum, tmp);
> +    }
> +    zero_vec(get_field(s->fields, v1));
> +    write_vec_element_i32(sum, get_field(s->fields, v1), 1, ES_32);

It seems like it should be possible to implement this with i64, and fold the
carry around at the end -- 2 insns instead of 12 for managing carry.  But I
can't quite tell if that produces the same results.

You could use

  tcg_gen_add2_i32(sum, tmp, sum, zero, tmp, zero);
  tcg_gen_add_i32(sum, sum, tmp);

instead of computing carry manually with setcond.

That said, your code exactly matches the language in the manual, so

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
