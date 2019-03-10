Received: from eggs.gnu.org ([209.51.188.92]:57555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h31qs-0005pC-GX
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 13:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h31qr-0007ef-9v
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 13:03:06 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:50181)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h31qq-0007dH-Tu
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 13:03:05 -0400
References: <20190306031221.GA53@03612eec87fc>
	<20190306045019.GF75@03612eec87fc>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <63800576-160f-a104-ede7-ca0fd2386bd9@vivier.eu>
Date: Sun, 10 Mar 2019 18:02:37 +0100
MIME-Version: 1.0
In-Reply-To: <20190306045019.GF75@03612eec87fc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 6/10] qemu-binfmt-conf.sh: generalize
 <CPU> to positional <CPUS>
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, eblake@redhat.com

On 06/03/2019 05:50, Unai Martinez-Corral wrote:
> This breaks brackward compatibility.
> 
> Option '--systemd CPU' allows to register binfmt interpreters for a
> single target architecture or for 'ALL' (of them). This patch
> generalizes the approach to support it in any mode (default, '--debian'
> or '--systemd'). To do so, option 'systemd' is changed to be boolean
> (no args). Then, all the positional arguments are considered to be a
> list of target architectures.
> 
> The list can be separated by spaces, tabs, newlines or commas. If no

I think it would be simpler to not manage commas, and to use the default
field separator.

> positional argument is provided, or when it is 'ALL', all of the
> architectures in qemu_target_list are registered.
> 
> Conversely, argument value 'NONE' allows to make a 'dry run' of the
> script. I.e., checks are executed according to the mode, but no
> interpreter is registered.
> 
> Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
> ---
>  scripts/qemu-binfmt-conf.sh | 92 +++++++++++++++++++++++--------------
>  1 file changed, 57 insertions(+), 35 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index c113ff131e..2751363089 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -6,6 +6,36 @@ mips mipsel mipsn32 mipsn32el mips64 mips64el \
>  sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb \
>  microblaze microblazeel or1k x86_64"
> 
> +# check if given target CPUS is/are in the supported target list
> +qemu_check_target_list() {
> +    all="$qemu_target_list"

Why do you need to introduce a new variable "all", you can use directly
"qemu_target_list".

> +    if [ "x$1" = "xALL" ] ; then
> +      checked_target_list="$all"
> +      return
> +    fi
> +    list=""

No need to introduce a new variable, you can use directly
checked_target_list

> +    bIFS="$IFS"
> +    IFS=$"$IFS",

Keep it simple, don't manage comma.

> +    for target ; do
> +        unknown_target="true"
> +        for cpu in $all ; do

Use directly "qemu_target_list"

> +            if [ "x$cpu" = "x$target" ] ; then
> +                list="$list $target"
> +                unknown_target="false"
> +                break
> +            fi
> +        done
> +        if [ "$unknown_target" = "true" ] ; then

You don't need a new variable, you can check "x$cpu" = "x$target" to
know if you have found the target.

> +            IFS="$bIFS"
> +            echo "ERROR: unknown CPU \"$target\"" 1>&2
> +            usage
> +            exit 1
> +        fi
> +    done
> +    IFS="$bIFS"
> +    checked_target_list="$list"
> +}
> +
>  i386_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x03\x00'
>  i386_mask='\xff\xff\xff\xff\xff\xfe\xfe\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
>  i386_family=i386
> @@ -167,11 +197,14 @@ qemu_get_family() {
> 
>  usage() {
>      cat <<EOF
> -Usage: qemu-binfmt-conf.sh [--path PATH][--debian][--systemd CPU]
> +Usage: qemu-binfmt-conf.sh [--path PATH][--debian][--systemd]
>                             [--help][--credential][--exportdir PATH]
> -                           [--persistent][--suffix SUFFIX]
> +                           [--persistent][--suffix SUFFIX][CPUS]
> 
> -       Configure binfmt_misc to use qemu interpreter
> +       Configure binfmt_misc to use qemu interpreter for the given CPUS.
> +       Supported formats for CPUS are: single arch or comma/space separated list.
> +       See QEMU target list below. If CPUS is 'ALL' or empty, configure all known
> +       cpus. If CPUS is 'NONE', no interpreter is configured.
> 
>         --help:        display this usage
>         --path:        set path to qemu interpreter ($QEMU_PATH)
> @@ -180,9 +213,10 @@ Usage: qemu-binfmt-conf.sh [--path PATH][--debian][--systemd CPU]
>         --debian:      don't write into /proc,
>                        instead generate update-binfmts templates
>         --systemd:     don't write into /proc,
> -                      instead generate file for systemd-binfmt.service
> -                      for the given CPU. If CPU is "ALL", generate a
> -                      file for all known cpus
> +                      instead generate file for systemd-binfmt.service;
> +                      environment variable HOST_ARCH allows to override 'uname'
> +                      to generate configuration files for a different
> +                      architecture than the current one.
>         --exportdir:   define where to write configuration files
>                        (default: $SYSTEMDDIR or $DEBIANDIR)
>         --credential:  if present, credential and security tokens are
> @@ -201,14 +235,7 @@ Usage: qemu-binfmt-conf.sh [--path PATH][--debian][--systemd CPU]
> 
>          sudo update-binfmts --package qemu-CPU --remove qemu-CPU $QEMU_PATH
> 
> -    With systemd, binfmt files are loaded by systemd-binfmt.service
> -
> -    The environment variable HOST_ARCH allows to override 'uname' to generate
> -    configuration files for a different architecture than the current one.
> -
> -    where CPU is one of:
> -
> -        $qemu_target_list
> +    QEMU target list: $qemu_target_list
> 
>  EOF
>  }
> @@ -289,12 +316,22 @@ EOF
>  }
> 
>  qemu_set_binfmts() {
> +    if [ "x$1" = "xNONE" ] ; then
> +      return
> +    fi
> +
>      # probe cpu type
>      host_family=$(qemu_get_family)
> 
> +    # reduce the list of target interpreters to those given in the CLI
> +    targets="$@"
> +    if [ $# -eq 0 ] ; then
> +      targets="ALL"
> +    fi
> +    qemu_check_target_list $targets
> +
>      # register the interpreter for each cpu except for the native one
> -
> -    for cpu in ${qemu_target_list} ; do
> +    for cpu in $checked_target_list ; do
>          magic=$(eval echo \$${cpu}_magic)
>          mask=$(eval echo \$${cpu}_mask)
>          family=$(eval echo \$${cpu}_family)
> @@ -327,7 +364,7 @@ QEMU_SUFFIX="${QEMU_SUFFIX:-}"
>  QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
>  QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"
> 
> -options=$(getopt -o ds:Q:S:e:hcp -l debian,systemd:,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
> +options=$(getopt -o :dsQ:S:e:hcp -l debian,systemd,path:,suffix:,exportdir:,help,credential,persistent -- "$@")

I think you don't need to add the ":" at the beginning of the list.

Thanks,
Laurent
