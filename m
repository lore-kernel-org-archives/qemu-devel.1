Received: from eggs.gnu.org ([2001:4830:134:3::10]:42300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dn2W9-0003NT-BE
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dn2W8-0006R6-5U
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:54:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dn2W7-0006QS-Sk
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:54:48 -0400
Date: Wed, 30 Aug 2017 20:54:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170830125427.GA8076@lemon.lan>
References: <20170824072202.26818-1-stefanha@redhat.com>
	<20170824083843.GB1866@lemon>
	<20170824180402.GA4368@stefanha-x1.localdomain>
	<20170825073229.GC11465@lemon.lan>
	<20170825085222.GA9688@stefanha-x1.localdomain>
	<20170825092914.GI11465@lemon.lan>
	<20170830124411.GN24565@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830124411.GN24565@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 0/3] iotests: clean up resources using
 context managers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, 08/30 13:44, Stefan Hajnoczi wrote:
> On Fri, Aug 25, 2017 at 05:29:14PM +0800, Fam Zheng wrote:
> > On Fri, 08/25 09:52, Stefan Hajnoczi wrote:
> > > On Fri, Aug 25, 2017 at 03:32:29PM +0800, Fam Zheng wrote:
> > > > On Thu, 08/24 19:04, Stefan Hajnoczi wrote:
> > > > > On Thu, Aug 24, 2017 at 04:38:43PM +0800, Fam Zheng wrote:
> > > > > > On Thu, 08/24 08:21, Stefan Hajnoczi wrote:
> > > > > > > Tests should declare resources upfront in a with statement.  Resources are
> > > > > > > automatically cleaned up whether the test passes or fails:
> > > > > > > 
> > > > > > >   with FilePath('test.img') as img_path,
> > > > > > >        VM() as vm:
> > > > > > >       ...test...
> > > > > > >   # img_path is deleted and vm is shut down automatically
> > > > > > 
> > > > > > Looks good but still requires test writers to learn and remember to use FilePath
> > > > > > and with.
> > > > > 
> > > > > You cannot forget to use FilePath() unless you love typing at
> > > > > os.path.join(iotests.test_dir, 'test.img').  It's much better than open
> > > > > coding filename generation!
> > > > > 
> > > > > > These are still boilerplates.  Here goes my personal oppinion, so may
> > > > > > not be plausible:
> > > > > > 
> > > > > > - For VM() maybe add an atexit in the launch() method also makes sure the VM is
> > > > > >   eventually terminated.
> > > > > > 
> > > > > >   This means vm.shutdown() is still needed in tearDown() if there are multiple
> > > > > >   test methods and each of them expects a clean state, but that is probably
> > > > > >   still less typing (and also indenting) than the with approach, and also easy
> > > > > >   to remember (otherwise a test will fail).
> > > > > 
> > > > > I looked into atexit before going this route.  atexit does not have an
> > > > > unregister() API in Python 2.  This makes it ugly to use because some
> > > > > tests do not want the resource to remain for the duration of the
> > > > > process.
> > > > > 
> > > > > A related point is that the Python objects used by atexit handlers live
> > > > > until the end of the process.  They cannot be garbage collected because
> > > > > the atexit handler still has a reference to them.
> > > > 
> > > > I think this shortcoming can be solved with a clean up list ("all problems in
> > > > computer science can be solved by another level of indirection"):
> > > > 
> > > > _clean_up_list = set()
> > > > def _clean_up_handler():
> > > >     for i in _clean_up_list:
> > > >         try:
> > > >             i()
> > > >         except:
> > > >             pass
> > > > 
> > > > atexit.register(_clean_up_handler)
> > > > 
> > > > class VM(...):
> > > > 
> > > >     def launch():
> > > >         ...
> > > >         _clean_up_list.add(self.launch)
> > > > 
> > > >     def shutdown():
> > > >         _clean_up_list.remove(self.launch)
> > > >         ...
> > > 
> > > atexit is still less powerful than context managers because its scope is
> > > fixed.  Handler functions are only called when the process terminates.
> > > Many test cases do not want resources (especially the VMs) around
> > > forever because they run several iterations or sub-tests.
> > > 
> > > The with statement can be used both for process-lifetime and for more
> > > fine-grained scoping.  That's why I chose it.
> > > 
> > > If you stick to atexit then sub-tests or iterations require manual
> > > vm.shutdown() - something that is not necessary using the with
> > > statement.
> > 
> > Sure!
> > 
> > I just think that if leftover VM instances are a concern and not all test code
> > are converted to "with", having the atexit handler in addition may provide more
> > robustness.
> 
> Okay, I checked this.  Existing code doesn't need to be changed (yet)
> because:
> 
> 1. Most existing code uses unittest's setUp()/tearDown() and already
>    correctly handles cleanup when the test fails.
> 
> 2. The LUKS crypto test doesn't use unittest but also doesn't use VM(),
>    so it doesn't need.
> 
> Are you happy for me to merge this series?

Yes. Sounds good! Thanks.

Fam
