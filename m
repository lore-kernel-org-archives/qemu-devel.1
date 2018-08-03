Received: from eggs.gnu.org ([2001:4830:134:3::10]:57752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1flWP5-0005d9-Rl
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1flWP0-0005qR-Tu
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:29:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52670 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1flWP0-0005o6-Q0
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:29:42 -0400
Date: Fri, 3 Aug 2018 17:29:39 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180803092939.GF16395@lemon.usersys.redhat.com>
References: <20180803085230.30574-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803085230.30574-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 0/5] tests/vm: various minor improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, patches@linaro.org

On Fri, 08/03 09:52, Peter Maydell wrote:
> The setup I had for my BSD VMs broke today, so I thought I'd
> have a look at using the tests/vm/ support for building QEMU
> inside BSD VMs rather than re-rolling my own. This patchset
> fixes some rough edges I ran into along the way:
>  * fixes support for non-KVM accelerators
>  * propagates J=n setting into 'make check' in the VM
>  * propagates V=1 setting into 'make' and 'make check' in the VM
>  * uses --output-sync so that J=n settings don't mangle output
>  * bumps the RAM settings so J=n doesn't cause the guest to
>    run out of memory and kill the compiler
> 
> Ideally I'd like to be able to separately invoke commands
> for "build in VM" and "run make check in VM for that build"; for
> instance I only want V=1 on the make-check, not the make, and in
> some cases might want to do a build but not check, and so on.
> But that seemed too complicated for the moment.

If we can limit the abstraction to "build" and "check" (or "test"), it shouldn't
be hard to add a --build-only option to the Python main() and VM_BUILD_ONLY=1 to
Makefile.

> 
> Is it possible for the VMs to be persistent? Currently it
> looks like they throw away their contents and start afresh
> for every invocation. Doing build tests as incremental is
> faster than doing every one as a from-clean...

Yes, we'll do that in 3.1.

> 
> Also, I notice that the OpenBSD VM setup is using SDL 1.2,
> which means that configure complains and suggests switching
> to SDL 2.0. How do we update the base image?

I prepared the image by hand and uploaded it because I couldn't find a better
way. So the easist way to update is probably booting the image by hand, do the
modifications, then upload it again.

> 
> thanks
> -- PMM
> 
> Peter Maydell (5):
>   tests/vm: Use -cpu max rather than -cpu host
>   tests/vm: Pass the jobs parallelism setting to 'make check'
>   tests/vm: Propagate V=1 down into the make inside the VM
>   tests/vm: Bump guest RAM up from 2G to 4G
>   tests/vm: Use make's --output-sync option
> 
>  tests/vm/Makefile.include | 1 +
>  docs/devel/testing.rst    | 1 +
>  tests/vm/basevm.py        | 9 ++++++---
>  tests/vm/freebsd          | 4 ++--
>  tests/vm/netbsd           | 4 ++--
>  tests/vm/openbsd          | 4 ++--
>  tests/vm/ubuntu.i386      | 4 ++--
>  7 files changed, 16 insertions(+), 11 deletions(-)
> 
> -- 
> 2.17.1
> 
> 
