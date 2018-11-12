Received: from eggs.gnu.org ([2001:4830:134:3::10]:40607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gMG8p-0000wh-Fv
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gMG8n-00007x-UE
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:36:51 -0500
References: <20181109221213.7310-1-crosa@redhat.com>
	<20181112104953.GB11580@linux.fritz.box>
	<f1c27ed2-9aba-edaf-2c49-ff565a0847ce@redhat.com>
	<20181112160025.GE11580@linux.fritz.box>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <b51dd4e4-e814-db42-86be-698c0d87f8ef@redhat.com>
Date: Mon, 12 Nov 2018 12:36:33 -0500
MIME-Version: 1.0
In-Reply-To: <20181112160025.GE11580@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] Acceptance tests for qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>



On 11/12/18 11:00 AM, Kevin Wolf wrote:
> Am 12.11.2018 um 15:59 hat Cleber Rosa geschrieben:
>>
>> On 11/12/18 5:49 AM, Kevin Wolf wrote:
>>> Am 09.11.2018 um 23:12 hat Cleber Rosa geschrieben:
>>>> The initial goal of this RFC is to get feedback on tests not specific
>>>> to the QEMU main binary, but specific to other components such as
>>>> qemu-img.
>>>>
>>>> For this experiment, a small issue with the zero and negative number
>>>> of I/O operations given to the bench command was chosen.
>>>
>>> Any reason why this shouldn't be in qemu-iotests?
>>>
>>> Kevin
>>>
>>
>> Hi Kevin,
>>
>> This is indeed one of the comments I was expecting to receive.
> 
> I expected that you should expect this question. So it surprised me to
> see that the cover letter didn't address it at all.
> 

I hope you don't blame me for trying to have the advantage of the
counter answer. :)

>> AFAIK, there's nothing that prevents such a *simple* test to be
>> written as a qemu-iotest.
> 
> Tests for qemu-img are pretty much by definition simple, just because
> qemu-img isn't very complex (in particular, it doesn't run guests which
> could introduce arbitrary complexity).
> 
> Can you give an example of what you would consider a not simple test for
> qemu-img?
> 

This is a hard question for me to answer since I haven't written that
many qemu-img tests.  Thinking of hypothetical situations, the Avocado
libraries contain utilities for logical volumes[1], so it'd naturally
be easier to write a test for qemu-img + LVs.

>> Having said that, one of the things we're trying to achieve with
>> "tests/acceptance" is that a individual developer or maintainer, should
>> be able to run a subset of tests that he/she cares about.
>>
>> Suppose that this developer is working on a "snapshot" related feature,
>> and wants to run tests that cover both "qemu-img snapshot" and then
>> tests interacting with a guest running on a snapshotted image.  By using
>> the tags mechanism, one could run:
>>
>>  $ avocado run -t snapshot tests/acceptance
> 
> You mean like './check -g snapshot'? (It would be more useful if we had
> cared enough to actually assign that group to some of the newer tests,
> but it exists...)
> 

Yes, but also something equivalent to './check -g snapshot,live -g
quick,-privileged', meaning tests that are tagged both with "snapshot
and live", in addition to tests that are quick and don't require super
user privilege.

Don't get me wrong, I wouldn't expect "check" to implement that logic.
Like I said before, one way to solve that is to add leave qemu-iotests
untouched, and add support on the Avocado runner to understand other
tests' metadata.

>> And run all tests related to snapshot.  This is one of the reasons for
>> maybe allowing the type of test proposed here to live under
>> "tests/acceptance".  Others include:
>>
>>  * No numbering conflicts when naming tests
>>  * More descriptive tests names and metadata
> 
> Test numbering and metadata - sure, we can change that in qemu-iotests.
> Should be a lot easier than adding a whole new second infrastructure for
> block tests.
> 

My impression is that the "infrastructure for block tests" is not that
different from the infrastructure needed by other tests, specially other
QEMU tests.  The point I'm trying to make here is that, adding a feature
such as metadata parsing/selection to tests looks much more like a *test
infrastructure* issue than a "block test" issue, right?

Having access to local or remote files (images?), preparing the
environment (creating those images?), accepting parameters from the user
(which image format to use?) are all examples of test infrastructure
problems applied to the block tests.

Logging and formatting the results are other examples of *test*
infrastructure problems that "check" has had to deal with itself, and is
quite understandably limited.

>>  * No "context switch" for people also writing acceptance tests
> 
> There are no people writing "acceptance tests" for the block layer yet.
> The context switch comes only with your patches, since you are
> introducing a second competing framework for the same task, without even
> giving a clear path of how to integrate or convert the existing tests so
> we could get back to a unified world.
> 

You're absolutely right, and it's quite obvious that there's no one
writing "acceptance tests" for the block layer yet.  There's a subtle
but important difference here though: this initiative is trying to allow
people to write tests generic enough, for various QEMU subsystems
(that's why maybe it's badly named as "acceptance").  It's really about
trying to avoid context switches that may occur when developers and
maintainers from those various subsystems (hopefully) start to write and
review tests.

So no, this is not an attempt to cause disruption, fragmentation and
separate worlds.  It's quite the contrary.  And please excuse me from
not writing a "how to migrate qemu-iotests" --  I don't even want to
think about that if the block layer maintainers do not see any value in
that.

If you believe that handing off some of the infrastructure problems that
qemu-iotests have to a common tool, and that it may be a good idea to
have qemu-iotests become more like "qemu tests that happen to exercise
the block layer", then we can push such an initiative forward.

> I really don't think fragmenting the test infrastructure is a good idea,
> especially for rather superficial advantages.
> 
>>  * The various utility APIs available in both the Test class and on
>> avocado.utils
> 
> Can you give examples?
> 

I believe ended up giving some examples before, but for ease reading,
let me duplicate them here:

 * avocado.Test: "Having access to local or remote files (images?),
preparing the environment (creating those images?), accepting parameters
from the user (which image format to use?) are all examples of test
infrastructure problems applied to the block tests."

 * avocado.utils: "Thinking of hypothetical situations, the Avocado
libraries contain utilities for logical volumes[1], so it'd naturally
be easier to write a test for qemu-img + LVs."

> Are those utility APIs actually worth losing the existing iotests.py
> functions that provide stuff that is pretty specific to the QEMU and the
> block layer?
> 

There's no reason to lose iotests.py.  Even the current acceptance tests
are based on the principle of reusing the code that a lot of the iotests
use (scripts/qemu.py and scripts/qmp/*).

What I'm aiming for is that QEMU developers can write *tests*, and have
a simple (and hopefully a common) way of running them.

>> BTW, since most tests Today exist outside of "tests/acceptance", that
>> may be also be solved in a great part by adding support in the (Avocado)
>> test runner about some metadata in tests such qemu-iotests.
> 
> Sure, feel free to wrap qemu-iotests as much as you want. Trivial
> wrappers don't sound like a big maintenance burden.
> 
> I just think that the block layer tests themselves should still keep
> living in a single place. The obvious one is qemu-iotests. If you want
> to change that, your cover letter shouldn't be quite as terse. The least
> I would expect is an elaborate answer to:
> 
> 1. Why is a change to something completely new useful and worth the
>    effort? We don't generally rewrite QEMU or the kernel if some parts
>    of it are ugly. We incrementally improve it instead. Exceptions need
>    good justification because rewrites come with costs, especially if
>    they can't offer feature parity.
> 

I'll tell you a "shocking secret" (please take that with a grain of
salt): I have no use case myself for any of the QEMU tests.  I don't
rely on them.  No QEMU test make a difference in my work.  That's why I
may miss some of the obvious points, but at the same time, maybe I can
look at things from a different perspective.

Because incrementally improving the *overall* testing of QEMU is indeed
one of my goals, this RFC was a "provocation" for change.  Had I written
a Python script with a very similar content, named it "233", we'd have
missed this discussion.

> 2. How do we migrate the existing tests to the new infrastructure to
>    avoid fragmentation?
> 

Again, I haven't even thought of proposing that.  This is so dependent
on so many other aspects, including this initial feeling and feedback
from the maintainers.

> Kevin
> 

Thanks a lot for the feedback so far,
- Cleber.

[1]
https://avocado-framework.readthedocs.io/en/65.0/api/utils/avocado.utils.html#module-avocado.utils.lv_utils
