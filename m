Received: from eggs.gnu.org ([2001:4830:134:3::10]:57961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqZ23-00089t-AI
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 03:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqZ1z-0004l2-Bz
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 03:18:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42282 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqZ1z-0004kG-6y
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 03:18:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-25-armbru@redhat.com>
	<22bb1644-c2a9-4bdb-33fb-057660d22844@redhat.com>
	<51449fc2-cefc-0142-46ed-7c1f3d815761@redhat.com>
	<87r2j2bvk6.fsf@dusky.pond.sub.org>
Date: Fri, 17 Aug 2018 09:18:42 +0200
In-Reply-To: <87r2j2bvk6.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Mon, 13 Aug 2018 09:00:09 +0200")
Message-ID: <87sh3d4g19.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Markus Armbruster <armbru@redhat.com> writes:

> Eric Blake <eblake@redhat.com> writes:
>
>> On 08/10/2018 10:48 AM, Eric Blake wrote:
>>> On 08/08/2018 07:03 AM, Markus Armbruster wrote:
>>>> This is consistent with qobject_to_json().  See commit e2ec3f97680.
>>>
>>> Side note: that commit mentions that on output, ASCII DEL (0x7f) is
>>> always escaped. RFC 7159 does not require it to be escaped on input,
>
> Weird, isn't it?
>
>>> but I wonder if any of your earlier testsuite improvements should
>>> specifically cover \x7f vs. \u007f on input being canonicalized to
>>> \u007f on round trip output.
>
> From utf8_string():
>
>         /* 2.2.1  1 byte U+007F */
>         {
>             "\x7F",
>             "\x7F",
>             "\\u007F",
>         },
>
> We test parsing of JSON "\x7F" (expecting C string "\x7F"), unparsing of
> that C string (expecting JSON "\\u007F"), and after PATCH 29 parsing of
> that JSON (expecting the C string again).  Sufficient?
>
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>   qobject/json-lexer.c  | 2 +-
>>>>   qobject/json-parser.c | 2 +-
>>>>   tests/check-qjson.c   | 8 +-------
>>>>   3 files changed, 3 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
>>>> index ca1e0e2c03..36fb665b12 100644
>>>> --- a/qobject/json-lexer.c
>>>> +++ b/qobject/json-lexer.c
>>>> @@ -93,7 +93,7 @@
>>>>    *   interpolation =3D %((l|ll|I64)[du]|[ipsf])
>>>>    *
>>>> =C2=A0=C2=A0 * Note:
>>>> - * - Input must be encoded in UTF-8.
>>>> + * - Input must be encoded in modified UTF-8.
>>>
>>> Worth documenting this in the QMP doc as an explicit extension?
>
> qmp-spec.txt:
>
>     The sever expects its input to be encoded in UTF-8, and sends its
>     output encoded in ASCII.
>
> The obvious update would be to stick in "modified".

Not really necessary, because:

* Before this patch, the JSON parser rejects \0 as ASCII control
  character, and \xC0\x80 as overlong UTF-8.

  Note that PATCH 17 fixed rejection of \0 in JSON strings.  PATCH 21
  fixed rejection of invalid UTF-8, but \xC0\x80 wasn't broken.

* This patch makes \xC0\x80 pass the "invalid UTF-8" check, only to get
  rejected as ASCII control character.  The error message changes,
  that's all.

The patch's benefit is consistency with the other direction:
qobject_to_json() maps \xC0\x80 to \\u0000.  I guess my commit message
should explain this a bit better.

[...]
