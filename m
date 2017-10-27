Received: from eggs.gnu.org ([2001:4830:134:3::10]:44619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7vuS-0008GH-Ll
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 00:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7vuO-0000JX-EZ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 00:06:16 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:50108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e7vuO-0000GU-50
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 00:06:12 -0400
Received: by mail-pf0-x244.google.com with SMTP id i5so4044013pfe.6
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 21:06:11 -0700 (PDT)
References: <20171026130656.31067-1-berrange@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <eaf799e7-0a7d-bbc7-7b4a-d286b32666ac@ozlabs.ru>
Date: Fri, 27 Oct 2017 15:06:06 +1100
MIME-Version: 1.0
In-Reply-To: <20171026130656.31067-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] build: don't create temporary files in
 source dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 27/10/17 00:06, Daniel P. Berrange wrote:
> There are cases where users do VPATH builds with the source directory being on
> a read-only volume. In such a case they have to manually run the command
> 'git-submodule.sh ...modules...'  manually ahead of time. When checking for
> status we should not then write into the source dir.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  scripts/git-submodule.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> index c66567d409..586ff32293 100755
> --- a/scripts/git-submodule.sh
> +++ b/scripts/git-submodule.sh
> @@ -31,10 +31,10 @@ fi
>  case "$command" in
>  status)
>      test -f "$substat" || exit 1
> -    trap "rm -f ${substat}.tmp" EXIT
> -    $GIT submodule status $modules > "${substat}.tmp"
> -    test $? -ne 0 && error "failed to query git submodule status"

This does not apply on any public tree, the error message and $GIT are missing.


> -    diff "${substat}" "${substat}.tmp" >/dev/null
> +    substat_tmp=$(mktemp)
> +    trap "rm -f ${substat_tmp}" EXIT
> +    $GIT submodule status $modules > "${substat_tmp}"
> +    diff "${substat}" "${substat_tmp}" >/dev/null
>      exit $?
>      ;;
>  update)
> 


-- 
Alexey
