Received: from eggs.gnu.org ([2001:4830:134:3::10]:39264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gWSSL-0008CJ-3A
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 15:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gWSSG-0008NE-VS
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 15:47:09 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57997)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gWSSG-0008My-9e
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 15:47:04 -0500
Date: Mon, 10 Dec 2018 15:47:00 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181210204700.GA29597@flamenco>
References: <20181207204107.GH7395@habkost.net>
	<20181209222738.GA9292@flamenco>
	<20181210174715.GI4669@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210174715.GI4669@habkost.net>
Subject: Re: [Qemu-devel] Help needed: test-qht-par hangs on Travis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Dec 10, 2018 at 15:47:15 -0200, Eduardo Habkost wrote:
> On Sun, Dec 09, 2018 at 05:27:38PM -0500, Emilio G. Cota wrote:
> > On Fri, Dec 07, 2018 at 18:41:07 -0200, Eduardo Habkost wrote:
> > > I've noticed QEMU Travis builds are failing recently, and they
> > > seem to happen only on the --enable-gprof jobs.  I have enabled
> > > V=1 and noticed that the jobs are hanging inside test-qht-par.
> > > 
> > > Example here (look for "/qht/parallel/2threads-0%updates-1s"):
> > > 
> > > https://travis-ci.org/ehabkost/qemu-hacks/jobs/465081311
> > > 
> > > Does anybody have any idea why?
> > 
> > So if I read that output correctly, it seems that the second
> > test in qht-par never completes.
> > 
> > Enabling gprof and gcov (as in that build) should just lower
> > the throughput of the benchmark (test-qht-par invokes qht-bench),
> [...]
> 
> Unrelated question: is there a specific reason why test-qht-par
> is written in C using gtest, instead of being just a shell script
> that runs qht-bench?

I didn't know how to integrate a shell script with
gtester, so I went with a C program.

There's a possibility that the use of system(3) here is
what's causing the problem. Can you try running the following
branch on travis?
  https://github.com/cota/qemu/tree/test-qht-par
I moved most of qht-bench into qht-bench.inc.c, so that
both qht-bench.c and test-qht-par.c can use it. This
gets rid of the use of system(3) in test-qht-par.c.

Thanks,

		Emilio
