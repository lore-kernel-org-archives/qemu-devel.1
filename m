Received: from eggs.gnu.org ([2001:4830:134:3::10]:48129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN3fw-0006x1-OX
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 16:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN3fr-0007ll-R6
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 16:53:32 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN3fr-0007lZ-M2
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 16:53:27 -0400
Received: by mail-qk0-x244.google.com with SMTP id r62so8482045qkf.3
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 13:53:25 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170611231633.32582-1-laurent@vivier.eu>
	<20170611231633.32582-6-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a229ea36-7ae8-daee-f446-8670fc3f6e53@twiddle.net>
Date: Mon, 19 Jun 2017 13:53:20 -0700
MIME-Version: 1.0
In-Reply-To: <20170611231633.32582-6-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 5/7] target-m68k: use floatx80 internally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 06/11/2017 04:16 PM, Laurent Vivier wrote:
> +static void gen_load_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp)
> +{
> +    TCGv tmp;
> +    TCGv_i64 t64;
> +    int index = IS_USER(s);
> +
> +    t64 = tcg_temp_new_i64();
> +    tmp = tcg_temp_new();
> +    switch (opsize) {
> +    case OS_BYTE:
> +        tcg_gen_qemu_ld8s(tmp, addr, index);
> +        gen_helper_exts32(cpu_env, fp, tmp);
> +        break;
> +    case OS_WORD:
> +        tcg_gen_qemu_ld16s(tmp, addr, index);
> +        gen_helper_exts32(cpu_env, fp, tmp);
> +        break;
> +    case OS_LONG:
> +        tcg_gen_qemu_ld32u(tmp, addr, index);
> +        gen_helper_exts32(cpu_env, fp, tmp);
> +        break;
> +    case OS_SINGLE:
> +        tcg_gen_qemu_ld32u(tmp, addr, index);
> +        gen_helper_extf32(cpu_env, fp, tmp);
> +        break;
> +    case OS_DOUBLE:
> +        tcg_gen_qemu_ld64(t64, addr, index);
> +        gen_helper_extf64(cpu_env, fp, t64);
> +        tcg_temp_free_i64(t64);
> +        break;
> +    case OS_EXTENDED:
> +        tcg_gen_qemu_ld32u(tmp, addr, index);
> +        tcg_gen_shri_i32(tmp, tmp, 16);
> +        tcg_gen_st16_i32(tmp, fp, offsetof(FPReg, l.upper));
> +        tcg_gen_addi_i32(tmp, addr, 4);
> +        tcg_gen_qemu_ld64(t64, tmp, index);
> +        tcg_gen_st_i64(t64, fp, offsetof(FPReg, l.lower));
> +        break;
> +    case OS_PACKED:
> +        tcg_gen_qemu_ld32u(tmp, addr, index);
> +        tcg_gen_st16_i32(tmp, fp, offsetof(FPReg, l.upper));
> +        tcg_gen_addi_i32(tmp, addr, 4);
> +        tcg_gen_qemu_ld64(t64, tmp, index);
> +        tcg_gen_st_i64(t64, fp, offsetof(FPReg, l.lower));

I don't see how this can be correct.  Doesn't the packed-decimal format use all 
12 bytes (with two unaligned nibbles unused)?

It would also make me happier if we were to adjust the definition of fl0atx80 
to more closely match m68k and those missing zeros.  Shouldn't real hardware 
move instructions propagate those middle 2 bytes regardless of contents?

Perhaps something like

#ifdef TARGET_M68K
   typedef struct {
     uint64_t low;
     union {
       uin32_t high32;
       struct {
#ifdef HOST_WORDS_BIGENDIAN
         uint16_t high, zero;
#else
         uint16_t zero, high;
#endif
       };
     };
   } floatx80;
#else
   ...
#endif

(with a minor fix to make_floatx80 to use named initializers).

Then you can use full 32-bit store insns when copying data here.  Which also 
allows you to drop some of the shifts you're needing to add.

And, in future, when you actually implement the packed decimal, you'll be able 
to use the high32 field to Do the Right Thing.

All of the rest of the patch looks good.


r~
