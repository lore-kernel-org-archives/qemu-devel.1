Received: from eggs.gnu.org ([2001:4830:134:3::10]:33082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCu3t-0003Oj-Uu
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 18:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCu3q-0003HY-OF
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 18:13:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gCu3q-0003Dc-F6
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 18:13:02 -0400
Date: Wed, 17 Oct 2018 19:12:49 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181017221249.GQ31060@habkost.net>
References: <20181016232201.16829-1-crosa@redhat.com>
	<CAFEAcA_KFOay7zBoYMSqqEYd0ZhTcW5wp3bs28cr=oK4W4FL3A@mail.gmail.com>
	<20181017162944.GF31060@habkost.net>
	<d5f32475-df5b-0c5c-591f-5fae8e641c11@redhat.com>
	<CAFEAcA_gyQvmq48QquNiFhGef-FWPeDKRUSk3wf7hS=_=xm_XQ@mail.gmail.com>
	<20181017190951.GG31060@habkost.net>
	<b6cff33b-79af-f7b2-2a08-a098135304e0@redhat.com>
	<20181017194833.GI31060@habkost.net>
	<ba4cef67-a2c3-bd7c-7f4a-e96b12d016fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba4cef67-a2c3-bd7c-7f4a-e96b12d016fe@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Acceptance tests: host arch to target arch
 name mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On Wed, Oct 17, 2018 at 04:54:52PM -0400, Cleber Rosa wrote:
> 
> 
> On 10/17/18 3:48 PM, Eduardo Habkost wrote:
> > On Wed, Oct 17, 2018 at 03:25:34PM -0400, Cleber Rosa wrote:
> >>
> >>
> >> On 10/17/18 3:09 PM, Eduardo Habkost wrote:
> >>> On Wed, Oct 17, 2018 at 07:40:51PM +0100, Peter Maydell wrote:
> >>>> On 17 October 2018 at 18:38, Cleber Rosa <crosa@redhat.com> wrote:
> >>>>>
> >>>>>
> >>>>> On 10/17/18 12:29 PM, Eduardo Habkost wrote:
> >>>>>> On Wed, Oct 17, 2018 at 01:34:41PM +0100, Peter Maydell wrote:
> >>>>>>> So, why does the test code need to care? It's not clear
> >>>>>>> from the patch... My expectation would be that you'd
> >>>>>>> just test all the testable target architectures,
> >>>>>>> regardless of what the host architecture is.
> >>>>>>
> >>>>>> I tend to agree.  Maybe the right solution is to get rid of the
> >>>>>> os.uname().  I think the default should be testing all QEMU
> >>>>>> binaries that were built, and the host architecture shouldn't
> >>>>>> matter.
> >>>>
> >>>> Yes, looking at os.uname() also seems like an odd thing
> >>>> for the tests to be doing here. The test framework
> >>>> should be as far as possible host-architecture agnostic.
> >>>> (For some of the KVM cases there probably is a need to
> >>>> care, but those are exceptions, not the rule.)
> >>>>
> >>>>> I'm in favor of exercising all built targets, but that seems to me to be
> >>>>> on another layer, above the test themselves. This change is about the
> >>>>> behavior of a test when not told about the target arch (and thus binary)
> >>>>> it should use.
> >>>>
> >>>> At that level, I think the right answer is "tell the user
> >>>> they need to specify the qemu executable they are trying to test".
> >>>> In particular, there is no guarantee that the user has actually
> >>>> built the executable for the target that corresponds to the
> >>>> host, so it doesn't work to try to default to that anyway.
> >>>
> >>> Agreed.  However, I don't see when exactly this message would be
> >>> triggered.  Cleber, on which use cases do you expect
> >>> pick_default_qemu_bin() to be called?
> >>>
> >>
> >> When a test is run ad-hoc.  You even suggested that tests could/should
> >> be executable.
> >>
> >>> In an ideal world, any testing runner/tool should be able to
> >>> automatically test all binaries by default.  Can Avocado help us
> >>> do that?  (If not, we could just do it inside a
> >>> ./tests/acceptance/run script).
> >>>
> >>
> >> Avocado can do that indeed.  But I'm afraid that's not the main issue.
> >> Think of the qemu-iotests: do we want a "check" command to run  all
> >> tests with all binaries?
> > 
> > Good question.  That would be my first expectation, but I'm not
> > sure.
> > 
> 
> If it wasn't clear, I'm trying to define the basic behavior of *one
> test*.  I'm aware of a few different behaviors across tests in QEMU:

I think we have some confusion here: I'm not sure what you mean
when you say "one test".  Note that I'm not talking about the
test code architecture, but about the interface we provide for
running tests.

> 
>  1) qemu-iotests: require "check" to run, will attempt to find/run with
> a "suitable" QEMU binary.
> 
>  2) libqtest based: executables, in theory runnable by themselves, and
> will not attempt to find/run a "suitable" QEMU binary.  Those will
> print: "Environment variable QTEST_QEMU_BINARY required".
> 
>  3) acceptance tests: require the Avocado test runner, will attempt to
> find/run with a "suitable" QEMU binary.
> 
> So, I'm personally not aware of any test in QEMU which *by themselves*
> defaults to running on all (relevant) built targets (machine types?
> device types?).  Test selection (defining a test suite) and setting
> parameters is always done elsewhere (Makefile, check-block.sh,
> qemu-iotests-quick.sh, etc).
> 
> > Pro: testing all binaries by default would cause less confusion
> > than picking a random QEMU binary.
> > 
> 
> IMO we have to differentiate between *in test* QEMU binary selection
> (some? none?) and other layers (Makefiles, scripts, etc).
> 
> > Con: testing all binaries may be inconvenient for quickly
> > checking if a test case works.  (I'm not convinced this is a
> > problem.  If you don't want to test everything, you probably
> > already have a short target list in your ./configure line?)
> > 
> 
> Convenience is important, but I'm convinced this is a software layering
> problem.  I have the feeling we're trying to impose higher level
> (environment/build/check) definitions to the lower level (test) entities.

I think we're mixing user interface with code
layering/organization.

The code organization may ensure the QEMU binary selection is in
another layer.  That's fine.

But the user interface we provide to running a single test should
be usable (and do what users expect).  That's where I think the
problem lies.  Maybe this UI problem could be addressed by
avocado, maybe it can be addressed by a wrapper script (see
comments below).


> 
> > Pro: testing a single binary using uname() is already
> > implemented.
> > 
> 
> Right.  I'm not unfavorable to changing that behavior, and ERRORing
> tests when a binary is not given (similar to libqtest) is a simple
> change if we're to do it.  But I do find that usability drops considerably.
> 
> And finally I don't think the "if a qemu binary is not explicitly given,
> let's try the matching host architecture" is confusing or hard to
> follow.  And, it's pretty well documented if you ask me:

I think it may cause confusion, and is inconsistent with all
other methods we recommend for running tests.

> 
> ---
> QEMU binary selection
> ~~~~~~~~~~~~~~~~~~~~~
> 
> The QEMU binary used for the ``self.vm`` QEMUMachine instance will
> primarily depend on the value of the ``qemu_bin`` parameter.  If it's
> not explicitly set, its default value will be the result of a dynamic
> probe in the same source tree.  A suitable binary will be one that
> targets the architecture matching (the) host machine.
> 
> Based on this description, test writers will usually rely on one of
> the following approaches:
> 
> 1) Set ``qemu_bin``, and use the given binary
> 
> 2) Do not set ``qemu_bin``, and use a QEMU binary named like
>    "${arch}-softmmu/qemu-system-${arch}", either in the current
>    working directory, or in the current source tree.
> 
> The resulting ``qemu_bin`` value will be preserved in the
> ``avocado_qemu.Test`` as an attribute with the same name.

If we provide a good user interface for running single tests
against all binaries, users won't even care about `qemu_bin`, and
this would be just a low level details inside the avocado_qemu
code.

"This is documented" is good.  "This doesn't need to be
documented" would be awesome.


> ---
> 
> > Con: making `avocado run` automatically generate variants of a
> > test case may take some effort?
> > 
> 
> Well, it will take some effort, sure.  But my point do we want to
> *enforce* that?  I think that should be left to a "run" script or make
> rule like you suggested.  IMO, `avocado run a_single_test.py` shouldn't
> do more than just that.

What do you mean by "do just that"?

I would love if avocado could be smarter and
"avocado run [<test>]" automatically got test variant information
somewhere and run multiple variants.  But if this is not possible
today, a wrapper script would be good enough to me.

-- 
Eduardo
