Received: from eggs.gnu.org ([2001:4830:134:3::10]:38098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCobr-0007pH-9D
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCobn-00013l-Mg
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:23:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gCobn-0000zU-BF
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:23:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50F1A30832E9
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 16:23:42 +0000 (UTC)
References: <20181016232201.16829-1-crosa@redhat.com>
	<f436196c-392e-1fd8-c176-54fe514bd07e@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <e6de9e3b-e64b-fb92-915f-55b036d22053@redhat.com>
Date: Wed, 17 Oct 2018 12:23:34 -0400
MIME-Version: 1.0
In-Reply-To: <f436196c-392e-1fd8-c176-54fe514bd07e@redhat.com>
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Cc: Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>



On 10/17/18 6:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Cleber,
>=20
> On 17/10/2018 01:22, Cleber Rosa wrote:
>> The host arch name is not always the target arch name, so it's
>> necessary to have a mapping.
>>
>> The configure scripts contains what is the authoritative and failproof
>> mapping, but, reusing it is not straightforward, so it's replicated in
>> the acceptance tests supporting code.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  configure                                 |  2 ++
>>  tests/acceptance/avocado_qemu/__init__.py | 23 ++++++++++++++++++++++=
+
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/configure b/configure
>> index 8af2be959f..e029b756d4 100755
>> --- a/configure
>> +++ b/configure
>> @@ -6992,6 +6992,8 @@ TARGET_ARCH=3D"$target_name"
>>  TARGET_BASE_ARCH=3D""
>>  TARGET_ABI_DIR=3D""
>> =20
>> +# When updating target_name =3D> TARGET_ARCH, please also update the
>> +# HOST_TARGET_ARCH mapping in tests/acceptance/avocado_qemu/__init__.=
py
>>  case "$target_name" in
>>    i386)
>>      mttcg=3D"yes"
>> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/accepta=
nce/avocado_qemu/__init__.py
>> index 1e54fd5932..d9bc4736ec 100644
>> --- a/tests/acceptance/avocado_qemu/__init__.py
>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>=20
> I'd put this in scripts/qemu.py
>=20

I chose avocado_qemu/__init__.py because this mapping is currently of no
use to scripts/qemu.py.

But, I'm fine with moving it to scripts/qemu.py if most people agree.

>> @@ -19,6 +19,28 @@ sys.path.append(os.path.join(SRC_ROOT_DIR, 'scripts=
'))
>> =20
>>  from qemu import QEMUMachine
>> =20
>> +
>> +#: Mapping of host arch names to target arch names.  It's expected th=
at the
>> +#: arch identification on the host, using os.uname()[4], would return=
 the
>> +#: key (LHS).  The QEMU target name, and consequently the target bina=
ry, would
>> +#: be based on the name on the value (RHS).
>> +HOST_TARGET_ARCH =3D {
>> +    'armeb': 'arm',
>> +    'aarch64_be': 'aarch64',
>=20
> Since you add this, I'd start directly with an exhaustive list:
>=20
>        'aarch64_be': {'arch': 'aarch64', 'endian': 'big', 'wordsize':
> 64, 'abi' =3D 'arm'},
>=20

Forgive my lack of QEMU culture, but the modus operandi I've been
following is to start with the simplest possible approach, as
justifiable by an existing requirement.

TBH, I lack knowledge about an use case for these other fields.

>> +    'microblazeel': 'microblaze',
>> +    'mipsel': 'mips',
>> +    'mipsn32el' : 'mips64',
>> +    'mips64el': 'mips64',
>> +    'or1k': 'openrisc',
>> +    'ppc64le': 'ppc64',
>> +    'ppc64abi32': 'ppc64',
>> +    'riscv64': 'riscv',
>> +    'sh4eb': 'sh4',
>> +    'sparc32plus': 'sparc64',
>> +    'xtensaeb': 'xtensa'
>> +    }
>=20
> Then a function such:
>=20
> def target_normalize(key, arch):
>     return table[arch][key]
>=20
>> +
>> +
>>  def is_readable_executable_file(path):
>>      return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK=
)
>> =20
>> @@ -29,6 +51,7 @@ def pick_default_qemu_bin():
>>      directory or in the source tree root directory.
>>      """
>>      arch =3D os.uname()[4]
>> +    arch =3D HOST_TARGET_ARCH.get(arch, arch)
>=20
>        arch =3D target_normalize('arch', os.uname()[4])
>=20
>>      qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
>>                                            "qemu-system-%s" % arch)
>>      if is_readable_executable_file(qemu_bin_relative_path):
>>
>=20
> What do you think?
>=20

Python dictionaries are so rich that can and are encouraged to be used
in place of such functions and even "switch/case" constructs.  I would
add such a function only if there's extra logic no present in a dict.

Since we're more or less building a coding style here, it'd be useful to
hear what other people think.

Thanks for the review!
- Cleber.

> Thanks,
>=20
> Phil.
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
