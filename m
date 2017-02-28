Received: from eggs.gnu.org ([2001:4830:134:3::10]:39942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cidM3-0005nB-Vt
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 03:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cidM3-0001PY-1L
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 03:41:56 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<87poi4c4jd.fsf@dusky.pond.sub.org>
	<8332e5e7-5e27-5c0b-7990-af814716acf8@redhat.com>
Date: Tue, 28 Feb 2017 09:41:46 +0100
In-Reply-To: <8332e5e7-5e27-5c0b-7990-af814716acf8@redhat.com> (Eric Blake's
	message of "Mon, 27 Feb 2017 13:43:23 -0600")
Message-ID: <87r32i1zcl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/27/2017 04:27 AM, Markus Armbruster wrote:
>> Design flaw: there is no good way to denote an empty array or object
>> other than the root object.
>> 
>> Empty KEY=VALUE,... is valid and results in an empty root object.
>> 
>> Presence of a KEY that contains periods results in additional non-root
>> objects or arrays.  For instance, KEY a.b.c results in root object
>> member "a" that has member "b" that has (scalar) member "c".
>> 
>> These additional objects and arrays all have at least one member, by
>> construction.
>> 
>> Begs the question how to denote an empty object or array other than the
>> root.
>
> If a.b.c=1 means root object has member "a" with child object "b", and
> object "b" has key "c" with scalar value, I suppose we could allow:
>
> a.b,
>
> (with no =val) to mean root object "a" has an empty child "b"
> (indeterminate if "b" is an object or a list) - but only if we don't
> allow the 'foo' => 'foo=on' magic already in use by QemuOpts.  And you
> still have to figure out how to choose empty list vs. empty object.

What if "b" is an alternate?  Should it be [], {} or true?

>> Without additional syntax, all we can do is choose what exactly to make
>> impossible:
>> 
>> * Absent key means absent, period.  No way to do empty array or object.
>>   This is what I implemented.
>
> I lean towards this meaning. It should generally possible to allow an
> empty object/list to mean the same thing as an optional omitted
> object/list in all contexts - so omitting KEY=VALUE for a list means you
> are omitting the list, but the omitted list behaves the same as an
> explicitly empty one would have done (even though dotted syntax doesn't
> have an easy way to express an explicit empty list).

It certainly feels "natural" (whatever that may mean) to imagine QAPI
used this way, but nothing stops users from making "absent" and "empty"
mean different things.

Say we have a configurable object in QEMU that sports an arbitrary
number of configurable sub-objects.  Like BlockdevOptionsBlkdebug has
BlkdebugInjectErrorOptions.  Except in our case, and just to make my
point, the sub-object configuration has only optional members, because a
perfectly sensible default configuration exists.  Let's further assume
that one sub-object in default configuration is not the same as zero sub
objects.

Now let's configure a single sub-object that is completely default.  In
JSON, that's

    "sub-objects": [ {} ]

With dotted keys, you can't express it.
