Received: from eggs.gnu.org ([2001:4830:134:3::10]:54496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cOUCe-0006wT-C0
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 13:52:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cOUCd-0007IZ-47
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 13:52:56 -0500
MIME-Version: 1.0
References: <1465919097-21453-1-git-send-email-berrange@redhat.com>
In-Reply-To: <1465919097-21453-1-git-send-email-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 03 Jan 2017 18:52:42 +0000
Message-ID: <CAJ+F1CJjQHo9EBQj2D5XUV8N9v_7PGDng7nyLJFM1fww3WpxqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] win32: don't run subprocess tests on
 Mingw32 platform
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

Hi

On Tue, Jun 14, 2016 at 6:34 PM Daniel P. Berrange <berrange@redhat.com>
wrote:

> The g_test_trap_subprocess() method does not work on the
> Mingw32 platform, causing the test-qdev-global-props
> test case to abort
>
> (test-logging.exe:230): GLib-ERROR **: g_test_trap_subprocess()
> failed: Failed to execute helper program (No such file or directory)
>
> This failure was introduced a while ago in
>
>   commit 2177801a4899bf29108b3d471417a5b4d701ec29
>   Author: Eduardo Habkost <ehabkost@redhat.com>
>   Date:   Fri Aug 8 16:03:27 2014 -0300
>
>     test-qdev-global-props: Run tests on subprocess
>
> Modify the configure time check to avoid enabling this feature
> on Mingw, rather than trying to rewrite the test to avoid this
> feature.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 8c2f90b..aa291e8 100755
> --- a/configure
> +++ b/configure
> @@ -5167,7 +5167,7 @@ if test "$bluez" =3D "yes" ; then
>    echo "CONFIG_BLUEZ=3Dy" >> $config_host_mak
>    echo "BLUEZ_CFLAGS=3D$bluez_cflags" >> $config_host_mak
>  fi
> -if test "$glib_subprocess" =3D "yes" ; then
> +if test "$glib_subprocess" =3D "yes" && test "$mingw32" !=3D "yes" ; the=
n
>    echo "CONFIG_HAS_GLIB_SUBPROCESS_TESTS=3Dy" >> $config_host_mak
>  fi
>

Isn't it only because you are missing gspawn-win*-helper.exe?

This seems to be a glib installation issue to me. I can run the
subprocesses tests fine on win32 and wine. I suggest to revert commit
7ad9339e372fcd12d584684d7f52ac259604a4f4, I can send a patch if you agree.



 echo "GLIB_CFLAGS=3D$glib_cflags" >> $config_host_mak
> --
> 2.5.5
>
>
> --
Marc-Andr=C3=A9 Lureau
