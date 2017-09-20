Received: from eggs.gnu.org ([2001:4830:134:3::10]:57930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duVF5-0002rH-8T
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 23:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duVF1-0007E6-Dk
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 23:00:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1duVF1-0007Cg-7F
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 22:59:59 -0400
Date: Wed, 20 Sep 2017 10:59:53 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170920025953.GD18491@lemon>
References: <20170919072719.11815-1-famz@redhat.com>
	<20170919072719.11815-4-famz@redhat.com>
	<4ffe9274-996f-8e16-4b79-583e54b17f54@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ffe9274-996f-8e16-4b79-583e54b17f54@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 03/13] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Tue, 09/19 10:10, Eric Blake wrote:
> On 09/19/2017 02:27 AM, Fam Zheng wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  scripts/archive-source.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100755 scripts/archive-source.sh
> > 
> > diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> > new file mode 100755
> > index 0000000000..e155d980ee
> > --- /dev/null
> > +++ b/scripts/archive-source.sh
> > @@ -0,0 +1,46 @@
> > +#!/bin/sh
> 
> Needs to be /bin/bash...
> 
> > +        git ls-files || error "git ls-files failed"
> > +        for sm in $submodules; do
> > +            (cd $sm; git ls-files) | sed "s:^:$sm/:"
> > +            if test ${PIPESTATUS[0]} -ne 0 -o $? -ne 0; then
> > +                error "git ls-files in submodule $sm failed"
> 
> ...because $PIPESTATUS is a useful bashism not present in dash, where
> the alternative is MUCH more verbose and painful to write in portable shell.
> 
> With just that fixed,
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> If desired, one other change (not mandatory, but if you want to do it,
> I'll want to re-review):
> 
> > +
> > +tar -cf "$1" -T "$1".list || error "failed to create tar file"
> 
> If we exit here, $1.list is not removed...
> 
> > +rm "$1".list
> 
> Should we make removal of the list be controlled by a cleanup trap, to
> always happen even if something else fails in the interim?  Or is
> leaving it around on failure useful for debugging?

Better to cleaned up. Will revise.

Fam
