Received: from eggs.gnu.org ([2001:4830:134:3::10]:55472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1faOd2-0004Gz-SH
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1faOcy-0004Ge-IN
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:58:12 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45683)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1faOcy-0004Fz-8d
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:58:08 -0400
References: <20180703160022.10705-1-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bd71ddfb-1f94-605a-ac94-bd372d34bddd@vivier.eu>
Date: Tue, 3 Jul 2018 18:57:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180703160022.10705-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] scripts/qemu-binfmt-conf.sh: allow
 clearing of entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 03/07/2018 à 18:00, Alex Bennée a écrit :
> Currently running the script twice will fail with "sh: echo: I/O
> error" as the registration is already complete. Add a new option
> --clear to reset the entries to save the user doing it by hand.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  scripts/qemu-binfmt-conf.sh | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index d7eefda0b8..13ef4713e6 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -160,7 +160,7 @@ qemu_get_family() {
>  usage() {
>      cat <<EOF
>  Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
> -                           [--help][--credential yes|no][--exportdir PATH]
> +                           [--help][--clear][--credential yes|no][--exportdir PATH]
>  
>         Configure binfmt_misc to use qemu interpreter
>  
> @@ -176,6 +176,7 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
>                       (default: $SYSTEMDDIR or $DEBIANDIR)
>         --credential: if yes, credential and security tokens are
>                       calculated according to the binary to interpret
> +       --clear:      clear existing qemu binfmt registrations
>  
>      To import templates with update-binfmts, use :
>  
> @@ -249,6 +250,13 @@ qemu_register_interpreter() {
>      qemu_generate_register > /proc/sys/fs/binfmt_misc/register
>  }
>  
> +qemu_clear_interpreter() {
> +    if [ -e /proc/sys/fs/binfmt_misc/qemu-$cpu ]; then

You should use qemu_check_access()

> +        echo "Removing qemu-$cpu as binfmt interpreter for $cpu"
> +        echo -1 > /proc/sys/fs/binfmt_misc/qemu-$cpu
> +    fi
> +}
> +
>  qemu_generate_systemd() {
>      echo "Setting $qemu as binfmt interpreter for $cpu for systemd-binfmt.service"
>      qemu_generate_register > "$EXPORTDIR/qemu-$cpu.conf"
> @@ -302,7 +310,7 @@ DEBIANDIR="/usr/share/binfmts"
>  QEMU_PATH=/usr/local/bin
>  FLAGS=""
>  
> -options=$(getopt -o ds:Q:e:hc: -l debian,systemd:,qemu-path:,exportdir:,help,credential: -- "$@")
> +options=$(getopt -o ds:Q:e:hc: -l debian,systemd:,qemu-path:,exportdir:,help,clear,credential: -- "$@")
>  eval set -- "$options"
>  
>  while true ; do
> @@ -354,6 +362,10 @@ while true ; do
>              FLAGS=""
>          fi
>          ;;
> +    --clear)
> +        shift
> +        BINFMT_SET=qemu_clear_interpreter
> +        ;;
>      *)
>          break
>          ;;
> 

if you use --debian or --systemd, you don't have the problem because
update-binfmts and systemd-binfmt.service update /proc from the
generated files for you.

But you're right there is no command to undo what we have done.
You manage only the /proc case, I think it would be also useful to
remove the files from $EXPORTDIR.

So could you also manage something like "--debian --clear" and
"--systemd CPU --clear"?

Thanks,
Laurent
