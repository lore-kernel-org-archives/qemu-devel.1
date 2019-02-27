Received: from eggs.gnu.org ([209.51.188.92]:36021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8EC-0004dk-Ii
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8E6-00032C-Fb
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:03:02 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:41790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8E1-0002vh-6Z
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:54 -0500
Received: by mail-pf1-x42d.google.com with SMTP id d25so8718141pfn.8
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:02:50 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-20-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f2a03544-24c2-71f7-41f2-d53b7e6b7909@linaro.org>
Date: Wed, 27 Feb 2019 08:20:32 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-20-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 19/33] s390x/tcg: Implement VECTOR MERGE
 (HIGH|LOW)
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

On 2/26/19 3:39 AM, David Hildenbrand wrote:
> +    for (dst_idx = 0; dst_idx < NUM_VEC_ELEMENTS(es); dst_idx++) {
> +        src_idx = dst_idx / 2;
> +        if (!high) {
> +            src_idx += NUM_VEC_ELEMENTS(es) / 2;
> +        }
> +        if (dst_idx % 2 == 0) {
> +            read_vec_element_i64(tmp, v2, src_idx, es);
> +        } else {
> +            read_vec_element_i64(tmp, v3, src_idx, es);
> +        }
> +        write_vec_element_i64(tmp, dst_v, dst_idx, es);
> +    }

TODO: Note that you do not need a vector temporary here, so long as you load
both source elements before writing, and you iterate in the proper direction.

For VMRL, iterate forward as you do now.  The element access order for MO_32:

 read  v2: 2   3
 read  v3:   2   3
 write v1: 0 1 2 3

For VMRH, iterate backward:

 read  v2: 1   0
 read  v3:   1   0
 write v1: 3 2 1 0


r~
