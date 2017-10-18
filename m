Received: from eggs.gnu.org ([2001:4830:134:3::10]:46462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4myl-0000zl-O1
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4myl-0002d2-02
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:57:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e4myk-0002cq-Qf
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:57:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7CE6C058EDC
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 11:57:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171016162910.GG2252@work-vm> (David Alan Gilbert's message of
	"Mon, 16 Oct 2017 17:29:10 +0100")
References: <20171004103933.7898-1-quintela@redhat.com>
	<20171004103933.7898-6-quintela@redhat.com>
	<20171016162910.GG2252@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 18 Oct 2017 13:57:36 +0200
Message-ID: <871sm0mzwv.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: Add migration compress threads
 tests
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
>> For some reason, compression is not working at the moment, test is
>> disabled until I found why.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  tests/migration-test.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>> 
>> diff --git a/tests/migration-test.c b/tests/migration-test.c
>> index f0734e4ba0..a8abc3d007 100644
>> --- a/tests/migration-test.c
>> +++ b/tests/migration-test.c
>> @@ -621,6 +621,54 @@ static void test_xbzrle_unix(void)
>>      g_free(uri);
>>  }
>>  
>> +static void test_compress(const char *uri)
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
>> +    migrate_set_parameter(from, "downtime-limit", "100");
>> +    /* 1MB/s slow*/
>> +    migrate_set_parameter(from, "max-bandwidth", "100000000");
>> +
>> +    migrate_set_parameter(from, "compress-threads", "4");
>> +    migrate_set_parameter(from, "decompress-threads", "3"); 
>
> Should that be 'to' ?

Yes.

> I worry about having this many threads in a loaded test environment.

Suggestion is?

I am not getting they working reliabely without having it loaded.

Later, Juan.
