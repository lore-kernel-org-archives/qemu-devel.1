Received: from eggs.gnu.org ([209.51.188.92]:47453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ15Z-00011M-2h
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ15X-000298-Ut
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:28:20 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ15W-00026J-Tj
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:28:19 -0400
Received: by mail-pl1-x641.google.com with SMTP id w24so8013022plp.2
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 12:28:15 -0700 (PDT)
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-13-richard.henderson@linaro.org>
	<ab0269a3-c0fd-44c4-f939-e3f073e8e2dd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a32e78bf-e4e4-a808-0c42-95e3b64ed1cf@linaro.org>
Date: Tue, 23 Apr 2019 12:28:11 -0700
MIME-Version: 1.0
In-Reply-To: <ab0269a3-c0fd-44c4-f939-e3f073e8e2dd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/38] tcg: Add gvec expanders for variable
 shift
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org

On 4/23/19 12:04 PM, David Hildenbrand wrote:
> In order to use this on s390x for VECTOR ELEMENT SHIFT, like
> 
> +static DisasJumpType op_vesv(DisasContext *s, DisasOps *o)
> +{
> +    const uint8_t es = get_field(s->fields, m4);
> +    const uint8_t v1 = get_field(s->fields, v1);
> +    const uint8_t v2 = get_field(s->fields, v2);
> +    const uint8_t v3 = get_field(s->fields, v3);
> +
> +    if (es > ES_64) {
> +        gen_program_exception(s, PGM_SPECIFICATION);
> +        return DISAS_NORETURN;
> +    }
> +
> +    switch (s->fields->op2) {
> +    case 0x70:
> +        gen_gvec_fn_3(shlv, es, v1, v2, v3);
> +        break;
> +    case 0x7a:
> +        gen_gvec_fn_3(sarv, es, v1, v2, v3);
> +        break;
> +    case 0x78:
> +        gen_gvec_fn_3(shrv, es, v1, v2, v3);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    return DISAS_NEXT;
> +}
> 
> We need to mask of invalid bits from the shift. Can that be added?

Yes, I do exactly this in patch 31 for target/ppc.


r~
