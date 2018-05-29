Received: from eggs.gnu.org ([2001:4830:134:3::10]:49408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fNeXc-0002uC-QW
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fNeXZ-00048Q-In
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:19:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fNeXZ-00047K-A5
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:19:53 -0400
Date: Tue, 29 May 2018 10:19:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180529131950.GY8988@localhost.localdomain>
References: <20180525184219.14440-1-crosa@redhat.com>
	<20180525184219.14440-5-crosa@redhat.com>
	<8ce51f76-9a2d-4de3-c048-e0c27e16b09e@amsat.org>
	<da53d1ab-69c1-dedd-9f1a-efd57b7766ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <da53d1ab-69c1-dedd-9f1a-efd57b7766ea@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/5] scripts/qemu.py: introduce
 set_console() method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amador Pahim <amador@pahim.org>

On Tue, May 29, 2018 at 09:01:42AM -0400, Cleber Rosa wrote:
> On 05/26/2018 12:54 AM, Philippe Mathieu-Daud=E9 wrote:
> > Hi Cleber,
> >=20
> > On 05/25/2018 03:42 PM, Cleber Rosa wrote:
> >> The set_console() method is intended to ease higher level use cases
> >> that require a console device.
> >>
> >> The amount of intelligence is limited on purpose, requiring either t=
he
> >> device type explicitly, or the existence of a machine (pattern)
> >> definition.
> >>
> >> Because of the console device type selection criteria (by machine
> >> type), users should also be able to define that.  It'll then be used
> >> for both '-machine' and for the console device type selection.
> >>
> >> Users of the set_console() method will certainly be interested in
> >> accessing the console device, and for that a console_socket property
> >> has been added.
> >>
> >> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> >> ---
> >>  scripts/qemu.py      |  97 +++++++++++++++++++++-
> >>  scripts/test_qemu.py | 186 ++++++++++++++++++++++++++++++++++++++++=
+++
> >>  2 files changed, 282 insertions(+), 1 deletion(-)
> >>  create mode 100644 scripts/test_qemu.py
> >>
> >> diff --git a/scripts/qemu.py b/scripts/qemu.py
> >> index 7cd8193df8..f099ce7278 100644
> >> --- a/scripts/qemu.py
> >> +++ b/scripts/qemu.py
> >> @@ -17,19 +17,41 @@ import logging
> >>  import os
> >>  import subprocess
> >>  import qmp.qmp
> >> +import re
> >>  import shutil
> >> +import socket
> >>  import tempfile
> >> =20
> >> =20
> >>  LOG =3D logging.getLogger(__name__)
> >> =20
> >> =20
> >> +#: Maps machine types to the preferred console device types
> >=20
> > This could be QMP query-able...
> >=20
>=20
> I'm not an expert here, but IIRC Eduardo thinks that the best solution
> may be for these machine types to implement support for "-serial"
> instead.  When all machines do that, then this "set_console()" would
> default to adding a "-serial" argument if no device type is given.

Both 'query-machines' and '-serial' would be good solutions for
this, IMO.  But I don't think this should block the inclusion of
avocado_qemu.

>=20
> >> +CONSOLE_DEV_TYPES =3D {
> >> +    r'^clipper$': 'isa-serial',
> >> +    r'^malta': 'isa-serial',
> >> +    r'^(pc.*|q35.*|isapc)$': 'isa-serial',
> >> +    r'^(40p|powernv|prep)$': 'isa-serial',
> >> +    r'^pseries.*': 'spapr-vty',
> >> +    r'^s390-ccw-virtio.*': 'sclpconsole',
> >> +    }
> >> +
> >> +
[...]

--=20
Eduardo
