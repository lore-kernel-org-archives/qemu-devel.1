Received: from eggs.gnu.org ([2001:4830:134:3::10]:33111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTnsg-0005n8-40
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTnse-00063v-Ub
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:31:06 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTnse-00063Z-Hj
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:31:04 -0400
Received: by mail-oi0-x242.google.com with SMTP id k190-v6so8629468oib.9
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 05:31:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180609151048.9628-1-f4bug@amsat.org>
References: <20180609151048.9628-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 13:30:43 +0100
Message-ID: <CAFEAcA-2GKS-hJnHp6Lv7OJ8-QnirGLAUikNvfYooa=yk4k9aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Makefile: Check for more dangling
 scratch files in out-of-tree builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>

On 9 June 2018 at 16:10, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> It is easy to catch the generated 'config-host.mak' in the source
> tree, however qemu-version.h and qemu-options.def are also generated
> files and are hidden by .gitignore rules.
>
> Improve the out-of-tree safety net rule added in d1bd2423a90,
> by also checking for these two files.
>
> This solves building issues with out-of-tree builds from a
> source tree that has been built in:
>
> - /qemu-version.h existing in source tree:
>
>     /source/qemu/qemu-nbd.c: In function =E2=80=98version=E2=80=99:
>     /source/qemu/qemu-nbd.c:133:6: error: expected =E2=80=98)=E2=80=99 be=
fore
>     =E2=80=98QEMU_FULL_VERSION=E2=80=99
>      "%s " QEMU_FULL_VERSION "\n"
>           ^~~~~~~~~~~~~~~~~~
>           )
>     /source/qemu/qemu-nbd.c:133:3: error: format =E2=80=98%s=E2=80=99 exp=
ects a matching
>     =E2=80=98char *=E2=80=99 argument [-Werror=3Dformat=3D]
>      "%s " QEMU_FULL_VERSION "\n"
>       ~^
>     cc1: all warnings being treated as errors
>
> - /qemu-options.def existing in source tree:
>
>     /source/qemu/vl.c: In function =E2=80=98main=E2=80=99:
>     /source/qemu/vl.c:3052:18: error: =E2=80=98QEMU_OPTION_blockdev=E2=80=
=99 undeclared
>     (first use in this function); did you mean =E2=80=98QEMU_OPTION_clock=
=E2=80=99?
>                  case QEMU_OPTION_blockdev:
>                       ^~~~~~~~~~~~~~~~~~~~
>                       QEMU_OPTION_clock
>     /source/qemu/vl.c:3052:18: note: each undeclared identifier is report=
ed
>     only once for each function it appears in

This commit message should I think also mention that it is
only needed to deal with source trees that have these stale
files from failed build attempts that predate commit
428952cfa966f5af8. Otherwise the existing test on config-host.mak
is sufficient.

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Since v1 http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg02254=
.html:
> Peter noticed [1] those files already are in GENERATED_FILES
>
> [1] http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg02338.html
>
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 023b3437ec..521009964c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -55,7 +55,8 @@ endif
>  # Check that we're not trying to do an out-of-tree build from
>  # a tree that's been used for an in-tree build.
>  ifneq ($(realpath $(SRC_PATH)),$(realpath .))
> -ifneq ($(wildcard $(SRC_PATH)/config-host.mak),)
> +scratch_files =3D config-host.mak qemu-version.h qemu-options.def
> +ifneq ($(wildcard $(addprefix $(SRC_PATH)/,$(scratch_files))),)
>  $(error This is an out of tree build but your source tree ($(SRC_PATH)) =
\
>  seems to have been used for an in-tree build. You can fix this by runnin=
g \
>  "$(MAKE) distclean && rm -rf *-linux-user *-softmmu" in your source tree=
)
> --
> 2.17.1

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
