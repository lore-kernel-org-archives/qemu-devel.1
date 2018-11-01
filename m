Received: from eggs.gnu.org ([2001:4830:134:3::10]:57198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gI7ii-0007wG-Ov
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 03:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gI7ie-0007GD-I3
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 03:48:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gI7ie-0007Ff-7h
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 03:48:44 -0400
Date: Thu, 1 Nov 2018 15:48:40 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20181101074840.GF17770@magic>
References: <20181013003058.3349-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181013003058.3349-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/vm: Use subprocess.Popen() with to
 uncompress XZ files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Sat, 10/13 02:30, Philippe Mathieu-Daud=E9 wrote:
> Avoiding the file copy greatly speeds the process up.
>=20
> Comparison with network file already cached, stopping after build_image=
():
>=20
> Before:
>   $ time make vm-build-freebsd
>   real    1m38.153s
>   user    1m16.871s
>   sys     0m19.325s
>=20
> After:
>   $ time make vm-build-freebsd
>   real    0m13.512s
>   user    0m9.520s
>   sys     0m3.685s
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/vm/centos  | 5 ++---
>  tests/vm/freebsd | 9 ++-------
>  tests/vm/netbsd  | 9 ++-------
>  tests/vm/openbsd | 9 ++-------
>  4 files changed, 8 insertions(+), 24 deletions(-)
>=20
> diff --git a/tests/vm/centos b/tests/vm/centos
> index afd560c564..fa653c1650 100755
> --- a/tests/vm/centos
> +++ b/tests/vm/centos
> @@ -63,9 +63,8 @@ class CentosVM(basevm.BaseVM):
> =20
>      def build_image(self, img):
>          cimg =3D self._download_with_cache("https://cloud.centos.org/c=
entos/7/images/CentOS-7-x86_64-GenericCloud-1802.qcow2.xz")
> -        img_tmp =3D img + ".tmp"
> -        subprocess.check_call(["cp", "-f", cimg, img_tmp + ".xz"])
> -        subprocess.check_call(["xz", "-df", img_tmp + ".xz"])
> +        with open(img, 'wb', 0644) as output:
> +            subprocess.Popen(["xz", "--threads=3D0", "--decompress", "=
--force", "--to-stdout", cimg], stdout=3Doutput)
>          subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
>          self.boot(img_tmp, extra_args =3D ["-cdrom", self._gen_cloud_i=
nit_iso()])
>          self.wait_ssh()
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index b6983127d0..7ec43a4c5c 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -31,13 +31,8 @@ class FreeBSDVM(basevm.BaseVM):
>      def build_image(self, img):
>          cimg =3D self._download_with_cache("http://download.patchew.or=
g/freebsd-11.1-amd64.img.xz",
>                  sha256sum=3D'adcb771549b37bc63826c501f05121a206ed3d9f5=
5f49145908f7e1432d65891')
> -        img_tmp_xz =3D img + ".tmp.xz"
> -        img_tmp =3D img + ".tmp"
> -        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> -        subprocess.check_call(["xz", "-df", img_tmp_xz])
> -        if os.path.exists(img):
> -            os.remove(img)
> -        os.rename(img_tmp, img)
> +        with open(img, 'wb', 0644) as output:
> +            subprocess.Popen(["xz", "--threads=3D0", "--decompress", "=
--force", "--to-stdout", cimg], stdout=3Doutput)

What if xz is terminated before the image is fully polulated? The next ti=
me make
is invoked we want build_image to start over, but with this change it won=
't.

Fam

> =20
>  if __name__ =3D=3D "__main__":
>      sys.exit(basevm.main(FreeBSDVM))
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index a4e25820d5..99023344b7 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -31,13 +31,8 @@ class NetBSDVM(basevm.BaseVM):
>      def build_image(self, img):
>          cimg =3D self._download_with_cache("http://download.patchew.or=
g/netbsd-7.1-amd64.img.xz",
>                                           sha256sum=3D'b633d565b0eac3d0=
2015cd0c81440bd8a7a8df8512615ac1ee05d318be015732')
> -        img_tmp_xz =3D img + ".tmp.xz"
> -        img_tmp =3D img + ".tmp"
> -        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> -        subprocess.check_call(["xz", "-df", img_tmp_xz])
> -        if os.path.exists(img):
> -            os.remove(img)
> -        os.rename(img_tmp, img)
> +        with open(img, 'wb', 0644) as output:
> +            subprocess.Popen(["xz", "--threads=3D0", "--decompress", "=
--force", "--to-stdout", cimg], stdout=3Doutput)
> =20
>  if __name__ =3D=3D "__main__":
>      sys.exit(basevm.main(NetBSDVM))
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index 52500ee52b..57604bb43d 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -32,13 +32,8 @@ class OpenBSDVM(basevm.BaseVM):
>      def build_image(self, img):
>          cimg =3D self._download_with_cache("http://download.patchew.or=
g/openbsd-6.1-amd64.img.xz",
>                  sha256sum=3D'8c6cedc483e602cfee5e04f0406c64eb99138495e=
8ca580bc0293bcf0640c1bf')
> -        img_tmp_xz =3D img + ".tmp.xz"
> -        img_tmp =3D img + ".tmp"
> -        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> -        subprocess.check_call(["xz", "-df", img_tmp_xz])
> -        if os.path.exists(img):
> -            os.remove(img)
> -        os.rename(img_tmp, img)
> +        with open(img, 'wb', 0644) as output:
> +            subprocess.Popen(["xz", "--threads=3D0", "--decompress", "=
--force", "--to-stdout", cimg], stdout=3Doutput)
> =20
>  if __name__ =3D=3D "__main__":
>      sys.exit(basevm.main(OpenBSDVM))
> --=20
> 2.19.1
>=20
