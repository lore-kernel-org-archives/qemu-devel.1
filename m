Received: from eggs.gnu.org ([2001:4830:134:3::10]:56261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f9LTO-0006uy-5V
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f9LTK-0003cd-Vr
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:08:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48774 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f9LTK-0003bw-QI
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:08:22 -0400
Date: Fri, 20 Apr 2018 10:08:19 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180420020819.GB17690@lemon.usersys.redhat.com>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180419135901.30035-2-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/43] docker: add "probe" command for
 configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, cota@braap.org, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

On Thu, 04/19 14:58, Alex Benn=E9e wrote:
> From: Peter Maydell <peter.maydell@linaro.org>
>=20
> This is a helper function for the configure script. It replies yes,
> sudo or no to inform the user if non-interactive docker support is
> available. We trap the Exception to fail gracefully.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  tests/docker/docker.py | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 1246ba9578..f8267586eb 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -390,6 +390,24 @@ class ImagesCommand(SubCommand):
>      def run(self, args, argv):
>          return Docker().command("images", argv, args.quiet)
> =20
> +
> +class ProbeCommand(SubCommand):
> +    """Probe if we can run docker automatically"""
> +    name =3D "probe"
> +
> +    def run(self, args, argv):
> +        try:
> +            docker =3D Docker()
> +            if docker._command[0] =3D=3D "docker":
> +                print "yes"
> +            elif docker._command[0] =3D=3D "sudo":
> +                print "sudo"
> +        except Exception:
> +            print "no"

Non-zero exit code is better in 'no' case, but I guess it's not required =
by
configure. Either way:

Reviewed-by: Fam Zheng <famz@redhat.com>


> +
> +        return
> +
> +
>  def main():
>      parser =3D argparse.ArgumentParser(description=3D"A Docker helper"=
,
>              usage=3D"%s <subcommand> ..." % os.path.basename(sys.argv[=
0]))
> --=20
> 2.17.0
>=20
