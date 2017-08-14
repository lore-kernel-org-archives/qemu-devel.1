Received: from eggs.gnu.org ([2001:4830:134:3::10]:41330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhBLG-0005Mw-Dk
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhBLF-0004bR-2y
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:07:22 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170705190404.22449-1-mreitz@redhat.com>
	<20170705190404.22449-3-mreitz@redhat.com>
	<87poddk583.fsf@dusky.pond.sub.org>
	<6a1740fd-2a8c-f338-6ce1-e0f4bbade407@redhat.com>
	<87a84c6476.fsf@dusky.pond.sub.org>
	<704969af-283c-d22b-f0d2-e7bf0a7b609a@redhat.com>
	<87y3rvjjip.fsf@dusky.pond.sub.org>
	<27f963d3-46f3-d497-2bb6-eca05e808983@redhat.com>
Date: Mon, 14 Aug 2017 11:07:11 +0200
In-Reply-To: <27f963d3-46f3-d497-2bb6-eca05e808983@redhat.com> (Max Reitz's
	message of "Tue, 11 Jul 2017 15:17:02 +0200")
Message-ID: <87bmnih60w.fsf@dusky.pond.sub.org>
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

> On 2017-07-11 13:33, Markus Armbruster wrote:
>> Max Reitz <mreitz@redhat.com> writes:
>> 
>>> First of all, OK, you don't want QNum(42.0) to equal QNum(42) at all (at
>>> least not right now and in the foreseeable future).
>>> You're the maintainer, so you decide, so I'll go along with it. :-)
>>>
>>> Now, let's follow up with my therefore rather useless commentary:
>>>
>>> (Feel free to disregard, because honestly, I can see how replying to
>>> most of the points I'm asking isn't really worth the time...)
>> 
>> When I use the authority entrusted to maintainers, I feel obliged to at
>> least explain my reasoning.  Besides, putting my reasoning in words
>> tends to lead me to new insights.
>
> And I am indeed very grateful for that. :-)
>
>>> On 2017-07-10 11:17, Markus Armbruster wrote:
>>>> Max Reitz <mreitz@redhat.com> writes:
>>>>
>>>>> On 2017-07-06 16:30, Markus Armbruster wrote:
>
> [...]
>
>>>> The only way to add unsigned integers without breaking QMP compatibility
>>>> is to make them interchangeable with signed integers.  That doesn't mean
>>>> you get to make floating-point numbers interchangeable with integers
>>>> now.
>>>
>>> Again, begs the question why QNum covers floating point numbers then and
>>> why this very fact is not documented in qnum.c.
>> 
>> What kind of documentation would you like to see?
>
> It would be good to note that the QNum type is not meant to be a
> completely uniform way to handle JSON numbers (e.g. if the user provides
> something with a decimal point but you need an integer, QNum will not do
> that conversion for you).
>
> It is (English indirect speech is broken badly) just meant to
> encapsulate the different variants a number can be represented in, but
> you're still generally supposed to read it out the way it was put in
> (exceptions apply, see signed/unsigned and qnum_get_double()).

Can we distill this into text that could become an actual patch?  Let me
try.

    QNum encapsulates how our dialect of JSON fills in the blanks left
    by the JSON specification (RFC 7159) regarding numbers.

    Conceptually, we treat number as an abstract type with three
    concrete subtypes: floating-point, signed integer, unsigned integer.
    QNum implements this a discriminated union of double, int64_t,
    uint64_t.

    The JSON parser picks the subtype as follows.  If the number has a
    decimal point or an exponent, it is floating-point.  Else if it fits
    into int64_t, it's signed integer.  Else if it first into uint64_t,
    it's unsigned integer.  Else it's floating-point.

    Any number can serve as double: qnum_get_double() converts under the
    hood.

    An integer can serve as signed / unsigned integer as long as it is
    in range: qnum_get_try_int() / qnum_get_try_uint() check range and
    convert under the hood.

What do you think?
