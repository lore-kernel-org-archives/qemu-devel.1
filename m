Received: from eggs.gnu.org ([2001:4830:134:3::10]:35832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fp6xM-00036L-Dh
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 03:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fp6xL-0006qY-I5
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 03:08:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47028 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fp6xL-0006qU-Bt
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 03:07:59 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-29-armbru@redhat.com>
	<67210961-8fc0-f3ac-be32-cf2f4903eed9@redhat.com>
Date: Mon, 13 Aug 2018 09:07:57 +0200
In-Reply-To: <67210961-8fc0-f3ac-be32-cf2f4903eed9@redhat.com> (Eric Blake's
	message of "Fri, 10 Aug 2018 12:18:10 -0500")
Message-ID: <87eff2bv76.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 28/56] json: Fix \uXXXX for surrogate pairs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/08/2018 07:03 AM, Markus Armbruster wrote:
>> The JSON parser treats each half of a surrogate pair as unpaired
>> surrogate.  Fix it to recognize surrogate pairs.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qobject/json-parser.c | 16 +++++++++++++++-
>>   tests/check-qjson.c   |  3 +--
>>   2 files changed, 16 insertions(+), 3 deletions(-)
>>
>
>> @@ -168,6 +170,18 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
>>                      cp |= hex2decimal(*ptr);
>>                  }
>> +                if (cp >= 0xD800 && cp <= 0xDBFF && !leading_surrogate
>> +                    && ptr[1] == '\\' && ptr[2] == 'u') {
>> +                    ptr += 2;
>> +                    leading_surrogate = cp;
>> +                    goto hex;
>> +                }
>> +                if (cp >= 0xDC00 && cp <= 0xDFFF && leading_surrogate) {
>> +                    cp &= 0x3FF;
>> +                    cp |= (leading_surrogate & 0x3FF) << 10;
>> +                    cp += 0x010000;
>> +                }
>> +
>>                   if (mod_utf8_encode(utf8_buf, sizeof(utf8_buf), cp) < 0) {
>>                       parse_error(ctxt, token,
>>                                   "\\u%.4s is not a valid Unicode character",
>
> Consider "\\udbff\\udfff" - a valid surrogate pair (in terms of being
> in range), but which decodes to u+10ffff.  Since is_valid_codepoint()
> (part of mod_utf8_encode()) rejects it due to (codepoint & 0xfffe) ==
> 0xfffe, it means we end up printing this error message, but only using
> the second half of the surrogate pair.  Is that okay?

It's not horrible, but I wouldn't call it okay.  I'll try to improve it.

> Otherwise,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
