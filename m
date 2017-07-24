Received: from eggs.gnu.org ([2001:4830:134:3::10]:42883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZXIe-0007sC-Pe
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 02:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZXIa-00069Z-H1
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 02:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dZXIa-00068A-8D
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 02:57:00 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <87o9so1hl7.fsf@dusky.pond.sub.org>
	<20170717103308.GI7163@stefanha-x1.localdomain>
	<8760epr9vw.fsf@dusky.pond.sub.org>
	<20170721153331.GL18014@stefanha-x1.localdomain>
	<026a093f-1f79-4af9-a5c9-d540342b472e@redhat.com>
Date: Mon, 24 Jul 2017 08:56:50 +0200
In-Reply-To: <026a093f-1f79-4af9-a5c9-d540342b472e@redhat.com> (Cleber Rosa's
	message of "Fri, 21 Jul 2017 12:16:30 -0400")
Message-ID: <8760eiuxu5.fsf@dusky.pond.sub.org>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, Cleber Rosa <cleber@redhat.com>

Cleber Rosa <crosa@redhat.com> writes:

> On 07/21/2017 11:33 AM, Stefan Hajnoczi wrote:
>>> Output testing style delegates checking ouput to diff.  I rather like it
>>> when text output is readily available.  It is when testing QMP.  A
>>> non-trivial example using this style could be useful, as discussing
>>> ideas tends to be more productive when they come with patches.
>> 
>> Yes, I was considering how many of the Python iotests could be rewritten
>> comfortably in shell.  It is nice when the test simply executes commands
>> and the output file shows the entire history of what happened.  Great
>> for debugging.
>> 
>> Stefan
>> 
> I'd like to have a better understanding of the major pain points here.
>
> Although this can be seen as a matter of taste, style preferences and
> even religion, I guess it's safe to say that Python can scale better
> than shell.  The upside of shell based tests is the "automatic" and
> complete logging, right?  Running "bash -x /path/to/test.sh" will give
> much more *useful* information than "python -v /path/to/test.py" will, fact.
>
> I believe this has to do with how *generic* Python code is written, and
> how builtin functions and most of the standard Python libraries work as
> they do.  Now, when writing code aimed at testing, making use of testing
> oriented libraries and tools, one would expect much more useful and
> readily available debug information.
>
> I'm biased, for sure, but that's what you get when you write basic tests
> using the Avocado libraries.  For instance, when using process.run()[1]
> within a test, you can choose to see its command output quite easily
> with a command such as "avocado --show=avocado.test.stdout run test.py".
>
> Using other custom logging channels is also trivial (for instance for
> specific QMP communication)[2][3].
>
> I wonder if such logging capabilities fill in the gap of what you
> describe as "[when the] output file shows the entire history of what
> happened".

Test code language is orthogonal to verification method (with code
vs. with diff).  Except verifying with shell code would be obviously
nuts[*].

The existing iotests written in Python verify with code, and the ones
written in shell verify with diff.  Doesn't mean that we have to port
from Python to shell to gain "verify with diff".

I don't doubt that featureful test frameworks like Avocado provide
adequate tools to debug tests.  The lure of the shell is its perceived
simplicity: everybody knows (well, should know) how to write and debug
simple shell scripts.  Of course, the simplicity evaporates when the
scripts grow beyond "simple".  Scare quotes, because what's simple for
Alice may not be so simple for Bob.

> BTW, I'll defer the discussion of using an external tool to check the
> output and determine test success/failure, because it is IMO a
> complementary topic, and I believe I understand its use cases.

Yes.  Regardless, I want to tell you *now* how tired of writing code to
verify test output I am.  Even of reading it.  Output text is easier to
read than code that tries to verify output text.  Diffs are easier to
read than stack backtraces.

> [1] -
> http://avocado-framework.readthedocs.io/en/52.0/api/utils/avocado.utils.html#avocado.utils.process.run
> [2] -
> http://avocado-framework.readthedocs.io/en/52.0/WritingTests.html#advanced-logging-capabilities
> [3] - https://www.youtube.com/watch?v=htUbOsh8MZI

[*] Very many nutty things are more obviously nuts in shell.  It's an
advantage of sorts ;)
