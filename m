Received: from eggs.gnu.org ([2001:4830:134:3::10]:40611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo88y-0007kv-6p
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo88v-00074k-3S
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:11:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34528 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fo88u-00074S-Tn
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:11:53 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-8-armbru@redhat.com>
	<4f9088ac-b871-f2de-0a7f-223a873d15d8@redhat.com>
Date: Fri, 10 Aug 2018 16:11:49 +0200
In-Reply-To: <4f9088ac-b871-f2de-0a7f-223a873d15d8@redhat.com> (Eric Blake's
	message of "Thu, 9 Aug 2018 09:00:12 -0500")
Message-ID: <87zhxul3a2.fsf@dusky.pond.sub.org>
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
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   tests/check-qjson.c | 94 ++++++++++++++++++++++++++-------------------
>>   1 file changed, 55 insertions(+), 39 deletions(-)
>>
>
>>       struct {
>> -        const char *encoded;
>> -        const char *decoded;
>> +        /* Content of JSON string to parse with qobject_from_json() */
>> +        const char *json_in;
>> +        /* Expected parse output; to unparse with qobject_to_json() */
>> +        const char *utf8_out;
>>           int skip;
>
> Instead of int skip (and why is that not a bool?),

Ask Anthony ;)

>                                                    would it be better
> to have an optional const char *json_out?
>
>> +    for (i = 0; test_cases[i].json_in; i++) {
>> +        for (j = 0; j < 2; j++) {
>> +            cstr = from_json_str(test_cases[i].json_in, &error_abort, j);
>> +            g_assert_cmpstr(qstring_get_try_str(cstr),
>> +                            ==, test_cases[i].utf8_out);
>> +            if (test_cases[i].skip == 0) {
>> +                jstr = to_json_str(cstr);
>> +                g_assert_cmpstr(jstr, ==, test_cases[i].json_in);
>> +                g_free(jstr);
>
> and here, write g_assert_cmpstr(jstr, ==, test_cases[i].json_out ?:
> test_cases[i].json_in)?  After all, the reason we're skipping is
> because there are some cases of multiple inputs that get canonicalized
> to constant output, such as " " vs. "\u0020", or "\\'" vs. "'".

This would additionally test that qobject_from_json() correctly maps '/'
and ' ' to themselves.  Marginal.  If we want it, then comparing jstr to
cstr if skip would do.  Dunno.
