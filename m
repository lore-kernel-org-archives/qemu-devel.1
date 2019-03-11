Received: from eggs.gnu.org ([209.51.188.92]:53672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h3UhP-0000hW-73
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 19:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h3UhN-0008RS-B7
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 19:51:15 -0400
Date: Mon, 11 Mar 2019 19:50:58 -0400
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190311235058.tfilvrk3af2d74u6@localhost.localdomain>
References: <20190221005753.27955-1-crosa@redhat.com>
	<20190221005753.27955-8-crosa@redhat.com>
	<20190301113719.2111b521.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301113719.2111b521.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/20] Acceptance tests: look for target
 architecture in test tags first
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>

On Fri, Mar 01, 2019 at 11:37:19AM +0100, Cornelia Huck wrote:
> On Wed, 20 Feb 2019 19:57:40 -0500
> Cleber Rosa <crosa@redhat.com> wrote:
> 
> > A test can, optionally, be tagged for one or many architectures.  If a
> > test has been tagged for a single architecture, there's a high chance
> > that the test won't run on other architectures.  This changes the
> > default order of choosing a default target architecture to use based
> > on the 'arch' tag value first.
> > 
> > The precedence order is for choosing a QEMU binary to use for a test
> > is now:
> > 
> >  * qemu_bin parameter
> >  * arch parameter
> >  * arch tag value (for example, x86_64 if ":avocado: tags=arch:x86_64
> >    is used)
> > 
> > This means that if one runs:
> > 
> >  $ avocado run -p qemu_bin=/usr/bin/qemu-system-x86_64 test.py
> > 
> > No arch parameter or tag will influence the selection of the QEMU
> > target binary.  If one runs:
> > 
> >  $ avocado run -p arch=ppc64 test.py
> > 
> > The target binary selection mechanism will attempt to find a binary
> > such as "ppc64-softmmu/qemu-system-ppc64".  And finally, if one runs
> > a test that is tagged (in its docstring) with "arch:aarch64":
> > 
> >  $ avocado run aarch64.py
> > 
> > The target binary selection mechanism will attempt to find a binary
> > such as "aarch64-softmmu/qemu-system-aarch64".
> > 
> > At this time, no provision is made to cancel the execution of tests if
> > the arch parameter given (manually) does not match the test "arch"
> > tag, but it may be a useful default behavior to be added in the
> > future.
> 
> Would it be useful as well to cancel a test if the passed-in qemu_bin
> parameter clashed with the tagged architecture?
> 

It would... in fact, a much older version of this proposal did that.
I'm waiting for the most basic things to get in, before adding yet
another "special" behavior.

Thanks for the review and suggestion.
- Cleber.

> > 
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  docs/devel/testing.rst                    | 4 +++-
> >  tests/acceptance/avocado_qemu/__init__.py | 7 ++++++-
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> > index 6035db1b44..87bcf8ef43 100644
> > --- a/docs/devel/testing.rst
> > +++ b/docs/devel/testing.rst
> > @@ -702,7 +702,9 @@ A test may, for instance, use the same value when selecting the
> >  architecture of a kernel or disk image to boot a VM with.
> >  
> >  The ``arch`` attribute will be set to the test parameter of the same
> > -name, and if one is not given explicitly, it will be set to ``None``.
> > +name.  If one is not given explicitly, it will either be set to
> > +``None``, or, if the test is tagged with one (and only one)
> > +``:avocado: tags=arch:VALUE`` tag, it will be set to ``VALUE``.
> >  
> >  qemu_bin
> >  ~~~~~~~~
> > diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> > index f580582602..9e98d113cb 100644
> > --- a/tests/acceptance/avocado_qemu/__init__.py
> > +++ b/tests/acceptance/avocado_qemu/__init__.py
> > @@ -53,7 +53,12 @@ def pick_default_qemu_bin(arch=None):
> >  class Test(avocado.Test):
> >      def setUp(self):
> >          self.vm = None
> > -        self.arch = self.params.get('arch')
> > +        arches = self.tags.get('arch', [])
> > +        if len(arches) == 1:
> > +            arch = arches.pop()
> > +        else:
> > +            arch = None
> > +        self.arch = self.params.get('arch', default=arch)
> >          default_qemu_bin = pick_default_qemu_bin(arch=self.arch)
> >          self.qemu_bin = self.params.get('qemu_bin',
> >                                          default=default_qemu_bin)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
