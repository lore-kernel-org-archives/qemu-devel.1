Received: from eggs.gnu.org ([2001:4830:134:3::10]:49320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCqVT-0002hr-Dg
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCqVL-0000xn-Vk
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:25:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52575)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gCqVL-0000pu-Ll
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:25:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DB0D3002E34
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 18:24:58 +0000 (UTC)
References: <20181016232201.16829-1-crosa@redhat.com>
	<5b8c6bcd-dfb8-3c9e-cdd3-113d771631a0@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <9a9b3ff9-1674-1281-caac-d4ccf37af076@redhat.com>
Date: Wed, 17 Oct 2018 14:24:56 -0400
MIME-Version: 1.0
In-Reply-To: <5b8c6bcd-dfb8-3c9e-cdd3-113d771631a0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Acceptance tests: host arch to target arch
 name mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>



On 10/17/18 10:54 AM, Wainer dos Santos Moschetta wrote:
> Hello Cleber!
>=20
> On 10/16/2018 08:22 PM, Cleber Rosa wrote:
>> The host arch name is not always the target arch name, so it's
>> necessary to have a mapping.
>>
>> The configure scripts contains what is the authoritative and failproof
>> mapping, but, reusing it is not straightforward, so it's replicated in
>> the acceptance tests supporting code.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>> =C2=A0 configure=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2=
 ++
>> =C2=A0 tests/acceptance/avocado_qemu/__init__.py | 23 ++++++++++++++++=
+++++++
>> =C2=A0 2 files changed, 25 insertions(+)
>>
>> diff --git a/configure b/configure
>> index 8af2be959f..e029b756d4 100755
>> --- a/configure
>> +++ b/configure
>> @@ -6992,6 +6992,8 @@ TARGET_ARCH=3D"$target_name"
>> =C2=A0 TARGET_BASE_ARCH=3D""
>> =C2=A0 TARGET_ABI_DIR=3D""
>> =C2=A0 +# When updating target_name =3D> TARGET_ARCH, please also upda=
te the
>> +# HOST_TARGET_ARCH mapping in tests/acceptance/avocado_qemu/__init__.=
py
>> =C2=A0 case "$target_name" in
>> =C2=A0=C2=A0=C2=A0 i386)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mttcg=3D"yes"
>> diff --git a/tests/acceptance/avocado_qemu/__init__.py
>> b/tests/acceptance/avocado_qemu/__init__.py
>> index 1e54fd5932..d9bc4736ec 100644
>> --- a/tests/acceptance/avocado_qemu/__init__.py
>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>> @@ -19,6 +19,28 @@ sys.path.append(os.path.join(SRC_ROOT_DIR, 'scripts=
'))
>> =C2=A0 =C2=A0 from qemu import QEMUMachine
>> =C2=A0 +
>> +#: Mapping of host arch names to target arch names.=C2=A0 It's expect=
ed
>> that the
>> +#: arch identification on the host, using os.uname()[4], would return
>> the
>> +#: key (LHS).=C2=A0 The QEMU target name, and consequently the target
>> binary, would
>> +#: be based on the name on the value (RHS).
>> +HOST_TARGET_ARCH =3D {
>> +=C2=A0=C2=A0=C2=A0 'armeb': 'arm',
>> +=C2=A0=C2=A0=C2=A0 'aarch64_be': 'aarch64',
>> +=C2=A0=C2=A0=C2=A0 'microblazeel': 'microblaze',
>> +=C2=A0=C2=A0=C2=A0 'mipsel': 'mips',
>> +=C2=A0=C2=A0=C2=A0 'mipsn32el' : 'mips64',
>=20
> Missing mipsn32 mapping to mips64:
>=20
> =C2=A0 mipsn32|mipsn32el)
> =C2=A0=C2=A0=C2=A0 TARGET_ARCH=3Dmips64
> =C2=A0=C2=A0=C2=A0 TARGET_BASE_ARCH=3Dmips
> =C2=A0=C2=A0=C2=A0 target_compiler=3D$cross_cc_mipsn32
> =C2=A0=C2=A0=C2=A0 echo "TARGET_ABI_MIPSN32=3Dy" >> $config_target_mak
> =C2=A0=C2=A0=C2=A0 echo "TARGET_ABI32=3Dy" >> $config_target_mak
> =C2=A0 ;;
>=20

Right!

>> +=C2=A0=C2=A0=C2=A0 'mips64el': 'mips64',
>> +=C2=A0=C2=A0=C2=A0 'or1k': 'openrisc',
>> +=C2=A0=C2=A0=C2=A0 'ppc64le': 'ppc64',
>> +=C2=A0=C2=A0=C2=A0 'ppc64abi32': 'ppc64',
>> +=C2=A0=C2=A0=C2=A0 'riscv64': 'riscv',
>=20
> riscv64 is not mapped to riscv:
>=20
> =C2=A0 riscv64)
> =C2=A0=C2=A0=C2=A0 TARGET_BASE_ARCH=3Driscv
> =C2=A0=C2=A0=C2=A0 TARGET_ABI_DIR=3Driscv
> =C2=A0=C2=A0=C2=A0 mttcg=3Dyes
> =C2=A0=C2=A0=C2=A0 target_compiler=3D$cross_cc_riscv64
> =C2=A0 ;;
>=20

Right again!

Thanks catching those mistakes!
- Cleber.

> Thanks,
> Wainer.
>=20
>> +=C2=A0=C2=A0=C2=A0 'sh4eb': 'sh4',
>> +=C2=A0=C2=A0=C2=A0 'sparc32plus': 'sparc64',
>> +=C2=A0=C2=A0=C2=A0 'xtensaeb': 'xtensa'
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +
>> =C2=A0 def is_readable_executable_file(path):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return os.path.isfile(path) and os.acce=
ss(path, os.R_OK | os.X_OK)
>> =C2=A0 @@ -29,6 +51,7 @@ def pick_default_qemu_bin():
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 directory or in the source tree root di=
rectory.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch =3D os.uname()[4]
>> +=C2=A0=C2=A0=C2=A0 arch =3D HOST_TARGET_ARCH.get(arch, arch)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_bin_relative_path =3D os.path.join=
("%s-softmmu" % arch,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "qemu-system-%s" % arch)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if is_readable_executable_file(qemu_bin=
_relative_path):
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
