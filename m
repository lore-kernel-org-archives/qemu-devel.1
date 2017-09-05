Received: from eggs.gnu.org ([2001:4830:134:3::10]:42972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp3dQ-0006ER-M6
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp3dL-00042V-H8
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:30:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp3dL-00041w-4l
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:30:35 -0400
Date: Tue, 5 Sep 2017 10:30:31 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170905023031.GD22515@lemon.lan>
References: <20170901152200.5953-1-famz@redhat.com>
	<20170901152200.5953-4-famz@redhat.com>
	<dc1cf740-09d8-edfd-c953-e559395363cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc1cf740-09d8-edfd-c953-e559395363cd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, kchamart@redhat.com

On Fri, 09/01 13:35, Eric Blake wrote:
> On 09/01/2017 10:22 AM, Fam Zheng wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  tests/docker/test-block | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >  create mode 100755 tests/docker/test-block
> > 
> > diff --git a/tests/docker/test-block b/tests/docker/test-block
> > new file mode 100755
> > index 0000000000..efc77b4b91
> > --- /dev/null
> > +++ b/tests/docker/test-block
> > @@ -0,0 +1,22 @@
> > +#!/bin/bash -e
> 
> 'set -e' is awful; it exists for backwards-compatibility with shell
> scripts that pre-date functions, but is NOT intuitive and generally does
> NOT do what you want when shell functions are added to the mix.  You're
> better off doing manual error checking than relying on 'set -e' to check
> for errors on your behalf.
> 
> > +#
> > +# Run block test cases
> > +#
> > +# Copyright (c) 2017 Red Hat Inc.
> > +#
> > +# Authors:
> > +#  Fam Zheng <famz@redhat.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2
> > +# or (at your option) any later version. See the COPYING file in
> > +# the top-level directory.
> > +
> > +. common.rc
> 
> Are we sure that '.' is early enough on $PATH that this will pick up the
> right common.rc? Safer is '. ./common.rc'.
> 
> > +
> > +cd "$BUILD_DIR"
> > +
> > +build_qemu --target-list=x86_64-softmmu
> > +cd tests/qemu-iotests
> > +for t in raw qcow2 nbd luks; do
> > +    ./check -g quick -$t
> > +done
> 
> That said, this script (and common.rc) is small enough to verify that
> you probably aren't going to trip over those non-intuitive 'set -e'
> behaviors, so the real reason to avoid it is if we want to be able to
> copy-and-paste into other scripts that aren't using 'set -e' (on the
> premise that avoiding implicit global state, like 'set -e', and being
> explicit instead, is a good thing).

OK, I will revise this patch and drop set -e.

Fam
