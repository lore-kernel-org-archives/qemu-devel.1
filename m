Received: from eggs.gnu.org ([209.51.188.92]:53412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guOC1-0005yy-B0
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guNzE-0000Af-MV
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:52:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1guNzE-0008UH-BU
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:52:00 -0500
References: <20190202144531.5772-1-n54@gmx.com>
	<a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
	<d0b7bfcb-8894-5a06-8290-ac9daf5a05da@gmx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fc6a0084-815c-5e4a-cd5c-11046f16f33b@redhat.com>
Date: Thu, 14 Feb 2019 21:51:39 +0100
MIME-Version: 1.0
In-Reply-To: <d0b7bfcb-8894-5a06-8290-ac9daf5a05da@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nlVNpdVog8n0iBXeQqkfDK3H65Z473epD"
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
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nlVNpdVog8n0iBXeQqkfDK3H65Z473epD
From: Paolo Bonzini <pbonzini@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <fc6a0084-815c-5e4a-cd5c-11046f16f33b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target-i386: Enhance the stub for
 kvm_arch_get_supported_cpuid()
References: <20190202144531.5772-1-n54@gmx.com>
 <a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
 <d0b7bfcb-8894-5a06-8290-ac9daf5a05da@gmx.com>
In-Reply-To: <d0b7bfcb-8894-5a06-8290-ac9daf5a05da@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14/02/19 20:41, Kamil Rytarowski wrote:
> Please do replace the current kludge that is sensitive to:
>  - compiler behavior that can change with new versions
>  - compiler gcc/clang
>  - optimization options

Not really, any half-decent compiler will optimize away "if (0)" and
QEMU is far from being the only software that relies on that.

GCC has been doing that even at -O0 for like 15 years, at some point it
was basically the only optimization it did.  Just try it for yourself:

	int f(void);

	int main()
	{
	        if (0)
	                return f();
	        else
	                return 0;
	}

Throw it at all compilers and optimization levels, and it *will* work.
If it doesn't then I'll consider again your patch.

>  - linux(KVM) - non-linux (no-KVM) build

That's the point.  We want your non-Linux non-KVM build to be as lean as
possible and not cause possible run-time failures due to people
forgetting about them.

>  - community not actively testing non-linux no-kvm build with
> optimization on clang

False, we test OS X and there are VM builds for the BSDs.
> My patch replaced it makes it work.
>=20
> Build error:
>=20
>   LINK    i386-bsd-user/qemu-i386

Ok, please use "make -C i386-bsd-user target/i386/cpu.o V=3D1" to get the=

command line, invoke it again with "-save-temps" at the end, and send me
both the command line and the resulting "cpu.i" file.

Paolo

> /usr/bin/ld: /usr/lib/libc.so and /usr/lib/crt0.o: warning: multiple
> common of `environ'
> /usr/bin/ld: target/i386/cpu.o: in function `x86_cpu_filter_features':
> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5047:
> undefined reference to `kvm_arch_get_supported_cpuid'
> /usr/bin/ld:
> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5048:
> undefined reference to `kvm_arch_get_supported_cpuid'
> /usr/bin/ld:
> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5049:
> undefined reference to `kvm_arch_get_supported_cpuid'
> /usr/bin/ld:
> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5050:
> undefined reference to `kvm_arch_get_supported_cpuid'
> /usr/bin/ld:
> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5051:
> undefined reference to `kvm_arch_get_supported_cpuid'
> clang-9: error: linker command failed with exit code 1 (use -v to see
> invocation)
> make[1]: *** [Makefile:199: qemu-i386] Error 1
> gmake: *** [Makefile:483: subdir-i386-bsd-user] Error 2
> gmake: *** Waiting for unfinished jobs....
>   LINK    x86_64-bsd-user/qemu-x86_64
> /usr/bin/ld: /usr/lib/libc.so and /usr/lib/crt0.o: warning: multiple
> common of `environ'
> /usr/bin/ld: target/i386/cpu.o: in function `x86_cpu_filter_features':
> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5047:
> undefined reference to `kvm_arch_get_supported_cpuid'
> /usr/bin/ld:
> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5048:
> undefined reference to `kvm_arch_get_supported_cpuid'
> /usr/bin/ld:
> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5049:
> undefined reference to `kvm_arch_get_supported_cpuid'
> /usr/bin/ld:
> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5050:
> undefined reference to `kvm_arch_get_supported_cpuid'
> /usr/bin/ld:
> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5051:
> undefined reference to `kvm_arch_get_supported_cpuid'
> clang-9: error: linker command failed with exit code 1 (use -v to see
> invocation)
> make[1]: *** [Makefile:199: qemu-x86_64] Error 1
> gmake: *** [Makefile:483: subdir-x86_64-bsd-user] Error 2
> *** Error code 2
>=20



--nlVNpdVog8n0iBXeQqkfDK3H65Z473epD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlxl1OAACgkQv/vSX3jH
roOhVQf7BZnVAopuNW+R/PZw2R540LjXS6iDLvFTM3m34zZEUCUjCizfbtr5vtZf
FQ4wrKcQUCMBhr8JImRvRQgookTEjJojOOJQCrLfXKF2SQrWxoDFNplBXQquygnb
dilk///5cBbySnzxaNc4eprPurB4Zs9aM1yCH8KeJd4xLWBnrQrcZ5EuKAtKgXkJ
wEI9Rug506lsUjTgcnGbkq6TFuwx2bUlUDKSNekW4mHlozpE15V5GKWWrG6z2CYm
ViLymJleKZMhrH62S3TNGOpV0/WLUV8gLRx1LbgeswqPgVDlo7KYH+wTGva1Wut2
4RDWh56P+xZf0bocqudiJwnuR+WGXg==
=C1DE
-----END PGP SIGNATURE-----

--nlVNpdVog8n0iBXeQqkfDK3H65Z473epD--
