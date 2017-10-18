Received: from eggs.gnu.org ([2001:4830:134:3::10]:45200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4muJ-000828-Op
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4muD-0000qo-SK
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:53:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e4muD-0000pX-Jm
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:53:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96F93C04AC53
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 11:53:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171016154000.GE2252@work-vm> (David Alan Gilbert's message of
	"Mon, 16 Oct 2017 16:40:01 +0100")
References: <20171004103933.7898-1-quintela@redhat.com>
	<20171004103933.7898-4-quintela@redhat.com>
	<20171016154000.GE2252@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 18 Oct 2017 13:52:56 +0200
Message-ID: <87a80on04n.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/6] tests: Add precopy test using
 deprecated commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  tests/migration-test.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 71 insertions(+)
>> 
>> diff --git a/tests/migration-test.c b/tests/migration-test.c
>> index 8ef2b72459..8549e4c2c6 100644
>> --- a/tests/migration-test.c
>> +++ b/tests/migration-test.c
>> @@ -422,6 +422,76 @@ static void migrate_set_parameter(QTestState *who, const char *parameter,
>>      QDECREF(rsp);
>>  }
>>  
>> +static void migrate_set_downtime(QTestState *who, const char *value)
>> +{
>> +    QDict *rsp;
>> +    gchar *cmd;
>> +
>> +    cmd = g_strdup_printf("{ 'execute': 'migrate_set_downtime',"
>> +                          "'arguments': { 'value': %s } }", value);
>> +    rsp = qtest_qmp(who, cmd);
>> +    g_free(cmd);
>> +    g_assert(qdict_haskey(rsp, "return"));
>> +    QDECREF(rsp);
>> +}
>> +
>> +static void migrate_set_speed(QTestState *who, const char *value)
>> +{
>> +    QDict *rsp;
>> +    gchar *cmd;
>> +
>> +    cmd = g_strdup_printf("{ 'execute': 'migrate_set_speed',"
>> +                          "'arguments': { 'value': %s } }", value);
>> +    rsp = qtest_qmp(who, cmd);
>> +    g_free(cmd);
>> +    g_assert(qdict_haskey(rsp, "return"));
>> +    QDECREF(rsp);
>> +}
>> +
>> +static void test_precopy_deprecated(const char *uri)
>> +{
>> +    QTestState *from, *to;
>> +
>> +    test_migrate_start(&from, &to, uri);
>> +
>> +    /* We want to pick a speed slow enough that the test completes
>> +     * quickly, but that it doesn't complete precopy even on a slow
>> +     * machine, so also set the downtime.
>> +     */
>> +    /* 100 ms */
>> +    migrate_set_downtime(from, "100");
>> +    /* 1MB/s slow*/
>> +    migrate_set_speed(from, "100000000");
>
> Can't we share more/most of this function?
> For example, how about we have a migrate_set_speed(who,value, old)
> tht is :
>   if (old) {
>       migrate_set_speed...
>   } else {
>       migrate_set_parameter
>   }
>
> then test_precopy(const char *uri, bool old)
>
> and we've duped most of it?

Moved to different setup, we end having:

- migrate_set_parameter

and

- migrate_set_speed
- migrate_set_downtime
- migrate_set_cache_size

My plan would be to test that if you don't use deprecated interfaces,
you don't need to deal with them.

Later, Juan.
