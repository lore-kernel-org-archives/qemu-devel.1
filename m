Received: from eggs.gnu.org ([2001:4830:134:3::10]:33854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ctce9-0007G6-J4
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ctce6-0004b1-62
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:10:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ctce5-0004aZ-Vo
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:09:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AF97804F7
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 16:09:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170330065652.GH20667@pxdev.xzpeter.org> (Peter Xu's message of
	"Thu, 30 Mar 2017 14:56:52 +0800")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-31-quintela@redhat.com>
	<20170330065652.GH20667@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Thu, 30 Mar 2017 18:09:54 +0200
Message-ID: <878tnmn3u5.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 30/51] ram: Move src_page_req* to RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Thu, Mar 23, 2017 at 09:45:23PM +0100, Juan Quintela wrote:
>> This are the last postcopy fields still at MigrationState.  Once there
>
> s/This/These/
>
>> Move MigrationSrcPageRequest to ram.c and remove MigrationState
>> parameters where appropiate.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> One question below though...
>
> [...]
>
>> @@ -1191,19 +1204,18 @@ static bool get_queued_page(RAMState *rs, MigrationState *ms,
>>   *
>>   * It should be empty at the end anyway, but in error cases there may
>>   * xbe some left.
>> - *
>> - * @ms: current migration state
>>   */
>> -void flush_page_queue(MigrationState *ms)
>> +void flush_page_queue(void)
>>  {
>> -    struct MigrationSrcPageRequest *mspr, *next_mspr;
>> +    struct RAMSrcPageRequest *mspr, *next_mspr;
>> +    RAMState *rs = &ram_state;
>>      /* This queue generally should be empty - but in the case of a failed
>>       * migration might have some droppings in.
>>       */
>>      rcu_read_lock();
>
> Could I ask why we are taking the RCU read lock rather than the mutex
> here?

I will let this one for dave.


>
>> -    QSIMPLEQ_FOREACH_SAFE(mspr, &ms->src_page_requests, next_req, next_mspr) {
>> +    QSIMPLEQ_FOREACH_SAFE(mspr, &rs->src_page_requests, next_req, next_mspr) {
>>          memory_region_unref(mspr->rb->mr);
>> -        QSIMPLEQ_REMOVE_HEAD(&ms->src_page_requests, next_req);
>> +        QSIMPLEQ_REMOVE_HEAD(&rs->src_page_requests, next_req);
>>          g_free(mspr);
>>      }
>>      rcu_read_unlock();
>
> Thanks,
>
> -- peterx
