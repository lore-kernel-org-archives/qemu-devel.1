Received: from eggs.gnu.org ([209.51.188.92]:48668)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1guLyF-0006xG-Vm
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:42:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1guLy9-0004K6-KR
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:42:49 -0500
Received: from mout.gmx.net ([212.227.15.18]:42657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1guLy7-0004CN-Nl
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:42:45 -0500
References: <20190202144531.5772-1-n54@gmx.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <a244ab86-985b-b9b6-ec3f-b15a61a21fc6@gmx.com>
Date: Thu, 14 Feb 2019 19:43:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190202144531.5772-1-n54@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MJttzcsazBY9wlj7qRgltpuQi3zQ1XOxQ"
Subject: Re: [Qemu-devel] [PATCH] target-i386: Enhance the stub for
 kvm_arch_get_supported_cpuid()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MJttzcsazBY9wlj7qRgltpuQi3zQ1XOxQ
From: Kamil Rytarowski <n54@gmx.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
Message-ID: <a244ab86-985b-b9b6-ec3f-b15a61a21fc6@gmx.com>
Subject: Re: [PATCH] target-i386: Enhance the stub for
 kvm_arch_get_supported_cpuid()
References: <20190202144531.5772-1-n54@gmx.com>
In-Reply-To: <20190202144531.5772-1-n54@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ping?

On 02.02.2019 15:45, Kamil Rytarowski wrote:
> This improves the commit:
> "target-i386: Fix build by providing stub kvm_arch_get_supported_cpuid(=
)"
> r. 2140cfa51d59177815f5b82e94ac48fb24909aba
>=20
> Clang/LLVM on NetBSD with enabled optimization cannot link
> correct qemu program because of a missing symbol of
> kvm_arch_get_supported_cpuid() in kvm-stubs.o used by executables.
>=20
> There are more than a single one kvm-stub.c and several types
> of possible programs such as bsd-user ones. the previous workaround
> does not work reliably for all use-cases. Instead of reworking
> the stubs and linking rules, move the workaround from a code that
> depends on the __OPTIMIZE__ builtin compiler flag, build option (KVM),
> compiler and arrangement of linking rules to a simple macro in a
> shared header with all the users that defines fallback dummy
> implementation, ignoring whether it is optimized out or not.
>=20
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  include/sysemu/kvm.h   | 13 +++++++++++++
>  target/i386/kvm-stub.c | 10 ----------
>  2 files changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index a6d1cd190f..93d3c0f0b3 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -459,8 +459,21 @@ int kvm_vm_check_extension(KVMState *s, unsigned i=
nt extension);
>          kvm_vcpu_ioctl(cpu, KVM_ENABLE_CAP, &cap);                   \=

>      })
> =20
> +#ifdef CONFIG_KVM
>  uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function=
,
>                                        uint32_t index, int reg);
> +#else
> +/*
> + * This function is only called inside conditionals which we
> + * rely on the compiler to optimize out when CONFIG_KVM is not
> + * defined.
> + */
> +#define kvm_arch_get_supported_cpuid(a, b, c, d)                     \=

> +    ({                                                               \=

> +        abort();                                                     \=

> +        0;                                                           \=

> +    })
> +#endif
>  uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t inde=
x);
> =20
> =20
> diff --git a/target/i386/kvm-stub.c b/target/i386/kvm-stub.c
> index e7a673e5db..9ce8566700 100644
> --- a/target/i386/kvm-stub.c
> +++ b/target/i386/kvm-stub.c
> @@ -29,16 +29,6 @@ bool kvm_enable_x2apic(void)
>  {
>      return false;
>  }
> -
> -/* This function is only called inside conditionals which we
> - * rely on the compiler to optimize out when CONFIG_KVM is not
> - * defined.
> - */
> -uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function=
,
> -                                      uint32_t index, int reg)
> -{
> -    abort();
> -}
>  #endif
> =20
>  bool kvm_hv_vpindex_settable(void)
>=20



--MJttzcsazBY9wlj7qRgltpuQi3zQ1XOxQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxltsYMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsYDgP/1lDSj+N7luEzJN5485uWOi9RJqM+jG8yabO13Ad
x2ZQGyfvnm1sqpKji/qYtPnW6rOBxjg52CqLb8ufu3i5HcNz+tkBbT62fF+qVqNQ
z9SYAELZWgrxNhXwt01iVH9J4wSZmXj2NN8qorlUdQCz0zdu1t8BLIl0TKRuAWB8
2jiOG0BcEnnT7XxWiHNeT/NryrGHS5aQMGy0RIKsPbzLfNoGxJbBjGbyS/0HhTbt
Tzcy0YNogglISBh8EAtMM1hLIGGbCPzqeX9dHSsG4U18CxY0JYecPGNW5nUYvG+P
LK15eU2u1PnCuU/QdqSvW9GOmzPmXRStVBMeS7tcjrD2XN3b5TIpjCI6ZmevmGmb
/UZYxq61VYLEgxvkjYfFphnT8kcOJnwk/zvieWhNKEpcPD13/oh48eOmEXchLDVK
k5618Yh73qb+sGttK71NwZ/38QRv1P7tEHmUZ3DA/JJ/qA/PqMeu2LdYaot7g43D
fy/SH88LFHp8Ph3bLzzlmeTyObbu+OK0m06KoVsoVEAELusjkoCELaukmdCR+xCQ
QypfimbxTpqCSLAaPdAla3LyA34gjj3SidCEf3rEN9k6uO7czNuCaaSUyzGUaqcs
fR8tLYLlv9BNaPnUb0ncZ6R4zKv1pGExb49IZIfzipKgZsgxeP7kHwhC1wrEppFt
5US2
=ui/x
-----END PGP SIGNATURE-----

--MJttzcsazBY9wlj7qRgltpuQi3zQ1XOxQ--
