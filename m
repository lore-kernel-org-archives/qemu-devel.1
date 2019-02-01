Received: from eggs.gnu.org ([209.51.188.92]:44311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gpPPp-0001Kz-72
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 22:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gpPEQ-0003Ku-H8
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 22:11:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gpPEQ-0003Jg-8n
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 22:11:06 -0500
Date: Fri, 1 Feb 2019 11:11:02 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190201031102.GE12081@stefanha-x1.localdomain>
References: <20190131202637.4062-1-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LSp5EJdfMPwZcMS1"
Content-Disposition: inline
In-Reply-To: <20190131202637.4062-1-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH] monitor: Add whitelist support for QMP
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>


--LSp5EJdfMPwZcMS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 11:26:37PM +0300, Julia Suvorova wrote:
> The whitelist option allows to run a reduced monitor with a subset of
> QMP commands. This allows the monitor to run in secure mode, which is
> convenient for sending commands via the WebSocket monitor using the
> web UI. This is planned to be done on micro:bit board.
>=20
> The list of allowed commands should be written to a file, one per line.
> The command line will look like this:
>     -mon chardev_name,mode=3Dcontrol,whitelist=3Dpath_to_file
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---

Please include a test case.  tests/qmp-cmd-test.c looks like a starting
point.

Interesting cases:
1. QMP negotiation still works.
2. A whitelisted command succeeds.
3. A forbidden command fails with the expected error.

> +static void monitor_qmp_cleanup_commands(Monitor *mon)
> +{
> +    QmpCommand *cmd, *next_cmd;
> +
> +    if (!monitor_is_qmp(mon) ||
> +        mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
> +        return;
> +    }

Checking side-effects can be avoided with a bool flag:

  if (!mon->qmp_commands_needs_free) {
      return;
  }

Any place that allocates qmp.commands must set this flag and then we
don't need to worry whether we're checking the right side-effects in the
cleanup function.

I think this makes the code easier to read but it's just a suggestion.

> diff --git a/qemu-options.hx b/qemu-options.hx
> index 521511ec13..e5d1b7dfb5 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3195,12 +3195,16 @@ Like -qmp but uses pretty JSON formatting.
>  ETEXI
> =20
>  DEF("mon", HAS_ARG, QEMU_OPTION_mon, \
> -    "-mon [chardev=3D]name[,mode=3Dreadline|control][,pretty[=3Don|off]]=
\n", QEMU_ARCH_ALL)
> +    "-mon [chardev=3D]name[,mode=3Dreadline|control][,pretty[=3Don|off]]=
" \
> +    "[,whitelist=3Dfile]\n", QEMU_ARCH_ALL)
>  STEXI
> -@item -mon [chardev=3D]name[,mode=3Dreadline|control][,pretty[=3Don|off]]
> +@item -mon [chardev=3D]name[,mode=3Dreadline|control][,pretty[=3Don|off]=
][,whitelist=3D@var{file}]

Your change reminded me that "[chardev=3D]name" should be
"[chardev=3D]@var{name}" since 'name' isn't a string literal but a
variable.

This is a pre-existing issue but please add a patch to this series to
fix it.

>  @findex -mon
>  Setup monitor on chardev @var{name}. @code{pretty} turns on JSON pretty =
printing
>  easing human reading and debugging.
> +The @code{whitelist} option disables all commands except those specified=
 in
> +@var{file}. The file must contain one command name per line. This option=
 is only
> +avaliable in 'control' mode.

s/avaliable/available/

--LSp5EJdfMPwZcMS1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcU7jGAAoJEJykq7OBq3PIP60H/0Z2Afmdqx8iRISK0mIxvYZt
2hrOXfMbxgI3kiEgv0HpJnzyWY4HzjwTSg7+mk0CXYt6hoyri1xCycwLLlc8xREP
oWrMp83l5iPqrEcYFCPraIQHbt/b9meq4Kl5HAX4vkrRvZjZXYZrY3ghCxCImUn7
4pwirBkh+2dgUPcKneVsvd0/xZYhxgcdNX3GNNOXijlITKuhM93QQKnYZjrXEOtF
56Gza29sPyj3Q2kCeK6vlULzFSi9vQTDlNBSpsfvfTZtIZa7j3xECyw5Erx5xm/H
IsIALQFtqbPiLRLBxGTsVMUY9C+R3JVfmBVHriCRWdz9kaS3uGJ1H8nlXxKo9u4=
=3h9f
-----END PGP SIGNATURE-----

--LSp5EJdfMPwZcMS1--
