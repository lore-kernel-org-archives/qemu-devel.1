Received: from eggs.gnu.org ([2001:4830:134:3::10]:60305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dkwUD-0001i4-5S
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dkwUA-0002LW-0y
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:04:09 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dkwU9-0002LG-Qa
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:04:05 -0400
Received: by mail-wm0-x241.google.com with SMTP id i76so218893wme.1
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 11:04:05 -0700 (PDT)
Date: Thu, 24 Aug 2017 19:04:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170824180402.GA4368@stefanha-x1.localdomain>
References: <20170824072202.26818-1-stefanha@redhat.com>
	<20170824083843.GB1866@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170824083843.GB1866@lemon>
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
To: Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Thu, Aug 24, 2017 at 04:38:43PM +0800, Fam Zheng wrote:
> On Thu, 08/24 08:21, Stefan Hajnoczi wrote:
> > Tests should declare resources upfront in a with statement.  Resources are
> > automatically cleaned up whether the test passes or fails:
> > 
> >   with FilePath('test.img') as img_path,
> >        VM() as vm:
> >       ...test...
> >   # img_path is deleted and vm is shut down automatically
> 
> Looks good but still requires test writers to learn and remember to use FilePath
> and with.

You cannot forget to use FilePath() unless you love typing at
os.path.join(iotests.test_dir, 'test.img').  It's much better than open
coding filename generation!

> These are still boilerplates.  Here goes my personal oppinion, so may
> not be plausible:
> 
> - For VM() maybe add an atexit in the launch() method also makes sure the VM is
>   eventually terminated.
> 
>   This means vm.shutdown() is still needed in tearDown() if there are multiple
>   test methods and each of them expects a clean state, but that is probably
>   still less typing (and also indenting) than the with approach, and also easy
>   to remember (otherwise a test will fail).

I looked into atexit before going this route.  atexit does not have an
unregister() API in Python 2.  This makes it ugly to use because some
tests do not want the resource to remain for the duration of the
process.

A related point is that the Python objects used by atexit handlers live
until the end of the process.  They cannot be garbage collected because
the atexit handler still has a reference to them.

The with statement's identation is annoying for straightforward scripts.
More complex tests use functions anyway, so the indentation doesn't
matter there - it can be hidden by a parent function or even a
decorator.

> - For scratch how about adding atexit in iotests.main to clean up everything in
>   the scratch directory? The rationale is similar to above.

If we decide to clear out TEST_DIR then it should be done in ./check,
not by iotests.py, so that all tests get the same file cleanup behavior,
regardless of the language they are written in.

Also, we can then chdir(iotests.test_dir) so filename generation isn't
necessary at all.  Tests can simply use 'test.img'.  I guess there may
be some cases where absolute paths are necessary, but for the most part
this would be a win.

Kevin may have an opinion on whether TEST_DIR should be cleared out or
not.

Stefan
