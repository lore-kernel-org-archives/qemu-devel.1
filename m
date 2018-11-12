Received: from eggs.gnu.org ([2001:4830:134:3::10]:35569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMEdr-0000BO-Gl
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMEdq-0002am-8O
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:00:47 -0500
Date: Mon, 12 Nov 2018 17:00:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181112160025.GE11580@linux.fritz.box>
References: <20181109221213.7310-1-crosa@redhat.com>
	<20181112104953.GB11580@linux.fritz.box>
	<f1c27ed2-9aba-edaf-2c49-ff565a0847ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1c27ed2-9aba-edaf-2c49-ff565a0847ce@redhat.com>
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

Am 12.11.2018 um 15:59 hat Cleber Rosa geschrieben:
> 
> On 11/12/18 5:49 AM, Kevin Wolf wrote:
> > Am 09.11.2018 um 23:12 hat Cleber Rosa geschrieben:
> >> The initial goal of this RFC is to get feedback on tests not specific
> >> to the QEMU main binary, but specific to other components such as
> >> qemu-img.
> >>
> >> For this experiment, a small issue with the zero and negative number
> >> of I/O operations given to the bench command was chosen.
> > 
> > Any reason why this shouldn't be in qemu-iotests?
> > 
> > Kevin
> > 
> 
> Hi Kevin,
> 
> This is indeed one of the comments I was expecting to receive.

I expected that you should expect this question. So it surprised me to
see that the cover letter didn't address it at all.

> AFAIK, there's nothing that prevents such a *simple* test to be
> written as a qemu-iotest.

Tests for qemu-img are pretty much by definition simple, just because
qemu-img isn't very complex (in particular, it doesn't run guests which
could introduce arbitrary complexity).

Can you give an example of what you would consider a not simple test for
qemu-img?

> Having said that, one of the things we're trying to achieve with
> "tests/acceptance" is that a individual developer or maintainer, should
> be able to run a subset of tests that he/she cares about.
> 
> Suppose that this developer is working on a "snapshot" related feature,
> and wants to run tests that cover both "qemu-img snapshot" and then
> tests interacting with a guest running on a snapshotted image.  By using
> the tags mechanism, one could run:
> 
>  $ avocado run -t snapshot tests/acceptance

You mean like './check -g snapshot'? (It would be more useful if we had
cared enough to actually assign that group to some of the newer tests,
but it exists...)

> And run all tests related to snapshot.  This is one of the reasons for
> maybe allowing the type of test proposed here to live under
> "tests/acceptance".  Others include:
> 
>  * No numbering conflicts when naming tests
>  * More descriptive tests names and metadata

Test numbering and metadata - sure, we can change that in qemu-iotests.
Should be a lot easier than adding a whole new second infrastructure for
block tests.

>  * No "context switch" for people also writing acceptance tests

There are no people writing "acceptance tests" for the block layer yet.
The context switch comes only with your patches, since you are
introducing a second competing framework for the same task, without even
giving a clear path of how to integrate or convert the existing tests so
we could get back to a unified world.

I really don't think fragmenting the test infrastructure is a good idea,
especially for rather superficial advantages.

>  * The various utility APIs available in both the Test class and on
> avocado.utils

Can you give examples?

Are those utility APIs actually worth losing the existing iotests.py
functions that provide stuff that is pretty specific to the QEMU and the
block layer?

> BTW, since most tests Today exist outside of "tests/acceptance", that
> may be also be solved in a great part by adding support in the (Avocado)
> test runner about some metadata in tests such qemu-iotests.

Sure, feel free to wrap qemu-iotests as much as you want. Trivial
wrappers don't sound like a big maintenance burden.

I just think that the block layer tests themselves should still keep
living in a single place. The obvious one is qemu-iotests. If you want
to change that, your cover letter shouldn't be quite as terse. The least
I would expect is an elaborate answer to:

1. Why is a change to something completely new useful and worth the
   effort? We don't generally rewrite QEMU or the kernel if some parts
   of it are ugly. We incrementally improve it instead. Exceptions need
   good justification because rewrites come with costs, especially if
   they can't offer feature parity.

2. How do we migrate the existing tests to the new infrastructure to
   avoid fragmentation?

Kevin
