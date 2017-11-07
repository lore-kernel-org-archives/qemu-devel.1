Received: from eggs.gnu.org ([2001:4830:134:3::10]:56934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eBvFk-0003TW-Ej
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 23:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eBvFf-00081J-Eg
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 23:12:44 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:49915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eBvFf-00080S-6r
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 23:12:39 -0500
Received: by mail-pf0-x241.google.com with SMTP id i5so9378591pfe.6
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 20:12:38 -0800 (PST)
References: <20171103153333.6416-1-berrange@redhat.com>
	<20171103153333.6416-6-berrange@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <d1704cf4-d3d4-cc69-df96-1298c11e1295@ozlabs.ru>
Date: Tue, 7 Nov 2017 15:12:32 +1100
MIME-Version: 1.0
In-Reply-To: <20171103153333.6416-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] build: delay check for empty git
 submodule list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 04/11/17 02:33, Daniel P. Berrange wrote:
> We short circuit the git submodule update when passed an empty module list.
> This accidentally causes the 'status' command to write to the status file. The
> test needs to be delayed into the individual commands to avoid this premature
> writing of the status file.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  scripts/git-submodule.sh | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> index 2857fc57c4..90376a7dae 100755
> --- a/scripts/git-submodule.sh
> +++ b/scripts/git-submodule.sh
> @@ -33,12 +33,6 @@ error() {
>      exit 1
>  }
>  
> -if test -z "$maybe_modules"
> -then
> -    test -e $substat || touch $substat
> -    exit 0
> -fi
> -
>  modules=""
>  for m in $maybe_modules
>  do
> @@ -51,7 +45,7 @@ do
>      fi
>  done
>  
> -if ! test -e ".git"
> +if test -n "$maybe_modules" && ! test -e ".git"


$GIT_DIR should be checked too imho:

if test -n "$maybe_modules" && ! test -e ".git" && test "$GIT_DIR" = ""




>  then
>      echo "$0: unexpectedly called with submodules but no git checkout exists"
>      exit 1
> @@ -59,6 +53,11 @@ fi
>  
>  case "$command" in
>  status)
> +    if test -z "$maybe_modules"
> +    then
> +         test -s ${substat} && exit 1 || exit 0
> +    fi
> +
>      test -f "$substat" || exit 1
>      CURSTATUS=`$GIT submodule status $modules`
>      OLDSTATUS=`cat $substat`
> @@ -66,6 +65,12 @@ status)
>      exit $?
>      ;;
>  update)
> +    if test -z "$maybe_modules"
> +    then
> +        test -e $substat || touch $substat
> +        exit 0
> +    fi
> +
>      $GIT submodule update --init $modules 1>/dev/null
>      test $? -ne 0 && error "failed to update modules"
>  
> 


-- 
Alexey
