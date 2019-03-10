Received: from eggs.gnu.org ([209.51.188.92]:60109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h32CZ-0003ue-Un
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 13:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h32CY-0002jA-UJ
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 13:25:31 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:59721)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h32CY-0002ci-Gf
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 13:25:30 -0400
References: <20190306031221.GA53@03612eec87fc>
	<20190306045508.GJ75@03612eec87fc>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <5b17cc79-33a2-8747-d3bc-581a69074ca8@vivier.eu>
Date: Sun, 10 Mar 2019 18:25:11 +0100
MIME-Version: 1.0
In-Reply-To: <20190306045508.GJ75@03612eec87fc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 10/10] qemu-binfmt-conf.sh: support
 QEMU_TARGETS
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

On 06/03/2019 05:55, Unai Martinez-Corral wrote:
> Rename CPUS to TARGETS, and support QEMU_TARGETS environment variable.
> This does not break backward compatibility, because it is just a placeholder.
> 
> Consistently with 'path', 'suffix', 'persistent' and 'credential',
> provide an environment variable to set the list of target architectures.
> The supported formats are the same as for positional arguments, which have
> priority. If both the variable and the list of positional arguments are empty,
> defaults to 'ALL'.
> 
> Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
> ---
>  scripts/qemu-binfmt-conf.sh | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 8ca2647ed0..0676f86512 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -6,7 +6,7 @@ mips mipsel mipsn32 mipsn32el mips64 mips64el \
>  sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb \
>  microblaze microblazeel or1k x86_64"
> 
> -# check if given target CPUS is/are in the supported target list
> +# check if given TARGETS is/are in the supported target list
>  qemu_check_target_list() {
>      all="$qemu_target_list"
>      if [ "x$1" = "xALL" ] ; then
> @@ -199,12 +199,12 @@ usage() {
>      cat <<EOF
>  Usage: qemu-binfmt-conf.sh [--help][--path PATH][--suffix SUFFIX]
>                             [--persistent][--credential][--exportdir PATH]
> -                           [--reset ARCHS][--systemd][--debian][CPUS]
> +                           [--reset ARCHS][--systemd][--debian][TARGETS]
> 
> -    Configure binfmt_misc to use qemu interpreter for the given CPUS.
> -    Supported formats for CPUS are: single arch or comma/space separated list.
> -    See QEMU target list below. If CPUS is 'ALL' or empty, configure all known
> -    cpus. If CPUS is 'NONE', no interpreter is configured.
> +    Configure binfmt_misc to use qemu interpreter for the given TARGETS.
> +    Supported formats for TARGETS are: single arch or comma/space separated list.
> +    See QEMU target list below. If TARGETS is 'ALL' or empty, configure all known
> +    TARGETS. If TARGETS is 'NONE', no interpreter is configured.
> 
>      --help:        display this usage.
>      --path:        set path to qemu interpreter.
> @@ -244,6 +244,7 @@ Usage: qemu-binfmt-conf.sh [--help][--path PATH][--suffix SUFFIX]
>        QEMU_SUFFIX=
>        QEMU_PERSISTENT=no
>        QEMU_CREDENTIAL=no
> +      QEMU_TARGETS=

         QEMU_TARGETS=$QEMU_TARGETS

> 
>  EOF
>  }
> @@ -324,17 +325,17 @@ EOF
>  }
> 
>  qemu_set_binfmts() {
> -    if [ "x$1" = "xNONE" ] ; then
> -      return
> -    fi
> -
>      # probe cpu type
>      host_family=$(qemu_get_family)
> 
>      # reduce the list of target interpreters to those given in the CLI
> -    targets="$@"
>      if [ $# -eq 0 ] ; then
> -      targets="ALL"
> +      targets="${QEMU_TARGETS:-ALL}"
> +    else
> +      if [ "x$1" = "xNONE" ] ; then

In fact, I think it would be cleaner to have a "--dry-run" option
instead (something setting BINFMT_SET to ':' I think)

Thanks,
Laurent
