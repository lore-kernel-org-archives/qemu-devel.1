Received: from eggs.gnu.org ([2001:4830:134:3::10]:46142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7hC1-0002Ts-22
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7hBx-0003ij-CU
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:23:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21933)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e7hBx-0003hi-5t
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:23:21 -0400
Date: Thu, 26 Oct 2017 13:23:16 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171026122316.GC10055@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171026013445.45605-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171026013445.45605-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v2] git-submodule.sh: Do not try
 writing to source directory if not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org

On Thu, Oct 26, 2017 at 12:34:45PM +1100, Alexey Kardashevskiy wrote:
> The new git-submodule.sh script writes .git-submodule-status to
> the source directory every time no matter what. This makes it conditional.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * fixed "status" branch too
> ---
>  scripts/git-submodule.sh | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> index d8fbc7e47e..ae038d2e58 100755
> --- a/scripts/git-submodule.sh
> +++ b/scripts/git-submodule.sh
> @@ -23,16 +23,21 @@ then
>      exit 1
>  fi
>  
> +substat_tmp=$(mktemp)
> +
>  case "$command" in
>  status)
>      test -f "$substat" || exit 1
> -    trap "rm -f ${substat}.tmp" EXIT

I don't see a need to change this to run a rm later - it is fine as is.

> -    git submodule status $modules > "${substat}.tmp"
> -    diff "${substat}" "${substat}.tmp" >/dev/null
> -    exit $?
> +    git submodule status $modules > "$substat_tmp"
> +    diff "${substat_tmp}" "${substat}" > /dev/null
>      ;;
>  update)
>      git submodule update --init $modules 1>/dev/null 2>&1
> -    git submodule status $modules > "${substat}"
> +    git submodule status $modules > "$substat_tmp"
> +    diff "${substat_tmp}" "${substat}" || mv "${substat_tmp}" "${substat}"
>      ;;

This update command doesn't need changing - it is fine as it exists
already. Once the status command is fix, the update command will never
be run when the submodules are already up2date. 


Essentially all we need is this

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 08932a35f0..67a33e5d79 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -26,9 +26,10 @@ fi
 case "$command" in
 status)
     test -f "$substat" || exit 1
-    trap "rm -f ${substat}.tmp" EXIT
-    git submodule status $modules > "${substat}.tmp"
-    diff "${substat}" "${substat}.tmp" >/dev/null
+    substat_tmp=$(mktemp)
+    trap "rm -f ${substat_tmp}" EXIT
+    git submodule status $modules > "${substat_tmp}"
+    diff "${substat}" "${substat_tmp}" >/dev/null
     exit $?
     ;;
 update)


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
