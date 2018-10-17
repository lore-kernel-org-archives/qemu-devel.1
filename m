Received: from eggs.gnu.org ([2001:4830:134:3::10]:58671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gCnE6-0002eG-Hr
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gCnE3-0001ma-6n
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:55:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gCnE2-0001iq-NH
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:55:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B142B5F72B
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 14:55:02 +0000 (UTC)
References: <20181016232201.16829-1-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <5b8c6bcd-dfb8-3c9e-cdd3-113d771631a0@redhat.com>
Date: Wed, 17 Oct 2018 11:54:48 -0300
MIME-Version: 1.0
In-Reply-To: <20181016232201.16829-1-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Hello Cleber!

On 10/16/2018 08:22 PM, Cleber Rosa wrote:
> The host arch name is not always the target arch name, so it's
> necessary to have a mapping.
>
> The configure scripts contains what is the authoritative and failproof
> mapping, but, reusing it is not straightforward, so it's replicated in
> the acceptance tests supporting code.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   configure                                 |  2 ++
>   tests/acceptance/avocado_qemu/__init__.py | 23 ++++++++++++++++++++++=
+
>   2 files changed, 25 insertions(+)
>
> diff --git a/configure b/configure
> index 8af2be959f..e029b756d4 100755
> --- a/configure
> +++ b/configure
> @@ -6992,6 +6992,8 @@ TARGET_ARCH=3D"$target_name"
>   TARGET_BASE_ARCH=3D""
>   TARGET_ABI_DIR=3D""
>  =20
> +# When updating target_name =3D> TARGET_ARCH, please also update the
> +# HOST_TARGET_ARCH mapping in tests/acceptance/avocado_qemu/__init__.p=
y
>   case "$target_name" in
>     i386)
>       mttcg=3D"yes"
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptan=
ce/avocado_qemu/__init__.py
> index 1e54fd5932..d9bc4736ec 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -19,6 +19,28 @@ sys.path.append(os.path.join(SRC_ROOT_DIR, 'scripts'=
))
>  =20
>   from qemu import QEMUMachine
>  =20
> +
> +#: Mapping of host arch names to target arch names.  It's expected tha=
t the
> +#: arch identification on the host, using os.uname()[4], would return =
the
> +#: key (LHS).  The QEMU target name, and consequently the target binar=
y, would
> +#: be based on the name on the value (RHS).
> +HOST_TARGET_ARCH =3D {
> +    'armeb': 'arm',
> +    'aarch64_be': 'aarch64',
> +    'microblazeel': 'microblaze',
> +    'mipsel': 'mips',
> +    'mipsn32el' : 'mips64',

Missing mipsn32 mapping to mips64:

 =C2=A0 mipsn32|mipsn32el)
 =C2=A0=C2=A0=C2=A0 TARGET_ARCH=3Dmips64
 =C2=A0=C2=A0=C2=A0 TARGET_BASE_ARCH=3Dmips
 =C2=A0=C2=A0=C2=A0 target_compiler=3D$cross_cc_mipsn32
 =C2=A0=C2=A0=C2=A0 echo "TARGET_ABI_MIPSN32=3Dy" >> $config_target_mak
 =C2=A0=C2=A0=C2=A0 echo "TARGET_ABI32=3Dy" >> $config_target_mak
 =C2=A0 ;;

> +    'mips64el': 'mips64',
> +    'or1k': 'openrisc',
> +    'ppc64le': 'ppc64',
> +    'ppc64abi32': 'ppc64',
> +    'riscv64': 'riscv',

riscv64 is not mapped to riscv:

 =C2=A0 riscv64)
 =C2=A0=C2=A0=C2=A0 TARGET_BASE_ARCH=3Driscv
 =C2=A0=C2=A0=C2=A0 TARGET_ABI_DIR=3Driscv
 =C2=A0=C2=A0=C2=A0 mttcg=3Dyes
 =C2=A0=C2=A0=C2=A0 target_compiler=3D$cross_cc_riscv64
 =C2=A0 ;;

Thanks,
Wainer.

> +    'sh4eb': 'sh4',
> +    'sparc32plus': 'sparc64',
> +    'xtensaeb': 'xtensa'
> +    }
> +
> +
>   def is_readable_executable_file(path):
>       return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK=
)
>  =20
> @@ -29,6 +51,7 @@ def pick_default_qemu_bin():
>       directory or in the source tree root directory.
>       """
>       arch =3D os.uname()[4]
> +    arch =3D HOST_TARGET_ARCH.get(arch, arch)
>       qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
>                                             "qemu-system-%s" % arch)
>       if is_readable_executable_file(qemu_bin_relative_path):
