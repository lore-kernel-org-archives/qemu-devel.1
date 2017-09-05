Received: from eggs.gnu.org ([2001:4830:134:3::10]:42617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpHOD-0003xW-VA
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpHO9-0002Mg-7k
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:11:53 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpHO9-0002Lk-27
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:11:49 -0400
Received: by mail-wr0-x232.google.com with SMTP id a43so10067283wrc.0
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 10:11:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170905170822.9109-1-f4bug@amsat.org>
References: <20170905170822.9109-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 18:11:27 +0100
Message-ID: <CAFEAcA_dejMPN9MSU0dObB103xOtzcu9H19PkZ5OoN=jaW1EZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 September 2017 at 18:08, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> tests/vhost-user-test keeps failing on build-system since Aug 15:
>
>   ERROR:tests/vhost-user-test.c:835:test_flags_mismatch: child process (/=
i386/vhost-user/flags-mismatch/subprocess [4836]) failed unexpectedly
> ...
>   ERROR:tests/vhost-user-test.c:807:test_connect_fail: child process (/x8=
6_64/vhost-user/connect-fail/subprocess [58910]) failed unexpectedly
>
> The test can still be build for debug session using:
>
>   $ FORCE_VHOST_USER_NET_TEST=3D1 ./configure ...
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  configure | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index fb7e34a901..d3b895b167 100755
> --- a/configure
> +++ b/configure
> @@ -6386,7 +6386,12 @@ if supported_kvm_target $target; then
>      if test "$vhost_net" =3D "yes" ; then
>          echo "CONFIG_VHOST_NET=3Dy" >> $config_target_mak
>          if test "$vhost_user" =3D "yes" ; then
> -            echo "CONFIG_VHOST_USER_NET_TEST_$target_name=3Dy" >> $confi=
g_host_mak
> +            if test -n "${FORCE_VHOST_USER_NET_TEST}"; then
> +                echo "CONFIG_VHOST_USER_NET_TEST_$target_name=3Dy" >> $c=
onfig_host_mak
> +            elif test -z "${VHOST_USER_NET_TEST_WARNED}"; then
> +                echo "warning: vhost-user tests disabled" >&2
> +                VHOST_USER_NET_TEST_WARNED=3D"warned"
> +            fi

Please don't make this print a warning -- that will just create
noise in my test logs to no useful effect.

thanks
-- PMM
