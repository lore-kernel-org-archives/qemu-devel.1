Received: from eggs.gnu.org ([209.51.188.92]:49091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goobu-00086Z-2J
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goobs-0001za-El
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:04:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1goobs-0001wt-5U
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:04:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE0CEA786C
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 12:04:32 +0000 (UTC)
Date: Wed, 30 Jan 2019 12:04:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190130120422.GK15904@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190130065530.6371-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130065530.6371-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scripts: use git archive in archive-source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com

On Wed, Jan 30, 2019 at 07:55:30AM +0100, Gerd Hoffmann wrote:
> Use git archive to create tarballs of qemu and submodules instead of
> cloning the repository and the submodules.  This is a order of magnitude
> faster because it doesn't fetch the submodules from the internet each
> time the script runs.

There's another patch addressing the same problem here, which takes
the approach of 'git clone' on the submodules to avoid pulling them
from the internet each time:

  https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06588.html

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  scripts/archive-source.sh | 46 ++++++++++------------------------------------
>  1 file changed, 10 insertions(+), 36 deletions(-)
> 
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> index 6eed2a29bd..beae968f80 100755
> --- a/scripts/archive-source.sh
> +++ b/scripts/archive-source.sh
> @@ -19,8 +19,7 @@ if test $# -lt 1; then
>  fi
>  
>  tar_file=$(realpath "$1")
> -list_file="${tar_file}.list"
> -vroot_dir="${tar_file}.vroot"
> +sub_file=$(mktemp "${tar_file%.tar}.sub.XXXXXXXX.tar")
>  
>  # We want a predictable list of submodules for builds, that is
>  # independent of what the developer currently has initialized
> @@ -28,7 +27,7 @@ vroot_dir="${tar_file}.vroot"
>  # different to the host OS.
>  submodules="dtc ui/keycodemapdb tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
>  
> -trap "status=$?; rm -rf \"$list_file\" \"$vroot_dir\"; exit \$status" 0 1 2 3 15
> +trap "status=$?; rm -rf \"$sub_file\" ; exit \$status" 0 1 2 3 15
>  
>  if git diff-index --quiet HEAD -- &>/dev/null
>  then
> @@ -36,38 +35,13 @@ then
>  else
>      HEAD=$(git stash create)
>  fi
> -git clone --shared . "$vroot_dir"
> -test $? -ne 0 && error "failed to clone into '$vroot_dir'"
> -
> -cd "$vroot_dir"
> -test $? -ne 0 && error "failed to change into '$vroot_dir'"
> -
> -git checkout $HEAD
> -test $? -ne 0 && error "failed to checkout $HEAD revision"
> -
> +git archive --format tar $HEAD > "$tar_file"
> +test $? -ne 0 && error "failed to archive qemu"
>  for sm in $submodules; do
> -    git submodule update --init $sm
> -    test $? -ne 0 && error "failed to init submodule $sm"
> +	git submodule update --init "$sm"

The current archive-source.sh code is careful to not touch the
developer's current git checkout, because it runs  submodule
update in a clone'd tree. The earlier patch hunk gets rid of the
clone, so now submodule update is touching the developer's master
git checkout. IMHO this is not acceptable - running tests (which
use archive-source.sh) must never alter the developer's git checkout
status in any way.

The alternate patch mentioned above does that.

Even if we keep the git clone part, we could still usefully
switch to running git archive, instead of re-inventing it
via git ls-files + tar.

> +	test $? -ne 0 && error "failed to update submodule $sm"
> +	(cd $sm; git archive --format tar --prefix "$sm/" HEAD) > "$sub_file"
> +	test $? -ne 0 && error "failed to archive submodule $sm"
> +	tar --concatenate --file "$tar_file" "$sub_file"
> +	test $? -ne 0 && error "failed append submodule $sm to $tar_file"
>  done
> -
> -if test -n "$submodules"; then
> -    {
> -        git ls-files || error "git ls-files failed"
> -        for sm in $submodules; do
> -            (cd $sm; git ls-files) | sed "s:^:$sm/:"
> -            if test "${PIPESTATUS[*]}" != "0 0"; then
> -                error "git ls-files in submodule $sm failed"
> -            fi
> -        done
> -    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) > "$list_file"
> -else
> -    git ls-files > "$list_file"
> -fi
> -
> -if test $? -ne 0; then
> -    error "failed to generate list file"
> -fi
> -
> -tar -cf "$tar_file" -T "$list_file" || error "failed to create tar file"
> -
> -exit 0
> -- 
> 2.9.3
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
