Received: from eggs.gnu.org ([2001:4830:134:3::10]:43086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo8Fw-00054e-Hr
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo8Fr-0003uO-Ie
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:19:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50788 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fo8Fr-0003tm-DY
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:19:03 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-12-armbru@redhat.com>
	<26ff5c67-abfa-bc5d-7c26-3f08ffbdc57b@redhat.com>
Date: Fri, 10 Aug 2018 16:18:59 +0200
In-Reply-To: <26ff5c67-abfa-bc5d-7c26-3f08ffbdc57b@redhat.com> (Eric Blake's
	message of "Thu, 9 Aug 2018 09:17:11 -0500")
Message-ID: <87k1oyl2y4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 11/56] check-qjson: Cover UTF-8 in single
 quoted strings
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

> On 08/08/2018 07:02 AM, Markus Armbruster wrote:
>> utf8_string() tests only double quoted strings.  Cover single quoted
>> strings, too: store the strings to test without quotes, then wrap them
>> in either kind of quote.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   tests/check-qjson.c | 427 ++++++++++++++++++++++----------------------
>>   1 file changed, 214 insertions(+), 213 deletions(-)
>>
>
> Pre-existing, but:
>
>>           /* 2.2.4  4 bytes U+1FFFFF */
>
> Technically, Unicode ends at U+10FFFF (21 bits). Anything beyond that
> is not valid Unicode, even if it IS a valid interpretation of UTF-8
> encoding.

Correct.  Testing how we handle such sequences makes sense all the same.

>>           {
>> -            "\"\xF7\xBF\xBF\xBF\"",
>> +            "\xF7\xBF\xBF\xBF",
>>               NULL,               /* bug: rejected */
>> -            "\"\\uFFFD\"",
>> +            "\\uFFFD",
>>               "\xF7\xBF\xBF\xBF",
>>           },
>>           /* 2.2.5  5 bytes U+3FFFFFF */
>
> Which makes this one also questionable,
>
>>           {
>> -            "\"\xFB\xBF\xBF\xBF\xBF\"",
>> +            "\xFB\xBF\xBF\xBF\xBF",
>>               NULL,               /* bug: rejected */
>> -            "\"\\uFFFD\"",
>> +            "\\uFFFD",
>>               "\xFB\xBF\xBF\xBF\xBF",
>>           },
>>           /* 2.2.6  6 bytes U+7FFFFFFF */
>
> and this one.
>
>>           {
>>               /* last one in last plane: U+10FFFD */
>> -            "\"\xF4\x8F\xBF\xBD\"",
>>               "\xF4\x8F\xBF\xBD",
>> -            "\"\\uDBFF\\uDFFD\""
>> +            "\xF4\x8F\xBF\xBD",
>> +            "\\uDBFF\\uDFFD"
>>           },
>>           {
>>               /* first one beyond Unicode range: U+110000 */
>
> while these are reasonable.
>
> The conversion of the initializer looks sane (well, mechanical).  Ergo:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
