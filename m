Received: from eggs.gnu.org ([209.51.188.92]:39172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkYf6-0008EK-Lk
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:14:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkYf1-00052F-2C
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:14:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gkYew-0004yC-CZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:14:27 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EB7937E8F
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 18:14:24 +0000 (UTC)
References: <20190118173103.4903-1-berrange@redhat.com>
	<20190118173103.4903-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64c2ec84-8950-3c58-0ca7-d54c1a9438d2@redhat.com>
Date: Fri, 18 Jan 2019 12:14:14 -0600
MIME-Version: 1.0
In-Reply-To: <20190118173103.4903-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jWfykcYV3ToPqnaYNtjwWaPZ7hUnSxyOX"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] trace: add ability to do simple
 printf logging via systemtap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jWfykcYV3ToPqnaYNtjwWaPZ7hUnSxyOX
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <64c2ec84-8950-3c58-0ca7-d54c1a9438d2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] trace: add ability to do simple
 printf logging via systemtap
References: <20190118173103.4903-1-berrange@redhat.com>
 <20190118173103.4903-5-berrange@redhat.com>
In-Reply-To: <20190118173103.4903-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/18/19 11:31 AM, Daniel P. Berrang=C3=A9 wrote:
> The dtrace systemtap trace backend for QEMU is very powerful but it is
> also somewhat unfriendly to users who aren't familiar with systemtap,
> or who don't need its power right now.
>=20
>   stap -e "....some strange script...."
>=20

> We go one step further though and introduce a 'qemu-trace-stap' tool to=

> make this even easier
>=20
>  $ qemu-trace-stap run qemu-system-x86_64 qio*
>  22806@1547735341399856820 qio_channel_socket_new Socket new ioc=3D0x56=
135d1d7c00

One thing I did not immediately get on the first read, and therefore
which may be worth mentioning in the docs portion of the patch:

Am I correct that stap is always run as a separate process from the
process(es) being traced, and that you can start the two in either order
(qemu first, then stap; or stap first, then qemu), where the tracing is
effectively output as long as both processes are running and trace
points being hit in the qemu process?


> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  Makefile                             |   3 +
>  Makefile.target                      |  11 +-
>  docs/devel/tracing.txt               |  32 +++++
>  scripts/qemu-trace-stap              | 167 +++++++++++++++++++++++++++=

>  scripts/tracetool/format/log_stap.py | 127 ++++++++++++++++++++

Overall, I'm impressed with the concept, but my familiarity with stap
and python is weak enough that I'm not leaving a formal R-b.  Still,
I'll give it a shot at looking for anything that stands out as I read
through.

>  5 files changed, 339 insertions(+), 1 deletion(-)
>  create mode 100755 scripts/qemu-trace-stap
>  create mode 100644 scripts/tracetool/format/log_stap.py
>=20
> diff --git a/Makefile b/Makefile
> index dccba1dca2..22e481e7ba 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -736,6 +736,9 @@ endif
>  ifneq ($(HELPERS-y),)
>  	$(call install-prog,$(HELPERS-y),$(DESTDIR)$(libexecdir))
>  endif
> +ifdef CONFIG_TRACE_SYSTEMTAP
> +	$(INSTALL_PROG) "scripts/qemu-trace-stap" $(DESTDIR)$(bindir)
> +endif

No man page being installed?  If we're planning on this binary being
available on a similar par with qemu-io, it deserves some installed
documentation.


> +++ b/docs/devel/tracing.txt
> @@ -317,6 +317,38 @@ probes:
>                           --target-name x86_64 \
>                           <trace-events-all >qemu.stp
> =20
> +To facilitate simple usage of systemtap where there merely needs to be=
 printf
> +logging of certain probes, a helper script "qemu-trace-stap" is provid=
ed
> +

Trailing '.' would look better

> +This can list all probes available for a given QEMU emulator binary:
> +
> +     $ qemu-trace-stap list qemu-system-x86_64
> +     ahci_check_irq
> +     ahci_cmd_done
> +     ahci_dma_prepare_buf
> +     ahci_dma_prepare_buf_fail
> +     ahci_dma_rw_buf
> +     ahci_irq_lower
> +     ...snip...
> +
> +Optionally restricted to a pattern prefix:
> +
> +     $ qemu-trace-stap list qemu-system-x86_64 qio*
> +     qio_channel_command_abort
> +     qio_channel_command_new_pid
> +     qio_channel_command_new_spawn
> +     qio_channel_command_wait
> +     qio_channel_file_new_fd
> +     ...snip...
> +
> +It can then run a simple systemtap script which prints each requested =
probe

Trailing ':' would look better

> +
> +     $ qemu-trace-stap run qemu-system-x86_64 qio*
> +     22806@1547735341399856820 qio_channel_socket_new Socket new ioc=3D=
0x56135d1d7c00
> +     22806@1547735341399862570 qio_task_new Task new task=3D0x56135cd6=
6eb0 source=3D0x56135d1d7c00 func=3D0x56135af746c0 opaque=3D0x56135bf0640=
0
> +     22806@1547735341399865943 qio_task_thread_start Task thread start=
 task=3D0x56135cd66eb0 worker=3D0x56135af72e50 opaque=3D0x56135c071d70
> +     22806@1547735341399976816 qio_task_thread_run Task thread run tas=
k=3D0x56135cd66eb0
> +

> +++ b/scripts/qemu-trace-stap

> +
> +def main():
> +    parser =3D argparse.ArgumentParser(description=3D"QEMU SystemTap t=
race tool")
> +
> +    subparser =3D parser.add_subparsers(help=3D"commands")
> +    subparser.required =3D True
> +    subparser.dest =3D "command"
> +
> +    runparser =3D subparser.add_parser("run", help=3D"Run a trace sess=
ion",
> +                                     formatter_class=3Dargparse.RawDes=
criptionHelpFormatter,
> +                                     epilog=3D"""
> +
> +To watch all trace points on the qemu-system-x86_64 binary:
> +
> +   %(argv0)s run qemu-system-x86_64
> +
> +To only watch the trace points matching the qio* and qcrypto* patterns=

> +
> +   %(argv0)s run qemu-system-x86_64 qio* qcrypto*

This output is not copy-pastable - it includes shell globs which might
inadvertantly expand based on the contents of $PWD. Should you amend the
output to be properly quoted for reuse in shell commands?

> +""" % {"argv0": sys.argv[0]})
> +    runparser.set_defaults(func=3Dcmd_run)
> +    runparser.add_argument("-v", "--verbose", help=3D"Print verbose pr=
ogress info",
> +                           action=3D'store_true')
> +    runparser.add_argument("binary", help=3D"QEMU system or user emula=
tor binary")
> +    runparser.add_argument("probes", help=3D"Probe names or wildcards"=
,
> +                           nargs=3Dargparse.REMAINDER)
> +
> +    listparser =3D subparser.add_parser("list", help=3D"List probe poi=
nts",
> +                                      formatter_class=3Dargparse.RawDe=
scriptionHelpFormatter,
> +                                      epilog=3D"""
> +
> +To list all trace points on the qemu-system-x86_64 binary:
> +
> +   %(argv0)s list qemu-system-x86_64
> +
> +To only list the trace points matching the qio* and qcrypto* patterns
> +
> +   %(argv0)s list qemu-system-x86_64 qio* qcrypto*

and again

> +""" % {"argv0": sys.argv[0]})
> +    listparser.set_defaults(func=3Dcmd_list)
> +    listparser.add_argument("-v", "--verbose", help=3D"Print verbose p=
rogress info",
> +                            action=3D'store_true')
> +    listparser.add_argument("binary", help=3D"QEMU system or user emul=
ator binary")
> +    listparser.add_argument("probes", help=3D"Probe names or wildcards=
",
> +                            nargs=3Dargparse.REMAINDER)
> +
> +    args =3D parser.parse_args()
> +
> +    args.func(args)
> +    sys.exit(0)
> +
> +if __name__ =3D=3D '__main__':
> +    main()
> diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/f=
ormat/log_stap.py
> new file mode 100644
> index 0000000000..3ccbc09d61
> --- /dev/null
> +++ b/scripts/tracetool/format/log_stap.py
> @@ -0,0 +1,127 @@
> +#!/usr/bin/env python
> +# -*- coding: utf-8 -*-
> +
> +"""
> +Generate .stp file that printfs log messages (DTrace with SystemTAP on=
ly).
> +"""
> +
> +__author__     =3D "Daniel P. Berrange <berrange@redhat.com>"
> +__copyright__  =3D "Copyright (C) 2014-2019, Red Hat, Inc."
> +__license__    =3D "GPL version 2 or (at your option) any later versio=
n"
> +
> +__maintainer__ =3D "Daniel Berrange"
> +__email__      =3D "berrange@redhat.com"
> +
> +import re
> +
> +from tracetool import out
> +from tracetool.backend.dtrace import binary, probeprefix
> +from tracetool.backend.simple import is_string
> +from tracetool.format.stap import stap_escape
> +
> +def global_var_name(name):
> +    return probeprefix().replace(".", "_") + "_" + name
> +
> +STATE_SKIP =3D 0
> +STATE_LITERAL =3D 1
> +STATE_MACRO =3D 2
> +
> +def c_macro_to_format(macro):
> +    if macro.startswith("PRI"):
> +        return macro[3]
> +
> +    if macro =3D=3D "TARGET_FMT_plx":
> +        return "%016x"

Do we really want to permit TARGET_FMT in our trace-events files, or
should that be fixed in hw/tpm/trace-events?  See commit 73ff0610.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--jWfykcYV3ToPqnaYNtjwWaPZ7hUnSxyOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxCF3YACgkQp6FrSiUn
Q2rZTQf/SnxFCA4Ciz4cedDtZOPgU1fhvxzJ6V0Ih/T2XYe0PpH6lbPJnjR/LtOv
qJLGgt7wMZTy8iYAxwVW4qmINaFuiTI6yrDoCN8dFyPI/fkOCnMRrvNovdflQn94
yiN3E6qDGFPKDTMr/CYWdrx6mLSnNZSI/Q0iWRNalFrIzdIS/NNpDjHHQlLYC6GF
q0QYQFspP59dhqwcWvU/Sv3h5OkaTkhq6xLaZSjPMtH5Wa+X1YoUsE1EhFTXlUB5
Yr4QRXySRPR6PDQshrj8YBTjgeXJaMQK2+wcExynkAReWJDNfSAA7GcxHIaiLJ4w
a2xIea/o8j4xaWPyKr2tp12ThfAL1Q==
=P6KT
-----END PGP SIGNATURE-----

--jWfykcYV3ToPqnaYNtjwWaPZ7hUnSxyOX--
