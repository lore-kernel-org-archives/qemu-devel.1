Received: from eggs.gnu.org ([209.51.188.92]:35500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8Co-0003jf-Qw
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8Co-0001z9-0L
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:01:38 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8Cn-0001uW-Lq
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:01:37 -0500
Received: by mail-pg1-x544.google.com with SMTP id l11so8667664pgq.10
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:01:33 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-8-david@redhat.com>
	<28395326-e599-45e0-ebbb-0758fc593284@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <04397ac3-4efb-115c-9d3d-7c9d0581f8ab@linaro.org>
Date: Wed, 27 Feb 2019 07:29:22 -0800
MIME-Version: 1.0
In-Reply-To: <28395326-e599-45e0-ebbb-0758fc593284@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 07/33] s390x/tcg: Implement VECTOR
 GENERATE MASK
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

On 2/26/19 1:16 PM, David Hildenbrand wrote:
>> +    tmp = tcg_temp_new_i64();
>> +    tcg_gen_movi_i64(tmp, mask);
>> +    gen_gvec_dup_i64(es, get_field(s->fields, v1), tmp);
> Richard, shall I better convert this into
> 
> switch (es) {
> case MO_8:
> 	tcg_gen_gvec_dup8i(..., 16, 16, mask)
> 	break;
> case MO_16:
> 	tcg_gen_gvec_dup16i(..., 16, 16, mask)
> 	break;
> ...
> };
> 
> ?

Yes, that would be better.

I see code in tcg/optimizer.c that should have propagated the constant, but
it's better to emit the correct opcode in the first place when it is easy like
this.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org

r~
