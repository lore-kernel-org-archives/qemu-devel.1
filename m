Received: from eggs.gnu.org ([2001:4830:134:3::10]:40110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddGpz-0005Cb-Da
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddGpk-0005U1-Tg
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:10:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ddGpk-0005Sy-H4
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:10:40 -0400
References: <150168523493.31663.3716600121804656211.stgit@bahia.lan>
	<928f0ce3-159a-e371-6309-078fac31eace@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b999332b-aef1-6f19-0a1c-cf1d4a694b32@redhat.com>
Date: Thu, 3 Aug 2017 09:10:29 -0500
MIME-Version: 1.0
In-Reply-To: <928f0ce3-159a-e371-6309-078fac31eace@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UOKN9ttsHWdPIWRDbcfEgCCrcwLRAF7XV"
Subject: Re: [Qemu-devel] [PATCH] kvm: workaround build break on gcc-7.1.1 /
 fedora26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UOKN9ttsHWdPIWRDbcfEgCCrcwLRAF7XV
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <b999332b-aef1-6f19-0a1c-cf1d4a694b32@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] kvm: workaround build break on gcc-7.1.1 /
 fedora26
References: <150168523493.31663.3716600121804656211.stgit@bahia.lan>
 <928f0ce3-159a-e371-6309-078fac31eace@amsat.org>
In-Reply-To: <928f0ce3-159a-e371-6309-078fac31eace@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/03/2017 08:46 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Greg,
>=20
> On 08/02/2017 11:47 AM, Greg Kurz wrote:
>> Building QEMU on fedora26 with the latest gcc package fails:
>>
>>    CC      ppc64-softmmu/target/ppc/kvm.o
>> In file included from include/sysemu/hw_accel.h:16:0,
>>                   from target/ppc/kvm.c:31:
>> target/ppc/kvm.c: In function =E2=80=98kvmppc_booke_watchdog_enable=E2=
=80=99:
>> include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 may =
be used
>> uninitialized
>>   in this function [-Werror=3Dmaybe-uninitialized]
>>               cap.args[i] =3D args_tmp[i];                            =
   \
>>                                     ^
>> target/ppc/kvm.c: In function =E2=80=98kvmppc_set_papr=E2=80=99:
>> include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 may =
be used
>> uninitialized
>>   in this function [-Werror=3Dmaybe-uninitialized]
>> cc1: all warnings being treated as errors
>=20
> I'm trying to reproduce this in our docker images (all x86_64 based) bu=
t
> can't reproduce.

That's because x86_64 hosts only call kvm_vm_enable_cap() with non-empty
varargs.  But we have:

accel/kvm/kvm-all.c: ret =3D kvm_vm_enable_cap(s, KVM_CAP_S390_IRQCHIP, 0=
);

which is only compiled on s390 hosts (or, at least that's my guess,
based on the cap name) - and THAT code is passing empty varargs, which
explains args_tmp[] being a 0-length array, and getting the compiler to
complain about i < 0 always being false.

So my question on IRC was whether we can stack the decks, and force a
non-empty args_tmp =3D { 0, __VA_ARGS__} coupled by skipping the first
iteration in the for loop.  Or, since cap.args[] is already being
zero-initialized, args_tmp =3D { __VA_ARGS__, 0 } means the last iteratio=
n
of the for loop is a no-op (assigning 0 to something that is already 0)
- although that may be harder to correctly account for both empty and
non-empty __VA_ARGS__.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UOKN9ttsHWdPIWRDbcfEgCCrcwLRAF7XV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmDLtUACgkQp6FrSiUn
Q2ppTggAmhDriIfBFsLmYN7P56CB+osOJbbpQbCVJfGAk0ZrgGPA1QAKDioNBvv/
1YzHZQPNsiPp8NKbe0isNdpf3HAV5zlp/cuGLDyM9XS0MFabh3sb4ijLcs3qUAyI
WidE2DjTY0cCcBe4ggcZXKXeWjYEHQqeiYblmCJ0ObNNAbT+GFcHFD3TMUpgxN3P
AfwObTpz0Jr4IfsstJwzoJlromelRmQ/DNy69hs6fL+eT4/waX6GwLtjDXXyrK8f
p2964nZnBlic/gljRc/Ik1gRkL3OCSleqTiTI5kDY8Z+xp3tLItlkru/NRsxfZj9
kIeYBf+PlvBIgh66sSfHK4B0XDVVKA==
=80mh
-----END PGP SIGNATURE-----

--UOKN9ttsHWdPIWRDbcfEgCCrcwLRAF7XV--
