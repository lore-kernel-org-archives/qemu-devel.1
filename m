Received: from eggs.gnu.org ([2001:4830:134:3::10]:45046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dnngd-0004A9-Hr
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dnngc-0000G4-Fw
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:16:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dnngc-0000Fe-7u
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:16:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 586BF61484
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:16:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170901122021.GN31680@redhat.com> (Daniel P. Berrange's message
	of "Fri, 1 Sep 2017 13:20:21 +0100")
References: <20170901115500.12654-1-quintela@redhat.com>
	<20170901115500.12654-2-quintela@redhat.com>
	<20170901122021.GN31680@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 01 Sep 2017 17:16:42 +0200
Message-ID: <87wp5i78kl.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 1/2] tests: Use real size for iov tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

"Daniel P. Berrange" <berrange@redhat.com> wrote:
> On Fri, Sep 01, 2017 at 01:54:59PM +0200, Juan Quintela wrote:
>> We were using -1 instead of the real size because the functions check
>> what is bigger, size in bytes or the size of the iov.  Recent gcc's
>> barf at this.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Tested-by: Cleber Rosa <crosa@redhat.com>
>> --
>> 
>> Remove comments about this feature.
>> Fix missing -1.
>> ---
>>  include/qemu/iov.h |  6 ------
>>  tests/test-iov.c   | 10 +++++-----
>>  2 files changed, 5 insertions(+), 11 deletions(-)
>> 
>> diff --git a/include/qemu/iov.h b/include/qemu/iov.h
>> index bd9fd55b0a..72d4c559b4 100644
>> --- a/include/qemu/iov.h
>> +++ b/include/qemu/iov.h
>> @@ -31,11 +31,6 @@ size_t iov_size(const struct iovec *iov, const unsigned int iov_cnt);
>>   * Number of bytes actually copied will be returned, which is
>>   *  min(bytes, iov_size(iov)-offset)
>>   * `Offset' must point to the inside of iovec.
>> - * It is okay to use very large value for `bytes' since we're
>> - * limited by the size of the iovec anyway, provided that the
>> - * buffer pointed to by buf has enough space.  One possible
>> - * such "large" value is -1 (sinice size_t is unsigned),
>> - * so specifying `-1' as `bytes' means 'up to the end of iovec'.
>>   */
>>  size_t iov_from_buf_full(const struct iovec *iov, unsigned int iov_cnt,
>>                           size_t offset, const void *buf, size_t bytes);
>> @@ -76,7 +71,6 @@ iov_to_buf(const struct iovec *iov, const unsigned int iov_cnt,
>>   * up to the end of it, will be filled with the specified value.
>>   * Function return actual number of bytes processed, which is
>>   * min(size, iov_size(iov) - offset).
>> - * Again, it is okay to use large value for `bytes' to mean "up to the end".
>>   */
>>  size_t iov_memset(const struct iovec *iov, const unsigned int iov_cnt,
>>                    size_t offset, int fillc, size_t bytes);
>
> I'm not sure its right to be removing these comments, unless you've
> audited the code to ensure no caller outside the test suite is
> relying on this documented behaviour.

I did.  The caller call with the real size of the buffer.
iov_memset() still works with the -1 size.

iov_to/from_buf, the non full versions don't work, because the inline
gets confused with -1 with newer gcc's.
>
> For the test-iov.c changes though you can have
>
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Later, Juan.
