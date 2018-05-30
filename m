Received: from eggs.gnu.org ([2001:4830:134:3::10]:39998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fO7Xv-0007zy-DJ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fO7H1-00066A-Qu
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:00:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fO7H1-000659-IC
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:00:43 -0400
Date: Wed, 30 May 2018 17:00:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180530200032.GF7451@localhost.localdomain>
References: <20180529193730.9204-1-crosa@redhat.com>
	<20180529193730.9204-4-crosa@redhat.com>
	<20180530125705.GL14623@stefanha-x1.localdomain>
	<20180530162949.GE7451@localhost.localdomain>
	<47189c37-afec-6366-e9e4-cae5999d9eb2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47189c37-afec-6366-e9e4-cae5999d9eb2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] Acceptance tests: add quick VNC
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>

On Wed, May 30, 2018 at 02:00:48PM -0400, Cleber Rosa wrote:
> 
> 
> On 05/30/2018 12:29 PM, Eduardo Habkost wrote:
> > On Wed, May 30, 2018 at 01:57:05PM +0100, Stefan Hajnoczi wrote:
> >> On Tue, May 29, 2018 at 03:37:28PM -0400, Cleber Rosa wrote:
> >>> This patch adds a few simple behavior tests for VNC.
> >>>
> >>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> >>> ---
> >>>  tests/acceptance/vnc.py | 60 +++++++++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 60 insertions(+)
> >>>  create mode 100644 tests/acceptance/vnc.py
> >>>
> >>> diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
> >>> new file mode 100644
> >>> index 0000000000..b1ef9d71b1
> >>> --- /dev/null
> >>> +++ b/tests/acceptance/vnc.py
> >>> @@ -0,0 +1,60 @@
> >>> +# Simple functional tests for VNC functionality
> >>> +#
> >>> +# Copyright (c) 2018 Red Hat, Inc.
> >>> +#
> >>> +# Author:
> >>> +#  Cleber Rosa <crosa@redhat.com>
> >>> +#
> >>> +# This work is licensed under the terms of the GNU GPL, version 2 or
> >>> +# later.  See the COPYING file in the top-level directory.
> >>> +
> >>> +from avocado_qemu import Test
> >>> +
> >>> +
> >>> +class Vnc(Test):
> >>> +    """
> >>> +    :avocado: enable
> >>> +    :avocado: tags=vnc,quick
> >>> +    """
> >>> +    def test_no_vnc(self):
> >>> +        self.vm.add_args('-nodefaults', '-S')
> >>> +        self.vm.launch()
> >>
> >> If this pattern becomes very common maybe vm.launch() should become
> >> vm.launch(*extra_args) to make this a one-liner:
> >>
> >>   self.vm.launch('-nodefaults', '-S')
> > 
> > I think this was suggested in the past:
> > 
> >   self.vm.add_args(...).launch()
> > 
> > This style would be useful if we add other methods that change
> > QEMU options in addition to raw add_args().  e.g.:
> > 
> >   self.vm.add_args(...).add_console(...).add_drive(...).launch()
> > 
> 
> Yes, this is an old discussion indeed.  IMO, method chaining can look
> attractive at first, but it will quickly bring a few new issues to be
> dealt with.

Which new issues?  I don't see any below.

> 
> For once, it brings the assumption that it can be done for all methods.
>  Using the previous example I'd expect to be able to do:
> 
>    self.vm.add_args(...).launch(...).migrate(...).shutdown()
> 
> Which seems fine, but now the code is plagued with "return self" statements.

Why the "return self" would be a problem?


> 
> Then, code style and indentation questions will quickly arise.  Either this:
> 
>    self.vm.add_args('-nodefaults', '-S').add_console('isa-serial') \
>           .add_drive(file='/path/to/file, format='raw').launch() \
>           .shutdown()

Maybe it's a matter of personal taste, but I don't see a problem
with this:

    self.vm.add_args('-nodefaults', '-S') \
        .add_console('isa-serial') \
        .add_drive(file='/path/to/file, format='raw') \
        .launch() \
        .shutdown()

> 
> Or this:
> 
>    (self.vm.add_args('-nodefaults', '-S').add_console('isa-serial')
>            .add_drive(file='/path/to/file, format='raw').launch()
>            .shutdown())

If you end up with very complex chains like above, you are still
free to split it into multiple statements.

I don't see why this would be an argument against making this
possible:

  self.vm.add_args('-nodefaults', '-S').launch()


> 
> Looks just as bad to me.  The non-method chaining syntax would look like:
> 
>    self.vm.add_args('-nodefaults', '-S')
>    self.vm.add_console('isa-serial')
>    self.vm.add_drive(file='/path/to/file, format='raw')
>    self.vm.launch()
>    self.vm.shutdown()

This is reasonable style if the .add_*() calls don't fit on a
single line.


> 
> Or even:
> 
>    with self.vm as vm:
>       vm.add_args('-nodefaults', '-S')
>       vm.add_console('isa-serial')
>       vm.add_drive(file='/path/to/file, format='raw')
>       vm.launch()
>    # shutdown() called on __exit__()

I don't like the extra indentation level, but people are free to
use this style.

(BTW, I think avocado_qemu must call shutdown() automatically
instead of requiring test code to do it manually.)


> 
> Which IMO, are superior in readability and clarity.  This is a matter of
> choosing a style, so that we can expect (demand?) that tests follow it.

They are more readable than the complex method chaining examples
you have shown, but I don't see any argument against:

  self.vm.add_args(...).launch()


> 
> I'm certainly less experienced with the project dynamics than most here,
> so I'm strongly hoping for your input to quickly define the code style
> to be used here.
> 
> Because of that, I'll skip changing anything here on v4.

Agreed: I don't think any changes to the add_args() style need to
be on v4.  I'd prefer to work to include avocado_qemu first, and
later consider how we can improve the qemu.py and avocado_qemu.py
APIs.

-- 
Eduardo
