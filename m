Received: from eggs.gnu.org ([2001:4830:134:3::10]:55556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH8zy-00036D-N2
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH8zy-0006bO-0K
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:58:34 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gH8zx-0006ZD-QP
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:58:33 -0400
Received: by mail-oi1-x243.google.com with SMTP id r127-v6so5594739oie.3
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 07:58:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181024113709.16599-3-richard.henderson@linaro.org>
References: <20181024113709.16599-1-richard.henderson@linaro.org>
	<20181024113709.16599-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 14:58:09 +0000
Message-ID: <CAFEAcA-ft-mktP5fz=fHvWzvJtZN1m86WHWYvXKba0Bv0hqPtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/5] target/arm: Fill in ARMISARegisters
 for kvm64
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

On 24 October 2018 at 12:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/kvm64.c | 63 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 5de8ff0ac5..6ed80eadc2 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -443,17 +443,41 @@ static inline void unset_feature(uint64_t *features, int feature)
>      *features &= ~(1ULL << feature);
>  }
>
> +static int read_sys_reg32(int fd, uint32_t *pret, uint64_t id)
> +{
> +    uint64_t ret;
> +    struct kvm_one_reg idreg = { .id = id, .addr = (uintptr_t)&ret };
> +    int err;
> +
> +    assert((id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U64);
> +    err = ioctl(fd, KVM_GET_ONE_REG, &idreg);
> +    if (err < 0) {
> +        return -1;
> +    }
> +    assert(ret <= UINT32_MAX);

In AArch64, there isn't really any such thing as a 32 bit sysreg.
Where the Arm ARM refers to 32 bit system registers this is just
a shorthand for "64-bit register where the top 32 bits are currently
RES0". This assert() would result in QEMU crashing if we ever ran
it on a host for some hypothetical future architecture which
assigned meanings to some of the high bits. (Granted, this is
unlikely for the specific case of the ID registers which track
the AArch32 ID register values.)

I think I would prefer it if we expanded the id_isar* fields
in the ARMISARegisters struct to uint64_t. If you dislike
that, I think we should make this code fail a bit more gracefully
in the presence of an unexpected extension into the high bits
of these registers. Or just ignore the high bits, since we're
effectively trusting that future architecture versions use
a compatible meaning for these registers anyway.

> +    *pret = ret;
> +    return 0;
> +}
> +
> +static int read_sys_reg64(int fd, uint64_t *pret, uint64_t id)
> +{
> +    struct kvm_one_reg idreg = { .id = id, .addr = (uintptr_t)pret };
> +
> +    assert((id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U64);
> +    return ioctl(fd, KVM_GET_ONE_REG, &idreg);
> +}
>

thanks
-- PMM
