Received: from eggs.gnu.org ([209.51.188.92]:50825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMd42-0003VT-5Q
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMd3y-000660-FH
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:37:41 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMd3x-00061z-EL
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:37:38 -0400
Received: by mail-pg1-x544.google.com with SMTP id i21so3098572pgi.12
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 11:37:34 -0700 (PDT)
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-5-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fc9eb698-c408-86eb-2c8e-7a2b7e9f7e97@linaro.org>
Date: Fri, 3 May 2019 11:37:30 -0700
MIME-Version: 1.0
In-Reply-To: <20190502143409.59600-5-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v8 04/12] target/rx: RX disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 5/2/19 7:34 AM, Yoshinori Sato wrote:
> +static int32_t li(DisasContext *ctx, int sz)
> +{
> +    int32_t addr;
> +    bfd_byte buf[4];
> +    addr = ctx->addr;
> +
> +    switch (sz) {
> +    case 1:
> +        ctx->addr += 1;
> +        ctx->dis->read_memory_func(addr, buf, 1, ctx->dis);
> +        return buf[0];
> +    case 2:
> +        ctx->addr += 2;
> +        ctx->dis->read_memory_func(addr, buf, 2, ctx->dis);
> +        return buf[1] << 8 | buf[0];
> +    case 3:
> +        ctx->addr += 3;
> +        ctx->dis->read_memory_func(addr, buf, 3, ctx->dis);
> +        return buf[2] << 16 | buf[1] << 8 | buf[0];
> +    case 0:
> +        ctx->addr += 4;
> +        ctx->dis->read_memory_func(addr, buf, 4, ctx->dis);
> +        return buf[3] << 24 | buf[2] << 16 | buf[1] << 8 | buf[0];
> +    default:
> +        g_assert_not_reached();
> +    }
> +}

These should be computing signed values.  This is already correct over in
translate.c.  Also, we can make use of some endian-specific unaligned load
functions from <qemu/bswap.h>.  So for the 4 cases:

  return (int8_t)buf[0];

  return ldsw_le_p(buf);

  return (int8_t)buf[2] << 16 | buf[1] << 8 | buf[0];

  return ldl_le_p(buf);


r~
