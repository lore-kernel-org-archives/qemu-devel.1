Received: from eggs.gnu.org ([209.51.188.92]:35702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8DQ-00044E-Sk
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8DP-0002Sc-Rw
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:16 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:39452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8DP-0002Qb-Ex
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:15 -0500
Received: by mail-pg1-x52f.google.com with SMTP id h8so8171689pgp.6
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:02:14 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-16-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <80bed043-7fa2-bce0-327f-d298d6799b75@linaro.org>
Date: Wed, 27 Feb 2019 08:08:16 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-16-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 15/33] s390x/tcg: Implement VECTOR LOAD
 TO BLOCK BOUNDARY
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
> +void HELPER(vll)(CPUS390XState *env, void *v1, uint64_t addr, uint64_t bytes)
> +{
> +    S390Vector tmp = {};
> +    int i;
> +
> +    bytes = MIN(bytes, 16);
> +    for (i = 0; i < bytes; i++) {
> +        uint8_t byte = cpu_ldub_data_ra(env, addr, GETPC());
> +
> +        s390_vec_write_element8(&tmp, i, byte);
> +        addr = wrap_address(env, addr + 1);
> +    }

TODO:

    if (likely(bytes >= 16)) {
        uint64_t t0 = cpu_ldq_data_ra(env, addr, GETPC());
        uint64_t t1 = cpu_ldq_data_ra(env, addr, GETPC());
        s390_vec_write_element64(v1, 0, t0);
        s390_vec_write_element64(v1, 1, t1);
    } else {
        // byte loop
    }

But what you have is correct, so
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
