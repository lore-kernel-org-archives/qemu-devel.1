Received: from eggs.gnu.org ([2001:4830:134:3::10]:33405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTsw5-0006Ro-5N
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTsw2-0003WA-5R
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:54:57 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:42536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTsw1-0003W2-So
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:54:54 -0400
Received: by mail-pf0-x242.google.com with SMTP id w7-v6so5206807pfn.9
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 10:54:53 -0700 (PDT)
References: <20180614193147.29680-1-richard.henderson@linaro.org>
	<CAFEAcA-n9U90h8j_-cu0Y+vxnM0mJra0Ldw880t33G122jdCiQ@mail.gmail.com>
	<20180615140103.GB9752@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ea888b0f-c095-afe9-23a2-8c58484a557f@linaro.org>
Date: Fri, 15 Jun 2018 07:54:47 -1000
MIME-Version: 1.0
In-Reply-To: <20180615140103.GB9752@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/18] tcg queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/15/2018 04:01 AM, Emilio G. Cota wrote:
> On Fri, Jun 15, 2018 at 11:41:28 +0100, Peter Maydell wrote:
>> Hi; I get compile failures with clang I'm afraid
>> (seen on x86-64 Linux, OSX and FreeBSD):
>>
>> /home/petmay01/linaro/qemu-for-merges/accel/tcg/translate-all.c:1800:44:
>> error: incompatible integer to pointer conversion passing 'uintptr_t'
>> (aka 'unsigned long') to parameter of type 'void *'
>> [-Werror,-Wint-conversion]
>>         atomic_set(&tcg_ctx->code_gen_ptr, orig_aligned);
> 
> Fixed with:
> 
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1797,7 +1797,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>          uintptr_t orig_aligned = (uintptr_t)gen_code_buf;
>  
>          orig_aligned -= ROUND_UP(sizeof(*tb), qemu_icache_linesize);
> -        atomic_set(&tcg_ctx->code_gen_ptr, orig_aligned);
> +        atomic_set(&tcg_ctx->code_gen_ptr, (void *)orig_aligned);
>          return existing_tb;
>      }
>      tcg_tb_insert(tb);
> 
> This applies to patch 14/18 ("translate-all: discard TB when
> tb_link_page returns an existing matching TB") of the pull request.
> 
> The rest compiles OK for me on clang 7.0.0.
> 
> Richard: can you fold this fixup into patch 14?

Will do.


r~
