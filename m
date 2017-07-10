Received: from eggs.gnu.org ([2001:4830:134:3::10]:35491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dUUpN-0003bQ-4g
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:18:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dUUpL-0006eW-6j
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:18:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170705190404.22449-1-mreitz@redhat.com>
	<20170705190404.22449-3-mreitz@redhat.com>
	<87poddk583.fsf@dusky.pond.sub.org>
	<6a1740fd-2a8c-f338-6ce1-e0f4bbade407@redhat.com>
Date: Mon, 10 Jul 2017 11:17:49 +0200
In-Reply-To: <6a1740fd-2a8c-f338-6ce1-e0f4bbade407@redhat.com> (Max Reitz's
	message of "Sun, 9 Jul 2017 19:36:12 +0200")
Message-ID: <87a84c6476.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 2/5] qapi: Add qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> On 2017-07-06 16:30, Markus Armbruster wrote:
>> Max Reitz <mreitz@redhat.com> writes:
>> 
>>> This generic function (along with its implementations for different
>>> types) determines whether two QObjects are equal.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>> Markus also proposed just reporting two values as unequal if they have a
>>> different internal representation (i.e. a different QNum kind).
>>>
>>> I don't like this very much, because I feel like QInt and QFloat have
>>> been unified for a reason: Outside of these classes, nobody should care
>>> about the exact internal representation.  In JSON, there is no
>>> difference anyway.  We probably want to use integers as long as we can
>>> and doubles whenever we cannot.
>> 
>> You're right in that JSON has no notion of integer and floating-point,
>> only "number".  RFC 4627 is famously useless[1] on what exactly a number
>> ought to be, and its successor RFC 7159 could then (due to wildly
>> varying existing practice) merely state that a number is what the
>> implementation makes it to be, and advises "good interoperability can be
>> achieved" by making it double".  Pffft.
>> 
>> For us, being able to represent 64 bit integers is more important than
>> interoperating with crappy JSON implementations, so we made it the union
>> of int64_t, uint64_t and double[2].
>> 
>> You make a fair point when you say that nothing outside QNum should care
>> about the exact internal representation.  Trouble is that unless I'm
>> mistaken, your idea of "care" doesn't match the existing code's idea.
>
> I disagree that it doesn't match the existing code's idea.  I think the
> existing code doesn't match its idea, but mine does.
>
>> Let i42 = qnum_from_int(42)
>>     u42 = qnum_from_uint(42)
>>     d42 = qnum_from_double(42)
>> 
>> Then
>> 
>>     qnum_is_equal(i42, u42) yields true, I think.
>>     qnum_is_equal(i42, d42) yields true, I think.
>>     qnum_get_int(i42) yields 42.
>>     qnum_get_int(u42) yields 42.
>>     qnum_get_int(d42) fails its assertion.
>> 
>> Failing an assertion qualifies as "care", doesn't it?
>
> It doesn't convert the value?  That's definitely not what I would have
> thought and it doesn't make a lot of sense to me.  I call that a bug. :-)

It's the existing code's idea, going back all the way to the dawn of
QMP: integers and floating point numbers are distinct.

Yes, they aren't distinct in the JSON grammar.  So sue the designers of
QMP.

Yes, they are less distinct in QMP than say integers and strings,
because there's an automatic conversion from integer to floating point.
Doesn't make them non-distinct; there is no conversion from floating
point to integer.

Yes, we recently changed the code to use the same C type for both.  That
was done to keep the code simple, not to change the semantics of QMP.

> From the other side we see that qnum_get_double() on all of this would
> yield 42.0 without failing.  So why is it that qnum_get_int() doesn't?
> Because there are doubles you cannot reasonably convert to integers, I
> presume, whereas the other way around the worst that can happen is that
> you lose some precision.
>
> But that has no implication on qnum_is_equal().  If the double cannot be
> converted to an integer because it is out of bounds, the values just are
> not equal.  Simple.
>
> So since qnum_get_double() does a conversion, I very much think that the
> reason qnum_get_int() doesn't is mostly "because sometimes it's not
> reasonably possible" and very much not because it is not intended to.

It doesn't because the whole shebang is for QMP, and QMP does not ever
treat floating point numbers (numbers with decimal point or exponent) as
integers.

Yes, there are users other than QMP.  They adopted it because it was
convenient.  They thus adopted its oddities due to QMP's requirements,
too.

>>> In any case, I feel like the class should hide the different internal
>>> representations from the user.  This necessitates being able to compare
>>> floating point values against integers.  Since apparently the main use
>>> of QObject is to parse and emit JSON (and represent such objects
>>> internally), we also have to agree that JSON doesn't make a difference:
>>> 42 is just the same as 42.0.
>> 
>> The JSON RFC is mum on that.
>> 
>> In *our* implementation of JSON, 42 and 42.0 have always been very much
>> *not* the same.  Proof:
>> 
>>     -> { "execute": "migrate_set_speed", "arguments": { "value": 42 } }
>>     <- {"return": {}}
>>     -> { "execute": "migrate_set_speed", "arguments": { "value": 42.0 } }
>>     <- {"error": {"class": "GenericError", "desc": "Invalid parameter type for 'value', expected: integer"}}
>> 
>> This is because migrate_set_speed argument value is 'int', and 42.0 is
>> not a valid 'int' value.
>
> Well, that's a bug, too.  It's nice that we accept things that aren't
> quite valid JSON (I'm looking at you, single quote), but we should
> accept things that are valid JSON.

The fact that an expression is valid JSON does not oblige the
application to accept it!

Of all the valid JSON strings, the parser accepts only the ones shorter
than MAX_TOKEN_SIZE.  Command block-job-set-speed then rejects all but
the ones that happen to be valid job IDs.

Similarly, of all the valid JSON numbers, the parser accepts only the
integers (no decimal point, no exponent) that fit into int64_t, uint64_t
or double, and the floating point numbers (decimal point or exponent)
that fit into double.  Command migrate_set_speed then rejects all but
the integers (again, no decimal point, no exponent) between 0 and
SIZE_MAX.

JSON defines *syntax*.  Once again, the JSON RFC is mum on whether 42
and 42.0 are identical or distinct.  That's *semantics*, and semantics
are up to the application.  Ours has always treated them as distinct.
It is how QMP works.  We can like it or we can hate it.  I certainly
find plenty of things to dislike there myself.  What we can't do is deny
that it's ABI.

We can of course make ABI more accepting.  However, messing with the QMP
ABI is *hairy*, and we should therefore mess with it only when we have a
damn good practical reason.  "It's not nice" ain't.

>> Note that 42 *is* a valid 'number' value.  migrate_set_downtime argument
>> value is 'number':
>> 
>>     -> { "execute": "migrate_set_downtime", "arguments": { "value": 42 } }
>>     <- {"return": {}}
>>     -> { "execute": "migrate_set_downtime", "arguments": { "value": 42.0 } }
>>     <- {"return": {}}
>> 
>> Don't blame me for the parts of QMP I inherited :)
>
> I sure don't.  But I am willing to start a discussion by calling that a
> bug. ;-)
>
> QNum has only been introduced recently.  Before, we had a hard split of
> QInt and QFloat.  So I'm not surprised that we haven't fixed everything yet.
>
> OTOH the introduction of QNum to me signals that we do want to fix this
> eventually.

QNum was introduced to get us unsigned numbers with the least possible
notational overhead.  It wasn't introduced to signal intent to redesign
QMP numbers.

>>> Finally, I think it's rather pointless not to consider 42u and 42 the
>>> same value.  But since unsigned/signed are two different kinds of QNums
>>> already, we cannot consider them equal without considering 42.0 equal,
>>> too.
>> 
>> Non sequitur.
>> 
>>> Because of this, I have decided to continue to compare QNum values even
>>> if they are of a different kind.
>> 
>> I think comparing signed and unsigned integer QNums is fair and
>> consistent with how the rest of our code works.
>
> I don't see how. doubles can represent different numbers than integers
> can. Signed integers can represent different numbers than unsigned can.

The only way to add unsigned integers without breaking QMP compatibility
is to make them interchangeable with signed integers.  That doesn't mean
you get to make floating-point numbers interchangeable with integers
now.

> Sure, signed/unsigned makes less of a difference than having an exponent
> does.  But I don't agree we should make a difference when the only
> reason not to seems to be "qemu currently likes to make a difference in
> its interface, for historical reasons mainly" and "Do you really want to
> write this equality function?  It seems hard to get right".

"Because this is an interesting puzzle I'd love to solve" is wholly
insufficient reason to mess with QMP ABI.  It's also an insufficient
reason to add "interesting" code for me to maintain.

> For the record, I could have lived with the old separation into QInt and
> QFloat.  But now we do have a common QNum and I think the idea behind is
> is to have a uniform opaque interface.

Nope, the idea is to get unsigned integers through QMP with the least
notational overhead.

>> Comparing integer and floating QNums isn't.  It's also a can of worms.
>> Are you sure we *need* to open that can *now*?
>
> Sure?  No.  Do I want to?  I guess so.
>
>> Are you sure a simple, stupid eql-like comparison won't do *for now*?
>> YAGNI!
>
> But I want it.  I think the current behavior your demonstrated above is
> a bug and I don't really want to continue to follow it.

Feel free to call the current behavior a bug.  But it's a design bug
then.  Fixing design bugs in ABIs is somewhere between hard and
impractical.  I do not think this one is worth your while or mine.

> All you have really convinced me to do is to add another patch which
> smacks a warning on qnum_get_int(), and maybe even a TODO that it should
> convert doubles to integers *if possible*.
>
> (And the "if possible" just means that you cannot convert values which
> are out of bounds or NaN.  Fractional parts may not even matter much --
> I mean, we do happily convert integers to doubles and rounding that way
> is implementation-defined.)

Always try the stupidest solution that could possibly work first.
Unless I misunderstand your use case, a simple & stupid
qobject_is_equal() would do.  So let's try that first.

Adding capability to compare signed and unsigned integers should still
be fairly simple.  I'd be willing to consider it.

>> [1] Standard reply to criticism of JSON: could be worse, could be XML.
>> 
>> [2] Union of int64_t and double until recently, plus bugs that could be
>> abused to "tunnel" uint64_t values.  Some of the bugs have to remain for
>> backward compatibility.
