Received: from eggs.gnu.org ([2001:4830:134:3::10]:44740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxd59-0004o0-Ce
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxd56-00073F-9f
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:58:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dxd55-00072Z-Vt
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:58:40 -0400
References: <20170928120621.30288-1-berrange@redhat.com>
	<20170928120621.30288-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3b48e116-7d88-4df0-05c3-7e45754db347@redhat.com>
Date: Thu, 28 Sep 2017 12:58:32 -0500
MIME-Version: 1.0
In-Reply-To: <20170928120621.30288-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E0uKSOKD0RL8UK8tH9X6Hr5wcdj5BjSLq"
Subject: Re: [Qemu-devel] [PATCH v7 1/6] build: automatically handle GIT
 submodule checkout for dtc
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E0uKSOKD0RL8UK8tH9X6Hr5wcdj5BjSLq
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3b48e116-7d88-4df0-05c3-7e45754db347@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 1/6] build: automatically handle GIT
 submodule checkout for dtc
References: <20170928120621.30288-1-berrange@redhat.com>
 <20170928120621.30288-2-berrange@redhat.com>
In-Reply-To: <20170928120621.30288-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/28/2017 07:06 AM, Daniel P. Berrange wrote:
> Currently if DTC is required by configure and not available in the host=

> OS install, we exit with an error message telling the user to checkout =
a
> git submodule or install the library.
>=20
> This introduces automatic handling of the git submodule checkout proces=
s
> and enables it for dtc. This only runs if building from GIT, so users o=
f
> release tarballs still need the system library install. The current sta=
te
> of the git checkout is stashed in .git-submodule-status, and a helper
> program is used to determine if this state matches the desired submodul=
e
> state. A dependency against 'Makefile' ensures that the submodule state=

> is refreshed at the start of the build process
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  .gitignore               |  1 +
>  Makefile                 | 23 ++++++++++++++++++++++-
>  configure                | 46 ++++++++++++++++++++++++++--------------=
------
>  scripts/git-submodule.sh | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 80 insertions(+), 21 deletions(-)
>  create mode 100755 scripts/git-submodule.sh
>=20

> +++ b/Makefile
> @@ -14,6 +14,27 @@ ifneq ($(wildcard config-host.mak),)
>  all:
>  include config-host.mak
> =20
> +git-submodule-update:
> +
> +.PHONY: git-submodule-update
> +
> +ifeq (0,$(MAKELEVEL))
> +  git_module_status :=3D $(shell \
> +    cd '$(SRC_PATH)'; \

Should this be && instead of ;, since I don't know if $(shell) implies
'set -e' semantics?

> +    ./scripts/git-submodule.sh status $(GIT_SUBMODULES); \
> +    echo $$?; \
> +  )
> +
> +ifeq (1,$(git_module_status))
> +git-submodule-update:
> +	$(call quiet-command, \
> +          (cd $(SRC_PATH); ./scripts/git-submodule.sh update $(GIT_SUB=
MODULES)), \

and again

> +          "GIT","$(GIT_SUBMODULES)")
> +endif
> +endif
> +
> +.git-submodule-status: git-submodule-update
> +

> +++ b/configure
> @@ -264,6 +264,7 @@ cc_i386=3Di386-pc-linux-gnu-gcc
>  libs_qga=3D""
>  debug_info=3D"yes"
>  stack_protector=3D""
> +git_submodules=3D""
> =20
>  # Don't accept a target_list environment variable.
>  unset target_list
> @@ -3580,27 +3581,30 @@ EOF
>    if compile_prog "" "$fdt_libs" ; then
>      # system DTC is good - use it
>      fdt=3Dyes
> -  elif test -d ${source_path}/dtc/libfdt ; then
=2E..
> -       symlink "$source_path/dtc/Makefile" "dtc/Makefile"

Old code is inconsistent on whether it quotes the expansion of
$source_path.  Given the unquoted usage, we don't support a $source_path
that contains spaces; however...

> +      # have GIT checkout, so activate dtc submodule
> +      if test -d ${source_path}/.git ; then

=2E..we might as well consistently use quotes in all new code, especially=
,
since it is already a red flag any time someone does unquoted test -d $fo=
o.

> +	  git_submodules=3D"${git_submodules} dtc"
> +      fi
> +      if test -d ${source_path}/dtc/libfdt || test -d ${source_path}/.=
git ; then

and again

=2Egit is not always a directory; it can be a symlink or text file
containing a directory name.  It is probably sufficient to just use test
-e instead of test -d.

> +	  fdt=3Dyes
> +	  dtc_internal=3D"yes"
> +	  mkdir -p dtc
> +	  if [ "$pwd_is_source_path" !=3D "y" ] ; then
> +	      symlink "$source_path/dtc/Makefile" "dtc/Makefile"
> +	      symlink "$source_path/dtc/scripts" "dtc/scripts"
> +	  fi
> +	  fdt_cflags=3D"-I\$(SRC_PATH)/dtc/libfdt"
> +	  fdt_libs=3D"-L\$(BUILD_DIR)/dtc/libfdt $fdt_libs"
> +      elif test "$fdt" =3D "yes" ; then
> +	  # have neither and want - prompt for system/submodule install
> +	  error_exit "DTC (libfdt) version >=3D 1.4.2 not present." \
> +		     "Please install the DTC (libfdt) devel package"

Is the comment accurate, given that the error message doesn't mention a
submodule?

> +      else
> +	  # don't have and don't want
> +	  fdt_libs=3D
> +	  fdt=3Dno
> +      fi
>    fi
>  fi
> =20

> +++ b/scripts/git-submodule.sh
> @@ -0,0 +1,31 @@
> +#!/bin/bash
> +
> +set -e

'set -e' is notoriously awkward to work with, especially if your shell
script includes functions.  Do we really need it, or can we do proper
error checking in place?

> +
> +command=3D$1
> +shift
> +modules=3D"$@"
> +
> +test -z "$modules" && exit 0
> +
> +if ! test -d ".git"

Again, .git doesn't necessarily have to be a directory; test -e may be
better.

> +then
> +    echo "$0: unexpectedly called with submodules but no git checkout =
exists"
> +    exit 1
> +fi
> +
> +substat=3D".git-submodule-status"
> +
> +case "$command" in
> +status)
> +    test -f "$substat" || exit 1
> +    git submodule status $modules > "${substat}.tmp"

This is one place where if 'set -e' is not in effect, you need to decide
if failure to run the command should cause early exit.

> +    trap "rm -f ${substat}.tmp" EXIT

Don't you want the trap installed one line earlier, before you create
the file?

> +    diff "${substat}" "${substat}.tmp" >/dev/null
> +    exit $?
> +    ;;
> +update)
> +    git submodule update --init $modules 1>/dev/null 2>&1
> +    git submodule status $modules > "${substat}"
> +    ;;
> +esac
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--E0uKSOKD0RL8UK8tH9X6Hr5wcdj5BjSLq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnNOEgACgkQp6FrSiUn
Q2pLMggAozcA1ewboCo2Wd4Ybf0Yw6Nu6Vb3KN6StuUdGHE+f3mxo8Jd8tPepBdj
QaqratiLYp6OxUp59B4mbc1qkcPS4dxbabF4wU8M0m7dPGY8CfCHWzHhiADQu6Rv
lwW0gpEfSx+Bjo0Qp3i9gIRVOMRjkwBbz2VxluqT5l2/a1W6rJzFHWRG+4/5Keof
wzLt+lv3qlQqLx24iOscmj4HbwYF6zsvdQzWZiIcsBKhjQstt9d7gMEme/I3Ycjn
ole4jjF6xCI3+AWHOUmtVmVZNSdm33Kp4Vy6DrbkOe7JFkH87gDI1FA9hTBURXRQ
K5dX1Wit1OVOLsoE6V3XIrkHjSym7g==
=Zhl5
-----END PGP SIGNATURE-----

--E0uKSOKD0RL8UK8tH9X6Hr5wcdj5BjSLq--
