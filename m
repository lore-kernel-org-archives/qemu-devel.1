Received: from eggs.gnu.org ([2001:4830:134:3::10]:45573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpHU3-0006Ek-RZ
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpHTy-0005WQ-Tl
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:17:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpHTy-0005WG-NQ
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:17:50 -0400
Date: Tue, 5 Sep 2017 18:17:46 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170905171746.GI311@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170905170822.9109-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905170822.9109-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost-user: disable broken test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On Tue, Sep 05, 2017 at 02:08:22PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> tests/vhost-user-test keeps failing on build-system since Aug 15:
>=20
>   ERROR:tests/vhost-user-test.c:835:test_flags_mismatch: child process =
(/i386/vhost-user/flags-mismatch/subprocess [4836]) failed unexpectedly
> ...
>   ERROR:tests/vhost-user-test.c:807:test_connect_fail: child process (/=
x86_64/vhost-user/connect-fail/subprocess [58910]) failed unexpectedly

Seems like it is always the subprocess tests which fail
from what I see. So rather than disable the entire test,
just put

   if (1) {
       g_test_skip("Skipping unreliable subprocess test");
       return;
   }

at the top of each test_*_subprocess() method

>=20
> The test can still be build for debug session using:
>=20
>   $ FORCE_VHOST_USER_NET_TEST=3D1 ./configure ...
>=20
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  configure | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index fb7e34a901..d3b895b167 100755
> --- a/configure
> +++ b/configure
> @@ -6386,7 +6386,12 @@ if supported_kvm_target $target; then
>      if test "$vhost_net" =3D "yes" ; then
>          echo "CONFIG_VHOST_NET=3Dy" >> $config_target_mak
>          if test "$vhost_user" =3D "yes" ; then
> -            echo "CONFIG_VHOST_USER_NET_TEST_$target_name=3Dy" >> $con=
fig_host_mak
> +            if test -n "${FORCE_VHOST_USER_NET_TEST}"; then
> +                echo "CONFIG_VHOST_USER_NET_TEST_$target_name=3Dy" >> =
$config_host_mak
> +            elif test -z "${VHOST_USER_NET_TEST_WARNED}"; then
> +                echo "warning: vhost-user tests disabled" >&2
> +                VHOST_USER_NET_TEST_WARNED=3D"warned"
> +            fi
>          fi
>      fi
>  fi
> --=20
> 2.14.1
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
