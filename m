Received: from eggs.gnu.org ([2001:4830:134:3::10]:44566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4msm-0007HH-DI
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4msj-0000Hd-CK
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:51:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15399)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e4msj-0000HK-6k
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:51:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F85AC05972E
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 11:51:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171016120901.GD2252@work-vm> (David Alan Gilbert's message of
	"Mon, 16 Oct 2017 13:09:02 +0100")
References: <20171004103933.7898-1-quintela@redhat.com>
	<20171004103933.7898-3-quintela@redhat.com>
	<20171016120901.GD2252@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 18 Oct 2017 13:51:24 +0200
Message-ID: <87fuagn077.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/6] tests: Add basic migration precopy tcp
 test
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
>>  tests/migration-test.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/tests/migration-test.c b/tests/migration-test.c
>> index cd954caee4..8ef2b72459 100644
>> --- a/tests/migration-test.c
>> +++ b/tests/migration-test.c
>> @@ -466,6 +466,13 @@ static void test_precopy_unix(void)
>>      g_free(uri);
>>  }
>>  
>> +static void test_precopy_tcp(void)
>> +{
>> +    const char *uri = "tcp:0:44444";
>> +
>> +    test_precopy(uri);
>> +}
>
> The problem is that this will fail if you make check -j  and two
> tests use 4444 at the same time.
> That's pretty common especially when you've built multiple architectures
> as targets and all the same tests run at the same time.

Options:

- Use different start value by architecture.
- as we have a directory use O_CREAT|O_EXCL  and do create the file with
- the port number that we want to use

Anything else that you want to propose?

Later, Juan.


>
> Dave
>
>>  int main(int argc, char **argv)
>>  {
>>      char template[] = "/tmp/migration-test-XXXXXX";
>> @@ -482,6 +489,7 @@ int main(int argc, char **argv)
>>      module_call_init(MODULE_INIT_QOM);
>>  
>>      qtest_add_func("/migration/precopy/unix", test_precopy_unix);
>> +    qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
>>  
>>      ret = g_test_run();
>>  
>> -- 
>> 2.13.5
>> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
