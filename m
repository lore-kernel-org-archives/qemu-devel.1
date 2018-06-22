Received: from eggs.gnu.org ([2001:4830:134:3::10]:33182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWCeG-0003uA-IN
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWCeD-0003H7-EF
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:22:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46604 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fWCeD-0003F3-8A
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:22:05 -0400
Date: Fri, 22 Jun 2018 06:22:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180622061513-mutt-send-email-mst@kernel.org>
References: <20180622022035.18490-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180622022035.18490-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] Makefile: Enable synchronized parallel
 output when possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

On Thu, Jun 21, 2018 at 11:20:35PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> The '--output-sync' option is available since GNU make 4.0.
>=20
>   5.4.1 Output During Parallel Execution
>=20
>   When running several recipes in parallel the output from each
>   recipe appears as soon as it is generated, with the result that
>   messages from different recipes may be interspersed, sometimes
>   even appearing on the same line. This can make reading the output
>   very difficult.
>=20
>   To avoid this you can use the =E2=80=98--output-sync=E2=80=99 (=E2=80=
=98-O=E2=80=99) option. This
>   option instructs make to save the output from the commands it
>   invokes and print it all once the commands are completed.
>   Additionally, if there are multiple recursive make invocations
>   running in parallel, they will communicate so that only one of
>   them is generating output at a time.
>=20
>   There are four levels of granularity when synchronizing output,
>   specified by giving an argument to the option (e.g., =E2=80=98-Oline=E2=
=80=99
>   or =E2=80=98--output-sync=3Drecurse=E2=80=99).
>=20
>     none
>       This is the default: all output is sent directly as it is
>       generated and no synchronization is performed.
>=20
>     line
>       Output from each individual line of the recipe is grouped
>       and printed as soon as that line is complete. If a recipe
>       consists of multiple lines, they may be interspersed with
>       lines from other recipes.
>=20
>     target
>       Output from the entire recipe for each target is grouped and
>       printed once the target is complete. This is the default if
>       the --output-sync or -O option is given with no argument.
>=20
>     recurse
>       Output from each recursive invocation of make is grouped and
>       printed once the recursive invocation is complete.
>=20
>   Regardless of the mode chosen, the total build time will be the
>   same. The only difference is in how the output appears.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Maybe 'line' is better for workstation and 'target/recurse' for
> unattended builds.
>=20
> doc: https://www.gnu.org/software/make/manual/html_node/Parallel-Output=
.html
> ---
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index e46f2b625a..e94c687afe 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -367,6 +367,10 @@ DOCS=3D
>  endif
> =20
>  SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory --quiet) BUILD_DIR=3D=
$(BUILD_DIR)
> +ifeq ($(shell test $(firstword $(subst ., ,$(MAKE_VERSION))) -ge 4; ec=
ho $$?),0)
> +SUBDIR_MAKEFLAGS+=3D--output-sync=3Dtarget
> +endif
> +
>  SUBDIR_DEVICES_MAK=3D$(patsubst %, %/config-devices.mak, $(TARGET_LIST=
))
>  SUBDIR_DEVICES_MAK_DEP=3D$(patsubst %, %-config-devices.mak.d, $(TARGE=
T_LIST))

I'd probably just use -O. If they change the default it will probably be
to a better one.

> --=20
> 2.18.0.rc2
