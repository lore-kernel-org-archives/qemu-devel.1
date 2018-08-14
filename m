Received: from eggs.gnu.org ([2001:4830:134:3::10]:38990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpSUX-0006Jy-5O
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpSUT-0000ds-Up
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:07:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51294 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpSUT-0000dL-PD
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:07:37 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-25-armbru@redhat.com>
	<22bb1644-c2a9-4bdb-33fb-057660d22844@redhat.com>
	<51449fc2-cefc-0142-46ed-7c1f3d815761@redhat.com>
	<87r2j2bvk6.fsf@dusky.pond.sub.org>
	<166c4648-e49a-1e1b-1511-e74cf8a0f726@redhat.com>
Date: Tue, 14 Aug 2018 08:07:34 +0200
In-Reply-To: <166c4648-e49a-1e1b-1511-e74cf8a0f726@redhat.com> (Eric Blake's
	message of "Mon, 13 Aug 2018 09:57:18 -0500")
Message-ID: <878t594h21.fsf@dusky.pond.sub.org>
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
Cc: Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/13/2018 02:00 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 08/10/2018 10:48 AM, Eric Blake wrote:
>>>> On 08/08/2018 07:03 AM, Markus Armbruster wrote:
>>>>> This is consistent with qobject_to_json().  See commit e2ec3f97680.
>>>>
>>>> Side note: that commit mentions that on output, ASCII DEL (0x7f) is
>>>> always escaped. RFC 7159 does not require it to be escaped on input,
>>
>> Weird, isn't it?
>>
>>>> but I wonder if any of your earlier testsuite improvements should
>>>> specifically cover \x7f vs. \u007f on input being canonicalized to
>>>> \u007f on round trip output.
>>
>>>From utf8_string():
>>
>>          /* 2.2.1  1 byte U+007F */
>>          {
>>              "\x7F",
>>              "\x7F",
>>              "\\u007F",
>>          },
>>
>> We test parsing of JSON "\x7F" (expecting C string "\x7F"), unparsing of
>> that C string (expecting JSON "\\u007F"), and after PATCH 29 parsing of
>> that JSON (expecting the C string again).  Sufficient?
>
> Indeed, looks like we have coverage of DEL thanks to the bounds
> testing of various interesting UTF-8 inflection points.
>
>>>>> +++ b/qobject/json-lexer.c
>>>>> @@ -93,7 +93,7 @@
>>>>>     *   interpolation =3D %((l|ll|I64)[du]|[ipsf])
>>>>>     *
>>>>>  =C2=A0=C2=A0 * Note:
>>>>> - * - Input must be encoded in UTF-8.
>>>>> + * - Input must be encoded in modified UTF-8.
>>>>
>>>> Worth documenting this in the QMP doc as an explicit extension?
>>
>> qmp-spec.txt:
>>
>>      The sever expects its input to be encoded in UTF-8, and sends its
>>      output encoded in ASCII.
>>
>> The obvious update would be to stick in "modified".
>>
>>>>                                                                  In
>>>> general, our QMP interfaces that take binary input do so via base64
>>>> encoding, rather than via a modified UTF-8 string -
>>
>> Agreed.
>>
>> However, whether QMP has a use for funny characters or not, the JSON
>> parser has to handle them *somehow*.  "Handle" in the broadest possible
>> sense, including "reject".  Not including misbehavior like "crash" and
>> "silently ignore some input following ASCII NUL".
>>
>
>>
>>>                                                      So it's really
>>> only a question of whether our input engine can pass "\x00"
>>> vs. "\\u0000" when we NEED an input NUL, and except for the testsuite,
>>> our QAPI schema never really needs an input NUL.
>>
>> The question is how the JSON parser is to handle "\u0000" escapes in
>> JSON strings and NUL bytes anywhere.
>>
>> The answer for NUL bytes is obvious: reject them just like any other
>> byte <=3D 0x1F, as required by the RFC.
>
> Yes, rejecting \x00 on input is fine, which leaves only the escape
> inside strings:
>
>>
>> My answer for \u0000 is to treat it as much like any other codepoint <=3D
>> 0x1F as possible.  Treating it exactly like them isn't possible, because
>> NUL bytes in C strings aren't possible.  However, \xC0\x80 sequences
>> are.
>
> Yes, for internal processing to use modified UTF-8 so that we can
> accept "\\u0000" on input is reasonable. And even nicer if we turn a
> QString containing \xc0\x80 back into "\\u0000" on output, so that our
> use of modified UTF-8 never even escapes to the QMP client (and then
> we don't need a documentation change).

We do, in to_json():

        for (; *ptr; ptr =3D end) {
--->        cp =3D mod_utf8_codepoint(ptr, 6, &end);
            switch (cp) {
            [special cases like \n...]
            default:
                if (cp < 0) {
                    cp =3D 0xFFFD; /* replacement character */
                }
                if (cp > 0xFFFF) {
                    /* beyond BMP; need a surrogate pair */
                    snprintf(buf, sizeof(buf), "\\u%04X\\u%04X",
                             0xD800 + ((cp - 0x10000) >> 10),
                             0xDC00 + ((cp - 0x10000) & 0x3FF));
                } else if (cp < 0x20 || cp >=3D 0x7F) {
--->                snprintf(buf, sizeof(buf), "\\u%04X", cp);
                } else {
                    buf[0] =3D cp;
                    buf[1] =3D 0;
                }
                qstring_append(str, buf);
            }

mod_utf8_codepoint() recognizes \xC0\x80 as codepoint 0.  That's an
ASCII control character, and those gets emitted using format \\u%04X.

>>
>> Reasonably simple and consistent, don't you think?
>>
