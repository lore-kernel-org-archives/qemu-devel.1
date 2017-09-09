Received: from eggs.gnu.org ([2001:4830:134:3::10]:51638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqhLr-0008VV-S6
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqhLm-0007HQ-U6
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:07:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqhLm-0007GW-KW
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:07:14 -0400
Date: Sat, 9 Sep 2017 23:07:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170909150710.GA29670@lemon.lan>
References: <20170909054613.19148-1-famz@redhat.com>
	<20170909054613.19148-11-famz@redhat.com>
	<CAFEAcA83JDUMAsCAY=YBL+qS8A1n6VMfH1p_DAmouF0W8m-j9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA83JDUMAsCAY=YBL+qS8A1n6VMfH1p_DAmouF0W8m-j9g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v2 10/37] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Sat, 09/09 13:07, Peter Maydell wrote:
> On 9 September 2017 at 06:45, Fam Zheng <famz@redhat.com> wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > Message-Id: <20170905021201.25684-4-famz@redhat.com>
> > ---
> >  scripts/archive-source.sh | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100755 scripts/archive-source.sh
> >
> > diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> > new file mode 100755
> > index 0000000000..1de369532e
> > --- /dev/null
> > +++ b/scripts/archive-source.sh
> > @@ -0,0 +1,31 @@
> > +#!/bin/sh
> > +#
> > +# Author: Fam Zheng <famz@redhat.com>
> > +#
> > +# Create archive of source tree, including submodules
> > +#
> > +# This code is licensed under the GPL version 2 or later.  See
> > +# the COPYING file in the top-level directory.
> 
> So is this the script that for instance Mike Roth would use
> to create the release tarballs? If it isn't, should it be?

I don't know the workflow of release tarballs, there is ./scripts/make-release
for that. So this one is not.

> Is it intended for end users to create tarballs with, or
> is it really just a helper script for the docker stuff?
> If the latter, it would be helpful to say so. If the former,
> it could really use more usage information/documentation...

I'm not sure what end users would use this for, but it should do its work just
the same.. What kind of usage information do you suggest? More explaination in
the header, or in the "usage" output when no target is specified, or a "-h"
option for help?

> 
> > +
> > +set -e
> > +
> > +if test $# -lt 1; then
> > +    echo "Usage: $0 <output>"
> > +    exit 1
> > +fi
> > +
> > +submodules=$(git submodule foreach --recursive --quiet 'echo $name')
> > +
> > +if test -n "$submodules"; then
> > +    {
> > +        git ls-files
> > +        for sm in $submodules; do
> > +            (cd $sm; git ls-files) | sed "s:^:$sm/:"
> > +        done
> > +    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) > $1.list
> 
> Supporting '-e something' in a tar -T listfile seems to
> be GNU tar specific. Do we care?

The "-e $sm" will go to the grep command line, so it isn't GNU specific, is it?

> 
> > +else
> > +    git ls-files > $1.list
> > +fi
> 
> This will blow up if we ever have a file in the repo
> that starts with a '-'. Do we care?

I'm sure such a file will be a trouble, but I'd rather we deal with it when
there is one: I don't think anyone will think about adding, or welcome such a
file.

> 
> > +
> > +tar -cf $1 -T $1.list
> > +rm $1.list
> 
> This is missing a lot of quoting for $1, so it will go wrong
> if there's a space in that filename argument.

Yes, good point. I will fix it before sending another pull request along with
other comments that are just raised.

Fam
