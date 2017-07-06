Received: from eggs.gnu.org ([2001:4830:134:3::10]:43672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT7ns-00058Q-GH
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT7nr-0002Oh-8z
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:30:48 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170705190404.22449-1-mreitz@redhat.com>
	<20170705190404.22449-3-mreitz@redhat.com>
Date: Thu, 06 Jul 2017 16:30:36 +0200
In-Reply-To: <20170705190404.22449-3-mreitz@redhat.com> (Max Reitz's message
	of "Wed, 5 Jul 2017 21:04:01 +0200")
Message-ID: <87poddk583.fsf@dusky.pond.sub.org>
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> This generic function (along with its implementations for different
> types) determines whether two QObjects are equal.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Markus also proposed just reporting two values as unequal if they have a
> different internal representation (i.e. a different QNum kind).
>
> I don't like this very much, because I feel like QInt and QFloat have
> been unified for a reason: Outside of these classes, nobody should care
> about the exact internal representation.  In JSON, there is no
> difference anyway.  We probably want to use integers as long as we can
> and doubles whenever we cannot.

You're right in that JSON has no notion of integer and floating-point,
only "number".  RFC 4627 is famously useless[1] on what exactly a number
ought to be, and its successor RFC 7159 could then (due to wildly
varying existing practice) merely state that a number is what the
implementation makes it to be, and advises "good interoperability can be
achieved" by making it double".  Pffft.

For us, being able to represent 64 bit integers is more important than
interoperating with crappy JSON implementations, so we made it the union
of int64_t, uint64_t and double[2].

You make a fair point when you say that nothing outside QNum should care
about the exact internal representation.  Trouble is that unless I'm
mistaken, your idea of "care" doesn't match the existing code's idea.

Let i42 = qnum_from_int(42)
    u42 = qnum_from_uint(42)
    d42 = qnum_from_double(42)

Then

    qnum_is_equal(i42, u42) yields true, I think.
    qnum_is_equal(i42, d42) yields true, I think.
    qnum_get_int(i42) yields 42.
    qnum_get_int(u42) yields 42.
    qnum_get_int(d42) fails its assertion.

Failing an assertion qualifies as "care", doesn't it?

> In any case, I feel like the class should hide the different internal
> representations from the user.  This necessitates being able to compare
> floating point values against integers.  Since apparently the main use
> of QObject is to parse and emit JSON (and represent such objects
> internally), we also have to agree that JSON doesn't make a difference:
> 42 is just the same as 42.0.

The JSON RFC is mum on that.

In *our* implementation of JSON, 42 and 42.0 have always been very much
*not* the same.  Proof:

    -> { "execute": "migrate_set_speed", "arguments": { "value": 42 } }
    <- {"return": {}}
    -> { "execute": "migrate_set_speed", "arguments": { "value": 42.0 } }
    <- {"error": {"class": "GenericError", "desc": "Invalid parameter type for 'value', expected: integer"}}

This is because migrate_set_speed argument value is 'int', and 42.0 is
not a valid 'int' value.

Note that 42 *is* a valid 'number' value.  migrate_set_downtime argument
value is 'number':

    -> { "execute": "migrate_set_downtime", "arguments": { "value": 42 } }
    <- {"return": {}}
    -> { "execute": "migrate_set_downtime", "arguments": { "value": 42.0 } }
    <- {"return": {}}

Don't blame me for the parts of QMP I inherited :)

> Finally, I think it's rather pointless not to consider 42u and 42 the
> same value.  But since unsigned/signed are two different kinds of QNums
> already, we cannot consider them equal without considering 42.0 equal,
> too.

Non sequitur.

> Because of this, I have decided to continue to compare QNum values even
> if they are of a different kind.

I think comparing signed and unsigned integer QNums is fair and
consistent with how the rest of our code works.

Comparing integer and floating QNums isn't.  It's also a can of worms.
Are you sure we *need* to open that can *now*?

Are you sure a simple, stupid eql-like comparison won't do *for now*?
YAGNI!


[1] Standard reply to criticism of JSON: could be worse, could be XML.

[2] Union of int64_t and double until recently, plus bugs that could be
abused to "tunnel" uint64_t values.  Some of the bugs have to remain for
backward compatibility.
