Received: from eggs.gnu.org ([2001:4830:134:3::10]:60587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo7eg-0005hm-0S
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo7ed-0008Rj-Cw
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:40:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53494 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fo7ed-0008Qr-7m
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:40:35 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-3-armbru@redhat.com>
	<8d30dec0-ddbb-60cc-208a-a02177c140b3@redhat.com>
Date: Fri, 10 Aug 2018 15:40:30 +0200
In-Reply-To: <8d30dec0-ddbb-60cc-208a-a02177c140b3@redhat.com> (Eric Blake's
	message of "Thu, 9 Aug 2018 08:29:03 -0500")
Message-ID: <87tvo2mjap.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 02/56] check-qjson: Cover blank and
 lexically erroneous input
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

> On 08/08/2018 07:02 AM, Markus Armbruster wrote:
>> qobject_from_json() can return null without setting an error on
>> lexical errors.  I call that a bug.  Add test coverage to demonstrate
>> it.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   tests/check-qjson.c | 36 +++++++++++++++++++++++++++++++++---
>>   1 file changed, 33 insertions(+), 3 deletions(-)
>>
>
>> +static void junk_input(void)
>> +{
>> +    /* Note: junk within strings is covered elsewhere */
>> +    Error *err = NULL;
>> +    QObject *obj;
>> +
>> +    obj = qobject_from_json("@", &err);
>
> Invalid token
>
>> +    g_assert(!err);             /* BUG */
>> +    g_assert(obj == NULL);
>> +
>> +    obj = qobject_from_json("[0\xFF]", &err);
>
> \xff stream reset, followed by unbalanced ]



>> +    error_free_or_abort(&err);
>> +    g_assert(obj == NULL);
>> +
>> +    obj = qobject_from_json("00", &err);
>
> Invalid as a JSON number
>
>> +    g_assert(!err);             /* BUG */
>> +    g_assert(obj == NULL);
>> +
>> +    obj = qobject_from_json("[1e", &err);
>
> Incomplete as a JSON number
>
>> +    g_assert(!err);             /* BUG */
>>       g_assert(obj == NULL);
>>   }
>
> Is it also worth testing:
>
> "t" (incomplete as a JSON literal)
> "a" (not a valid JSON literal, but alphabetic and thus different from
> the "@" test above)

Yes, an invalid keyword is worth testing.  The way the code works,
testing one should suffice.

> At any rate, with or without further tests this is good improved
> coverage dealt with in the rest of the series.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
