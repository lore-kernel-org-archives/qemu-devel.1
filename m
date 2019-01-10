Received: from eggs.gnu.org ([209.51.188.92]:41717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ghd90-0005sy-2V
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:25:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ghd8y-00064X-PV
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:25:22 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ghd8y-00063F-77
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:25:20 -0500
Received: by mail-wm1-x343.google.com with SMTP id m1so11863424wml.2
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 08:25:19 -0800 (PST)
References: <20190103150951.17592-1-philmd@redhat.com>
	<20190103150951.17592-3-philmd@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190103150951.17592-3-philmd@redhat.com>
Date: Thu, 10 Jan 2019 16:25:17 +0000
Message-ID: <87woncv5si.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] tests: Disable qht-bench parallel
 test when using gprof
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Emilio G . Cota" <cota@braap.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> This test is failing on the Travis CI [*] since some time now,
> disable it until it get fixed.
>
> [*] https://travis-ci.org/qemu/qemu/builds/474821674
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Use CONFIG_GPROF via config_host_mak (check-unit isn't target)
> ---
>  configure              | 1 +
>  tests/Makefile.include | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index fa5c079f98..69a125814d 100755
> --- a/configure
> +++ b/configure
> @@ -7470,6 +7470,7 @@ alpha)
>  esac
>
>  if test "$gprof" =3D "yes" ; then
> +  echo "CONFIG_GPROF=3Dy" >> $config_host_mak
>    echo "TARGET_GPROF=3Dy" >> $config_target_mak
>    if test "$target_linux_user" =3D "yes" ; then
>      cflags=3D"-p $cflags"
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3f5a1d0c30..b8f91fdd97 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -88,7 +88,8 @@ check-unit-y +=3D tests/test-rcu-simpleq$(EXESUF)
>  check-unit-y +=3D tests/test-rcu-tailq$(EXESUF)
>  check-unit-y +=3D tests/test-qdist$(EXESUF)
>  check-unit-y +=3D tests/test-qht$(EXESUF)
> -check-unit-y +=3D tests/test-qht-par$(EXESUF)
> +# FIXME: {test-qht-par + gprof} often break on Travis CI
> +check-unit-$(call lnot,$(CONFIG_GPROF)) +=3D
>  tests/test-qht-par$(EXESUF)

I got confused between test-qht-par and qht-bench. However we already
have this in the test case:

    if (g_test_quick()) {
        g_test_add_func("/qht/parallel/2threads-0%updates-1s", test_2th0u1s=
);
        g_test_add_func("/qht/parallel/2threads-20%updates-1s", test_2th20u=
1s);
    } else {
        g_test_add_func("/qht/parallel/2threads-0%updates-5s", test_2th0u5s=
);
        g_test_add_func("/qht/parallel/2threads-20%updates-5s", test_2th20u=
5s);
    }

So maybe we should be asking why it isn't limiting itself to 1s?

>  check-unit-y +=3D tests/test-bitops$(EXESUF)
>  check-unit-y +=3D tests/test-bitcnt$(EXESUF)
>  check-unit-y +=3D tests/test-qdev-global-props$(EXESUF)


--
Alex Benn=C3=A9e
