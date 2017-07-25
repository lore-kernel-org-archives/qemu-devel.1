Received: from eggs.gnu.org ([2001:4830:134:3::10]:38091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1da2dA-0007fM-Es
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1da2d9-0000mo-3f
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:24:20 -0400
Date: Tue, 25 Jul 2017 17:24:05 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170725162405.GT26394@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170721034730.25612-1-crosa@redhat.com>
	<20170721123325.GC18014@stefanha-x1.localdomain>
	<20170721140155.GQ17693@redhat.com>
	<bcf52c05-1d73-a56f-98ae-7029a924786b@redhat.com>
	<20170725154921.GS23343@stefanha-x1.localdomain>
	<547d0cd0-052c-a1e5-e116-483d2a176ab8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <547d0cd0-052c-a1e5-e116-483d2a176ab8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] build configuration query tool and
 conditional (qemu-io)test skip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

On Tue, Jul 25, 2017 at 12:16:13PM -0400, Cleber Rosa wrote:
> 
> 
> On 07/25/2017 11:49 AM, Stefan Hajnoczi wrote:
> > On Fri, Jul 21, 2017 at 10:21:24AM -0400, Cleber Rosa wrote:
> >> On 07/21/2017 10:01 AM, Daniel P. Berrange wrote:
> >>> On Fri, Jul 21, 2017 at 01:33:25PM +0100, Stefan Hajnoczi wrote:
> >>>> On Thu, Jul 20, 2017 at 11:47:27PM -0400, Cleber Rosa wrote:
> >> Without the static capabilities defined, the dynamic check would be
> >> influenced by the run time environment.  It would really mean "qemu-io
> >> running on this environment (filesystem?) can do native aio".  Again,
> >> that's not the best type of information to depend on when writing tests.
> > 
> > Can you explain this more?
> > 
> > It seems logical to me that if qemu-io in this environment cannot do
> > aio=native then we must skip those tests.
> > 
> > Stefan
> > 
> 
> OK, let's abstract a bit more.  Let's take this part of your statement:
> 
>  "if qemu-io in this environment cannot do aio=native"
> 
> Let's call that a feature check.  Depending on how the *feature check*
> is written, a negative result may hide a test failure, because it would
> now be skipped.
> 
> Suppose that a feature check for "SDL display" is such that you run
> "qemu -display sdl".  A *feature failure* here (SDL init is broken), or
> an environment issue (DISPLAY=), will cause a SDL test skip.

You could have a way to statically define what features any given run
of the test suite should enable, then report failure if they were not
detected.

This is a similar situation to that seen with configure scripts. If invoked
with no --enable-xxx flags, it will probe for features & enable them if
found.  This means you can accidentally build without expected features if
you have a missing -devel package, or a header/library is broken in some
way. This is why configure prints a summary of which features it actually
found. It is also why when building binary packages like RPMs, it is common
to explicitly give --enable-xxx flags for all features you expect to see.
Automatic enablement is none the less still useful for people in general.

So if we applied this kind of approach for testing, then any automated
test systems at least, ought to provide a fixed list of features they
expect to be present for tests. So if any features accidentally broke
the tests would error.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
