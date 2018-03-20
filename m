Received: from eggs.gnu.org ([2001:4830:134:3::10]:50402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyINH-0000I9-Kq
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyINC-0002Bj-Uq
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:36:27 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:33872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyINC-0002BL-Nx
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:36:22 -0400
Received: by mail-ot0-x242.google.com with SMTP id m7-v6so1941140otd.1
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 07:36:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180320142343.13867-1-berrange@redhat.com>
References: <20180320142343.13867-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 14:36:01 +0000
Message-ID: <CAFEAcA8dqLa2sTqOm9+z+sh4uft8OM06wNRTs1YkjsSa73yhRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] make: improve check for stale generated
 files in source dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 20 March 2018 at 14:23, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wr=
ote:
> When doing a build with builddir !=3D srcdir, if any generated files are
> accidentally present in srcdir from a previous build, these can cause
> unexpected failures.
>
> Currently there is a rule that checks for existance of config-host.mak,
> but there have been cases where config-host.mak is absent, while other
> generated files still exist.
>
> Update the check to look at every file listed in $(GENERATED_FILES). To
> do this we must move the check further down after $(GENERATED_FILES) has
> been populated.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  Makefile | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index c8116694a0..73caabc019 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -52,16 +52,6 @@ endif
>
>  .git-submodule-status: git-submodule-update config-host.mak
>
> -# Check that we're not trying to do an out-of-tree build from
> -# a tree that's been used for an in-tree build.
> -ifneq ($(realpath $(SRC_PATH)),$(realpath .))
> -ifneq ($(wildcard $(SRC_PATH)/config-host.mak),)
> -$(error This is an out of tree build but your source tree ($(SRC_PATH)) =
\
> -seems to have been used for an in-tree build. You can fix this by runnin=
g \
> -"$(MAKE) distclean && rm -rf *-linux-user *-softmmu" in your source tree=
)
> -endif
> -endif
> -
>  CONFIG_SOFTMMU :=3D $(if $(filter %-softmmu,$(TARGET_DIRS)),y)
>  CONFIG_USER_ONLY :=3D $(if $(filter %-user,$(TARGET_DIRS)),y)
>  CONFIG_XEN :=3D $(CONFIG_XEN_BACKEND)
> @@ -1027,6 +1017,25 @@ ifdef SIGNCODE
>  endif # SIGNCODE
>  endif # CONFIG_WIN
>
> +define nl
> +
> +
> +endef
> +
> +CHECK_FILES =3D config-host.mak $(filter-out .git-submodule-status, $(GE=
NERATED_FILES))
> +UNEXPECTED_FILES =3D $(wildcard $(CHECK_FILES:%=3D$(SRC_PATH)/%))
> +
> +# Check that we're not trying to do an out-of-tree build from
> +# a tree that's been used for an in-tree build.
> +ifneq ($(realpath $(SRC_PATH)),$(realpath .))
> +ifneq ($(UNEXPECTED_FILES),)
> +$(error Stale files in source tree:${nl}${nl} $(UNEXPECTED_FILES:%=3D  %=
${nl}) ${nl}\
> +This is an out of tree build but your source tree ($(SRC_PATH)) \
> +seems to have been used for an in-tree build. You can fix this by runnin=
g \
> +"$(MAKE) distclean && rm -rf *-linux-user *-softmmu" in your source tree=
)
> +endif
> +endif
> +
>  # Add a dependency on the generated files, so that they are always
>  # rebuilt before other object files
>  ifneq ($(wildcard config-host.mak),)
> --

Does this still mean the check is made sufficiently early, before
we start trying to build config-all-devices.mak and other things?
This change has moved it down after 'include' directives which
I think will cause make to try to build the file that it must
include.

It's also moved out of the "only run this if we've actually run
configure" block, but I think that part is OK.

thanks
-- PMM
