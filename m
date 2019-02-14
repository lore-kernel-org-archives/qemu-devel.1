Received: from eggs.gnu.org ([209.51.188.92]:34079)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1guMsZ-0006wF-L9
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:41:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1guMsY-0006mF-Fw
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:41:03 -0500
Received: from mout.gmx.net ([212.227.15.15]:44055)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1guMsS-0006Mx-1A
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:40:58 -0500
References: <20190202144531.5772-1-n54@gmx.com>
	<a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <d0b7bfcb-8894-5a06-8290-ac9daf5a05da@gmx.com>
Date: Thu, 14 Feb 2019 20:41:13 +0100
MIME-Version: 1.0
In-Reply-To: <a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PLs9BIiIylVa5j7DWZLKXQOZDZyskbLP0"
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PLs9BIiIylVa5j7DWZLKXQOZDZyskbLP0
From: Kamil Rytarowski <n54@gmx.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <d0b7bfcb-8894-5a06-8290-ac9daf5a05da@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] target-i386: Enhance the stub for
 kvm_arch_get_supported_cpuid()
References: <20190202144531.5772-1-n54@gmx.com>
 <a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
In-Reply-To: <a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.02.2019 19:44, Paolo Bonzini wrote:
> On 02/02/19 15:45, Kamil Rytarowski wrote:
>>
>> Clang/LLVM on NetBSD with enabled optimization cannot link
>> correct qemu program because of a missing symbol of
>> kvm_arch_get_supported_cpuid() in kvm-stubs.o used by executables.
>=20
> Can you please include the full error message?  Usually these things ar=
e
> a sign of a bug elsewhere.
>=20
> Paolo
>=20

Please do replace the current kludge that is sensitive to:
 - compiler behavior that can change with new versions
 - compiler gcc/clang
 - optimization options
 - linux(KVM) - non-linux (no-KVM) build
 - community not actively testing non-linux no-kvm build with
optimization on clang


My patch replaced it makes it work.

Build error:

  LINK    i386-bsd-user/qemu-i386
/usr/bin/ld: /usr/lib/libc.so and /usr/lib/crt0.o: warning: multiple
common of `environ'
/usr/bin/ld: target/i386/cpu.o: in function `x86_cpu_filter_features':
/tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5047:
undefined reference to `kvm_arch_get_supported_cpuid'
/usr/bin/ld:
/tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5048:
undefined reference to `kvm_arch_get_supported_cpuid'
/usr/bin/ld:
/tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5049:
undefined reference to `kvm_arch_get_supported_cpuid'
/usr/bin/ld:
/tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5050:
undefined reference to `kvm_arch_get_supported_cpuid'
/usr/bin/ld:
/tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5051:
undefined reference to `kvm_arch_get_supported_cpuid'
clang-9: error: linker command failed with exit code 1 (use -v to see
invocation)
make[1]: *** [Makefile:199: qemu-i386] Error 1
gmake: *** [Makefile:483: subdir-i386-bsd-user] Error 2
gmake: *** Waiting for unfinished jobs....
  LINK    x86_64-bsd-user/qemu-x86_64
/usr/bin/ld: /usr/lib/libc.so and /usr/lib/crt0.o: warning: multiple
common of `environ'
/usr/bin/ld: target/i386/cpu.o: in function `x86_cpu_filter_features':
/tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5047:
undefined reference to `kvm_arch_get_supported_cpuid'
/usr/bin/ld:
/tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5048:
undefined reference to `kvm_arch_get_supported_cpuid'
/usr/bin/ld:
/tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5049:
undefined reference to `kvm_arch_get_supported_cpuid'
/usr/bin/ld:
/tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5050:
undefined reference to `kvm_arch_get_supported_cpuid'
/usr/bin/ld:
/tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5051:
undefined reference to `kvm_arch_get_supported_cpuid'
clang-9: error: linker command failed with exit code 1 (use -v to see
invocation)
make[1]: *** [Makefile:199: qemu-x86_64] Error 1
gmake: *** [Makefile:483: subdir-x86_64-bsd-user] Error 2
*** Error code 2


--PLs9BIiIylVa5j7DWZLKXQOZDZyskbLP0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxlxFkMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsZi0P/0T5Pg4snNED2ae15joDg7IVhoDKDpkP6TPGp63/
st6Y/ENBe/sLC2BnQ/GhWzDLU37cyR0vDrZk3iiuXJWweFEs5CbCSQjAmtXoY5dS
vP11KBTnmBReq/TzwQ1dtm/8lVg3fY3WFXdJDp2SGpCV86gQq0w3+woLLvbfjhxs
resRB+4/PRSLIXmSioAx4ZP5QuQ88U+zlbcmZ0sA7sv4sWq+kbi4E7mz3XgjZUEs
+ZfK6im5RVVS+fFOLf+iIX+wW9oAlnhNpSjL/ZiNcAkDxr4SIzZQ+UgGZrmXDubs
8u2+EwQ40GmuVk7weyT6tNG96W0BrO84uQMchnE6Cd+h6iFFHe4xuSljq2PcW1Sm
7GbBDk8F97e5R02L1lOtjUGRd4cZesw3IcomTHNcGsEzEQ6VVeTpc7sVV0R+zlnw
X/abtD+sccQN9yL1j6utU6FVkpBXLgXc8akC+8X+VWHzBV4lpCjgzc8jvYQu4h+I
cYY0KNpGDBRRPDA4BR8jU4pNIoQ1YqS4JLFQ9ymMkA8An+04nc1KMWv2UYYmYt3U
0etWevixEmf3/RiI6pZVezdFVb8mxl1vJqUAEnuklsXrYzRnNOAu/SUMgP/hyHAE
CPz+zynyb1kI3lI7+tqPoAnCO97VMnZc17N6/HEzybU7q435VI1phI+e/TmqPtNM
Ada+
=Bz87
-----END PGP SIGNATURE-----

--PLs9BIiIylVa5j7DWZLKXQOZDZyskbLP0--
