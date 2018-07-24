Received: from eggs.gnu.org ([2001:4830:134:3::10]:47358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1fhs2i-0001gq-V7
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1fhs2f-00034f-QP
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:47:36 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:44277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1fhs2f-00034A-M0
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:47:33 -0400
Received: by mail-ua0-f178.google.com with SMTP id k25-v6so2146858uao.11
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 00:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180717195553.9111-1-alex.bennee@linaro.org>
	<20180717195553.9111-14-alex.bennee@linaro.org>
In-Reply-To: <20180717195553.9111-14-alex.bennee@linaro.org>
From: Fam Zheng <famz@redhat.com>
Date: Tue, 24 Jul 2018 15:46:55 +0800
Message-ID: <CAK1Eb9mNF4TQV47F+b+MjLFaBVju9BCP4_vn3UDg3atWXTwTkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 for 3.0 13/18] docker: add --hint to
 docker.py check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: cota@braap.org, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, balrogg@gmail.com, aurelien@aurel32.net, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Jul 18, 2018 at 4:03 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
> When a check fails we currently just report why we failed. This is not
> totally helpful to people who want to boot-strap a new image. Add a
> --hint option which we can pass down to give a bit more information.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/docker/Makefile.include | 3 ++-
>  tests/docker/docker.py        | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
> index ec23620153..c9e412f9d0 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -73,7 +73,8 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debia=
n-bootstrap.docker
>                         $(if $(EXECUTABLE),--include-executable=3D$(EXECU=
TABLE)), \
>                         "BUILD","binfmt debian-$* (debootstrapped)"),    =
       \
>                 $(call quiet-command,                                    =
       \
> -                       $(DOCKER_SCRIPT) check --quiet qemu:debian-$* $<,=
       \
> +                       $(DOCKER_SCRIPT) check --quiet qemu:debian-$* $< =
       \
> +                       --hint "you will need to build $(EXECUTABLE)",   =
       \
>                         "CHECK", "debian-$* exists"))
>
>  endif
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 2f81c6b13b..523f4b95a2 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -475,6 +475,7 @@ class CheckCommand(SubCommand):
>                              default=3D"checksum", help=3D"check type")
>          parser.add_argument("--olderthan", default=3D60, type=3Dint,
>                              help=3D"number of minutes")
> +        parser.add_argument("--hint", default=3D"", help=3D"hint to user=
")
>
>      def run(self, args, argv):
>          tag =3D args.tag
> @@ -487,7 +488,7 @@ class CheckCommand(SubCommand):
>
>          info =3D dkr.inspect_tag(tag)
>          if info is None:
> -            print("Image does not exist")
> +            print("Image does not exist %s" % (args.hint))

No, please. This is just hacky and makes no sense to me. The Makefile
can do this

  $(DOCKER_SCRIPT) check ... || { echo "you will need to build
$(EXECUTABLE)"; exit 1 }

Fam

>              return 1
>
>          if args.checktype =3D=3D "checksum":
> --
> 2.17.1
>
