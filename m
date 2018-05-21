Received: from eggs.gnu.org ([2001:4830:134:3::10]:59715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fKbOM-00062N-M9
	for qemu-devel@nongnu.org; Sun, 20 May 2018 23:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fKbOI-000225-Ov
	for qemu-devel@nongnu.org; Sun, 20 May 2018 23:21:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49368 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fKbOI-00021p-Js
	for qemu-devel@nongnu.org; Sun, 20 May 2018 23:21:42 -0400
Date: Mon, 21 May 2018 11:21:39 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180521032139.GF17725@lemon.usersys.redhat.com>
References: <20180518152228.15362-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180518152228.15362-1-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/docker/Makefile.include: handle
 empty TARGET_LIST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Fri, 05/18 16:22, Alex Benn=E9e wrote:
> If the user doesn't specify a TARGET_LIST they get the current
> configuration but with spaces and hilarity ensues. This adds some make
> magic to turn the TARGET_LIST back into a comma separated list.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index d00887bdf1..eccd5f7d68 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -125,6 +125,10 @@ docker:
>  	@echo '    EXTRA_FILES=3D"<path> [... <path>]"'
>  	@echo '                         Include extra files in image.'
> =20
> +null  :=3D
> +space :=3D $(null) #
> +comma :=3D ,

We have $(COMMA) in rules.mak, please add space there.

> +
>  # This rule if for directly running against an arbitrary docker target=
.
>  # It is called by the expanded docker targets (e.g. make
>  # docker-test-foo@bar) which will do additional verification.
> @@ -148,7 +152,7 @@ docker-run: docker-qemu-src
>  			$(if $V,,--rm) 					\
>  			$(if $(DEBUG),-ti,)				\
>  			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),--net=3D$(NETWORK)),--n=
et=3Dnone) \
> -			-e TARGET_LIST=3D$(TARGET_LIST) 			\
> +			-e TARGET_LIST=3D$(subst $(space),$(comma),$(TARGET_LIST))	\
>  			-e EXTRA_CONFIGURE_OPTS=3D"$(EXTRA_CONFIGURE_OPTS)" \
>  			-e V=3D$V -e J=3D$J -e DEBUG=3D$(DEBUG)		\
>  			-e SHOW_ENV=3D$(SHOW_ENV) 			\
> --=20
> 2.17.0
>=20

Fam
