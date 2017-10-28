Received: from eggs.gnu.org ([2001:4830:134:3::10]:38634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e8Fuq-0005Bv-Tc
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 21:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e8Ful-0008IJ-Ue
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 21:28:00 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:56709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e8Ful-0008HZ-Lf
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 21:27:55 -0400
Received: by mail-pg0-x241.google.com with SMTP id m18so6490077pgd.13
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 18:27:55 -0700 (PDT)
References: <20171027131412.18830-1-berrange@redhat.com>
	<20171027131412.18830-5-berrange@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f440be99-e1dc-267f-50fd-52d03533f62a@ozlabs.ru>
Date: Sat, 28 Oct 2017 12:27:49 +1100
MIME-Version: 1.0
In-Reply-To: <20171027131412.18830-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] build: don't fail if given a git
 submodule which does not exist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>

On 28/10/17 00:14, Daniel P. Berrange wrote:
> If going back in time in git history, across a commit that introduces a new
> submodule, the 'git-submodule.sh' script will fail, causing rebuild to fail.
> 
> This is because config-host.mak contains a GIT_SUBMODULES variable that lists
> a submodule that only exists in the later commit. config-host.mak won't get
> repopulated until config.status is invoked, but make won't get this far due to
> the submodule error.
> 
> This change makes 'git-submodule.sh' check whether each module is known to git
> and drops any which are not present. A warning message will be printed when any
> submodule is dropped in this manner.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  scripts/git-submodule.sh | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> index 30fd83db55..60b3b9bdeb 100755
> --- a/scripts/git-submodule.sh
> +++ b/scripts/git-submodule.sh
> @@ -7,7 +7,7 @@ substat=".git-submodule-status"
>  
>  command=$1
>  shift
> -modules="$@"
> +maybe_modules="$@"
>  
>  test -z "$GIT" && GIT=git
>  
> @@ -16,12 +16,24 @@ error() {
>      exit 1
>  }
>  
> -if test -z "$modules"
> +if test -z "$maybe_modules"
>  then
>      test -e $substat || touch $substat
>      exit 0
>  fi
>  
> +modules=""
> +for m in $maybe_modules
> +do
> +    $GIT submodule status $m 1> /dev/null 2>&1
> +    if test $? == 0


./scripts/git-submodule.sh: 29: test: 0: unexpected operator

This helps:

-    if test $? == 0
+    if test "$?" -eq "0"



> +    then
> +        modules="$modules $m"
> +    else
> +        echo "warn: ignoring non-existant submodule $m"
> +    fi
> +done
> +
>  if ! test -e ".git"
>  then
>      echo "$0: unexpectedly called with submodules but no git checkout exists"
> 


-- 
Alexey
