Received: from eggs.gnu.org ([2001:4830:134:3::10]:44360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpebH-0003Fp-Pp
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpebD-0007NA-0P
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:58:55 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<20170906153202.GJ3753@dhcp-200-186.str.redhat.com>
Date: Wed, 06 Sep 2017 19:58:31 +0200
In-Reply-To: <20170906153202.GJ3753@dhcp-200-186.str.redhat.com> (Kevin Wolf's
	message of "Wed, 6 Sep 2017 17:32:02 +0200")
Message-ID: <87o9qnr9o8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 00/56] qapi: Use 'size' for byte counts
 & offsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com, mreitz@redhat.com, jsnow@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> Am 07.08.2017 um 16:45 hat Markus Armbruster geschrieben:
>> Byte sizes, offsets and the like should use QAPI type 'size'
>> (uint64_t).  This rule is more honored in the breach than in the
>> observance.  Fix the obvious offenders.
>> 
>> The series is RFC for at least two reasons:
>> 
>> 1. It's only lightly tested.  Commit message claims like "FOO now
>>    works" haven't been verified, yet.
>> 
>> 2. The block layer represents file offsets and sizes as int64_t in
>>    many places.  Must not be negative, except for function return
>>    values, where it means failure.
>> 
>>    If you pass negative values via QMP, things explode.  Rejecting
>>    them cleanly would be better, but we do that only haphazardly, as
>>    far as I can tell.
>> 
>>    Changing the QAPI schema from 'int' (C: int64_t) to 'size' (C:
>>    uint64_t) arguably makes things slightly worse: you can't
>>    reasonably expect negative offsets and sizes to work, but expecting
>>    offsets and sizes between 2^63 and 2^64-1 to work is less
>>    unreasonable.  The explosions stay the same.
>> 
>>    Perhaps we should have a dedicated QAPI type for file offsets, just
>>    like libc has off_t.  Which is also signed, by the way.
>
> I discussed this a bit on IRC with Markus and I'll just reply here with
> some of our findings:
>
> * Having a 63-bit unsigned type makes sense. Not because it's the most
>   accurate type for most places and will catch all invalid arguments,
>   it's probably still too large in most places and individual function
>   needs to keep (or finally introduce) checks for the valid range. But
>   compared to 'int' it doesn't allow us to forget the < 0 check, and
>   compared to 'uint64' the resulting values are immune to careless
>   casting between unsigned and signed C types. These seem to be common
>   bugs, so getting rid of them would be nice.

The block layer at least has the excuse "return negative errno on error,
file offset on success" for using / casting to signed.  Because of that,
it needs (but neglects) to limit QMP file offset arguments to [0,2^63-1]
in QMP command handlers.  Fixing the handlers would be straightforward,
but tedious, and new code would be prone to forget the range check
again.  Being able to leave it to the QAPI core should be convenient.

Do we want a dedicated file offset QAPI type (similar to C has off_t)
for the block layer, or are we fine with using a general 'uint63' type?
I guess the latter, as the block layer seems to be happily using general
int64_t rather than dedicated off_t.

> * 'size' is the right type for sizes, offsets, etc. but the problem is
>   likely to affect other arguments, too. 'size' enables additional
>   syntax in the string visitor, so it is different from the other
>   integer types. This means that we probably want both a 63 bit size
>   type and a 63 bit plain unsigned integer type.

Yes, "want alternate format" is orthogonal to "want only 63 bits".  We
may well run into all four cases.

Aside: creating separate built-in types to enable alternate formats
won't scale to multiple alternate formats.  But it's what we've done for
'uint64' and 'size', and what we now may have to do for 'uint63' and
'size63'.

> * 'int' is an alias for (signed) 'int64'. People don't seem to think
>   much about using 'int' because it's the simplest type. That doesn't
>   make it right to use, though. It may be better to remove the 'int'
>   type and force any definitions to be specific about the signedness and
>   width they need. My intuitive guess is that most places that use 'int'
>   today don't actually want to accept negative numbers.

Hmm.  Perhaps we should make an effort to fix up incorrect uses of
'int', then see how many uses are left.

> * Schema introspection doesn't distinguish between integer types, this
>   is purely internal, so changing a definition from one integer type to
>   another is okay.

Yes.

> Markus, did I forget anything important?

I think that's it.  Thanks!
