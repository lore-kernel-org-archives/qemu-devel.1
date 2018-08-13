Received: from eggs.gnu.org ([2001:4830:134:3::10]:34367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fp6pv-00005K-3T
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 03:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fp6pq-0003pg-6h
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 03:00:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fp6pq-0003o9-04
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 03:00:14 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-25-armbru@redhat.com>
	<22bb1644-c2a9-4bdb-33fb-057660d22844@redhat.com>
	<51449fc2-cefc-0142-46ed-7c1f3d815761@redhat.com>
Date: Mon, 13 Aug 2018 09:00:09 +0200
In-Reply-To: <51449fc2-cefc-0142-46ed-7c1f3d815761@redhat.com> (Eric Blake's
	message of "Fri, 10 Aug 2018 11:09:20 -0500")
Message-ID: <87r2j2bvk6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 24/56] json: Accept overlong \xC0\x80 as
 U+0000 ("modified UTF-8")
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/10/2018 10:48 AM, Eric Blake wrote:
>> On 08/08/2018 07:03 AM, Markus Armbruster wrote:
>>> This is consistent with qobject_to_json().  See commit e2ec3f97680.
>>
>> Side note: that commit mentions that on output, ASCII DEL (0x7f) is
>> always escaped. RFC 7159 does not require it to be escaped on input,

Weird, isn't it?

>> but I wonder if any of your earlier testsuite improvements should
>> specifically cover \x7f vs. \u007f on input being canonicalized to
>> \u007f on round trip output.

>From utf8_string():

        /* 2.2.1  1 byte U+007F */
        {
            "\x7F",
            "\x7F",
            "\\u007F",
        },

We test parsing of JSON "\x7F" (expecting C string "\x7F"), unparsing of
that C string (expecting JSON "\\u007F"), and after PATCH 29 parsing of
that JSON (expecting the C string again).  Sufficient?

>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>   qobject/json-lexer.c  | 2 +-
>>>   qobject/json-parser.c | 2 +-
>>>   tests/check-qjson.c   | 8 +-------
>>>   3 files changed, 3 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
>>> index ca1e0e2c03..36fb665b12 100644
>>> --- a/qobject/json-lexer.c
>>> +++ b/qobject/json-lexer.c
>>> @@ -93,7 +93,7 @@
>>>    *   interpolation =3D %((l|ll|I64)[du]|[ipsf])
>>>    *
>>> =C2=A0=C2=A0 * Note:
>>> - * - Input must be encoded in UTF-8.
>>> + * - Input must be encoded in modified UTF-8.
>>
>> Worth documenting this in the QMP doc as an explicit extension?

qmp-spec.txt:

    The sever expects its input to be encoded in UTF-8, and sends its
    output encoded in ASCII.

The obvious update would be to stick in "modified".

>>                                                                 In
>> general, our QMP interfaces that take binary input do so via base64
>> encoding, rather than via a modified UTF-8 string -

Agreed.

However, whether QMP has a use for funny characters or not, the JSON
parser has to handle them *somehow*.  "Handle" in the broadest possible
sense, including "reject".  Not including misbehavior like "crash" and
"silently ignore some input following ASCII NUL".

>>                                                     and I don't know
>> how yajl or jansson would feel about an extension for producing
>> modified UTF-8 for QMP to consume if we really did want to pass NUL
>> bytes without the overhead of UTF-8; what's more, even if you can
>> pass NUL, you still have to worry about all other byte sequences
>> being valid (so base64 is still better for true binary data - it's
>> hard to argue that we'd ever have an interface where we want UTF-8
>> including embedded NUL rather than true binary).  I guess it can
>> also be argued that outputting modified UTF-8 is a violation of
>> JSON, so the fact that we can round-trip NUL doesn't help if the
>> client can't read it.
>>
>> So having typed all that, I guess the answer is no, we don't want to
>> document it; for now, the fact that we accept \xc0\x80 on input and
>> produce it on output is only for the testsuite, and unlikely to
>> matter to any real client of QMP.
>
> Actually, I guess we never output \xc0\x80; but would output the C
> string "\\u0000" (since any byte above 0x1f is passed through our UTF
> decoder back into a codepoint then output with \u).

to_json() converts the C string sequence by sequence.  Valid sequences
in the BMP other than ASCII control characters (\x00..\x1F and \x7F) are
copied unchanged.  Everything else is escaped.

>                                                     So it's really
> only a question of whether our input engine can pass "\x00"
> vs. "\\u0000" when we NEED an input NUL, and except for the testsuite,
> our QAPI schema never really needs an input NUL.

The question is how the JSON parser is to handle "\u0000" escapes in
JSON strings and NUL bytes anywhere.

The answer for NUL bytes is obvious: reject them just like any other
byte <=3D 0x1F, as required by the RFC.

My answer for \u0000 is to treat it as much like any other codepoint <=3D
0x1F as possible.  Treating it exactly like them isn't possible, because
NUL bytes in C strings aren't possible.  However, \xC0\x80 sequences
are.

Reasonably simple and consistent, don't you think?
