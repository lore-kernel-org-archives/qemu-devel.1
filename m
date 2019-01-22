Received: from eggs.gnu.org ([209.51.188.92]:57555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm1In-0008N5-La
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm1Ig-0004xP-Oc
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:01:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gm1Ic-0004vb-1B
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:01:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3AE4124D35
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 17:42:32 +0000 (UTC)
References: <20190122164940.29244-1-berrange@redhat.com>
	<20190122164940.29244-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c97c34e6-f7ef-88b4-6958-da54ec1767d7@redhat.com>
Date: Tue, 22 Jan 2019 11:42:31 -0600
MIME-Version: 1.0
In-Reply-To: <20190122164940.29244-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7yJRDE6cwPKaqPG0c8pOwmI1u82b1p10x"
Subject: Re: [Qemu-devel] [PATCH v3 4/4] trace: add ability to do simple
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7yJRDE6cwPKaqPG0c8pOwmI1u82b1p10x
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <c97c34e6-f7ef-88b4-6958-da54ec1767d7@redhat.com>
Subject: Re: [PATCH v3 4/4] trace: add ability to do simple printf logging via
 systemtap
References: <20190122164940.29244-1-berrange@redhat.com>
 <20190122164940.29244-5-berrange@redhat.com>
In-Reply-To: <20190122164940.29244-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/22/19 10:49 AM, Daniel P. Berrang=C3=A9 wrote:
> The dtrace systemtap trace backend for QEMU is very powerful but it is
> also somewhat unfriendly to users who aren't familiar with systemtap,
> or who don't need its power right now.
>=20
>   stap -e "....some strange script...."
>=20

> By default it monitors all existing running processes and all future
> launched proceses. This can be restricted to a specific PID using the
> --pid arg
>=20
>  $ qemu-trace-stap run --pid 2532 qemu-system-x86_64 'qio*'
>=20

Can --pid mode be smart enough to check /proc/NNN/exe without the user
having to specify the explicit qemu-system-x86_64 argument?  (Could be
followup patch)

> +++ b/scripts/qemu-trace-stap
> @@ -0,0 +1,174 @@

> +#  QEMU SystemTap Trace Tool
> +#
> +#  This program is free software; you can redistribute it and/or modif=
y
> +#  it under the terms of the GNU General Public License as published b=
y
> +#  the Free Software Foundation; under version 2 of the License.
> +#

Why GPLv2-only?

> +def main():
> +    parser =3D argparse.ArgumentParser(description=3D"QEMU SystemTap t=
race tool")
> +    parser.add_argument("-v", "--verbose", help=3D"Print verbose progr=
ess info",
> +                        action=3D'store_true')
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
> +   %(argv0)s run qemu-system-x86_64 'qio*' 'qcrypto*'
> +""" % {"argv0": sys.argv[0]})
> +    runparser.set_defaults(func=3Dcmd_run)
> +    runparser.add_argument("--pid", "-p", dest=3D"pid",
> +                           help=3D"Restrict tracing to a specific proc=
ess ID")
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

No mention of --pid mode in the --help output?

> +++ b/scripts/qemu-trace-stap.texi
> @@ -0,0 +1,139 @@
> +@example
> +@c man begin SYNOPSIS
> +@command{qemu-trace-stap} @var{GLOBAL-OPTIONS} @var{COMMAND} @var{COMM=
AND-OPTIONS} @var{ARGS...}
> +@c man end
> +@end example
> +
> +@c man begin DESCRIPTION
> +
> +The @command{qemu-trace-stap} program facilitates tracing of the execu=
tion
> +of QEMU emulators using SystemTap.
> +
> +It is required to have the SystemTap runtime environment installed to =
use
> +this program, since it is a wrapper around execution of the @command{s=
tap}
> +program.
> +
> +@c man end
> +
> +@c man begin OPTIONS
> +
> +The following global options may be used regardless of which command
> +is executed
> +

Could use trailing ':'

> +@table @option
> +@item @var{--verbose}, @var{-v}
> +
> +Display verbose information about command execution

Trailing '.'


> +@item @var{run} @var{OPTIONS} @var{BINARY} @var{PATTERN...}
> +
> +Run a trace session, printing formatted output any time a process that=
 is
> +executing @var{BINARY} triggers a probe matching @var{PATTERN}.
> +
> +If @var{BINARY} is not an absolute path, it will be located by searchi=
ng
> +the directories listed in the @code{$PATH} environment variable.
> +
> +@var{PATTERN} is a plain string that matches a probe name shown by the=

> +@var{list} command. It may optionally contain a @code{*} wildcard to
> +facilitate matching multiple probes without listing each one explicitl=
y.
> +Multiple @var{PATTERN} arguments may be given, causing all matching pr=
obes
> +to be monitored. At least one @var{PATTERN} is required, since stap is=
 not
> +capable of tracing all known QEMU probes concurrently without overflow=
ing
> +its trace buffer.
> +
> +Invokation of this command does not need to be synchronized with

s/Invokation/Invocation/

> +invokation of the QEMU process(es). It will match probes on all

and again

> +existing running processes and all future launched processes,
> +unless told to only monitor a specific procss.

s/procss/process/

> +
> +Valid command specific options are:
> +
> +@table @option
> +@item @var{--pid=3DPID}, @var{-p PID}
> +
> +Restrict the tracing session so that it only triggers for the process
> +identified by @code{PID}.
> +
> +@end table
> +
> +For example, to monitor all processes executing @command{qemu-system-x=
86_64},

Maybe "executing @command{qemu-system-x86_64} as found on $PATH,"


> +@setfilename qemu-trace-stap
> +@settitle QEMU SystemTap trace tool
> +
> +@c man begin LICENSE
> +
> +Copyright (C) 2018 Red Hat, Inc.

Welcome to 2019

> +
> +This program is free software; you can redistribute it and/or modify
> +it under the terms of the GNU General Public License as published by
> +the Free Software Foundation; under version 2 of the License.

Why GPLv2-only?

> +
> +@c man end
> +
> +@c man begin SEEALSO
> +qemu(1), stap(1)
> +@c man end
> +
> +@end ignore
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

At least this file is GPLv2+.

Typos are trivial, licensing less so, but I trust you can fix licensing
without me having to see a respin (as it won't change code).  So:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--7yJRDE6cwPKaqPG0c8pOwmI1u82b1p10x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxHVgcACgkQp6FrSiUn
Q2rc6Af+Jh1lGihFS3+9kgRRVVGFsNwrRWfjcolPiN9uqJUnx6M2SqdflYO7mPh6
mxn6NYupmVl23GV2vhgDGUgV1OGaOd5RWI93G9oyqQhje0o7Uk+x+4z7md6IyFR/
FpodSlbolBIqAgCzqqTN2qCM71B4xJEvCLqPjQtMbT6arn5YZve2jeNP4xXBGLQU
gVB5yZ0ggyJ63vc7RPVOUuZEFhx39h9KC+ct0u9m/qxZSaXqdWd366hixbhQoi/b
nbMd7tJVynX1bkvz7WTOTDtnQioi5N3zv0odvD5DWdd12Q2GN75xA2k9OebjjJTw
Ojq2jo5SNTwpbsfYZRuns3AGJoCeXQ==
=R0th
-----END PGP SIGNATURE-----

--7yJRDE6cwPKaqPG0c8pOwmI1u82b1p10x--
