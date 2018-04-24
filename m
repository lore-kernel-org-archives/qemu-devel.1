Received: from eggs.gnu.org ([2001:4830:134:3::10]:45619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fAyAm-0003Vi-Dh
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fAyAl-0004Nz-4C
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:39:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54450 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fAyAk-0004MY-TG
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:39:55 -0400
References: <152406338081.5947.5696498314762417499@sif>
	<6bb9731f-013d-018d-0b6e-c6dc55570f1f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <72d4dd49-19a2-2e24-48f0-7b81dc42e728@redhat.com>
Date: Tue, 24 Apr 2018 08:39:52 -0500
MIME-Version: 1.0
In-Reply-To: <6bb9731f-013d-018d-0b6e-c6dc55570f1f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7tRAJ2nReUg8QRLWi8jxOgVvNMDQIKiV6"
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.12.0-rc4 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, peter.maydell@linaro.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Michael Clark <mjc@sifive.com>, Richard Henderson <richard.henderson@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7tRAJ2nReUg8QRLWi8jxOgVvNMDQIKiV6
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, peter.maydell@linaro.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Clark <mjc@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>
Message-ID: <72d4dd49-19a2-2e24-48f0-7b81dc42e728@redhat.com>
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.12.0-rc4 is now available
References: <152406338081.5947.5696498314762417499@sif>
 <6bb9731f-013d-018d-0b6e-c6dc55570f1f@redhat.com>
In-Reply-To: <6bb9731f-013d-018d-0b6e-c6dc55570f1f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 07:46 AM, Laszlo Ersek wrote:

> I just noticed two QAPI bugs introduced in 2.12, in the following two
> commits:
>=20
> (1) ca230ff33f89 ("qmp: add architecture specific cpu data for
> query-cpus-fast", 2018-02-26)
>=20
> This commit added @arch to @CpuInfoFast, but it failed to set the new
> field to CPU_INFO_ARCH_OTHER in qmp_query_cpus_fast(), when TARGET_S390=
X
> is not defined.

We zero-initialize info->value, and info->value->arch =3D=3D 0 happens to=
 be
CPU_INFO_ARCH_X86 which is associated with the empty type CpuInfoOther,
which is no different than what we would have had with
CPU_INFO_ARCH_OTHER.  So the drawback is that on x86 architectures,
things look correct; while on sparc, ppc, mips, and tricore (which have
a specific type) and on all other platforms (which should use "other"),
the output wrongly reports "arch":"x86" but does not crash.

>=20
> (2) 25fa194b7b11 ("RISC-V Build Infrastructure", 2018-03-07)
>=20
> This commit added the @riscv enum constant to @CpuInfoArch (used in bot=
h
> @CpuInfo and @CpuInfoFast -- the return types of the @query-cpus and
> @query-cpus-fast commands, respectively), and assigned, in both return
> structures, the @CpuInfoRISCV sub-structure to the new enum value.

Ouch - we SHOULD have used 'CpuInfoOther' rather than 'CpuInfoRISCV' for
@CpuInfoFast.  We do NOT want to report the 'pc' field in the fast query.=


>=20
> However, qmp_query_cpus_fast() does not populate the sub-structure, whe=
n
> TARGET_RISCV is defined; only qmp_query_cpus() does.

Indeed, the output wrongly reports "arch":"x86" instead of
"arch":"riscv" - but at least things do not crash.

>=20
> The fixes don't look complicated. Do you want to hold the release while=

> I post the fixes?
>=20
> I don't think these bugs are "show stoppers". On the other hand, QAPI i=
s
> an external interface.

It's too late for the 2.12 release.  We'll definitely fix things in
2.12.1 (so cc the patches to qemu-stable), and should document in the
release notes that query-cpus-fast is known to report bogus "arch" data
for all architectures except x86 and s390, so applications should be
careful to not rely on the bogus information.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7tRAJ2nReUg8QRLWi8jxOgVvNMDQIKiV6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrfM6kACgkQp6FrSiUn
Q2rkJQgAlMf+3MDnrnSYs8E8+GanXl8P0JTzUwUil8xrU26AgXFzdE40/6mTQi4D
kLM6h4RRhYWSTL8FrAHsRSMmBiy24ZWstsZmTaC20vQerydbK+i+Ivl34c6WbCGb
TkgMGG3h9968hNGo1MOb1XR1O6kgX6hJ7JERnIvp/x8onzQBcksbQv3cYTAefhkG
jhGbLtbdBhvJuz1RyMY+8enIevNlEdbmfOM3L96AIQiSPFB7UKOKOp25qeYyUVf8
VvMqjXL3WYlz6fHV3BilvJwIuNZdFHiP9N+/rLubI61ynu8JFgWtv/q5so/CS7re
nP1Qfsv7lv8vaHUj6oorwZUtFCveGw==
=lORi
-----END PGP SIGNATURE-----

--7tRAJ2nReUg8QRLWi8jxOgVvNMDQIKiV6--
