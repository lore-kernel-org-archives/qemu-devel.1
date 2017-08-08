Received: from eggs.gnu.org ([2001:4830:134:3::10]:59609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1detYG-0002QO-1d
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 21:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1detYB-0001gH-7M
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 21:43:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1detYB-0001f9-0G
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 21:43:15 -0400
Date: Tue, 8 Aug 2017 09:43:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170808014310.GP14780@lemon>
References: <20170807153934.29477-1-alex.bennee@linaro.org>
	<20170807153934.29477-5-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170807153934.29477-5-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 v3 4/6] docker: docker.py make
 --no-cache skip checksum test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Mon, 08/07 16:39, Alex Benn=E9e wrote:
> If you invoke with NOCACHE=3D1 we pass --no-cache in the argv to
> docker.py but may still not force a rebuild if the dockerfile checksum
> hasn't changed. By testing for its presence we can force builds
> without having to manually remove the docker image.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  tests/docker/docker.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index ee40ca04d9..aab1648cc5 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -261,7 +261,8 @@ class BuildCommand(SubCommand):
>          tag =3D args.tag
> =20
>          dkr =3D Docker()
> -        if dkr.image_matches_dockerfile(tag, dockerfile):
> +        if "--no-cache" not in argv and \
> +           dkr.image_matches_dockerfile(tag, dockerfile):
>              if not args.quiet:
>                  print "Image is up to date."
>          else:
> --=20
> 2.13.0
>=20
>=20

NACK.

Please add "--no-cache" to BuildCommand.args, and use args.no_cache.

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index ee40ca04d9..530bc62d40 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -251,6 +251,8 @@ class BuildCommand(SubCommand):
         parser.add_argument("--add-current-user", "-u", dest=3D"user",
                             action=3D"store_true",
                             help=3D"Add the current user to image's pass=
wd")
+        parser.add_argument("--no-cache", action=3D"store_true",
+                            help=3D"Disable docker cache and checksum")
         parser.add_argument("tag",
                             help=3D"Image Tag")
         parser.add_argument("dockerfile",
