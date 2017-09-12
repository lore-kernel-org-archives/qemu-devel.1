Received: from eggs.gnu.org ([2001:4830:134:3::10]:59070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1drYia-0003Cp-P4
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 20:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1drYiX-0006zy-K2
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 20:06:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1drYiX-0006zk-B2
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 20:06:17 -0400
Date: Tue, 12 Sep 2017 08:06:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170912000611.GE32341@lemon.lan>
References: <20170905021201.25684-1-famz@redhat.com>
	<20170905021201.25684-4-famz@redhat.com>
	<87vaktgskq.fsf@linaro.org> <20170908231419.GC18677@lemon.lan>
	<871sndbbbn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <871sndbbbn.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 03/12] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Mon, 09/11 14:43, Alex Benn=E9e wrote:
>=20
> Fam Zheng <famz@redhat.com> writes:
>=20
> > On Fri, 09/08 15:42, Alex Benn=E9e wrote:
> >>
> >> Fam Zheng <famz@redhat.com> writes:
> >>
> >> > Signed-off-by: Fam Zheng <famz@redhat.com>
> >> > ---
> >> >  scripts/archive-source.sh | 31 +++++++++++++++++++++++++++++++
> >> >  1 file changed, 31 insertions(+)
> >> >  create mode 100755 scripts/archive-source.sh
> >> >
> >> > diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> >> > new file mode 100755
> >> > index 0000000000..3cae7f34d3
> >> > --- /dev/null
> >> > +++ b/scripts/archive-source.sh
> >> > @@ -0,0 +1,31 @@
> >> > +#!/bin/sh
> >> > +#
> >> > +# Author: Fam Zheng <famz@redhat.com>
> >> > +#
> >> > +# Create archive of source tree, including submodules
> >> > +#
> >> > +# This work is licensed under the terms of the GNU GPL, version 2=
.
> >> > +# See the COPYING file in the top-level directory.
> >> > +
> >> > +set -e
> >> > +
> >> > +if test $# -lt 1; then
> >> > +    echo "Usage: $0 <output>"
> >>
> >> Maybe <output tarball> to make it clear what it creates?
> >
> > OK.
> >
> >>
> >> > +    exit 1
> >> > +fi
> >> > +
> >> > +submodules=3D$(git submodule foreach --recursive --quiet 'echo $n=
ame')
> >> > +
> >> > +if test -n "$submodules"; then
> >> > +    {
> >> > +        git ls-files
> >>
> >> Couldn't we do the main git ls-files first and then append the data =
for
> >> any submodules?
> >
> > Isn't that exactly what we are doing now?
>=20
> I mean hoist the git ls-files out of the if so we can avoid repeating
> with an else leg. e.g.
>=20
>   git ls-files > $1.list

The output of top "git ls-files" has to be filtered by grep if the submod=
ules
list is non-empty, so we cannot save LoC by hoisting.

Fam

>   if test -n "$submodules"; then
>   {
>     .. the rest..
>   } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) >> $1=
.list
>=20
> >
> > Fam
> >
> >>
> >> > +        for sm in $submodules; do
> >> > +            (cd $sm; git ls-files) | sed "s:^:$sm/:"
> >> > +        done
> >> > +    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; don=
e) > $1.list
> >> > +else
> >> > +    git ls-files > $1.list
> >> > +fi
> >> > +
> >> > +tar -cf $1 -T $1.list
> >> > +rm $1.list
> >>
> >>
> >> --
> >> Alex Benn=E9e
>=20
>=20
> --
> Alex Benn=E9e
