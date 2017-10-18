Received: from eggs.gnu.org ([2001:4830:134:3::10]:43812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4syH-0007Cu-4l
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 14:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4syD-0000eI-36
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 14:21:37 -0400
References: <20171016202358.3633-1-david@redhat.com>
	<20171016202358.3633-3-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8dd3c355-7d91-e1bb-b7d6-4d3e3e213da3@redhat.com>
Date: Wed, 18 Oct 2017 20:21:22 +0200
MIME-Version: 1.0
In-Reply-To: <20171016202358.3633-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/2] s390x/tcg: low-address protection
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, cohuck@redhat.com, Peter Maydell <peter.maydell@linaro.org>

On 16.10.2017 22:23, David Hildenbrand wrote:
> This is a neat way to implement low address protection, whereby
> only the first 512 bytes of the first two pages (each 4096 bytes) of
> every address space are protected.
>=20
> Store a tec of 0 for the access exception, this is what is defined by
> Enhanced Suppression on Protection in case of a low address protection
> (Bit 61 set to 0, rest undefined).
>=20
> We have to make sure to to pass the access address, not the masked page
> address into mmu_translate*().
>=20
> Drop the check from testblock. So we can properly test this via
> kvm-unit-tests.
>=20
> This will check every access going through one of the MMUs.
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/excp_helper.c |  3 +-
>  target/s390x/mem_helper.c  |  8 ----
>  target/s390x/mmu_helper.c  | 94 +++++++++++++++++++++++++++++---------=
--------
>  3 files changed, 60 insertions(+), 45 deletions(-)
[...]
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index 9daa0fd8e2..9806685bee 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -106,6 +106,35 @@ static void trigger_page_fault(CPUS390XState *env,=
 target_ulong vaddr,
>      trigger_access_exception(env, type, ilen, tec);
>  }
> =20
> +/* check whether the address would be proteted by Low-Address Protecti=
on */
> +static bool is_low_address(uint64_t addr)
> +{
> +    return addr < 512 || (addr >=3D 4096 && addr <=3D 4607);
> +}

Just cosmetic, but I'd rather either use "<=3D" or "<" both times, so:

   return addr <=3D 511 || (addr >=3D 4096 && addr <=3D 4607);

or:

   return addr < 512 || (addr >=3D 4096 && addr < 4608);

> +/* check whether Low-Address Protection is enabled for mmu_translate()=
 */
> +static bool lowprot_enabled(const CPUS390XState *env, uint64_t asc)
> +{
> +    if (!(env->cregs[0] & CR0_LOWPROT)) {
> +        return false;
> +    }
> +    if (!(env->psw.mask & PSW_MASK_DAT)) {
> +        return true;
> +    }
> +
> +    /* Check the private-space control bit */
> +    switch (asc) {
> +    case PSW_ASC_PRIMARY:
> +        return !(env->cregs[1] & _ASCE_PRIVATE_SPACE);
> +    case PSW_ASC_SECONDARY:
> +        return !(env->cregs[7] & _ASCE_PRIVATE_SPACE);
> +    case PSW_ASC_HOME:
> +        return !(env->cregs[13] & _ASCE_PRIVATE_SPACE);
> +    default:
> +        g_assert_not_reached();

Well, this is certainly reachable - if the guest was running in access
register mode. So it might be nicer to the user if you keep the
error_report() here?

> +    }
> +}
> +
>  /**
>   * Translate real address to absolute (=3D physical)
>   * address by taking care of the prefix mapping.
> @@ -323,6 +352,24 @@ int mmu_translate(CPUS390XState *env, target_ulong=
 vaddr, int rw, uint64_t asc,
>      }
> =20
>      *flags =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +    if (is_low_address(vaddr & TARGET_PAGE_MASK) && lowprot_enabled(en=
v, asc)) {
> +        /*
> +         * If any part of this page is currently protected, make sure =
the
> +         * TLB entry will not be reused.
> +         *
> +         * As the protected range is always the first 512 bytes of the
> +         * two first pages, we are able to catch all writes to these a=
reas
> +         * just by looking at the start address (triggering the tlb mi=
ss).
> +         */
> +        *flags |=3D PAGE_WRITE_INV;
> +        if (is_low_address(vaddr) && rw =3D=3D MMU_DATA_STORE) {
> +            if (exc) {
> +                trigger_access_exception(env, PGM_PROTECTION, ILEN_AUT=
O, 0);
> +            }
> +            return -EACCES;
> +        }
> +    }
> +
>      vaddr &=3D TARGET_PAGE_MASK;
> =20
>      if (!(env->psw.mask & PSW_MASK_DAT)) {
> @@ -392,50 +439,17 @@ int mmu_translate(CPUS390XState *env, target_ulon=
g vaddr, int rw, uint64_t asc,
>  }
> =20
>  /**
> - * lowprot_enabled: Check whether low-address protection is enabled
> - */
> -static bool lowprot_enabled(const CPUS390XState *env)
> -{
> -    if (!(env->cregs[0] & CR0_LOWPROT)) {
> -        return false;
> -    }
> -    if (!(env->psw.mask & PSW_MASK_DAT)) {
> -        return true;
> -    }
> -
> -    /* Check the private-space control bit */
> -    switch (env->psw.mask & PSW_MASK_ASC) {
> -    case PSW_ASC_PRIMARY:
> -        return !(env->cregs[1] & _ASCE_PRIVATE_SPACE);
> -    case PSW_ASC_SECONDARY:
> -        return !(env->cregs[7] & _ASCE_PRIVATE_SPACE);
> -    case PSW_ASC_HOME:
> -        return !(env->cregs[13] & _ASCE_PRIVATE_SPACE);
> -    default:
> -        /* We don't support access register mode */
> -        error_report("unsupported addressing mode");
> -        exit(1);
> -    }
> -}

Apart from the nits, the patch looks fine to me.

 Thomas
