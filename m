Received: from eggs.gnu.org ([2001:4830:134:3::10]:49749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fmhNO-0006Kj-19
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 11:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fmhNK-0005Ml-RD
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 11:24:54 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fmhNK-0005MS-KL
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 11:24:50 -0400
Received: by mail-oi0-x241.google.com with SMTP id s198-v6so22841155oih.11
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 08:24:50 -0700 (PDT)
References: <20180805182832.3012-1-pavel.zbitskiy@gmail.com>
	<20180805182832.3012-4-pavel.zbitskiy@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <15c06ae1-5262-85fe-df70-afd570f7efa7@linaro.org>
Date: Mon, 6 Aug 2018 08:24:44 -0700
MIME-Version: 1.0
In-Reply-To: <20180805182832.3012-4-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] target/s390x: fix ipm polluting
 irrelevant bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-trivial@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, "open list:S390" <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 08/05/2018 11:28 AM, Pavel Zbitskiy wrote:
> +    tcg_gen_andi_i64(t1, psw_mask, 0x00000f0000000000);
> +    tcg_gen_shri_i64(t1, t1, 16);

It would be better to swap these two operations, so that a 64-bit constant
isn't needed for the mask, e.g:

    tcg_gen_shri_i64(t1, psw_mask, 16);
    tcg_gen_andi_i64(t1, t1, 0xf000000);

Or maybe rewrite this whole function with extract/deposit:

    tcg_gen_extract_i64(t1, psw_mask, 40, 4);
    tcg_gen_extu_i32_i64(t2, cc_op);
    tcg_gen_deposit_i64(t1, t1, t2, 4, 60);
    tcg_gen_deposit_i64(o->out, o->out, t1, 24, 8);

But what you have is not wrong so,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
