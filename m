Received: from eggs.gnu.org ([2001:4830:134:3::10]:48921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPTC9-0006PS-L7
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 09:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPTC6-0002FV-Fj
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 09:09:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gPTC6-0002FG-8h
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 09:09:30 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181120092542.13102-1-david@redhat.com>
	<20181120092542.13102-6-david@redhat.com>
	<27cfb4e6-b4db-10de-02c7-691f011d5f99@redhat.com>
	<f5dd77c5-8d40-fe95-4fc8-69aa96fa4f13@redhat.com>
	<0a72b07b-3620-7728-4248-8cd7c0112489@redhat.com>
	<9a7bc7ca-774c-5419-65a3-a4ebf621996b@redhat.com>
Date: Wed, 21 Nov 2018 15:09:23 +0100
In-Reply-To: <9a7bc7ca-774c-5419-65a3-a4ebf621996b@redhat.com> (David
	Hildenbrand's message of "Wed, 21 Nov 2018 11:49:30 +0100")
Message-ID: <875zwq4j58.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/9] test-string-input-visitor: Add more
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

David Hildenbrand <david@redhat.com> writes:

> On 20.11.18 18:26, Eric Blake wrote:
>> On 11/20/18 11:20 AM, Eric Blake wrote:
>>> On 11/20/18 11:06 AM, Eric Blake wrote:
>>>> On 11/20/18 3:25 AM, David Hildenbrand wrote:
>>>>> Test that very big/small values are not accepted and that ranges with
>>>>> only one element work. Also test that ranges are ascending and cannot
>>>>> have more than 65536 elements.
>>>>>
>>>>> Rename expect4 to expect5, as we will be moving that to a separate ul=
ist
>>>>> test after the rework.
>>>>>
>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>> ---
>>>>> =C2=A0 tests/test-string-input-visitor.c | 41 +++++++++++++++++++++++=
++++++--
>>>>> =C2=A0 1 file changed, 39 insertions(+), 2 deletions(-)
>>>>>
>>>>
>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>
>>> Do we also want to test garbage strings like:
>>>
>>> "1-" (incomplete range)
>>> "1X-2" (garbage suffix on first element)
>>> "1-2X" (garbage suffix on second element)
>>>
>>> and/or
>>>
>>> "-2--1" (valid range of signed integers)
>>> "-1--2" (questionable whether this is valid for the two largest unsigne=
d=20
>>> integers)
>>=20
>> Or even " 1- 2" (we permit leading whitespace for plain integers - do we=
=20
>> also permit it in both sides of a range)?  Also, if we permit whitespace=
=20
>> after the range '-', should we permit it beforehand?
>>=20
>> These sorts of questions may be fine in followup patches.
>>=20
>
> As always, you can never cover all cases during tests :)
>
> While these things surely make sense, I will not add them right now. As
> you said, we can do that later.
>
>
> Taking about spaces:
>
> I think spaces before the "-" are not supported before/after the rewrite
> (I remember that strto.* does not skip over them). Spaces after the
> space should be covered by strto* automatically (strto.* skips over
> leading spaces).

qemu_strtol() & friends ignore leading whitespace, just like strtol()
does.  Trailing whitespace is handled like any other trailing
characters: hard error when endptr is null, else make *endptr point to
it.

I'd expect whitespace to be accepted before either number of a range,
but not between the first number and the '-'.

Perhaps rejecting whitespace there would be the cleaner interface, but
then we get to discuss backward compatibility, and I go "thanks, but no,
thanks."
