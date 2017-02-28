Received: from eggs.gnu.org ([2001:4830:134:3::10]:35536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cil19-0002ym-OB
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:52:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cil14-00036V-3k
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:52:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cil13-000362-US
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:52:46 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EAD242BAB
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 16:52:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-23-git-send-email-armbru@redhat.com>
	<24436027-2f2f-e233-f51d-f71164bd1e98@redhat.com>
Date: Tue, 28 Feb 2017 17:52:42 +0100
In-Reply-To: <24436027-2f2f-e233-f51d-f71164bd1e98@redhat.com> (Eric Blake's
	message of "Tue, 28 Feb 2017 10:00:13 -0600")
Message-ID: <87a896mf51.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 22/26] test-qobject-input-visitor: Cover
 missing nested struct member
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/26/2017 03:43 PM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/test-qobject-input-visitor.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
>> index 10c15c4..6e04736 100644
>> --- a/tests/test-qobject-input-visitor.c
>> +++ b/tests/test-qobject-input-visitor.c
>> @@ -894,7 +894,7 @@ static void test_visitor_in_fail_struct_missing(TestInputVisitorData *data,
>>      char *str;
>>      double dbl;
>>  
>> -    v = visitor_input_test_init(data, "{}");
>> +    v = visitor_input_test_init(data, "{ 'sub': [ {} ] }");
>>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
>>      visit_start_struct(v, "struct", NULL, 0, &err);
>>      error_free_or_abort(&err);
>> @@ -920,6 +920,11 @@ static void test_visitor_in_fail_struct_missing(TestInputVisitorData *data,
>>      error_free_or_abort(&err);
>>      visit_type_null(v, "null", &err);
>>      error_free_or_abort(&err);
>> +    visit_start_list(v, "sub", NULL, 0, &error_abort);
>> +    visit_start_struct(v, NULL, NULL, 0, &error_abort);
>> +    visit_type_int(v, "i64", &i64, &err);
>> +    error_free_or_abort(&err);
>> +    visit_end_struct(v, NULL);
>>      visit_end_struct(v, NULL);
>
> Missing a visit_end_list, no?

Yes.

qobject-input-visitor.c fails to check the visit_end_ matches the last
visit_start_.  Perhaps test-qobject-input-visitor.c should additionally
check no visit_end_ is missing.

I intend to add the missing visit_end_list(), and leave the rest for the
next series.

Thanks!
