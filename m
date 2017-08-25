Received: from eggs.gnu.org ([2001:4830:134:3::10]:58347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dl96e-0003Tx-0Z
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 03:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dl96Z-000246-RB
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 03:32:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dl96Z-00023R-If
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 03:32:35 -0400
Date: Fri, 25 Aug 2017 15:32:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170825073229.GC11465@lemon.lan>
References: <20170824072202.26818-1-stefanha@redhat.com>
	<20170824083843.GB1866@lemon>
	<20170824180402.GA4368@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170824180402.GA4368@stefanha-x1.localdomain>
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

On Thu, 08/24 19:04, Stefan Hajnoczi wrote:
> On Thu, Aug 24, 2017 at 04:38:43PM +0800, Fam Zheng wrote:
> > On Thu, 08/24 08:21, Stefan Hajnoczi wrote:
> > > Tests should declare resources upfront in a with statement.  Resources are
> > > automatically cleaned up whether the test passes or fails:
> > > 
> > >   with FilePath('test.img') as img_path,
> > >        VM() as vm:
> > >       ...test...
> > >   # img_path is deleted and vm is shut down automatically
> > 
> > Looks good but still requires test writers to learn and remember to use FilePath
> > and with.
> 
> You cannot forget to use FilePath() unless you love typing at
> os.path.join(iotests.test_dir, 'test.img').  It's much better than open
> coding filename generation!
> 
> > These are still boilerplates.  Here goes my personal oppinion, so may
> > not be plausible:
> > 
> > - For VM() maybe add an atexit in the launch() method also makes sure the VM is
> >   eventually terminated.
> > 
> >   This means vm.shutdown() is still needed in tearDown() if there are multiple
> >   test methods and each of them expects a clean state, but that is probably
> >   still less typing (and also indenting) than the with approach, and also easy
> >   to remember (otherwise a test will fail).
> 
> I looked into atexit before going this route.  atexit does not have an
> unregister() API in Python 2.  This makes it ugly to use because some
> tests do not want the resource to remain for the duration of the
> process.
> 
> A related point is that the Python objects used by atexit handlers live
> until the end of the process.  They cannot be garbage collected because
> the atexit handler still has a reference to them.

I think this shortcoming can be solved with a clean up list ("all problems in
computer science can be solved by another level of indirection"):

_clean_up_list = set()
def _clean_up_handler():
    for i in _clean_up_list:
        try:
            i()
        except:
            pass

atexit.register(_clean_up_handler)

class VM(...):

    def launch():
        ...
        _clean_up_list.add(self.launch)

    def shutdown():
        _clean_up_list.remove(self.launch)
        ...

> 
> The with statement's identation is annoying for straightforward scripts.
> More complex tests use functions anyway, so the indentation doesn't
> matter there - it can be hidden by a parent function or even a
> decorator.
> 
> > - For scratch how about adding atexit in iotests.main to clean up everything in
> >   the scratch directory? The rationale is similar to above.
> 
> If we decide to clear out TEST_DIR then it should be done in ./check,
> not by iotests.py, so that all tests get the same file cleanup behavior,
> regardless of the language they are written in.
> 
> Also, we can then chdir(iotests.test_dir) so filename generation isn't
> necessary at all.  Tests can simply use 'test.img'.  I guess there may
> be some cases where absolute paths are necessary, but for the most part
> this would be a win.

Good point, ./check can even invoke scripts with scratch as their working
directory.

Fam

> 
> Kevin may have an opinion on whether TEST_DIR should be cleared out or
> not.
> 
> Stefan
> 
