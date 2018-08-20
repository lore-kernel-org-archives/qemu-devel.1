Received: from eggs.gnu.org ([2001:4830:134:3::10]:43404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1frgId-00075p-Ex
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1frgIX-00029q-4u
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:16:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50092 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1frgIX-00029g-0u
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:16:29 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-8-armbru@redhat.com>
	<51121d8e-9e44-e027-a590-b69956531c8f@redhat.com>
Date: Mon, 20 Aug 2018 11:16:24 +0200
In-Reply-To: <51121d8e-9e44-e027-a590-b69956531c8f@redhat.com> (Eric Blake's
	message of "Fri, 17 Aug 2018 11:22:12 -0500")
Message-ID: <877ekls8if.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 07/60] check-qjson: Cover escaped
 characters more thoroughly, part 1
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

> On 08/17/2018 10:05 AM, Markus Armbruster wrote:
>> escaped_string() first tests double quoted strings, then repeats a few
>> tests with single quotes.  Repeat all of them: store the strings to
>> test without quotes, and wrap them in either kind of quote for
>> testing.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   tests/check-qjson.c | 96 +++++++++++++++++++++++++++------------------
>>   1 file changed, 57 insertions(+), 39 deletions(-)
>>
>> diff --git a/tests/check-qjson.c b/tests/check-qjson.c
>> index 188f683317..2f1890929d 100644
>> --- a/tests/check-qjson.c
>> +++ b/tests/check-qjson.c
>> @@ -22,55 +22,73 @@
>>   #include "qapi/qmp/qstring.h"
>>   #include "qemu-common.h"
>>   +static QString *from_json_str(const char *jstr, Error **errp,
>> bool single)
>
> Unusual to put Error **errp in the middle rather than last. Worth
> swapping 'single' to come before 'errp'?

Absolutely.

>>          int skip;
>
> Pre-existing, but since you are touching this, is it worth making this bool?

There's more of the same in other functions, which aren't touched by
this patch.  If we want to convert to bool, we should convert all of
them.  Doesn't fit into this patch.

>> +    for (i = 0; test_cases[i].json_in; i++) {
>> +        for (j = 0; j < 2; j++) {
>> +            cstr = from_json_str(test_cases[i].json_in, &error_abort, j);
>
> Only one caller to adjust here (and maybe a couple more later in the
> series).
>
> That's bike-shedding, so either way,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
