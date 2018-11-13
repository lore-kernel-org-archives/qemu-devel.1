Received: from eggs.gnu.org ([2001:4830:134:3::10]:38788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMamL-0000mt-8Y
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:39:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMamJ-00089c-TS
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:39:01 -0500
Date: Tue, 13 Nov 2018 16:38:49 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181113153849.GF4830@localhost.localdomain>
References: <20181109221213.7310-1-crosa@redhat.com>
	<20181112104953.GB11580@linux.fritz.box>
	<f1c27ed2-9aba-edaf-2c49-ff565a0847ce@redhat.com>
	<20181112160025.GE11580@linux.fritz.box>
	<b51dd4e4-e814-db42-86be-698c0d87f8ef@redhat.com>
	<20181113121836.GC4830@localhost.localdomain>
	<cab511df-cba6-b900-98c0-9fff6e323654@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cab511df-cba6-b900-98c0-9fff6e323654@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] Acceptance tests for qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Hi Cleber,

I will shorten this email a lot while replying because I have the
impression that most of the discussion isn't actually as productive as
it could be. I'm not trying to evade on any point that I'm cutting out,
so if there is something specific in the part I'm removing that you
would like to get answer for, please let me know and I'll follow up.

Am 13.11.2018 um 15:15 hat Cleber Rosa geschrieben:
> >> So no, this is not an attempt to cause disruption, fragmentation and
> >> separate worlds.  It's quite the contrary.  And please excuse me from
> >> not writing a "how to migrate qemu-iotests" --  I don't even want to
> >> think about that if the block layer maintainers do not see any value in
> >> that.
> > 
> > [ Insert that "how standards proliferate" xkcd here ]
> > 
> > I see value in having a unified test infrastructure. However, I don't
> > think committing a new Hello World grade qemu-img test case using
> > different tooling than the rest of the qemu-img test cases is
> > contributing much to this goal.
> 
> There are a few ways I take this response.  First one is that my attempt
> to make this *RFC* an attempt to discuss and eventually collaborate, is
> more a miss than a hit.  Second, it makes me wonder whether you'd prefer
> to take a patch without any test, or a test using a "different tooling"
> (I'm considering you do take patches without tests, if you don't, then
> please disregard this point).

As for the actual patch series at hand, if you want it to get into 3.1,
the best way would be to split code change and test into two different
patches and make a traditional qemu-iotests case out of it. But I think
that wasn't the main point of the exercise, right?

For the broader topic of testing and the block layer, I believe the
following paragraph shows a fundamental misunderstanding. Maybe I'm
wrong, but that's my impression. This one:

> > We have so many unfinished conversions inside QEMU, and this looks
> > like the approach you would take to add another one.
> 
> Wrong, there's no conversion attempted here.

I get the impression that you think not attempting any conversion is
something that should make it easier for me to agree with the approach.

The opposite is true: Introducing a second way to do things and not
converting existing test cases to it so that the first way could go away
is the fragmentation that I really want to avoid. I don't mind too much
which way we use, but I do care a lot that it's a single way.


So when I said "let's push it forward in a different way", what I had
in mind was starting with the existing qemu-iotests:

Currently, if you run avocado in tests/qemu-iotests/, it doesn't do
anything. I imagine it shouldn't be very hard to make it run at least
the Python-based unit test style cases, which look very similar to what
we have in tests/acceptance/.

In the next step, we could do the Python-based tests that work with
diffing a reference output. And then shell scripts (which need a very
specific environment to run and might require the most changes).

And finally, we would make sure that every option in ./check has a
translation to the new style and start making use of the new features
that Avocado brings in.


There are questions to answer on the way that don't seem completely
clear to me, but that's probably just because I don't know Avocado very
well. For example, while tests like the VNC one run exactly once and
don't require a prepared environment, ./check from qemu-iotests takes
a parameter for the image format and protocol to use for the test case.
This mechanism would have to be translated to Avocado somehow.

I think if you (or someone else who know Avocado well) try to do this
change, you'll figure out solutions quickly. This is where we need your
help because the block layer people don't know how this stuff works (at
least I don't). Or if you don't have the time to actually do the
patches yourself, tell us how we should do it. I'm not sure I can find
the time for this, but I can try.


So if the most important part for you is not the qemu-img bench fix, but
the approach to testing in general, I think this would be a much more
useful way to attack it.

> > And in fact, as those other parts don't exist yet (other than simple
> > examples), maybe it would actually be worth discussing whether they
> > shouldn't use the same structure and tooling as qemu-iotests (which can
> > obviously be improved at the same time, but my point is about being in
> 
> Feel free to start the discussion on why they should, and how.  I'm
> really receptive to discussing any ideas.

Maybe it's actually too late for that, considering that you said that
many test cases are already in development that use the newly introduced
acceptance test way.

But it would have essentially been:

1. move the qemu-iotests infrastructure up to tests/
2. if you already want to add vnc tests, you can add them to that
3. do all of the conversion steps I outlined above to make sure that we
   don't lose features compared to the old infrastructure.
4. you get a generic infrastructure that looks much like what you're
   creating inside tests/acceptance, only that it's used for everything

We can still do it out of order, but we have two parts to integrate now
instead of just one that needs to be evolved.

(By the way, why is tests/acceptance/ a separate directory? If we want
it to be _the_ way to do tests, wouldn't it make more sense to have it
on the top level and then use subdirectories only to categorise test
cases?)

> > sync) instead of setting a new standard without considering the existing
> > test cases and then trying to move qemu-iotests to it.
> > 
> 
> OK, "new" having a bad connotation is quite common on your reply.

To me, "new" has a bad connotation as long as it implies that it
coexists with "old" instead of replacing it. This is the part that I
really want to fix, and then we can happily go ahead with "new" (and
only "new").

Experience says that the easiest way to get there is by simply evolving
"old" into "new", but there are other ways. Maybe the coexisting "new"
is already developed far enough that we will have to use other ways this
time. But then let's use those ways and not put up with "old" and "new"
coexisting.

> > Anyway, one specific concern about the "simple way" I have is that we're
> > adding a hard dependency on an external package (Avocado) that isn't
> > usually installed anyway on developer machines. Maintainers will of
> > course just install it. But will this reduce the amount of tests that
> > contributors run, and increase the amount of untested patches on the
> > mailing list?
> > 
> 
> We've opted for a "opt-in" approach.  If you want to run tests that
> depend on this external package, you go ahead and pay the data costs
> associated with that download.  We did pack all those steps in a single
> "make check-acceptance" command for everyone's convenience, though.
> 
> > Maybe we can keep a simple in-tree runner like ./check that doesn't have
> > any external dependencies and runs all of those tests that don't make
> > use of Avocado utility functions etc.? And you'd use Avocado when you
> > want to run all tests or use advanced test harness options.
> > 
> 
> Sure, this is the current state of affairs.  And yes, one way of
> integrating the execution of test from different "silos" is by adding
> support on the runner, as mentioned before.  I hope to work on this some
> time soon.

Actually, with Eduardo's hint that you don't need to manually install
Avocado any more, but we automatically download everything that is
needed, I consider this concern mostly addressed. We need to make sure
that ./configure without any options allows to run it (currently you
need to explicitly specify Python 3), but that's it.

Then a separate in-tree runner isn't really needed either.

> > So for a long time, the only Python test cases we had looked much like
> > your test case: Just run some code with lots of asserts in it, and at
> > the end print something like "42 test cases passed"; this or an
> > exception stack trace is the only output you get. Turns out that this is
> > really hard to debug when a test case starts to fail.
> > 
> > Our shell based test cases, on the other hand, have always printed the
> > output and then we diffed it against a reference output. When it fails,
> > you usually can see immediately what happens. The lesson we learned is
> > that most of our newer Python test cases are much more verbose and make
> > more use of diffing aginst a reference output instead of asserting. This
> > is what your qemu-img test should probably do as well.
> > 
> > And in fact, if it doesn't involve interacting with QMP in complex ways
> > that actually need some programming to deal with the return values of
> > the monitor, we wouldn't even write it in Python, but just in bash.
> 
> Right, you'd review this new qemu-iotest, but the overall discussion
> about an eventual larger collaboration would be missed.

This was not at all about the harness, but specific feedback how I would
like a simple qemu-img test case to work. The implied message, if any,
was that I'd like to see an example for how to implement a diff-based
test (ideally in bash) in the Avocado-based test framework.

At the same time, this would be the prototype for converting existing
qemu-iotests cases.

Kevin
