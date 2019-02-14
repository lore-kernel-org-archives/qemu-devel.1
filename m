Received: from eggs.gnu.org ([209.51.188.92]:56689)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1guQZS-0000nz-Cd
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:37:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1guQZQ-00061F-Ga
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:37:34 -0500
Received: from mout.gmx.net ([212.227.15.15]:43091)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1guQZM-0005vh-Lj
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:37:30 -0500
References: <20190202144531.5772-1-n54@gmx.com>
	<a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
	<d0b7bfcb-8894-5a06-8290-ac9daf5a05da@gmx.com>
	<fc6a0084-815c-5e4a-cd5c-11046f16f33b@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <e2a4fad5-5a96-994d-e8d4-f129e0929522@gmx.com>
Date: Fri, 15 Feb 2019 00:38:09 +0100
MIME-Version: 1.0
In-Reply-To: <fc6a0084-815c-5e4a-cd5c-11046f16f33b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EooHn4IC61yxh8pGEpJPhveFekx9StgSC"
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
--EooHn4IC61yxh8pGEpJPhveFekx9StgSC
From: Kamil Rytarowski <n54@gmx.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <e2a4fad5-5a96-994d-e8d4-f129e0929522@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] target-i386: Enhance the stub for
 kvm_arch_get_supported_cpuid()
References: <20190202144531.5772-1-n54@gmx.com>
 <a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
 <d0b7bfcb-8894-5a06-8290-ac9daf5a05da@gmx.com>
 <fc6a0084-815c-5e4a-cd5c-11046f16f33b@redhat.com>
In-Reply-To: <fc6a0084-815c-5e4a-cd5c-11046f16f33b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.02.2019 21:51, Paolo Bonzini wrote:
> On 14/02/19 20:41, Kamil Rytarowski wrote:
>> Please do replace the current kludge that is sensitive to:
>>  - compiler behavior that can change with new versions
>>  - compiler gcc/clang
>>  - optimization options
>=20
> Not really, any half-decent compiler will optimize away "if (0)" and
> QEMU is far from being the only software that relies on that.
>=20
> GCC has been doing that even at -O0 for like 15 years, at some point it=

> was basically the only optimization it did.  Just try it for yourself:
>=20
> 	int f(void);
>=20
> 	int main()
> 	{
> 	        if (0)
> 	                return f();
> 	        else
> 	                return 0;
> 	}
>=20
> Throw it at all compilers and optimization levels, and it *will* work.
> If it doesn't then I'll consider again your patch.
>=20

I consider it as fragile hack and certainly not something to depend on.
Also in some circumstances of such code, especially "if (zero0)" we want
to enable disabled code under a debugger.

There were also kernel backdoors due to this optimization.

>>  - linux(KVM) - non-linux (no-KVM) build
>=20
> That's the point.  We want your non-Linux non-KVM build to be as lean a=
s
> possible and not cause possible run-time failures due to people
> forgetting about them.
>=20
>>  - community not actively testing non-linux no-kvm build with
>> optimization on clang
>=20
> False, we test OS X and there are VM builds for the BSDs.

Unfortunately not in the same combination of options as nobody caught it
in years. (Probably not many people actually develop it on these OSes
with debug flags). I was keeping this patch locally for some time now.
This hack was introduced several years ago.

>> My patch replaced it makes it work.
>>
>> Build error:
>>
>>   LINK    i386-bsd-user/qemu-i386
>=20
> Ok, please use "make -C i386-bsd-user target/i386/cpu.o V=3D1" to get t=
he
> command line, invoke it again with "-save-temps" at the end, and send m=
e
> both the command line and the resulting "cpu.i" file.
>=20

I'm building qemu with pkgsrc that provides all the dependencies and
compiler settings. It also uses wrappers to translate original compiler
options with transformed ones.

Log from pkgsrc with command lines:

http://netbsd.org/~kamil/qemu/qemu-build-2019-02-14.txt.bz2

Requested cpu.i (hopefully correctly generated)

http://netbsd.org/~kamil/qemu/cpu.i.bz2

I've generated it manually with this command.

/usr/local/bin/clang -iquote
/tmp/pkgsrc-tmp/wip/qemu-haxm/work/qemu-3.0.0/target/i386 -iquote
target/i386 -iquote /tmp/pkgsrc-tmp/wip/qemu-haxm/work/qemu-3.0.0/tcg
-iquote /tmp/pkgsrc-tmp/wip/qemu-haxm/work/qemu-3.0.0/tcg/i386 -iquote .
-iquote /tmp/pkgsrc-tmp/wip/qemu-haxm/work/qemu-3.0.0 -iquote
/tmp/pkgsrc-tmp/wip/qemu-haxm/work/qemu-3.0.0/accel/tcg -iquote
/tmp/pkgsrc-tmp/wip/qemu-haxm/work/qemu-3.0.0/include
-I/tmp/pkgsrc-tmp/wip/qemu-haxm/work/.x11-buildlink/include/pixman-1
-I/tmp/pkgsrc-tmp/wip/qemu-haxm/work/qemu-3.0.0/dtc/libfdt -pthread
-I/tmp/pkgsrc-tmp/wip/qemu-haxm/work/.buildlink/include/glib/glib-2.0
-I/tmp/pkgsrc-tmp/wip/qemu-haxm/work/.buildlink/lib/glib-2.0/include
-I/tmp/pkgsrc-tmp/wip/qemu-haxm/work/.buildlink/include -m64 -mcx16
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
-Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings
-Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv
-Wno-error=3Daddress-of-packed-member -Wno-string-plus-int
-Wno-initializer-overrides -Wexpansion-to-defined -Wendif-labels
-Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body
-Wnested-externs -Wformat-security -Wformat-y2k -Winit-self
-Wignored-qualifiers -Wold-style-definition -Wtype-limits
-fstack-protector-strong
-I/tmp/pkgsrc-tmp/wip/qemu-haxm/work/.buildlink/include/libpng16
-I/tmp/pkgsrc-tmp/wip/qemu-haxm/work/qemu-3.0.0/capstone/include -iquote
=2E. -iquote /tmp/pkgsrc-tmp/wip/qemu-haxm/work/qemu-3.0.0/target/i386
-DNEED_CPU_H -iquote
/tmp/pkgsrc-tmp/wip/qemu-haxm/work/qemu-3.0.0/include -MMD -MP -MT
target/i386/cpu.o -MF target/i386/cpu.d -O2 -g -O2 -O0 -g -ggdb
-I/tmp/pkgsrc-tmp/wip/qemu-haxm/work/.buildlink/include/SDL2
-I/tmp/pkgsrc-tmp/wip/qemu-haxm/work/.x11-buildlink/include
-I/tmp/pkgsrc-tmp/wip/qemu-haxm/work/.x11-buildlink/include/libdrm
-I/tmp/pkgsrc-tmp/wip/qemu-haxm/work/.buildlink/include/glib/gio-unix-2.0=

-I/usr/include/krb5 -c -o target/i386/cpu.o
/tmp/pkgsrc-tmp/wip/qemu-haxm/work/qemu-3.0.0/target/i386/cpu.c
-Qunused-arguments -fstack-protector -save-temps

> Paolo
>=20
>> /usr/bin/ld: /usr/lib/libc.so and /usr/lib/crt0.o: warning: multiple
>> common of `environ'
>> /usr/bin/ld: target/i386/cpu.o: in function `x86_cpu_filter_features':=

>> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5047:=

>> undefined reference to `kvm_arch_get_supported_cpuid'
>> /usr/bin/ld:
>> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5048:=

>> undefined reference to `kvm_arch_get_supported_cpuid'
>> /usr/bin/ld:
>> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5049:=

>> undefined reference to `kvm_arch_get_supported_cpuid'
>> /usr/bin/ld:
>> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5050:=

>> undefined reference to `kvm_arch_get_supported_cpuid'
>> /usr/bin/ld:
>> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5051:=

>> undefined reference to `kvm_arch_get_supported_cpuid'
>> clang-9: error: linker command failed with exit code 1 (use -v to see
>> invocation)
>> make[1]: *** [Makefile:199: qemu-i386] Error 1
>> gmake: *** [Makefile:483: subdir-i386-bsd-user] Error 2
>> gmake: *** Waiting for unfinished jobs....
>>   LINK    x86_64-bsd-user/qemu-x86_64
>> /usr/bin/ld: /usr/lib/libc.so and /usr/lib/crt0.o: warning: multiple
>> common of `environ'
>> /usr/bin/ld: target/i386/cpu.o: in function `x86_cpu_filter_features':=

>> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5047:=

>> undefined reference to `kvm_arch_get_supported_cpuid'
>> /usr/bin/ld:
>> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5048:=

>> undefined reference to `kvm_arch_get_supported_cpuid'
>> /usr/bin/ld:
>> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5049:=

>> undefined reference to `kvm_arch_get_supported_cpuid'
>> /usr/bin/ld:
>> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5050:=

>> undefined reference to `kvm_arch_get_supported_cpuid'
>> /usr/bin/ld:
>> /tmp/pkgsrc-tmp/emulators/qemu/work/qemu-3.1.0/target/i386/cpu.c:5051:=

>> undefined reference to `kvm_arch_get_supported_cpuid'
>> clang-9: error: linker command failed with exit code 1 (use -v to see
>> invocation)
>> make[1]: *** [Makefile:199: qemu-x86_64] Error 1
>> gmake: *** [Makefile:483: subdir-x86_64-bsd-user] Error 2
>> *** Error code 2
>>
>=20
>=20



--EooHn4IC61yxh8pGEpJPhveFekx9StgSC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxl++IMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsBRoP/1/5mmI7+8z/fPSsqaj7rUJ1uP1dmzO+uY2ohqXw
h74XtE2oxebHntZte16Hz49plu6RTSt6QGc/N6j4CvAYK3WEJu2tYxBsIewASSEs
oumLq6R4BChriY7Z/t2AV3ftC03O4J1MTcDGYJOX0xkrqB5TToKOFofAXhlb5kLd
C3om20Sa0e0UNa+zdzHN5AIUKiA1DH8Y/8c5Tdw0Q0a03QFwjPwurwh2LBVN0vYm
x2bQjxGH1E6+2ZIY4mFF+Dd4Ffhy4j5HJWSPNlGCQhK9Xi35nb5SnxxlwSsevK8i
/oEjo6IbEjKTzybfycJKHAVhzqcy4uri+IOEY6nxQETFR/P9lbWuSamjJSAkDXCt
q7b0/KahpdCuopfpBsVM51LCWlZjVraKPrnV22/AFibZ8MUs/eQ8RUFYP/BXCnFB
9JFPGDfwuoG6OPj78wdisNsAqCANvTpUWVOWgpOfynv627okSYttu8u6aWPawzko
8WFeKnxgjPy8mmp0o+8tnK3P89MHowfGAILYmua6yiurSTspenetplyG9d19w2CZ
e7+yi9xzvoSWgYcuZXT41wuWZOM5Qj2pvMuejlvasQOYNzfme+6Wjp/bh7GmiHAa
NtxyU/1FrFA3hBOMm3loNaZwYalc0dbGg7kfFwmDYsjZS1hPPfXq4/El0mZMVezB
CpRN
=CPJ3
-----END PGP SIGNATURE-----

--EooHn4IC61yxh8pGEpJPhveFekx9StgSC--
