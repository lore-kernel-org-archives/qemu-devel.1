Received: from eggs.gnu.org ([2001:4830:134:3::10]:57684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cinos-0001RU-6X
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:52:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cinor-0000Zk-CD
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:52:22 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-15-git-send-email-armbru@redhat.com>
	<93694acf-d6ed-b74d-1641-85b9a1589bd6@redhat.com>
Date: Tue, 28 Feb 2017 20:52:10 +0100
In-Reply-To: <93694acf-d6ed-b74d-1641-85b9a1589bd6@redhat.com> (Eric Blake's
	message of "Tue, 28 Feb 2017 13:25:24 -0600")
Message-ID: <877f4af5zp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 14/24] check-qjson: Test errors from
 qobject_from_json()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com, pkrempa@redhat.com, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/27/2017 05:20 AM, Markus Armbruster wrote:
>> Pass &error_abort with known-good input.  Else pass &err and check
>> what comes back.  This demonstrates that the parser fails silently for
>> many errors.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/check-qjson.c | 88 ++++++++++++++++++++++++++++++++++-------------------
>>  1 file changed, 56 insertions(+), 32 deletions(-)
>> 
>
>> @@ -809,7 +811,7 @@ static void utf8_string(void)
>>          utf8_in = test_cases[i].utf8_in ?: test_cases[i].utf8_out;
>>          json_out = test_cases[i].json_out ?: test_cases[i].json_in;
>>  
>> -        obj = qobject_from_json(json_in, NULL);
>> +        obj = qobject_from_json(json_in, utf8_out ? &error_abort : NULL);
>
> This one ignores errors if utf8_out is not specified; intentional?
> Especially when compared to...

            if (utf8_out) {
                str = qobject_to_qstring(obj);
                g_assert(str);
                g_assert_cmpstr(qstring_get_str(str), ==, utf8_out);

If @utf8_out, the conversion is expected to work and produce utf8_out.

            } else {
                g_assert(!obj);

Else, the conversion expected not to work.  These are bugs we've known
for a long time.

            }

>>  static void unterminated_string(void)
>>  {
>> -    QObject *obj = qobject_from_json("\"abc", NULL);
>> +    Error *err = NULL;
>> +    QObject *obj = qobject_from_json("\"abc", &err);
>> +    g_assert(!err);             /* BUG */
>>      g_assert(obj == NULL);
>
> change like these.

These are new bugs: the JSON parser can fail without setting an error.
