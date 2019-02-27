Received: from eggs.gnu.org ([209.51.188.92]:43578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8u9-0007Cy-PH
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:46:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8u7-0002Tj-Up
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:46:25 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:32781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8u7-0002NC-BE
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:46:23 -0500
Received: by mail-pf1-x42a.google.com with SMTP id i19so8782994pfd.0
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:46:20 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-30-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3c7484d3-4bea-61f7-eee9-234e0750bba9@linaro.org>
Date: Wed, 27 Feb 2019 15:46:15 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-30-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 29/33] s390x/tcg: Implement VECTOR STORE
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
> +static DisasJumpType op_vst(DisasContext *s, DisasOps *o)
> +{
> +    /*
> +     * FIXME: On exceptions we must not modify any memory.
> +     */
> +    store_vec_element(s, get_field(s->fields, v1), 0, o->addr1, MO_64);
> +    gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
> +    store_vec_element(s, get_field(s->fields, v1), 1, o->addr1, MO_64);
> +    return DISAS_NEXT;

Should handle alignment though.

FWIW, there is a probe_write function that can be called to make sure a region
is writable before actually accessing it.  But this is common enough that we
should probably just handle 16-byte quantities as a native tcg type.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
