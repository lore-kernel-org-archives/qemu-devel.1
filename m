Received: from eggs.gnu.org ([2001:4830:134:3::10]:58170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp3DE-00016E-UB
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp3DA-0003hs-1m
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:03:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp3D9-0003hM-Ra
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:03:31 -0400
Date: Tue, 5 Sep 2017 10:03:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170905020325.GC22515@lemon.lan>
References: <20170831064302.14427-1-famz@redhat.com>
	<20170831064302.14427-4-famz@redhat.com>
	<3e83fff4-2a8d-f16b-51cd-9d99441f443d@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3e83fff4-2a8d-f16b-51cd-9d99441f443d@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 03/12] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Fri, 09/01 17:31, Philippe Mathieu-Daud=E9 wrote:
> On 08/31/2017 03:42 AM, Fam Zheng wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >   scripts/archive-source.sh | 29 +++++++++++++++++++++++++++++
> >   1 file changed, 29 insertions(+)
> >   create mode 100755 scripts/archive-source.sh
> >=20
> > diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> > new file mode 100755
> > index 0000000000..84e84961d4
> > --- /dev/null
> > +++ b/scripts/archive-source.sh
> > @@ -0,0 +1,29 @@
> > +#!/bin/sh
> > +#
> > +# Author: Fam Zheng <famz@redhat.com>
> > +#
> > +# Create archive of source tree, including submodules
> > +#
>=20
> It seems you missed the license here.

I can add one.

Fam

>=20
> > +
> > +set -e
> > +
> > +if test $# -lt 1; then
> > +    echo "Usage: $0 <output>"
> > +    exit 1
> > +fi
> > +
> > +submodules=3D$(git submodule foreach --recursive --quiet 'echo $name=
')
> > +
> > +if test -n "$submodules"; then
> > +    {
> > +        git ls-files
> > +        for sm in $submodules; do
> > +            (cd $sm; git ls-files) | sed "s:^:$sm/:"
> > +        done
> > +    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) =
> $1.list
> > +else
> > +    git ls-files > $1.list
> > +fi
> > +
> > +tar -cf $1 -T $1.list
> > +rm $1.list
> >=20
