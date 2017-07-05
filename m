Received: from eggs.gnu.org ([2001:4830:134:3::10]:51618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSmtr-0001kZ-Lf
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSmtq-0007kz-H9
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:11:35 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-3-mreitz@redhat.com>
	<87r2xve509.fsf@dusky.pond.sub.org>
	<98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
	<7e9bdf55-c11d-e7cd-d92b-5ccef7e48d3c@redhat.com>
Date: Wed, 05 Jul 2017 18:11:25 +0200
In-Reply-To: <7e9bdf55-c11d-e7cd-d92b-5ccef7e48d3c@redhat.com> (Eric Blake's
	message of "Wed, 5 Jul 2017 09:15:09 -0500")
Message-ID: <87zicilv82.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: Add qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 07/05/2017 08:48 AM, Max Reitz wrote:
>>>>  /**
>>>> + * qnum_is_equal(): Test whether the two QNums are equal
>>>> + */
>>>> +bool qnum_is_equal(const QObject *x, const QObject *y)
>>>> +{
>>>> +    QNum *num_x = qobject_to_qnum(x);
>>>> +    QNum *num_y = qobject_to_qnum(y);
>>>> +
>>>> +    switch (num_x->kind) {
>>>> +    case QNUM_I64:
>>>> +        switch (num_y->kind) {
>>>> +        case QNUM_I64:
>>>> +            /* Comparison in native int64_t type */
>>>> +            return num_x->u.i64 == num_y->u.i64;
>>>> +        case QNUM_U64:
>>>> +            /* Implicit conversion of x to uin64_t, so we have to
>>>> +             * check its sign before */
>>>> +            return num_x->u.i64 >= 0 && num_x->u.i64 == num_y->u.u64;
>>>> +        case QNUM_DOUBLE:
>>>> +            /* Implicit conversion of x to double; no overflow
>>>> +             * possible */
>>>> +            return num_x->u.i64 == num_y->u.dbl;
>>>
>>> Overflow is impossible, but loss of precision is possible:
>>>
>>>     (double)9007199254740993ull == 9007199254740992.0
>>>
>>> yields true.  Is this what we want?
>> 
>> I'd argue that yes, because the floating point value represents
>> basically all of the values which are "equal" to it.
>
> But the problem is that we CAN represent the fully-precise number as an
> integer, so having multiple distinct integers that compare differently
> against each other, but equal to the same double, is awkward.

Yup.

>> But I don't have a string opinion. I guess the alternative would be to
>> convert the double to an integer instead and check for overflows before?
>
> That's the solution Markus gave, and I'm in favor of the tighter check:
>
[...]
>>> I think there's more than one sane interpretations of "is equal",
>>> including:
>>> 
>>> * The mathematical numbers represented by @x and @y are equal.
>>> 
>>> * @x and @y have the same contents, i.e. same kind and u.
>>> 
>>> * @x and @y are the same object (listed for completeness; we don't need
>>>   a function to compare pointers).
>>> 
>>> Your patch implements yet another one.  Which one do we want, and why?
>>
>> Mine is the first one, except that I think that a floating point value
>> does not represent a single number but just some number in a range.
>>
>>> The second is easier to implement than the first.
>>
>> It seems much less useful, though.

Depends on what for.

Common Lisp has

* eq: same object
* eql: eq, or both numbers with same type and value, or both characters
  that represent the same character
* =: mathematically equal (arguments must be numbers)
* equal: like eql, but it recursively descends into lists (I'm
  simplifying)

Decades of use back the assertion that eq, eql and = are all useful.

>>> If we really want the first, you need to fix the loss of precision bugs.
>>
>> I'm not sure, but I don't mind either, so...

For what it's worth, your v2 had QInt compare not equal to QFloat.
Makes me suspect that eql is good enough for the problem at hand.

>>> I guess the obvious fix is
>>>
>>>     return (double)x == x && x == y;
>> 
>> Yes, that would do, too; and spares me of having to think about how well
>> comparing an arbitrary double to UINT64_MAX actually works. :-)
>
> It basically says that we are unwilling to declare an integer equivalent
> to the double if the double loses precision when trying to store the
> integer.
>
>>> Note that this is what you do for mixed signedness: first check @x is
>>> exactly representable in @y's type, then compare in @y's type.
>>> 
>>> Regardless of which one we pick, the function comment needs to explain.
