Received: from eggs.gnu.org ([2001:4830:134:3::10]:52158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dkTx3-0003RE-QD
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dkTx0-0002eJ-MU
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:36:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dkTx0-0002dt-Fu
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:35:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4ABE040431B
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 11:35:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170823111832.GC19071@pxdev.xzpeter.org> (Peter Xu's message of
	"Wed, 23 Aug 2017 19:18:32 +0800")
References: <20170823083901.852-1-quintela@redhat.com>
	<20170823083901.852-2-quintela@redhat.com>
	<20170823111832.GC19071@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Wed, 23 Aug 2017 13:35:53 +0200
Message-ID: <87r2w2ldnq.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: Use real size for iov tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com, pbonzini@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Wed, Aug 23, 2017 at 10:39:00AM +0200, Juan Quintela wrote:
>> We were using -1 instead of the real size because the functions check
>> what is bigger, size in bytes or the size of the iov.  Recent gcc's
>> barf at this.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  tests/test-iov.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/tests/test-iov.c b/tests/test-iov.c
>> index a22d71fd2c..819c410a51 100644
>> --- a/tests/test-iov.c
>> +++ b/tests/test-iov.c
>> @@ -81,17 +81,17 @@ static void test_to_from_buf_1(void)
>>            * skip whole vector and process exactly 0 bytes */
>>  
>>           /* first set bytes [i..sz) to some "random" value */
>> -         n = iov_memset(iov, niov, 0, 0xff, -1);
>> +         n = iov_memset(iov, niov, 0, 0xff, sz);
>
> This one is not needed?

Not, but it is for consistence.  iov_memset() has that property, that it
memset whatever is smaller, bytes parameter or iov size.


>>                * with j in [i..sz]. */
>>  
>>               /* clear iovec */
>> -             n = iov_memset(iov, niov, 0, 0xff, -1);
>> +             n = iov_memset(iov, niov, 0, 0xff, sz);
>
> This one as well?

I decided to change all of them for consistence.

Using -1 is a trick that just happens to work for current
implementation, but it is a hack.  and we have just after that an assert
with the real size that we want to copy.  Just use them everywhere.

>
> Actually I think we can keep the two places above, but there seems to
> be a 3rd one below which is untouched.  If we do change the two, maybe
> we'd better change the 3rd one as well.

Opps, didn't saw that other.  With this changes it fixed all for me.



> Besides:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks, Juan.


>
>>               g_assert(n == sz);
>>  
>>               /* copy bytes [i..j) from ibuf to iovec */
>> -- 
>> 2.13.5
>> 
