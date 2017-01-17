Received: from eggs.gnu.org ([2001:4830:134:3::10]:55061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTbjb-0004ES-N0
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 16:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTbjY-0001I0-Mt
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 16:56:07 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cTbjY-0001Hb-FH
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 16:56:04 -0500
Received: by mail-pf0-x241.google.com with SMTP id 19so6240836pfo.3
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 13:56:04 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
	<1484644078-21312-8-git-send-email-batuzovk@ispras.ru>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7e0cf16b-3da2-d072-d693-b40f4a35c4cc@twiddle.net>
Date: Tue, 17 Jan 2017 13:56:01 -0800
MIME-Version: 1.0
In-Reply-To: <1484644078-21312-8-git-send-email-batuzovk@ispras.ru>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/18] tcg: add vector addition operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>

On 01/17/2017 01:07 AM, Kirill Batuzov wrote:
> +/***************************************/
> +/* 64-bit and 128-bit vector arithmetic.          */
> +
> +static inline void *tcg_v128_swap_slot(int n)
> +{
> +    return &tcg_ctx.v128_swap[n * 16];
> +}
> +
> +/* Find a memory location for 128-bit TCG variable. */
> +static inline void tcg_v128_to_ptr(TCGv_v128 tmp, TCGv_ptr base, int slot,
> +                                   TCGv_ptr *real_base, intptr_t *real_offset,
> +                                   int is_read)

None of this needs to be inline in tcg-op.h.  All of it should be out-of-line 
in tcg-op.c.


> @@ -750,6 +778,7 @@ struct TCGContext {
>      void *code_gen_buffer;
>      size_t code_gen_buffer_size;
>      void *code_gen_ptr;
> +    uint8_t v128_swap[16 * 3];

This is not thread-safe.
Shouldn't use space in TCGContext; should use space on stack.

Since there is no function call that is live, you can re-use the space for 
on-stack arguments.  There is TCG_STATIC_CALL_ARGS_SIZE (128) bytes allocated 
for that.  Which should be more than enough.


r~
