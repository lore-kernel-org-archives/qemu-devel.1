Received: from eggs.gnu.org ([209.51.188.92]:46591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwVgl-0006IJ-Hk
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwVgi-0002ib-W0
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:29:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gwVgh-0002bG-2y
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:29:39 -0500
References: <20190202144531.5772-1-n54@gmx.com>
	<a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
	<d0b7bfcb-8894-5a06-8290-ac9daf5a05da@gmx.com>
	<fc6a0084-815c-5e4a-cd5c-11046f16f33b@redhat.com>
	<e2a4fad5-5a96-994d-e8d4-f129e0929522@gmx.com>
	<4e7b8587-02a4-4ad2-c297-db7a1231f0b6@gmx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <39f61014-bde0-bcbe-67ec-e479b8ab14ec@redhat.com>
Date: Wed, 20 Feb 2019 18:29:27 +0100
MIME-Version: 1.0
In-Reply-To: <4e7b8587-02a4-4ad2-c297-db7a1231f0b6@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jaNZF44sTiRHeuH36gnA4tqimY9le06An"
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
--jaNZF44sTiRHeuH36gnA4tqimY9le06An
From: Paolo Bonzini <pbonzini@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <39f61014-bde0-bcbe-67ec-e479b8ab14ec@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target-i386: Enhance the stub for
 kvm_arch_get_supported_cpuid()
References: <20190202144531.5772-1-n54@gmx.com>
 <a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
 <d0b7bfcb-8894-5a06-8290-ac9daf5a05da@gmx.com>
 <fc6a0084-815c-5e4a-cd5c-11046f16f33b@redhat.com>
 <e2a4fad5-5a96-994d-e8d4-f129e0929522@gmx.com>
 <4e7b8587-02a4-4ad2-c297-db7a1231f0b6@gmx.com>
In-Reply-To: <4e7b8587-02a4-4ad2-c297-db7a1231f0b6@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20/02/19 12:59, Kamil Rytarowski wrote:
> Ping, still valid.

Sorry, I missed your email.

> On 15.02.2019 00:38, Kamil Rytarowski wrote:
>> I consider it as fragile hack and certainly not something to depend on=
=2E
>> Also in some circumstances of such code, especially "if (zero0)" we wa=
nt
>> to enable disabled code under a debugger.

That's a good objection, but certainly does not apply to KVM on NetBSD.

>> There were also kernel backdoors due to this optimization.

Citation please?

>> Requested cpu.i (hopefully correctly generated)
>>
>> http://netbsd.org/~kamil/qemu/cpu.i.bz2

So, first thing first I can reproduce clang's behavior with this .i file
and also with this reduced test case.

    extern void f(void);
    int i, j;
    int main()
    {
        if (0  && i) f();
        if (j  && 0) f();
   }

The first is eliminated but the second is not, just like in QEMU where
this works:

        if (kvm_enabled() && cpu->enable_pmu) {
            KVMState *s =3D cs->kvm_state;

            *eax =3D kvm_arch_get_supported_cpuid(s, 0xA, count, R_EAX);
            *ebx =3D kvm_arch_get_supported_cpuid(s, 0xA, count, R_EBX);
            *ecx =3D kvm_arch_get_supported_cpuid(s, 0xA, count, R_ECX);
            *edx =3D kvm_arch_get_supported_cpuid(s, 0xA, count, R_EDX);
        } else if (hvf_enabled() && cpu->enable_pmu) {
            *eax =3D hvf_get_supported_cpuid(0xA, count, R_EAX);
            *ebx =3D hvf_get_supported_cpuid(0xA, count, R_EBX);
            *ecx =3D hvf_get_supported_cpuid(0xA, count, R_ECX);
            *edx =3D hvf_get_supported_cpuid(0xA, count, R_EDX);

while this doesn't:

    if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
        kvm_enabled()) {
        KVMState *s =3D CPU(cpu)->kvm_state;
        uint32_t eax_0 =3D kvm_arch_get_supported_cpuid(s, 0x14, 0, R_EAX=
);
        uint32_t ebx_0 =3D kvm_arch_get_supported_cpuid(s, 0x14, 0, R_EBX=
);
        uint32_t ecx_0 =3D kvm_arch_get_supported_cpuid(s, 0x14, 0, R_ECX=
);
        uint32_t eax_1 =3D kvm_arch_get_supported_cpuid(s, 0x14, 1, R_EAX=
);
        uint32_t ebx_1 =3D kvm_arch_get_supported_cpuid(s, 0x14, 1, R_EBX=
);

But, that's okay, it's -O0 so we give clang a pass for that  Note that
clang does do the optimization even in more complex cases like

    extern _Bool f(void);
    int main()
    {
        if (!0) return 0;
        if (!f()) return 0;
    }

The problem is that there is a kvm-stub.c entry for that, and in fact
my compilation passes and the symbol is resolved correctly:

$ nm target/i386/cpu.o |grep kvm_.*get_sup
                 U kvm_arch_get_supported_cpuid
$ nm target/i386/kvm-stub.o|grep kvm_.*get_sup
0000000000000030 T kvm_arch_get_supported_cpuid
$ nm qemu-system-x86_64 |grep kvm_.*get_sup
000000000046eab0 T kvm_arch_get_supported_cpuid

As expected, something much less obvious is going on for you, in
particular __OPTIMIZE__seems not to be working properly.  However,
that would also be very surprising.

Please:

1) run the last two "nm" commands on your build (wthout grep).

2) do the same exercise to get a .i for target/i386/kvm-stub.c

3) try removing the "#ifndef __OPTIMIZE__" and leave everything else as i=
s,
see if it works.  No need to play with macros, which also goes to show th=
at
you didn't really understand what's going on---that's fine, but then plea=
se
refrain from making summary judgments which only lengthen the discussion.=


Thanks,

Paolo


--jaNZF44sTiRHeuH36gnA4tqimY9le06An
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlxtjncACgkQv/vSX3jH
roNZcwgAmqeGktnb//CMFoGH2D79y6Pgs4chPqY10VTxrac5o4QS5jf9PH7NxuH1
2T/Q4gTInWprzBvLX2EMdW8cANFHHU6yTLHm/zCnika+3Bhimdl4z0UOjUbWe7dB
UtDOUNUfTvf/paWFJ+9xHO3aWb4jjkXfa24oEmW9a8MbHUwbmqUHs84zKt5QHysd
t5kTHP1lJ4iu/2YFfN25ZjNppsavSi9nFRpHByaVq0V4UZbfvpaZ0ClOKQRJ26Zm
8DnxHLyzosopsb2lIEsGQ99UP7/zjO5+OVGW1ulKyo0io7RnSA1SZYgZfx6+5D4T
CfPj1/IcoC50wP+hra0GDQ7d8eRgTw==
=vzh8
-----END PGP SIGNATURE-----

--jaNZF44sTiRHeuH36gnA4tqimY9le06An--
