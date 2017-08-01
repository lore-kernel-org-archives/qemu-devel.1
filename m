Received: from eggs.gnu.org ([2001:4830:134:3::10]:49992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dcPuy-0000RR-0g
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 01:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dcPuw-0005nh-RM
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 01:40:32 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-10-eblake@redhat.com>
	<20170728130538.GQ12364@stefanha-x1.localdomain>
	<3c27944c-bb18-a501-39b5-139059a4aa85@redhat.com>
	<307cae51-da45-4968-f6c9-4fa1ad4b22f8@redhat.com>
	<878tj5awtc.fsf@dusky.pond.sub.org>
	<e063a047-d587-9d05-842d-acea8cd8ecde@redhat.com>
Date: Tue, 01 Aug 2017 07:40:21 +0200
In-Reply-To: <e063a047-d587-9d05-842d-acea8cd8ecde@redhat.com> (Eric Blake's
	message of "Mon, 31 Jul 2017 13:33:24 -0500")
Message-ID: <87a83jzvzu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 09/12] tests/libqos/pci: Clean up string
 interpolation into QMP input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "open list:virtio-blk" <qemu-block@nongnu.org>, qemu-devel@nongnu.org, stefanha@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/31/2017 02:29 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> On 07/28/2017 11:35 AM, Eric Blake wrote:
>>>>>> +    QObject *extra_args = qobject_from_jsonf("{ 'shm': '%s', 'size': '1M' }",
>>>>>> +                                             tmpshm);
>>>>>
>>>
>>>> Passing '%s' through qobject_from_jsonf() is generally wrong (it would
>>>> produce ''...'' instead of the intended '...').
>>>>
>>>> Looks like something to fix on the next round.
>>>>
>>>
>>> What's scary is that the testsuite didn't start failing.  That's not
>>> good; we'll want to figure out why the bug didn't impact the test.
>> 
>> Good idea.
>
> The intended result: the created QDict would include
> "shm":"/qtest-11387-3641365368" (or comparable string).  The actual
> result: the created QDict includes "shm":"%s" - a literal 2-character
> string, because the lexer does not do interpolation inside strings.  And
> apparently, naming your ivshmem shared memory a literal "%s" (rather
> than a name beginning with "/") is not a semantic error, so the test passes.
>
> In other words, qobject_from_jsonf() does NOT do % interpolation of
> anything embedded inside '', and basically blindly ignores the tmpshm
> vararg.

Actually, it recognizes conversion specifications in lexer state
IN_START.  The only other states where it accepts them are IN_DQ_STRING
and IN_SQ_STRING.  It chokes on '%' in all other states.  Therefore,
conversion specifications can be be silently ignored only in JSON
strings.

>          It would be neat if we could make qobject_from_jsonf() detect a
> mismatch in varargs, even though we don't (can't) require a NULL
> sentinel (we're limited to fitting in with -Wformat paradigms already).
> So while we can't flag it at compile time, I do think we can flag it at
> runtime: if, in qobject_from_jsonf() (but NOT in qobject_from_json()),
> we reject any JSON string from the lexer that contains "%" but not "%%",
> we will have caught all the places where gcc paired a % sequence with a
> vararg parameter even though our lexer did not make the same pairing.
> If we WANT a literal % in a string (rare, probably only in the
> testsuite), we write it as %% and then qobject_from_jsonf() interpolates
> it.

If we make it do that.

Note that the JSON parser then recognizing one subset of printf
conversion specifiers as values (%s, %ld, %lld, ...) and another subset
within strings (just %%).  Not exactly elegant, but it works.

We could let it accept more (all?) conversion specifiers within strings,
but that would bring back the temptation to code JSON injection flaws.

>      Then, since bare % is NOT valid JSON, we don't have to enhance the
> lexer to recognize anything new; our changes are limited to
> documentation and the vararg parser.  It still means we only get a
> runtime, rather than a compile-time, detection of misuse of % passed to
> the format argument, but it should be an easy enough proof of concept
> that such a runtime failure would have been enough to make ivshmem-test
> fail and flag the error during 'make check' rather than escaping review.
