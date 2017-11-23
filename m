Received: from eggs.gnu.org ([2001:4830:134:3::10]:33280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eHpXq-000124-NZ
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:19:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eHpXm-0003eL-Mw
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:19:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eHpXm-0003d9-Dn
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:19:46 -0500
Date: Thu, 23 Nov 2017 11:19:43 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171123111943.GD26022@stefanha-x1.localdomain>
References: <1511419276-31212-1-git-send-email-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Content-Disposition: inline
In-Reply-To: <1511419276-31212-1-git-send-email-yang.zhong@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2] rcu: reduce more than 7MB heap memory
 by malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com, stone.xulei@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, zhang.zhanghailiang@huawei.com, liujunjie23@huawei.com


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 02:41:16PM +0800, Yang Zhong wrote:
> Since there are some issues in memory alloc/free machenism
> in glibc for little chunk memory, if Qemu frequently
> alloc/free little chunk memory, the glibc doesn't alloc
> little chunk memory from free list of glibc and still
> allocate from OS, which make the heap size bigger and bigger.
>=20
> This patch introduce malloc_trim(), which will free heap memory.
>=20
> Below are test results from smaps file.
> (1)without patch
> 55f0783e1000-55f07992a000 rw-p 00000000 00:00 0  [heap]
> Size:              21796 kB
> Rss:               14260 kB
> Pss:               14260 kB
>=20
> (2)with patch
> 55cc5fadf000-55cc61008000 rw-p 00000000 00:00 0  [heap]
> Size:              21668 kB
> Rss:                6940 kB
> Pss:                6940 kB
>=20
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  configure  | 4 ++++
>  util/rcu.c | 6 ++++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/configure b/configure
> index 0e856bb..5b463d4 100755
> --- a/configure
> +++ b/configure
> @@ -6012,6 +6012,10 @@ if test "$opengl" =3D "yes" ; then
>    fi
>  fi
> =20
> +if test "$tcmalloc" =3D "yes" || test "$jemalloc" =3D "yes" ; then
> +  echo "CONFIG_NONGLIBMALLOC=3Dy" >> $config_host_mak

malloc(3) is provided by glibc, not glib, so the name
CONFIG_NONGLIBMALLOC is confusing.

I suggest calling it CONFIG_MALLOC_TRIM instead:

  # Even if malloc_trim() is available, these non-libc memory allocators
  # do not support it.
  if test "$tcmalloc" =3D "yes" || test "$jemalloc" =3D "yes" ; then
      if test "$malloc_trim" =3D "yes" ; then
          echo "Disabling malloc_trim with non-libc memory allocator"
      fi
      malloc_trim=3D"no"
  fi

  if test "$malloc_trim" !=3D "no" ; then
      cat > $TMPC << EOF
  #include <malloc.h>
  int main(void) { malloc_trim(0); return 0; }
  EOF
      if compile_prog "" "" ; then
          malloc_trim=3D"yes"
      else
          malloc_trim=3D"no"
      fi
  fi

  ...

  if test "$malloc_trim" =3D "yes" ; then
      echo "CONFIG_MALLOC_TRIM=3Dy" >> $config_host_mak
  fi

Then the code in rcu.c just has to #ifdef CONFIG_MALLOC_TRIM and there's
no need for Linux-specific checks.  If other operating systems support
malloc_trim() then QEMU will use it by default.

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaFq7PAAoJEJykq7OBq3PIG5gH/2pxP286MubiyshDJzu2H4xV
QVCvrfFIMrAtgxTxMU8800RKK0M5ePbf2fPN+FUEO83Cg5Zc/GmTEcXzbTng90SE
pqXV7KvPy/tdgrObk3bpBZwMsL+L7PSR3fkVeer/R9WjR1TcJ+W9sH5IRtp5w+dq
Kssf4kn9oMkBJvPAtRYEcFtsikp91RarSdp0W19wiu/Eu4dZ6fmxVmQQqAVvICa9
s+RHBv4RWTuovgBvDcvf4n4t+0cflzqgPl0phbGFVH3v36kxSNrP1v0yzuJXjwRQ
qJdJmknktdHWzWzUEXaPYJA+2FftHhRBCJitqkDbtahl09kpbF9BOEUHVfkv3AQ=
=Ntr5
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
