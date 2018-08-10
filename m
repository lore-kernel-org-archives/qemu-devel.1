Received: from eggs.gnu.org ([2001:4830:134:3::10]:38486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo81A-0000tk-He
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo817-0007cw-Di
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:03:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50334 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fo817-0007c3-81
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:03:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-8-armbru@redhat.com>
	<b03cba79-b0b4-30c4-d36b-03d1bbd945e9@redhat.com>
Date: Fri, 10 Aug 2018 16:03:46 +0200
In-Reply-To: <b03cba79-b0b4-30c4-d36b-03d1bbd945e9@redhat.com> (Eric Blake's
	message of "Thu, 9 Aug 2018 08:54:59 -0500")
Message-ID: <874lg2mi7x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 07/56] check-qjson: Cover escaped
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
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/08/2018 07:02 AM, Markus Armbruster wrote:
>> escaped_string() first tests double quoted strings, then repeats a few
>> tests with single quotes.  Repeat all of them: store the strings to
>> test without quotes, and wrap them in either kind of quote for
>> testing.
>
> Does that properly cover the fact that "'" and '"' are valid, but the
> counterparts need escaping?
>
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   tests/check-qjson.c | 94 ++++++++++++++++++++++++++-------------------
>>   1 file changed, 55 insertions(+), 39 deletions(-)
>>
>> diff --git a/tests/check-qjson.c b/tests/check-qjson.c
>> index 0a9a054c7b..1c7f24bc4d 100644
>> --- a/tests/check-qjson.c
>> +++ b/tests/check-qjson.c
>> @@ -22,55 +22,71 @@
>>   #include "qapi/qmp/qstring.h"
>>   #include "qemu-common.h"
>>   +static QString *from_json_str(const char *jstr, Error **errp,
>> bool single)
>> +{
>> +    char quote = single ? '\'' : '"';
>> +    char *qjstr = g_strdup_printf("%c%s%c", quote, jstr, quote);
>> +
>> +    return qobject_to(QString, qobject_from_json(qjstr, errp));
>
> Memory leak of qjstr.

Fixing.

>> +}
>> +
>> +static char *to_json_str(QString *str)
>> +{
>> +    QString *json = qobject_to_json(QOBJECT(str));
>> +    char *jstr;
>> +
>> +    if (!json) {
>> +        return NULL;
>> +    }
>> +    /* peel off double quotes */
>> +    jstr = g_strndup(qstring_get_str(json) + 1,
>> +                     qstring_get_length(json) - 2);
>> +    qobject_unref(json);
>> +    return jstr;
>> +}
>> +
>>   static void escaped_string(void)
>>   {
>> -    int i;
>>       struct {
>> -        const char *encoded;
>> -        const char *decoded;
>> +        /* Content of JSON string to parse with qobject_from_json() */
>> +        const char *json_in;
>> +        /* Expected parse output; to unparse with qobject_to_json() */
>> +        const char *utf8_out;
>>           int skip;
>>       } test_cases[] = {
>
>> +        { "\\\"", "\"" },
>
> This covers the escaped version of ", but not of ', and not the
> unescaped version of either (per my comment above, the latter can only
> be done with the opposite quoting).

escaped_string() is about testing \-escapes.  Unescaped quotes are
covered by simple_string() and single_quote_string().

However, I drop both in PATCH 10.  That's actually a bad idea.

>> Otherwise looks sane.

Thanks!
