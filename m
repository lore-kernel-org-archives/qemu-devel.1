Received: from eggs.gnu.org ([209.51.188.92]:36460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwsLm-0000c4-D8
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:41:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwsLk-0008Uf-G9
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:41:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gwsLg-0008SD-P6
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:41:30 -0500
References: <20190202144531.5772-1-n54@gmx.com>
	<a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
	<d0b7bfcb-8894-5a06-8290-ac9daf5a05da@gmx.com>
	<fc6a0084-815c-5e4a-cd5c-11046f16f33b@redhat.com>
	<e2a4fad5-5a96-994d-e8d4-f129e0929522@gmx.com>
	<4e7b8587-02a4-4ad2-c297-db7a1231f0b6@gmx.com>
	<39f61014-bde0-bcbe-67ec-e479b8ab14ec@redhat.com>
	<26044929-af0b-dc8c-c042-a5d56779caa5@gmx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <005a33a1-73cb-dca2-48d9-d6782be5680d@redhat.com>
Date: Thu, 21 Feb 2019 18:41:23 +0100
MIME-Version: 1.0
In-Reply-To: <26044929-af0b-dc8c-c042-a5d56779caa5@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zWorQLGjMZ3UZ6fO0PQx8llTHmPjSgjnr"
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
--zWorQLGjMZ3UZ6fO0PQx8llTHmPjSgjnr
From: Paolo Bonzini <pbonzini@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <005a33a1-73cb-dca2-48d9-d6782be5680d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target-i386: Enhance the stub for
 kvm_arch_get_supported_cpuid()
References: <20190202144531.5772-1-n54@gmx.com>
 <a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
 <d0b7bfcb-8894-5a06-8290-ac9daf5a05da@gmx.com>
 <fc6a0084-815c-5e4a-cd5c-11046f16f33b@redhat.com>
 <e2a4fad5-5a96-994d-e8d4-f129e0929522@gmx.com>
 <4e7b8587-02a4-4ad2-c297-db7a1231f0b6@gmx.com>
 <39f61014-bde0-bcbe-67ec-e479b8ab14ec@redhat.com>
 <26044929-af0b-dc8c-c042-a5d56779caa5@gmx.com>
In-Reply-To: <26044929-af0b-dc8c-c042-a5d56779caa5@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21/02/19 03:08, Kamil Rytarowski wrote:
> $ find . -name kvm-stub.o|grep x86_64
> ./x86_64-softmmu/accel/stubs/kvm-stub.o
> ./x86_64-softmmu/target/i386/kvm-stub.o
> ./x86_64-bsd-user/accel/stubs/kvm-stub.o
>=20

So here's the bug.  The fix should be as simple as

diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index cb9c265525..48e0c28434 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -3,10 +3,10 @@ obj-$(CONFIG_TCG) +=3D translate.o
 obj-$(CONFIG_TCG) +=3D bpt_helper.o cc_helper.o excp_helper.o fpu_helper=
=2Eo
 obj-$(CONFIG_TCG) +=3D int_helper.o mem_helper.o misc_helper.o mpx_helpe=
r.o
 obj-$(CONFIG_TCG) +=3D seg_helper.o smm_helper.o svm_helper.o
+obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
 ifeq ($(CONFIG_SOFTMMU),y)
 obj-y +=3D machine.o arch_memory_mapping.o arch_dump.o monitor.o
 obj-$(CONFIG_KVM) +=3D kvm.o
-obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
 obj-$(CONFIG_HYPERV) +=3D hyperv.o
 obj-$(call lnot,$(CONFIG_HYPERV)) +=3D hyperv-stub.o
 ifeq ($(CONFIG_WIN32),y)

Thanks,

Paolo


--zWorQLGjMZ3UZ6fO0PQx8llTHmPjSgjnr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlxu4sQACgkQv/vSX3jH
roPa5wf+JdklgBu6W9l2KJcY209cZcLLXGZ6aq+a5lMlnfkCoUwjO5R9W9wM7v2b
eqaYvDM6ioYk/wKHPSLfJoFYG/KNqSbAy2r1hu8WVR6rI9vpE6iBUGfLWabc//o+
DaPnYHwSKi70mfhoQzBuBonIZnHz83O/542E7DtwI3O3s8EowL8nWSv88pXrQplq
hwH1bHnhIXYEpa5EX/6mw429fqta+Aqa1x3qmQEDtMIBZNtO6ITigimgIk7uVJL/
YUbXL1b3T+8CV05XOqgWeJAzOozKUdQ4mdA5vIgNyeevHhd5128tVE4EpP9CxXiB
F79bHiTfH7omimeg6PunlBZBspA9uA==
=srFs
-----END PGP SIGNATURE-----

--zWorQLGjMZ3UZ6fO0PQx8llTHmPjSgjnr--
