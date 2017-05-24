Received: from eggs.gnu.org ([2001:4830:134:3::10]:56345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDOmL-0001U8-CU
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDOmH-00006n-B5
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:24:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dDOmH-00006b-1I
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:24:09 -0400
Date: Wed, 24 May 2017 13:24:05 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170524052405.GK12279@lemon.lan>
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170521032956.27446-4-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/24] docker: rebuild image if 'extra
 files' checksum does not match
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Sun, 05/21 00:29, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/docker/docker.py | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index eef92a54f1..0dd6a3304f 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -38,6 +38,9 @@ def _text_checksum(text):
>      """Calculate a digest string unique to the text content"""
>      return hashlib.sha1(text).hexdigest()
> =20
> +def _file_checksum(filename):
> +    return _text_checksum(open(filename, 'rb').read())
> +
>  def _guess_docker_command():
>      """ Guess a working docker command or raise exception if not found=
"""
>      commands =3D [["docker"], ["sudo", "-n", "docker"]]
> @@ -154,7 +157,7 @@ class Docker(object):
>          return labels.get("com.qemu.dockerfile-checksum", "")
> =20
>      def build_image(self, tag, docker_dir, dockerfile,
> -                    quiet=3DTrue, user=3DFalse, argv=3DNone):
> +                    quiet=3DTrue, user=3DFalse, argv=3DNone, extra_fil=
es_cksum=3D[]):
>          if argv =3D=3D None:
>              argv =3D []
> =20
> @@ -170,7 +173,7 @@ class Docker(object):
> =20
>          tmp_df.write("\n")
>          tmp_df.write("LABEL com.qemu.dockerfile-checksum=3D%s" %
> -                     _text_checksum(dockerfile))
> +                     _text_checksum(dockerfile + "-".join(extra_files_=
cksum)))

Since @dockerfile is the content of the the Dockerfile, how about concate=
nating
with "\n":

                        _text_checksum("\n".join([dockerfile] + extra_fil=
es_cksum))

?


>          tmp_df.flush()
> =20
>          self._do(["build", "-t", tag, "-f", tmp_df.name] + argv + \
> @@ -276,16 +279,22 @@ class BuildCommand(SubCommand):
>                      return 1
> =20
>              # Include files used by ADD directives found within the Do=
ckerfile.
> +            cksum =3D []
>              if args.include_executable:
> +                # FIXME: there is no checksum of this executable and t=
he linked
> +                # libraries, once the image built any change of this e=
xecutable
> +                # or any library won't trigger another build.
>                  _copy_binary_with_libs(args.include_executable, docker=
_dir)
>              for filename in args.include_files or []:
>                  _copy_with_mkdir(filename, docker_dir)
> +                cksum +=3D [_file_checksum(filename)]
> =20
>              argv +=3D ["--build-arg=3D" + k.lower() + "=3D" + v
>                          for k, v in os.environ.iteritems()
>                          if k.lower() in FILTERED_ENV_NAMES]
>              dkr.build_image(tag, docker_dir, dockerfile,
> -                            quiet=3Dargs.quiet, user=3Dargs.user, argv=
=3Dargv)
> +                            quiet=3Dargs.quiet, user=3Dargs.user, argv=
=3Dargv,
> +                            extra_files_cksum=3Dcksum)
> =20
>              rmtree(docker_dir)
> =20
> --=20
> 2.11.0
>=20
