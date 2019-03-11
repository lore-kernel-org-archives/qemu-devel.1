Received: from eggs.gnu.org ([209.51.188.92]:39159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3IMh-0008Eu-UC
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3IMg-0000nT-O0
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:41:03 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:34345)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h3IMg-0000mE-Ar
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:41:02 -0400
References: <20190311101428.GA11@765644dd90e5>
	<20190311102659.GB16@765644dd90e5>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e088c9f2-6042-c770-fec1-d9d686d905c3@vivier.eu>
Date: Mon, 11 Mar 2019 11:40:42 +0100
MIME-Version: 1.0
In-Reply-To: <20190311102659.GB16@765644dd90e5>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/10] qemu-binfmt-conf.sh: add
 QEMU_CREDENTIAL and QEMU_PERSISTENT
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

On 11/03/2019 11:26, Unai Martinez-Corral wrote:
> Allow to set options '--persistent' and/or '--credential' through
> environment variables. If not defined, defaults are used ('no').
> Anyway, command-line arguments have priority over environment variables.
> 
> Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
> ---
>  scripts/qemu-binfmt-conf.sh | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index ca15ff8092..e7a714e22c 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -186,9 +186,11 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
>                        (default: $SYSTEMDDIR or $DEBIANDIR)
>         --credential:  if present, credential and security tokens are
>                        calculated according to the binary to interpret
> +                      ($QEMU_CREDENTIAL=yes)
>         --persistent:  if present, the interpreter is loaded when binfmt is
>                        configured and remains in memory. All future uses
>                        are cloned from the open file.
> +                      ($QEMU_PERSISTENT=yes)
> 
>      To import templates with update-binfmts, use :
> 
> @@ -255,10 +257,10 @@ qemu_check_systemd() {
> 
>  qemu_generate_register() {
>      flags=""
> -    if [ "x$CREDENTIAL" = "xyes" ] ; then
> +    if [ "x$QEMU_CREDENTIAL" = "xyes" ] ; then
>          flags="OC"
>      fi
> -    if [ "x$PERSISTENT" = "xyes" ] ; then
> +    if [ "x$QEMU_PERSISTENT" = "xyes" ] ; then
>          flags="${flags}F"
>      fi
> 
> @@ -281,7 +283,7 @@ package qemu-$cpu
>  interpreter $qemu
>  magic $magic
>  mask $mask
> -credential $CREDENTIAL
> +credential $QEMU_CREDENTIAL
>  EOF
>  }
> 
> @@ -320,8 +322,10 @@ SYSTEMDDIR="/etc/binfmt.d"
>  DEBIANDIR="/usr/share/binfmts"
> 
>  QEMU_PATH=/usr/local/bin
> -CREDENTIAL=no
> -PERSISTENT=no
> +
> +QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
> +QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"
> +
>  QEMU_SUFFIX=""
> 
>  options=$(getopt -o ds:Q:S:e:hcp -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential,persistent -- "$@")
> @@ -373,10 +377,10 @@ while true ; do
>          exit 1
>          ;;
>      -c|--credential)
> -        CREDENTIAL="yes"
> +        QEMU_CREDENTIAL="yes"
>          ;;
>      -p|--persistent)
> -        PERSISTENT="yes"
> +        QEMU_PERSISTENT="yes"
>          ;;
>      *)
>          break
> --
> 2.21.0
> 
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
