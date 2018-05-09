Received: from eggs.gnu.org ([2001:4830:134:3::10]:50571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGMfR-0006AW-Qg
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGMfO-0003KT-Jo
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:49:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36238 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGMfO-0003Iu-EX
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:49:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8C4F40200A0
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 10:49:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180426071558.GQ9036@xz-mi> (Peter Xu's message of "Thu, 26 Apr
	2018 15:15:58 +0800")
References: <20180425112723.1111-1-quintela@redhat.com>
	<20180425112723.1111-11-quintela@redhat.com>
	<20180426071558.GQ9036@xz-mi>
Reply-To: quintela@redhat.com
Date: Wed, 09 May 2018 12:52:01 +0200
Message-ID: <87lgct5cfi.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v12 10/21] migration: Create multipage
 support
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
> On Wed, Apr 25, 2018 at 01:27:12PM +0200, Juan Quintela wrote:
>
> [...]
>
>> +static void multifd_pages_init(MultiFDPages_t **ppages, size_t size)
>> +{
>> +    MultiFDPages_t *pages = g_new0(MultiFDPages_t, 1);
>> +
>> +    pages->allocated = size;
>> +    pages->iov = g_new0(struct iovec, size);
>> +    pages->offset = g_new0(ram_addr_t, size);
>> +    *ppages = pages;
>> +}
>
> Can we just return the pages pointer?  Then it can be:
>
>   static MultiFDPages_t *multifd_pages_init(size_t size)

Done.

>
> [...]
>
>> @@ -731,6 +784,7 @@ static void *multifd_recv_thread(void *opaque)
>>  int multifd_load_setup(void)
>>  {
>>      int thread_count;
>> +    uint32_t page_count = migrate_multifd_page_count();
>>      uint8_t i;
>>  
>>      if (!migrate_use_multifd()) {
>> @@ -740,6 +794,7 @@ int multifd_load_setup(void)
>>      multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
>>      multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
>>      atomic_set(&multifd_recv_state->count, 0);
>> +
>
> Useless line?

Changed it a lot in other places.

Later, Juan.
