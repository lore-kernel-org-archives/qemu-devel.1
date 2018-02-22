Received: from eggs.gnu.org ([2001:4830:134:3::10]:60768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoteh-0004ve-Hs
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoted-0005g8-Oi
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:23:32 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:34687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eoted-0005fC-Ig
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:23:31 -0500
Received: by mail-ot0-x242.google.com with SMTP id n74so4907648ota.1
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 08:23:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180216215608.13227-5-richard.henderson@linaro.org>
References: <20180216215608.13227-1-richard.henderson@linaro.org>
	<20180216215608.13227-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 16:23:10 +0000
Message-ID: <CAFEAcA-7LRypmv9CcOcyGR=1f9eT=_eun1NrD0W4p1NCpNhNiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 4/5] aarch64-linux-user: Add support for
 EXTRA signal frame records
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 February 2018 at 21:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The EXTRA record allows for additional space to be allocated
> beyon what is currently reserved.  Add code to emit and read
> this record type.
>
> Nothing uses extra space yet.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

> @@ -1554,14 +1572,16 @@ static void target_restore_fpsimd_record(CPUARMState *env,
>  static int target_restore_sigframe(CPUARMState *env,
>                                     struct target_rt_sigframe *sf)
>  {
> -    struct target_aarch64_ctx *ctx;
> +    struct target_aarch64_ctx *ctx, *extra = NULL;
>      struct target_fpsimd_context *fpsimd = NULL;
> +    uint64_t extra_datap = 0;
> +    bool used_extra = false;
>
>      target_restore_general_frame(env, sf);
>
>      ctx = (struct target_aarch64_ctx *)sf->uc.tuc_mcontext.__reserved;
>      while (ctx) {
> -        uint32_t magic, size;
> +        uint32_t magic, size, extra_size;
>
>          __get_user(magic, &ctx->magic);
>          __get_user(size, &ctx->size);
> @@ -1570,7 +1590,12 @@ static int target_restore_sigframe(CPUARMState *env,
>              if (size != 0) {
>                  return 1;
>              }
> -            ctx = NULL;
> +            if (used_extra) {
> +                ctx = NULL;
> +            } else {
> +                ctx = extra;
> +                used_extra = true;
> +            }
>              continue;
>
>          case TARGET_FPSIMD_MAGIC:
> @@ -1580,6 +1605,17 @@ static int target_restore_sigframe(CPUARMState *env,
>              fpsimd = (struct target_fpsimd_context *)ctx;
>              break;
>
> +        case TARGET_EXTRA_MAGIC:
> +            if (extra || size != sizeof(struct target_extra_context)) {
> +                return 1;
> +            }
> +            __get_user(extra_datap,
> +                       &((struct target_extra_context *)ctx)->datap);
> +            __get_user(extra_size,
> +                       &((struct target_extra_context *)ctx)->size);
> +            extra = lock_user(VERIFY_READ, extra_datap, extra_size, 0);
> +            break;
> +
>          default:
>              /* Unknown record -- we certainly didn't generate it.
>               * Did we in fact get out of sync?
> @@ -1595,6 +1631,9 @@ static int target_restore_sigframe(CPUARMState *env,
>      }
>      target_restore_fpsimd_record(env, fpsimd);
>
> +    if (extra) {
> +        unlock_user(extra, extra_datap, 0);
> +    }

This will fail to call unlock_user if the function returns early
(eg because of failed magic-number checks or the FPSIMD record
not being present).

You don't need the "if (extra)" check -- unlock_user() is
specified to do nothing if passed a NULL host_ptr.

Otherwise looks good.

thanks
-- PMM
