Received: from eggs.gnu.org ([2001:4830:134:3::10]:54838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCim3-0001Cu-RA
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCily-00023x-Sx
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:09:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gCily-00023b-M1
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:09:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id e187-v6so1538464wmf.0
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 03:09:50 -0700 (PDT)
References: <20181016232201.16829-1-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f436196c-392e-1fd8-c176-54fe514bd07e@redhat.com>
Date: Wed, 17 Oct 2018 12:09:48 +0200
MIME-Version: 1.0
In-Reply-To: <20181016232201.16829-1-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Cc: Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>

Hi Cleber,

On 17/10/2018 01:22, Cleber Rosa wrote:
> The host arch name is not always the target arch name, so it's
> necessary to have a mapping.
> 
> The configure scripts contains what is the authoritative and failproof
> mapping, but, reusing it is not straightforward, so it's replicated in
> the acceptance tests supporting code.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  configure                                 |  2 ++
>  tests/acceptance/avocado_qemu/__init__.py | 23 +++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/configure b/configure
> index 8af2be959f..e029b756d4 100755
> --- a/configure
> +++ b/configure
> @@ -6992,6 +6992,8 @@ TARGET_ARCH="$target_name"
>  TARGET_BASE_ARCH=""
>  TARGET_ABI_DIR=""
>  
> +# When updating target_name => TARGET_ARCH, please also update the
> +# HOST_TARGET_ARCH mapping in tests/acceptance/avocado_qemu/__init__.py
>  case "$target_name" in
>    i386)
>      mttcg="yes"
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> index 1e54fd5932..d9bc4736ec 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py

I'd put this in scripts/qemu.py

> @@ -19,6 +19,28 @@ sys.path.append(os.path.join(SRC_ROOT_DIR, 'scripts'))
>  
>  from qemu import QEMUMachine
>  
> +
> +#: Mapping of host arch names to target arch names.  It's expected that the
> +#: arch identification on the host, using os.uname()[4], would return the
> +#: key (LHS).  The QEMU target name, and consequently the target binary, would
> +#: be based on the name on the value (RHS).
> +HOST_TARGET_ARCH = {
> +    'armeb': 'arm',
> +    'aarch64_be': 'aarch64',

Since you add this, I'd start directly with an exhaustive list:

       'aarch64_be': {'arch': 'aarch64', 'endian': 'big', 'wordsize':
64, 'abi' = 'arm'},

> +    'microblazeel': 'microblaze',
> +    'mipsel': 'mips',
> +    'mipsn32el' : 'mips64',
> +    'mips64el': 'mips64',
> +    'or1k': 'openrisc',
> +    'ppc64le': 'ppc64',
> +    'ppc64abi32': 'ppc64',
> +    'riscv64': 'riscv',
> +    'sh4eb': 'sh4',
> +    'sparc32plus': 'sparc64',
> +    'xtensaeb': 'xtensa'
> +    }

Then a function such:

def target_normalize(key, arch):
    return table[arch][key]

> +
> +
>  def is_readable_executable_file(path):
>      return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
>  
> @@ -29,6 +51,7 @@ def pick_default_qemu_bin():
>      directory or in the source tree root directory.
>      """
>      arch = os.uname()[4]
> +    arch = HOST_TARGET_ARCH.get(arch, arch)

       arch = target_normalize('arch', os.uname()[4])

>      qemu_bin_relative_path = os.path.join("%s-softmmu" % arch,
>                                            "qemu-system-%s" % arch)
>      if is_readable_executable_file(qemu_bin_relative_path):
> 

What do you think?

Thanks,

Phil.
