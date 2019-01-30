Received: from eggs.gnu.org ([209.51.188.92]:37404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gorXA-0002u0-MS
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gorX7-0006sV-J8
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:12:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53737)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gorX3-0006kc-QP
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:12:07 -0500
Date: Wed, 30 Jan 2019 15:11:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190130151154.GS15904@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190125140017.6092-1-alex.bennee@linaro.org>
	<20190125140017.6092-5-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190125140017.6092-5-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 04/14] archive-source.sh: Clone the
 submodules locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

On Fri, Jan 25, 2019 at 02:00:07PM +0000, Alex Benn=C3=A9e wrote:
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> We cloned the QEMU repository from the local storage. Since the
> submodules are also available there, clone them too. This is
> quicker and reduce network use.

FYI there's another attempt at solving it here:

  https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg07710.html

though that has some problems, so I prefer what you've done
here.  There's still scope for replacing the git ls-tree + tar
command with a git archive command, but that's tangential to
the problem of reducing network usage.

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  scripts/archive-source.sh | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> index 6eed2a29bd..ce31be67b0 100755
> --- a/scripts/archive-source.sh
> +++ b/scripts/archive-source.sh
> @@ -38,6 +38,10 @@ else
>  fi
>  git clone --shared . "$vroot_dir"
>  test $? -ne 0 && error "failed to clone into '$vroot_dir'"
> +for sm in $submodules; do
> +    git clone --shared "$sm" "$vroot_dir/$sm"
> +    test $? -ne 0 && error "failed to clone submodule $sm"
> +done

I don't think this is reliable. Notice the message further up
where we define $submodules

  # We want a predictable list of submodules for builds, that is
  # independent of what the developer currently has initialized
  # in their checkout, because the build environment is completely
  # different to the host OS.


IOW, if the developers host build does not require 'dtc', then
the 'dtc' directory will be an empty directory, not a git
submodule checkout. At which point "git clone" has nothing
available.

Second, even if 'dtc' is checked out, we can't assume that
it is checked out at the right commit hash - 'git clone' will
match whatever is currently checked out.

So this needs to be wrapped

   if test -d "$sm/.git"
   then
       git clone --shared "$sm" "$vroot_dir/$sm"
       test $? -ne 0 && error "failed to clone submodule $sm"
   fi


> =20
>  cd "$vroot_dir"
>  test $? -ne 0 && error "failed to change into '$vroot_dir'"
> @@ -45,11 +49,6 @@ test $? -ne 0 && error "failed to change into '$vroo=
t_dir'"
>  git checkout $HEAD
>  test $? -ne 0 && error "failed to checkout $HEAD revision"
> =20
> -for sm in $submodules; do
> -    git submodule update --init $sm
> -    test $? -ne 0 && error "failed to init submodule $sm"
> -done

This should not be deleted. It ensures that the checkout we
just cloned gets moved to the correct HEAD. It might still
use the network, but that is genuinely neccessary in some
cases. At least the network usage will be minimized if the
developers host already had an updated submodule set.

> -
>  if test -n "$submodules"; then
>      {
>          git ls-files || error "git ls-files failed"


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
