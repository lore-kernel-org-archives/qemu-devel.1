Received: from eggs.gnu.org ([209.51.188.92]:51758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gxDpU-0004Dq-Uf
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:37:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gxDpR-0004cY-LG
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:37:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gxDpQ-0004Xq-Pf
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:37:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F3773024EA2
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 16:37:33 +0000 (UTC)
Date: Fri, 22 Feb 2019 16:37:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190222163727.GE25234@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190118140336.GA19921@beluga.usersys.redhat.com>
	<20190221143915.GB2506@beluga.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190221143915.GB2506@beluga.usersys.redhat.com>
Subject: Re: [Qemu-devel] [libvirt] Libvirt upstream CI efforts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Erik Skultety <eskultet@redhat.com>
Cc: libvir-list@redhat.com, Yash Mankad <ymankad@redhat.com>, qemu-devel@nongnu.org, Cleber Rosa Junior <crosa@redhat.com>

On Thu, Feb 21, 2019 at 03:39:15PM +0100, Erik Skultety wrote:
> number of test cases (and also many unnecessary legacy test cases). An
> alternative set of functional test cases is available as part of the
> libvirt-tck framework [2]. The obvious question now is how can we build upon
> any of this and introduce proper functional testing of upstream libvirt to our
> jenkins environment at ci.centos.org, so I formulated the following discussion
> points as I think these are crucial to sort out before we move on to the test
> suite itself:

Having thought about this some more I think it would be helpful to outline
the various areas of testing libvirt is missing / could benefit from, as
I think it is broader than just running an integration test suite on the
ci.centos.org

Listing in order of the phase of development, not priority....


 - Testing by developers before code submissions

   Developers today (usually) run unit tests + syntax check before
   submission, though even that is forgotten at times.

   Ideally some level of functional testing would be commonly performed
   too.

   Amount of time devs are likely to want spend on testing will depend
   on the scope of the work being done. ie they're not going to test
   on all distros, with all integration tests for simple patches. Also
   no desire to make devs run QEMU tests on patches which are changing
   Xen code and vica-verca.

   Essentially goal is to give developers confidence that they have
   not done something terrible before submission. Not expecting devs
   to catch all bugs themselves at this stage.


 - Testing of patches posted to mailing list pre merge

   patchew.org currently monitors patch postings to libvir-list
   and imports each posting into a new github branch. In theory
   it runs syntax-check against them & reports failures but this
   has not been reliable.

   Highly desirable to have all patches go through build + unit
   tests at this point, across multiple distros. It is common for
   devs to break mingw and/or *BSD and/or macOS builds, since vast
   majority of the dev focus is Linux.  There is generally long
   enough between patch posting & review approval that build+unit
   tests should be doable with sufficient patchew worker resource.


   Extra brownie points if the build + tests ran across each
   individual patch to prove that  git bisect-ability isn't
   broken. This would require significantly more worker
   resources though. This is the only place bi-sect could
   be tested as anything beyond is too late.


   Running functional tests at this point would be beneficial,
   on the general principle that the sooner we find a problem,
   the cheaper it is to fix & less impact it has on people.
   Massively dependant on worker resource.


 - Testing of latest git master post merge

   This is where almost all of our current effort has gone.
   
   ci.centos.org does build & unit testing fully chained
   together all libvirt components on Linux + BSD using VMs

   Travis CI does testing of individual of libvirt components
   on Linux + macOS, using contaniers for Linux.

   Both of these are x86 only thus far. Through use of Debian
   cross compilers we can get non-x86 coverage for builds,
   but not much else without finding some real hardware.

   Desirable to have functional testing here to detect problems
   before they get into any formal release. Dependent on resource
   to run on ci.centos.org or Travis, or another system we might
   get access to. Still likely to be x86 only.


 - Testing during RPM builds

   When building new packages for distros, 'make check' is usually
   run. This has caught problems appearing in distros which have
   sometimes been missed by ci.centos.org.

   Desirable to have functional testing here in order to prevent
   breakage making its way into distros, by aborting the build.

   Runs on all Fedora architectures which is a big plus, since
   all earlier upstream testing resources are x86 only.

   The environment is quite restrictive as it is inside Koji/Brew
   but libguestfs test suite has shown its possible to do very
   thorough testing of Libvirt & QEMU in this context that frequently
   identifies bugs in libvirt & QEMU & kernel & other Fedora/RHEL
   components.

   Fedora has an automated system that frequently rebuilds the
   RPMs to check FTBFS (fail to build from source) status of
   packages to detect regresisons over time.


 - Testing of composed distros

   Real integration testing belongs here, as its validating the
   exact software build & deployment setup that users will ultimately
   run with.

   The test environment is more flexible than during RPM build,
   but by the time it runs the update is already in the distro
   repos, potentially breaking downstream users (libguestfs).

   Note 100% sure, but I think the Fedora CI is x86 only.



 - Testing by developers investigating CI failures

   For any of the above steps which are run by any kind of automated
   system there needs to be a way for developers to reproduce the
   same test environment in an easy manner.

   For ci.centos.org we can re-generate the VMs.
   For Travis we can pull the docker images from quay.io
   For koji/brew we can run mock locally

   None of these are a perfect match though, as they can't reproduce
   the exact hardware setup, or the load characteristics, just the
   software install setup.



It is clear we have lots of places where we should/could be doing
functional testing, and none of them is going to cover all the
bases.

The environments in which we need to be able to do testing are
also quite varied in scope. Some places (ci.centos) have freedom
to bring a full VMs customized as we desire, others (Travis, Gitlab)
are supporting docker containers with arbitrary Linux, others (brew,
koji) we just have to accept whatever environment we're executing
in.

In terms of developers, we can't rely on ability to run VMs, because
they may already be running inside a VM, and lacking nested-virt.

Essentially I think this means we need to make it practical to run
the functional tests as is, in whatever the current execution
environment is. If that works, then pretty much by implication,
it ought to be possible to optionally launch it inside a VM, or
inside a container to reproduce the precise environment of a
particular test system.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
