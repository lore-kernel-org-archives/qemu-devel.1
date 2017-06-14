Received: from eggs.gnu.org ([2001:4830:134:3::10]:45457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLDhW-0002ik-S0
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLDhW-00064b-21
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:11:34 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dLDhV-00064T-Rc
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:11:33 -0400
Received: by mail-wr0-x231.google.com with SMTP id r103so11460766wrb.0
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 12:11:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <871sqmo3xb.fsf@linaro.org>
References: <20170614140209.29847-1-alex.bennee@linaro.org>
	<20170614140209.29847-4-alex.bennee@linaro.org>
	<09a35585-d876-6c9e-7045-8cda418455e0@twiddle.net>
	<a1a0b43c-b074-a1a4-dc26-717964121b1a@redhat.com>
	<871sqmo3xb.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Jun 2017 20:11:12 +0100
Message-ID: <CAFEAcA-02MVgmdMaDMfhU55J9B7ER1gT6TmyNsZE+bc3wTW45w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 3/3] tcg-runtime: short-circuit
 lookup_tb_ptr on IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>

On 14 June 2017 at 18:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index 2a85666579..7e67bb3db2 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -835,6 +835,9 @@ void HELPER(msr_i_pstate)(CPUARMState *env, uint32_t =
op, uint32_t imm)
>          break;
>      case 0x1f: /* DAIFClear */
>          env->daif &=3D ~((imm << 6) & PSTATE_DAIF);
> +        /* This may result in pending IRQs being unmasked so ensure we
> +           exit the loop */
> +        cpu_exit(ENV_GET_CPU(env));
>          break;
>      default:
>          g_assert_not_reached();

The 'op' field we're switching on here is just a constant
from the instruction encoding, so I'd rather see us
identify that in translate-a64.c and end the TB or
whatever when we need to, rather than doing the
longjump-out-of-here that cpu_exit() does at runtime.

thanks
-- PMM
