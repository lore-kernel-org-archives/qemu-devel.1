Received: from eggs.gnu.org ([209.51.188.92]:38761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmHOu-0002gX-Jo
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:13:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmHBk-0002rm-6L
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:59:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmHBj-0002mz-JG
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:59:23 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 650AB80F6D
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 11:59:22 +0000 (UTC)
Date: Wed, 23 Jan 2019 11:59:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190123115908.GE27270@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190122164940.29244-1-berrange@redhat.com>
	<20190122164940.29244-5-berrange@redhat.com>
	<c97c34e6-f7ef-88b4-6958-da54ec1767d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c97c34e6-f7ef-88b4-6958-da54ec1767d7@redhat.com>
Content-Transfer-Encoding: quoted-printable
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Jan 22, 2019 at 11:42:31AM -0600, Eric Blake wrote:
> On 1/22/19 10:49 AM, Daniel P. Berrang=C3=A9 wrote:
> > The dtrace systemtap trace backend for QEMU is very powerful but it i=
s
> > also somewhat unfriendly to users who aren't familiar with systemtap,
> > or who don't need its power right now.
> >=20
> >   stap -e "....some strange script...."
> >=20
>=20
> > By default it monitors all existing running processes and all future
> > launched proceses. This can be restricted to a specific PID using the
> > --pid arg
> >=20
> >  $ qemu-trace-stap run --pid 2532 qemu-system-x86_64 'qio*'
> >=20
>=20
> Can --pid mode be smart enough to check /proc/NNN/exe without the user
> having to specify the explicit qemu-system-x86_64 argument?  (Could be
> followup patch)

It could do that, but this complicates the parsing of command line
arguments, as the binary is a positional arg.

> > +++ b/scripts/qemu-trace-stap
> > @@ -0,0 +1,174 @@
>=20
> > +#  QEMU SystemTap Trace Tool
> > +#
> > +#  This program is free software; you can redistribute it and/or mod=
ify
> > +#  it under the terms of the GNU General Public License as published=
 by
> > +#  the Free Software Foundation; under version 2 of the License.
> > +#
>=20
> Why GPLv2-only?

A mistake, it should be v2-or-later

>=20
> > +def main():
> > +    parser =3D argparse.ArgumentParser(description=3D"QEMU SystemTap=
 trace tool")
> > +    parser.add_argument("-v", "--verbose", help=3D"Print verbose pro=
gress info",
> > +                        action=3D'store_true')
> > +
> > +    subparser =3D parser.add_subparsers(help=3D"commands")
> > +    subparser.required =3D True
> > +    subparser.dest =3D "command"
> > +
> > +    runparser =3D subparser.add_parser("run", help=3D"Run a trace se=
ssion",
> > +                                     formatter_class=3Dargparse.RawD=
escriptionHelpFormatter,
> > +                                     epilog=3D"""
> > +
> > +To watch all trace points on the qemu-system-x86_64 binary:
> > +
> > +   %(argv0)s run qemu-system-x86_64
> > +
> > +To only watch the trace points matching the qio* and qcrypto* patter=
ns
> > +
> > +   %(argv0)s run qemu-system-x86_64 'qio*' 'qcrypto*'
> > +""" % {"argv0": sys.argv[0]})
> > +    runparser.set_defaults(func=3Dcmd_run)
> > +    runparser.add_argument("--pid", "-p", dest=3D"pid",
> > +                           help=3D"Restrict tracing to a specific pr=
ocess ID")
> > +    runparser.add_argument("binary", help=3D"QEMU system or user emu=
lator binary")
> > +    runparser.add_argument("probes", help=3D"Probe names or wildcard=
s",
> > +                           nargs=3Dargparse.REMAINDER)
> > +
> > +    listparser =3D subparser.add_parser("list", help=3D"List probe p=
oints",
> > +                                      formatter_class=3Dargparse.Raw=
DescriptionHelpFormatter,
> > +                                      epilog=3D"""
> > +
> > +To list all trace points on the qemu-system-x86_64 binary:
> > +
> > +   %(argv0)s list qemu-system-x86_64
>=20
> No mention of --pid mode in the --help output?

getopt generates --help output listing all arguments. The epilog is
just a bit of text to augment what it already prints



> Typos are trivial, licensing less so, but I trust you can fix licensing
> without me having to see a respin (as it won't change code).  So:
> Reviewed-by: Eric Blake <eblake@redhat.com>

Will incorporate these changes


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
