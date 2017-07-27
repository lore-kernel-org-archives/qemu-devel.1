Received: from eggs.gnu.org ([2001:4830:134:3::10]:35153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dadwu-0000HQ-L5
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dadwr-0007QV-UM
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:15:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dadwr-0007Pn-L3
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:15:09 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <87o9so1hl7.fsf@dusky.pond.sub.org>
	<20170717103308.GI7163@stefanha-x1.localdomain>
	<8760epr9vw.fsf@dusky.pond.sub.org>
	<20170721153331.GL18014@stefanha-x1.localdomain>
	<026a093f-1f79-4af9-a5c9-d540342b472e@redhat.com>
	<8760eiuxu5.fsf@dusky.pond.sub.org>
	<9d4a3015-a3d2-e9d5-2254-0bcb77b37161@redhat.com>
Date: Thu, 27 Jul 2017 10:14:58 +0200
In-Reply-To: <9d4a3015-a3d2-e9d5-2254-0bcb77b37161@redhat.com> (Cleber Rosa's
	message of "Tue, 25 Jul 2017 21:21:13 -0400")
Message-ID: <871sp2gut9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Improving QMP test coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, Cleber Rosa <cleber@redhat.com>

Cleber Rosa <crosa@redhat.com> writes:

> On 07/24/2017 02:56 AM, Markus Armbruster wrote:
>> Test code language is orthogonal to verification method (with code
>> vs. with diff).  Except verifying with shell code would be obviously
>> nuts[*].
>> 
>> The existing iotests written in Python verify with code, and the ones
>> written in shell verify with diff.  Doesn't mean that we have to port
>> from Python to shell to gain "verify with diff".
>> 
>
> The fact that they are still subject to "verify with diff" is
> interesting.  IMO, exit status makes a lot more sense.
>
> I only raised this point, and gave my opinion, because:
>
> 1) Shell based tests *with* output check has a lot of use cases and
> proven value
> 2) Python based tests *without* output check also have use cases and value
>
> To me, this shows that language flexibility is a must, and output check
> can be an unnecessary burden.  If at all possible, it should be optional.
>
> Implementation-wise, this seems pretty simple.  Tests based on any
> language can communicate the basic success/failure by exit status code
> and/or by recorded output.  If the ".out" file exists, let's use it, if
> not, fallback to exit status (or the other way around, as long as it's
> predictable).  For instance, the current implementation of
> iotests.main() discards the exit status that could be one of the
> PASS/FAIL criteria.

I think we basically agree.

"Verify output with diff" is great when it fits the test, but it doesn't
fit all tests.

A test program terminating unsuccessfully should be treated as test
failure, regardless of any output checking the test harness may do.

>> I don't doubt that featureful test frameworks like Avocado provide
>> adequate tools to debug tests.  The lure of the shell is its perceived
>> simplicity: everybody knows (well, should know) how to write and debug
>> simple shell scripts.  Of course, the simplicity evaporates when the
>> scripts grow beyond "simple".  Scare quotes, because what's simple for
>> Alice may not be so simple for Bob.
>> 
>
> Agreed.  That's why I avoided "simple" and "complex" in my previous
> messages.  A statement such as "tool XYZ usually scales better" has
> bigger chances of being agreed upon by both Alice and Bob.

Of course, "scales better" is actually better only if you need it to
scale :)

>>> BTW, I'll defer the discussion of using an external tool to check the
>>> output and determine test success/failure, because it is IMO a
>>> complementary topic, and I believe I understand its use cases.
>> 
>> Yes.  Regardless, I want to tell you *now* how tired of writing code to
>> verify test output I am.  Even of reading it.  Output text is easier to
>> read than code that tries to verify output text.  Diffs are easier to
>> read than stack backtraces.
>> 
>
> Point taken.  And truth be told: the current shell based qemu-iotests
> excel at this, with its simple and effective "run_qemu <<<QMP_INPUT"
> pattern.  The cons are:
>
> 1) Some use cases do not fall so nicely in this pattern, and end up
> requiring workarounds (such as filters)

Output filtering is just fine as long as it's reasonably simple, and you
have to mess with it only rarely.  You can almost ignore it in actual
testing work then.

> 2) The expected output is not readily accessible

Expected output would be in git, readily accessible, so that can't be
what you mean.  What do you mean?

> Considering that for the specific case of tests targeting QMP, most of
> the action comes down to the message exchanges (commands sent, response
> received), how would you feel about a descriptive approach to the
> communication?  Something along these lines:
>
> """
> -> { "execute": "change",
>      "arguments": { "device": "ide1-cd0",
>                     "target": "/srv/images/Fedora-12-x86_64-DVD.iso" } }
> <- { "return": {} }
> """
>
> If this looks familiar, that's because it is a snippet from the
> qapi-schema.json file.  It's documentation, so it should mean that's
> easy to read, *but*, there's no reason this can not be treated as code too.
>
> This approach is similar to Python's doctest[1], in which a docstring
> contains snippets of Python code to be evaluated, and the expected
> outcome.  Example:
>
> def factorial(n):
>     """Return the factorial of n, an exact integer >= 0.
>
>     If the result is small enough to fit in an int, return an int.
>     Else return a long.
>
>     >>> [factorial(n) for n in range(6)]
>     [1, 1, 2, 6, 24, 120]
>     """
>
> The lines that match the interpreter input will be evaluated, and the
> subsequent lines are the expected output.

Executable examples in documentation are a really, really good idea,
because they greatly improve the chances the examples reflect reality.

But as you remark below, they can't be the one source of tests, because
(1) it would clutter documentation too much, and (2) it would limit what
tests can do.

An executable example provides QMP input and output, no more.  What if
we need to run QEMU a certain way to make the example work?  We'd have
to add that information to the example.  Might even be an improvement.

More seriously, executable examples make the test case *data*.  Good,
because data is better than code.  Until it isn't.  Sometimes you just
need a loop, a timeout, or want to print a bit of extra information that
isn't QMP output.

> I don't think all QMP tests can be modeled like this, inside literal
> strings, but having blocks that can be used when it makes sense seems
> logical to me.  Pseudo code:
>
> test_change() {
>
>   init_qemu()
>   failUnless(fileExists('/srv/images/Fedora-12-x86_64-DVD.iso'))
>
>   qmp("""
> -> { "execute": "change",
>      "arguments": { "device": "ide1-cd0",
>                     "target": "/srv/images/Fedora-12-x86_64-DVD.iso" } }
> <- { "return": {} }
> """)
>
>   check_qemu_has_fd_open_for_iso()
> }
>
> IMO, the qmp() function can provide similar quality of readability to diff.
>
> How does it sound?  As with previous interactions, if people see value
> in this, I can certainly follow up with a PoC.

This brings some advantages of "verify output with diff" to tests that
verify with code.  Improvement if it simplifies the verification code.

I'd still prefer *no* verification code (by delegating the job to diff)
for tests where I can get away wit it.

>>> [1] -
>>> http://avocado-framework.readthedocs.io/en/52.0/api/utils/avocado.utils.html#avocado.utils.process.run
>>> [2] -
>>> http://avocado-framework.readthedocs.io/en/52.0/WritingTests.html#advanced-logging-capabilities
>>> [3] - https://www.youtube.com/watch?v=htUbOsh8MZI
>> 
>> [*] Very many nutty things are more obviously nuts in shell.  It's an
>> advantage of sorts ;)
>> 
>
> We all know a number of amazing software that gets written using the
> most improbable tools and languages.  It makes the world a much more
> interesting place!
>
> [1] - https://docs.python.org/2/library/doctest.html
