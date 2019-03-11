Received: from eggs.gnu.org ([209.51.188.92]:42302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3Ie2-0005qY-0A
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3IRZ-0003wX-Gw
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:46:06 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:51705)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h3IRZ-0003ui-3w
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:46:05 -0400
References: <20190311101428.GA11@765644dd90e5>
	<20190311103207.GI16@765644dd90e5>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <84a11265-59ea-4c06-12df-6f2c54927e7f@vivier.eu>
Date: Mon, 11 Mar 2019 11:45:40 +0100
MIME-Version: 1.0
In-Reply-To: <20190311103207.GI16@765644dd90e5>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 10/10] qemu-binfmt-conf.sh: add
 --test|--dry-run
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

On 11/03/2019 11:32, Unai Martinez-Corral wrote:
> Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
> ---
>  scripts/qemu-binfmt-conf.sh | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index a516181a3a..db85798e76 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -196,8 +196,7 @@ Options and associated environment variables:
> 
>  Argument             Env-variable     Description
>  TARGETS              QEMU_TARGETS     A single arch name or a list of them (see all names below);
> -                                      if empty, configure/clear all known targets;
> -                                      if 'NONE', no interpreter is configured.
> +                                      if empty, configure/clear all known targets.
>  -h|--help                             display this usage
>  -Q|--path PATH:      QEMU_PATH        set path to qemu interpreter(s)
>  -F|--suffix SUFFIX:  QEMU_SUFFIX      add a suffix to the default interpreter name
> @@ -209,6 +208,8 @@ TARGETS              QEMU_TARGETS     A single arch name or a list of them (see
>                       SYSTEMDDIR
>  -c|--clear:          QEMU_CLEAR       (yes) remove registered interpreters for target TARGETS;
>                                        then exit.
> +-t|--test|--dry-run: QEMU_TEST        (yes) test the setup with the provided arguments, but do not
> +                                      configure any of the interpreters.
>  -s|--systemd:                         don't write into /proc, generate file(s) for
>                                        systemd-binfmt.service; environment variable HOST_ARCH
>                                        allows to override 'uname' to generate configuration files
> @@ -222,6 +223,7 @@ QEMU_SUFFIX=$QEMU_SUFFIX
>  QEMU_PERSISTENT=$QEMU_PERSISTENT
>  QEMU_CREDENTIAL=$QEMU_CREDENTIAL
>  QEMU_CLEAR=$QEMU_CLEAR
> +QEMU_TEST=$QEMU_TEST
> 
>  To import templates with update-binfmts, use :
> 
> @@ -317,9 +319,6 @@ qemu_set_binfmts() {
> 
>      # reduce the list of target interpreters to those given in the CLI
>      [ $# -eq 0 ] && targets="${QEMU_TARGETS:-}" || targets="$@"
> -    if [ "x$targets" = "xNONE" ] ; then
> -      return
> -    fi
>      qemu_check_target_list $targets
> 
>      # register the interpreter for each target except for the native one
> @@ -376,12 +375,16 @@ QEMU_SUFFIX="${QEMU_SUFFIX:-}"
>  QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"
>  QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
>  QEMU_CLEAR="${QEMU_CLEAR:-no}"
> +QEMU_TEST="${QEMU_TEST:-no}"
> 
> -options=$(getopt -o cdsQ:S:e:hcp -l clear,debian,systemd,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
> +options=$(getopt -o tcdsQ:S:e:hcp -l test,dry-runclear,debian,systemd,path:,suffix:,exportdir:,help,credential,persistent -- "$@")

missing comma here.

>  eval set -- "$options"
> 
>  while true ; do
>      case "$1" in
> +    -t|--test|--dry-run)

We don't need multiple parameter for the same effect. You must choose
between --test and --dry-run.

> +      QEMU_TEST="yes"
> +    ;;
>      -c|--clear)
>          QEMU_CLEAR="yes"
>          ;;
> @@ -438,4 +441,10 @@ if [ "x$QEMU_CLEAR" = "xyes" ] ; then
>    exit
>  fi
> 
> +if [ "x$QEMU_TEST" = "xyes" ] ; then
> +    skip(){
> +    :;}
> +    BINFMT_SET=skip

Why do you need a function?
Can't you set directly BINFMT_SET to ':'?

Thanks,
Laurent
