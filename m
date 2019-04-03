Received: from eggs.gnu.org ([209.51.188.92]:59544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hBihR-0003lZ-DC
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 12:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hBia4-0008Ew-0d
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 12:17:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hBia3-0007Zo-NG
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 12:17:39 -0400
Date: Wed, 3 Apr 2019 17:17:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190403161729.GW25150@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190403124948.GA14129@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190403124948.GA14129@ls3530.dellerweb.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Relax check for libseccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

On Wed, Apr 03, 2019 at 02:49:48PM +0200, Helge Deller wrote:
> On a non-release architecture, the configure program aborts if the
> --enable-seccomp flag was given (with no way to work around it on the
> command line):
>=20
> ERROR: User requested feature libseccomp
> 	configure was not able to find it.
> 	libseccomp is not supported for host cpu parisc64
>=20
> Instead of aborting, fall back to require libseccomp version 2.2.0
> (or any higher version currently installed) which should be OK for
> non-release architectures.
>=20
> Signed-off-by: Helge Deller <deller@gmx.de>
>=20
> diff --git a/configure b/configure
> index 1c563a7027..8632267049 100755
> --- a/configure
> +++ b/configure
> @@ -2389,7 +2389,6 @@ if test "$seccomp" !=3D "no" ; then
>          libseccomp_minver=3D"2.3.0"
>          ;;
>      *)
> -        libseccomp_minver=3D""
>          ;;
>      esac

This makes sense to me. From a QEMU source POV we are able to build with
libseccomp >=3D 2.2.0, which our default libseccomp_minver=3D env express=
es
a few lines earlier.

If libseccomp isn't supported on a platform, then I think we should just
assume that libseccomp won't be present in the OS install we are building
against. I don't think QEMU needs to second-guess whether or not it is
supported on the given architecture. In fact I'd go as far as to say we
could probably just remove all this per-arch checking and just have a
generic >=3D 2.2.0 check, and just rely on fact libseccomp won't exist
on a s390/ppc/etc host if the distro had version < 2.3.0

Anyway, this particular patch is better than what we have so on that
basis I think we can just apply this as-is:

  Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
