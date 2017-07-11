Received: from eggs.gnu.org ([2001:4830:134:3::10]:43311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dUtPy-0000Cr-3Q
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 07:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dUtPu-0006ve-UN
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 07:33:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170705190404.22449-1-mreitz@redhat.com>
	<20170705190404.22449-3-mreitz@redhat.com>
	<87poddk583.fsf@dusky.pond.sub.org>
	<6a1740fd-2a8c-f338-6ce1-e0f4bbade407@redhat.com>
	<87a84c6476.fsf@dusky.pond.sub.org>
	<704969af-283c-d22b-f0d2-e7bf0a7b609a@redhat.com>
Date: Tue, 11 Jul 2017 13:33:02 +0200
In-Reply-To: <704969af-283c-d22b-f0d2-e7bf0a7b609a@redhat.com> (Max Reitz's
	message of "Mon, 10 Jul 2017 23:30:45 +0200")
Message-ID: <87y3rvjjip.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

> First of all, OK, you don't want QNum(42.0) to equal QNum(42) at all (at
> least not right now and in the foreseeable future).
> You're the maintainer, so you decide, so I'll go along with it. :-)
>
> Now, let's follow up with my therefore rather useless commentary:
>
> (Feel free to disregard, because honestly, I can see how replying to
> most of the points I'm asking isn't really worth the time...)

When I use the authority entrusted to maintainers, I feel obliged to at
least explain my reasoning.  Besides, putting my reasoning in words
tends to lead me to new insights.

> On 2017-07-10 11:17, Markus Armbruster wrote:
>> Max Reitz <mreitz@redhat.com> writes:
>>=20
>>> On 2017-07-06 16:30, Markus Armbruster wrote:
>>>> Max Reitz <mreitz@redhat.com> writes:
>>>>
>>>>> This generic function (along with its implementations for different
>>>>> types) determines whether two QObjects are equal.
>>>>>
>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>> ---
>>>>> Markus also proposed just reporting two values as unequal if they hav=
e a
>>>>> different internal representation (i.e. a different QNum kind).
>>>>>
>>>>> I don't like this very much, because I feel like QInt and QFloat have
>>>>> been unified for a reason: Outside of these classes, nobody should ca=
re
>>>>> about the exact internal representation.  In JSON, there is no
>>>>> difference anyway.  We probably want to use integers as long as we can
>>>>> and doubles whenever we cannot.
>>>>
>>>> You're right in that JSON has no notion of integer and floating-point,
>>>> only "number".  RFC 4627 is famously useless[1] on what exactly a numb=
er
>>>> ought to be, and its successor RFC 7159 could then (due to wildly
>>>> varying existing practice) merely state that a number is what the
>>>> implementation makes it to be, and advises "good interoperability can =
be
>>>> achieved" by making it double".  Pffft.
>>>>
>>>> For us, being able to represent 64 bit integers is more important than
>>>> interoperating with crappy JSON implementations, so we made it the uni=
on
>>>> of int64_t, uint64_t and double[2].
>>>>
>>>> You make a fair point when you say that nothing outside QNum should ca=
re
>>>> about the exact internal representation.  Trouble is that unless I'm
>>>> mistaken, your idea of "care" doesn't match the existing code's idea.
>>>
>>> I disagree that it doesn't match the existing code's idea.  I think the
>>> existing code doesn't match its idea, but mine does.
>>>
>>>> Let i42 =3D qnum_from_int(42)
>>>>     u42 =3D qnum_from_uint(42)
>>>>     d42 =3D qnum_from_double(42)
>>>>
>>>> Then
>>>>
>>>>     qnum_is_equal(i42, u42) yields true, I think.
>>>>     qnum_is_equal(i42, d42) yields true, I think.
>>>>     qnum_get_int(i42) yields 42.
>>>>     qnum_get_int(u42) yields 42.
>>>>     qnum_get_int(d42) fails its assertion.
>>>>
>>>> Failing an assertion qualifies as "care", doesn't it?
>>>
>>> It doesn't convert the value?  That's definitely not what I would have
>>> thought and it doesn't make a lot of sense to me.  I call that a bug. :=
-)
>>=20
>> It's the existing code's idea, going back all the way to the dawn of
>> QMP: integers and floating point numbers are distinct.
>>=20
>> Yes, they aren't distinct in the JSON grammar.  So sue the designers of
>> QMP.
>
> Sounds like it was a reasonable idea at the time but could be done
> better today.  But that's how it always is, right?

Finding fault with designs we've inherited turns out to be much easier
than coming up with designs that last.

>> Yes, they are less distinct in QMP than say integers and strings,
>> because there's an automatic conversion from integer to floating point.
>> Doesn't make them non-distinct; there is no conversion from floating
>> point to integer.
>
> I can very well see that as a technical reason, but OK.
>
>> Yes, we recently changed the code to use the same C type for both.  That
>> was done to keep the code simple, not to change the semantics of QMP.
>
> Hm, OK.
>
>>> From the other side we see that qnum_get_double() on all of this would
>>> yield 42.0 without failing.  So why is it that qnum_get_int() doesn't?
>>> Because there are doubles you cannot reasonably convert to integers, I
>>> presume, whereas the other way around the worst that can happen is that
>>> you lose some precision.
>>>
>>> But that has no implication on qnum_is_equal().  If the double cannot be
>>> converted to an integer because it is out of bounds, the values just are
>>> not equal.  Simple.
>>>
>>> So since qnum_get_double() does a conversion, I very much think that the
>>> reason qnum_get_int() doesn't is mostly "because sometimes it's not
>>> reasonably possible" and very much not because it is not intended to.
>>=20
>> It doesn't because the whole shebang is for QMP, and QMP does not ever
>> treat floating point numbers (numbers with decimal point or exponent) as
>> integers.
>
> Well, to my defense, I couldn't see that from looking at the code.  From
> that point of view, it just looks like qnum_get_int() is lacking.

Looking at qnum.c in isolation can certainly lead sensible people to
such ideas.

>> Yes, there are users other than QMP.  They adopted it because it was
>> convenient.  They thus adopted its oddities due to QMP's requirements,
>> too.
>
> To me, that mostly sounds like an excuse that distinguishing between
> integers and floats will not be wrong, but not like a reason it is right.

More on that below.

>>>>> In any case, I feel like the class should hide the different internal
>>>>> representations from the user.  This necessitates being able to compa=
re
>>>>> floating point values against integers.  Since apparently the main use
>>>>> of QObject is to parse and emit JSON (and represent such objects
>>>>> internally), we also have to agree that JSON doesn't make a differenc=
e:
>>>>> 42 is just the same as 42.0.
>>>>
>>>> The JSON RFC is mum on that.
>>>>
>>>> In *our* implementation of JSON, 42 and 42.0 have always been very much
>>>> *not* the same.  Proof:
>>>>
>>>>     -> { "execute": "migrate_set_speed", "arguments": { "value": 42 } }
>>>>     <- {"return": {}}
>>>>     -> { "execute": "migrate_set_speed", "arguments": { "value": 42.0 =
} }
>>>>     <- {"error": {"class": "GenericError", "desc": "Invalid parameter =
type for 'value', expected: integer"}}
>>>>
>>>> This is because migrate_set_speed argument value is 'int', and 42.0 is
>>>> not a valid 'int' value.
>>>
>>> Well, that's a bug, too.  It's nice that we accept things that aren't
>>> quite valid JSON (I'm looking at you, single quote), but we should
>>> accept things that are valid JSON.
>>=20
>> The fact that an expression is valid JSON does not oblige the
>> application to accept it!
>
> Err, well...
>
>> Of all the valid JSON strings, the parser accepts only the ones shorter
>> than MAX_TOKEN_SIZE.  Command block-job-set-speed then rejects all but
>> the ones that happen to be valid job IDs.
>
> Yes...
>
>> Similarly, of all the valid JSON numbers, the parser accepts only the
>> integers (no decimal point, no exponent) that fit into int64_t, uint64_t
>> or double, and the floating point numbers (decimal point or exponent)
>> that fit into double.  Command migrate_set_speed then rejects all but
>> the integers (again, no decimal point, no exponent) between 0 and
>> SIZE_MAX.
>>=20
>> JSON defines *syntax*.  Once again, the JSON RFC is mum on whether 42
>> and 42.0 are identical or distinct.  That's *semantics*, and semantics
>> are up to the application.  Ours has always treated them as distinct.
>> It is how QMP works.  We can like it or we can hate it.  I certainly
>> find plenty of things to dislike there myself.  What we can't do is deny
>> that it's ABI.
>
> OK, yes, but I think it's just weird and serves no purpose.
>
> The thing is that numbers are a special case.  As far as I can see, all
> other parts of JSON have a clear and unique representation (disregarding
> whitespace).  There is only one true, one false, one null, one way to
> write a string, etc..
>
> But there are many ways to write 42.  You can write 42, you can write
> 42.0, you can write 4.2e1.
>
> This is very much guesswork on my part, but from what I've gathered
> about JSON, there is no difference between integers and floats.  There
> are only numbers.

I'm afraid you've gathered wrong.

RFC 4627 states "The representation of numbers is similar to that used
in most programming languages."  It then defines syntax.  That is all.
RFC 7159 follows suit.

In JavaScript, 42 and 42.0 are the same thing, because JavaScript
provides just one numeric type: IEEE double precision.

In most programming languages, they are not, because most programming
languages provide distinct numerical types for integers and
floating-point numbers.  For instance, C makes 42 an int, and 42.0 a
double.  See also Java, Lisp, ...

JSON is *not* a subset of JavaScript!  Perhaps it was once intended to
be one, but if that was the case, then the job got botched pretty
comprehensively.  Here's another difference, for your entertainment:
https://writing.pupius.co.uk/json-js-42a28471221d

>                    So whatever interprets a JSON value semantically will
> just see something that is a number value and it should not be able to
> tell whether that number had a decimal point or not (except for guessing
> by looking whether there's a fractional part).

True if your dialect of JSON treats all numbers as double.  Not true for
our dialect of JSON.

> Therefore, if you reject a number based on the fact that it has a
> decimal point in it, that to me seems like syntax, not semantics.
>
> In any case, to me it's no different from discriminating between 42.0
> and 4.2e1 (which even in C is exactly the same value).

Yes, but 42 isn't.

>> We can of course make ABI more accepting.  However, messing with the QMP
>> ABI is *hairy*, and we should therefore mess with it only when we have a
>> damn good practical reason.  "It's not nice" ain't.
>
> That depends on who looks at it.  You don't think it's a good reason,
> OK.  I think it is.
>
> I hope you can excuse me for not having yet made my fair share of bad
> experiences with trying to fix things and thus breaking them even
> further.  I'm sure I'll get appropriately pessimistic over the coming
> years. :-)

People's lack of understanding how hard something is has always been a
major contributor to progress :)

That said, I think we got plenty of bigger fish to fry in QAPI/QMP-land.

>>>> Note that 42 *is* a valid 'number' value.  migrate_set_downtime argume=
nt
>>>> value is 'number':
>>>>
>>>>     -> { "execute": "migrate_set_downtime", "arguments": { "value": 42=
 } }
>>>>     <- {"return": {}}
>>>>     -> { "execute": "migrate_set_downtime", "arguments": { "value": 42=
.0 } }
>>>>     <- {"return": {}}
>>>>
>>>> Don't blame me for the parts of QMP I inherited :)
>>>
>>> I sure don't.  But I am willing to start a discussion by calling that a
>>> bug. ;-)
>>>
>>> QNum has only been introduced recently.  Before, we had a hard split of
>>> QInt and QFloat.  So I'm not surprised that we haven't fixed everything=
 yet.
>>>
>>> OTOH the introduction of QNum to me signals that we do want to fix this
>>> eventually.
>>=20
>> QNum was introduced to get us unsigned numbers with the least possible
>> notational overhead.  It wasn't introduced to signal intent to redesign
>> QMP numbers.
>
> Again, that is very much not obvious from looking at QNum.  Why does it
> include floats then?  Because some basically integer values were
> represented as floats because they were supposed to be unsigned and did
> not fit into an int64_t?

QMP needs to bridge JSON to QAPI.  JSON has its (underspecified) JSON
number.  QAPI has integers and double.  The QMP designers chose to have
QMP accept any JSON number as double, but only numbers without decimal
point and exponent as integer.

This is implemented partly in the parser (which creates the approprate
QNum variant, see parse_literal()), and partly in qnum.c (where
qnum_get_double() accepts any variant).  Before qnum.c, the latter part
had to be done in every place that gets a double (at the time,
qobject_input_type_number() and qdict_get_double()).  One of the reasons
I like the QNum solution.

> I could understand that from a technical perspective, but it sounds more
> like we should have expanded QInt then to cover both signed and unsigned
> integers and then fixed places which tried to "abuse" QFloat for
> unsigned integers.

Marc-Andr=C3=A9 first proposed a solution with separate QInt, QUInt, QFloat.
I asked him to explore QNum as well, and that one turned out nicely, so
we picked it.

Separate QInt (with signed and unsigned variant) and QFloat would've
been possible, too.

Here's how I like to think about QNum.

At the implementation level, QNum has int64_t, uint64_t and double
variants, and is a subtype of QObject.

At the conceptual level, we have a signed integer, an unsigned integer
and a floating-point type, all subtypes of a number type, which is a
subtype of a value type.

The fact that some subtypes get their own C type while others "only"
become variants is an implementation detail.

>>>>> Finally, I think it's rather pointless not to consider 42u and 42 the
>>>>> same value.  But since unsigned/signed are two different kinds of QNu=
ms
>>>>> already, we cannot consider them equal without considering 42.0 equal,
>>>>> too.
>>>>
>>>> Non sequitur.
>>>>
>>>>> Because of this, I have decided to continue to compare QNum values ev=
en
>>>>> if they are of a different kind.
>>>>
>>>> I think comparing signed and unsigned integer QNums is fair and
>>>> consistent with how the rest of our code works.
>>>
>>> I don't see how. doubles can represent different numbers than integers
>>> can. Signed integers can represent different numbers than unsigned can.
>>=20
>> The only way to add unsigned integers without breaking QMP compatibility
>> is to make them interchangeable with signed integers.  That doesn't mean
>> you get to make floating-point numbers interchangeable with integers
>> now.
>
> Again, begs the question why QNum covers floating point numbers then and
> why this very fact is not documented in qnum.c.

What kind of documentation would you like to see?

>>> Sure, signed/unsigned makes less of a difference than having an exponent
>>> does.  But I don't agree we should make a difference when the only
>>> reason not to seems to be "qemu currently likes to make a difference in
>>> its interface, for historical reasons mainly" and "Do you really want to
>>> write this equality function?  It seems hard to get right".
>>=20
>> "Because this is an interesting puzzle I'd love to solve" is wholly
>> insufficient reason to mess with QMP ABI.
>
> I don't see how I'm messing with the QMP ABI here, but with an
> s/QMP ABI/this/, I see your point.

Because the QMP ABI is in part implemented in qnum.c.  Change to qnum.c
has to consider its effect on the QMP ABI.  Counts as "messing" in my
book.  I could've explained this more clearly, I guess.

>>                                            It's also an insufficient
>> reason to add "interesting" code for me to maintain.
>
> Now this is a point I can fully understand and agree on.
>
>>> For the record, I could have lived with the old separation into QInt and
>>> QFloat.  But now we do have a common QNum and I think the idea behind is
>>> is to have a uniform opaque interface.
>>=20
>> Nope, the idea is to get unsigned integers through QMP with the least
>> notational overhead.
>
> (Again, why include floats, then?)
>
>>>> Comparing integer and floating QNums isn't.  It's also a can of worms.
>>>> Are you sure we *need* to open that can *now*?
>>>
>>> Sure?  No.  Do I want to?  I guess so.
>>>
>>>> Are you sure a simple, stupid eql-like comparison won't do *for now*?
>>>> YAGNI!
>>>
>>> But I want it.  I think the current behavior your demonstrated above is
>>> a bug and I don't really want to continue to follow it.
>>=20
>> Feel free to call the current behavior a bug.  But it's a design bug
>> then.  Fixing design bugs in ABIs is somewhere between hard and
>> impractical.  I do not think this one is worth your while or mine.
>
> Technical question: How is this an ABI and not an API?  Making QNum
> replace QInt and QFloat was messing with the ABI.

If QEMU provided a C ABI that exposed QInt/QFloat/QNum, then the change
to QNum would've messed with that C ABI.  QEMU does not.

An ABI it does provide is the QMP ABI.  The change to QNum should be
invisible there.  We reviewed it carefully in that regard.

>                                                    Now, making QNum
> behave as both depending on what is asked for is just an API change,
> isn't it?

I suspect it would make QMP accept 42.0 as valid integer.  That would be
an ABI change.  I wouldn't bet on this being the only one without
careful review.

> Also, I still don't see how just converting every JSON number into a
> QNum and then making QNum return a valid integer or float depending on
> who's asking would be hard or impractical.

It's certainly possible.  It's just a lot more work than hacking up the
code for it.  The more work something takes, the stronger its
justification needs to be.

> (But really, don't bother to reply.  I pretty much know I'm overlooking
> a lot here and this is just my naive standpoint.  Again, though, maybe
> there should be documentation in qnum.c about this.)
>
>>> All you have really convinced me to do is to add another patch which
>>> smacks a warning on qnum_get_int(), and maybe even a TODO that it should
>>> convert doubles to integers *if possible*.
>>>
>>> (And the "if possible" just means that you cannot convert values which
>>> are out of bounds or NaN.  Fractional parts may not even matter much --
>>> I mean, we do happily convert integers to doubles and rounding that way
>>> is implementation-defined.)
>>=20
>> Always try the stupidest solution that could possibly work first.
>> Unless I misunderstand your use case, a simple & stupid
>> qobject_is_equal() would do.  So let's try that first.
> Honestly, I pretty much hate it.  But I can't say I disagree with your
> most important points (it'd be useless, it'd be overly complicated,
> you'd have to maintain something you don't want), so yep, will do.
>
>> Adding capability to compare signed and unsigned integers should still
>> be fairly simple.  I'd be willing to consider it.
>
> Thanks for bearing with me. :-)

Thank you for speaking your mind, and for hearing me out!
