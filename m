Received: from eggs.gnu.org ([2001:4830:134:3::10]:44137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4mrB-0006bC-81
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4mr8-00069M-5F
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e4mr7-00068I-VF
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:49:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC1B5C0601E1
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 11:49:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171009081938.GD2196@pxdev.xzpeter.org> (Peter Xu's message of
	"Mon, 9 Oct 2017 16:19:38 +0800")
References: <20171004103933.7898-1-quintela@redhat.com>
	<20171004103933.7898-2-quintela@redhat.com>
	<20171009081938.GD2196@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Wed, 18 Oct 2017 13:49:42 +0200
Message-ID: <87k1zsn0a1.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/6] tests: Add basic migration precopy test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Wed, Oct 04, 2017 at 12:39:28PM +0200, Juan Quintela wrote:
>
> [...]
>
> (having some unit tests for migration is really good...)
>
>> +static void test_precopy(const char *uri)
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
>
> This is 100MB/s?
>
>> +    migrate_set_parameter(from, "max-bandwidth", "100000000");
>> +
>> +    /* Wait for the first serial output from the source */
>> +    wait_for_serial("src_serial");
>> +
>> +    migrate(from, uri);
>> +
>> +    wait_for_migration_pass(from);
>> +
>> +    /* 1GB/s now it should converge */
>> +    migrate_set_parameter(from, "max-bandwidth", "1000000000");
>
> Curious: would it possible that 1GB/s won't suffice in some cases?
> Is there any reason behind this 1GB/s value?

No.

My new test setup just uses 1GB/s

and plays with the downtime (1ms) while I want to wait for one full
cycle
and then 300ms.

Notice that the guest is around 100MB of size, so ....


>
> (I agree with Thomas that it would be good to work upon the existing
>  postcopy-test.c file, at least easier to review :)

Done.

did the other way around:

rename postcopy-test.c to migrate-test.c

and then went from there.

Later, Juan.
