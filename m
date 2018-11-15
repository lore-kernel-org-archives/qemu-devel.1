Received: from eggs.gnu.org ([2001:4830:134:3::10]:49964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNEhl-0007lq-Co
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:16:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNEhg-0000ma-Bf
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:16:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gNEhg-0000mC-3t
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:16:52 -0500
References: <20181109110221.10553-1-david@redhat.com>
	<20181109110221.10553-4-david@redhat.com>
	<874lcjmue4.fsf@dusky.pond.sub.org>
	<2ba6fbb2-d2cb-a4b3-61f5-385b08f822bd@redhat.com>
	<87tvkiisdi.fsf@dusky.pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ef7b64f3-d7f3-6892-e0f3-f4e605604225@redhat.com>
Date: Thu, 15 Nov 2018 11:16:48 +0100
MIME-Version: 1.0
In-Reply-To: <87tvkiisdi.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 3/6] qapi: rewrite string-input-visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On 15.11.18 10:48, Markus Armbruster wrote:
> David Hildenbrand <david@redhat.com> writes:
>=20
>> On 14.11.18 18:38, Markus Armbruster wrote:
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>> The input visitor has some problems right now, especially
>>>> - unsigned type "Range" is used to process signed ranges, resulting =
in
>>>>   inconsistent behavior and ugly/magical code
>>>> - uint64_t are parsed like int64_t, so big uint64_t values are not
>>>>   supported and error messages are misleading
>>>> - lists/ranges of int64_t are accepted although no list is parsed an=
d
>>>>   we should rather report an error
>>>> - lists/ranges are preparsed using int64_t, making it hard to
>>>>   implement uint64_t values or uint64_t lists
>>>> - types that don't support lists don't bail out
>>>
>>> Known weirdness: empty list is invalid (test-string-input-visitor.c
>>> demonstates).  Your patch doesn't change that (or else it would updat=
e
>>> the test).  Should it be changed?
>>>
>>
>> I don't change the test, so the old behavior still works.
>> (empty string -> error)
>=20
> Understand.  Design question: should it remain an error?  Feel free to
> declare the question out of scope for this patch.

I think I was confused, let me retry to explain.

Empty lists actually don't result in an error. Calling start_list() on
an empty string works just fine.

However
- check_list() will result in "Fewer list elements expected"
- visit_type_.*int64() will result in "Fewer list elements expected"
- next_list() will result in NULL

I guess that is the intended behavior. E.g. the test does

v =3D visitor_input_test_init(data, "");
visit_type_uint64List(v, NULL, &res, &error_abort);
g_assert(!res);

So there won't be any error as the first "visit_next_list()" will
properly indicate "NULL".


>> Added "Only flat lists of integers (int64/uint64) are supported."
>=20
> Hmm, do lists of narrower integer types also work?  I guess they do: th=
e
> narrower visit_type_*int*() call v->type_*int64() via
> visit_type_*intN().
>=20
> Lists of type size are expressly excluded, in parse_type_size() below.
> That's okay, we can lift the restriction when it gets in the way.

Right, we can make that clearer

"Only flat lists of integers (except type "size") are supported." ?
[...]

>=20
>> What about "Less list elements expected"? That at least matches the
>> other error.
>=20
> Good enough.  I'd say "fewer", though.

Fine with me!
[...]
>>>> +        return;
>>>> +    case LM_UNPARSED:
>>>> +        if (try_parse_int64_list_entry(siv, obj)) {
>>>> +            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? n=
ame : "null",
>>>> +                       "list of int64 values or ranges");
>>>> +        }
>>>
>>> I figure I'd make try_parse_int64_list_entry() just parse, and on
>>> success fall through to case LM_INT64_RANGE.  But your solution works=
,
>>> too.
>>
>> Then we would have to represent even single values as ranges, which is
>> something I'd like to avoid.
>=20
> Your artistic license applies.

It actually looks nicer your way (and seems to be less error prone).
Stay tuned!

--=20

Thanks,

David / dhildenb
