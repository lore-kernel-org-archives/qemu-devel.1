Received: from eggs.gnu.org ([2001:4830:134:3::10]:43675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1df5sH-0001zy-O3
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1df5sG-0003te-Gy
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:52:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170721034730.25612-1-crosa@redhat.com>
	<20170721123325.GC18014@stefanha-x1.localdomain>
	<20170721140155.GQ17693@redhat.com>
	<bcf52c05-1d73-a56f-98ae-7029a924786b@redhat.com>
	<20170725154921.GS23343@stefanha-x1.localdomain>
	<547d0cd0-052c-a1e5-e116-483d2a176ab8@redhat.com>
	<20170726175808.GD3600@stefanha-x1.localdomain>
	<ecbf4c6b-64e0-7878-380a-262753068cb0@redhat.com>
	<20170727134101.GG10129@stefanha-x1.localdomain>
	<87mv7a4h77.fsf@dusky.pond.sub.org>
	<20170808124410.GN16801@stefanha-x1.localdomain>
Date: Tue, 08 Aug 2017 16:52:25 +0200
In-Reply-To: <20170808124410.GN16801@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Tue, 8 Aug 2017 13:44:10 +0100")
Message-ID: <877eye9knq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Tue, Aug 08, 2017 at 10:06:04AM +0200, Markus Armbruster wrote:
>> Stefan Hajnoczi <stefanha@gmail.com> writes:
>> 
>> > On Wed, Jul 26, 2017 at 02:24:02PM -0400, Cleber Rosa wrote:
>> >> 
>> >> 
>> >> On 07/26/2017 01:58 PM, Stefan Hajnoczi wrote:
>> >> > On Tue, Jul 25, 2017 at 12:16:13PM -0400, Cleber Rosa wrote:
>> >> >> On 07/25/2017 11:49 AM, Stefan Hajnoczi wrote:
>> >> >>> On Fri, Jul 21, 2017 at 10:21:24AM -0400, Cleber Rosa wrote:
>> >> >>>> On 07/21/2017 10:01 AM, Daniel P. Berrange wrote:
>> >> >>>>> On Fri, Jul 21, 2017 at 01:33:25PM +0100, Stefan Hajnoczi wrote:
>> >> >>>>>> On Thu, Jul 20, 2017 at 11:47:27PM -0400, Cleber Rosa wrote:
>> >> >>>> Without the static capabilities defined, the dynamic check would be
>> >> >>>> influenced by the run time environment.  It would really mean "qemu-io
>> >> >>>> running on this environment (filesystem?) can do native aio".  Again,
>> >> >>>> that's not the best type of information to depend on when writing tests.
>> >> >>>
>> >> >>> Can you explain this more?
>> >> >>>
>> >> >>> It seems logical to me that if qemu-io in this environment cannot do
>> >> >>> aio=native then we must skip those tests.
>> >> >>>
>> >> >>> Stefan
>> >> >>>
>> >> >>
>> >> >> OK, let's abstract a bit more.  Let's take this part of your statement:
>> >> >>
>> >> >>  "if qemu-io in this environment cannot do aio=native"
>> >> >>
>> >> >> Let's call that a feature check.  Depending on how the *feature check*
>> >> >> is written, a negative result may hide a test failure, because it would
>> >> >> now be skipped.
>> >> > 
>> >> > You are saying a pass->skip transition can hide a failure but ./check
>> >> > tracks skipped tests.  See tests/qemu-iotests/check.log for a
>> >> > pass/fail/skip history.
>> >> > 
>> >> 
>> >> You're not focusing on the problem here.  The problem is that a test
>> >> that *was not* supposed to be skipped, would be skipped.
>> >
>> > As Daniel Berrange mentioned, ./configure has the same problem.  You
>> > cannot just run it blindly because it silently disables features.
>> >
>> > What I'm saying is that in addition to watching ./configure closely, you
>> > also need to look at the skipped tests that ./check reports.  If you do
>> > that then you can be sure the expected set of tests is passing.
>> >
>> >> > It is the job of the CI system to flag up pass/fail/skip transitions.
>> >> > You're no worse off using feature tests.
>> >> > 
>> >> > Stefan
>> >> > 
>> >> 
>> >> What I'm trying to help us achieve here is a reliable and predictable
>> >> way for the same test job execution to be comparable across
>> >> environments.  From the individual developer workstation, CI, QA etc.
>> >
>> > 1. Use ./configure --enable-foo options for all desired features.
>> > 2. Run the ./check command-line and there should be no unexpected skips
>> >    like this:
>> >
>> > 087         [not run] missing aio=native support
>> >
>> > To me this seems to address the problem.
>> >
>> > I have mentioned the issues with the build flags solution: it creates a
>> > dependency on the build environment and forces test feature checks to
>> > duplicate build dependency logic.  This is why I think feature tests are
>> > a cleaner solution.
>> 
>> I suspect the actual problem here is that the qemu-iotests harness is
>> not integrated in the build process.  For other tests, we specify the
>> tests to run in a Makefile, and use the same configuration mechanism as
>> for building stuff conditionally.
>
> The ability to run tests against QEMU binaries without a build
> environment is useful though.  It would still be possible to symlink to
> external binaries but then the build feature information could be
> incorrect.

I don't dispute it's useful.  "make check" doesn't do it, though.

I think we can either have a standalone test suite (introspects the
binaries under test to figure out what to test), or an integrated test
suite (tests exactly what is configured).  "make check" is the latter.
qemu-iotests is kind-of-sort-of the former.
