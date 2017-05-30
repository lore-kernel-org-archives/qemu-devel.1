Received: from eggs.gnu.org ([2001:4830:134:3::10]:40276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dFnKp-0007fk-C6
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dFnKl-0004No-EI
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:01:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dFnKl-0004NW-5k
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:01:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF6718046B
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 20:01:37 +0000 (UTC)
Reply-To: vyasevic@redhat.com
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-9-git-send-email-vyasevic@redhat.com>
	<20170530193542.GX2120@work-vm>
From: Vlad Yasevich <vyasevic@redhat.com>
Message-ID: <a6643292-6926-7ca3-4576-b9c661ccc812@redhat.com>
Date: Tue, 30 May 2017 16:01:28 -0400
MIME-Version: 1.0
In-Reply-To: <20170530193542.GX2120@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/12] announce_timer: Add ability to reset
 an existing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com

On 05/30/2017 03:35 PM, Dr. David Alan Gilbert wrote:
> * Vladislav Yasevich (vyasevic@redhat.com) wrote:
>> It is now potentially possible to issue annouce-self command in a tight
>> loop.  Instead of doing nother, we can reset the timeout pararameters,
>> especially since each instance may provide it's own values.  This
>> allows the user to  extend or cut short currently runnig timer.
>>
>> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
> 
> ah ok, you can ignore my comment on the previous patch then!
> 
>> ---
>>  include/migration/vmstate.h |  1 +
>>  migration/savevm.c          | 41 +++++++++++++++++++++++++++++++----------
>>  2 files changed, 32 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index 689b685..6dfdac3 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -1057,6 +1057,7 @@ void vmstate_register_ram_global(struct MemoryRegion *memory);
>>  
>>  typedef struct AnnounceTimer {
>>      QEMUTimer *tm;
>> +    QemuMutex active_lock;
>>      struct AnnounceTimer **entry;
>>      AnnounceParameters params;
>>      QEMUClockType type;
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index dcba8bd..e43658f 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -220,20 +220,29 @@ static void qemu_announce_self_iter(NICState *nic, void *opaque)
>>  
>>  AnnounceTimer *announce_timers[QEMU_ANNOUNCE__MAX];
>>  
>> +static void qemu_announce_timer_destroy(AnnounceTimer *timer)
>> +{
>> +    timer_del(timer->tm);
>> +    timer_free(timer->tm);
>> +    qemu_mutex_destroy(&timer->active_lock);
> 
> Can you explain what makes this safe; we're not
> holding the lock at this point are we? Are we guaranteed
> that no one else will try and take it?
> Either way it should be commented to say why it's safe.

Looking at this again, it doesn't look safe.
The problem is the lookup code.  There is needs to be a lock on the
on the global array that needs to be held during creation/modification.

Thanks
-vlad

> 
> Dave
> 
>> +    g_free(timer);
>> +}
>> +
>>  static void qemu_announce_self_once(void *opaque)
>>  {
>>      AnnounceTimer *timer = (AnnounceTimer *)opaque;
>>  
>> +    qemu_mutex_lock(&timer->active_lock);
>>      qemu_foreach_nic(qemu_announce_self_iter, NULL);
>>  
>> -    if (--timer->round) {
>> +    if (--timer->round ) {
>>          timer_mod(timer->tm, qemu_clock_get_ms(timer->type) +
>>                    self_announce_delay(timer));
>> +        qemu_mutex_unlock(&timer->active_lock);
>>      } else {
>> -            *(timer->entry) = NULL;
>> -            timer_del(timer->tm);
>> -            timer_free(timer->tm);
>> -            g_free(timer);
>> +        *(timer->entry) = NULL;
>> +        qemu_mutex_unlock(&timer->active_lock);
>> +        qemu_announce_timer_destroy(timer);
>>      }
>>  }
>>  
>> @@ -242,6 +251,7 @@ AnnounceTimer *qemu_announce_timer_new(AnnounceParameters *params,
>>  {
>>      AnnounceTimer *timer = g_new(AnnounceTimer, 1);
>>  
>> +    qemu_mutex_init(&timer->active_lock);
>>      timer->params = *params;
>>      timer->round = params->rounds;
>>      timer->type = type;
>> @@ -259,6 +269,21 @@ AnnounceTimer *qemu_announce_timer_create(AnnounceParameters *params,
>>      return timer;
>>  }
>>  
>> +static void qemu_announce_timer_update(AnnounceTimer *timer,
>> +                                       AnnounceParameters *params)
>> +{
>> +    qemu_mutex_lock(&timer->active_lock);
>> +
>> +    /* Update timer paramenter with any new values.
>> +     * Reset the number of rounds to run, and stop the current timer.
>> +     */
>> +    timer->params = *params;
>> +    timer->round = params->rounds;
>> +    timer_del(timer->tm);
>> +
>> +    qemu_mutex_unlock(&timer->active_lock);
>> +}
>> +
>>  void qemu_announce_self(AnnounceParameters *params, AnnounceType type)
>>  {
>>      AnnounceTimer *timer;
>> @@ -270,11 +295,7 @@ void qemu_announce_self(AnnounceParameters *params, AnnounceType type)
>>          announce_timers[type] = timer;
>>          timer->entry = &announce_timers[type];
>>      } else {
>> -        /* For now, don't do anything.  If we want to reset the timer,
>> -         * we'll need to add locking to each announce timer to prevent
>> -         * races between timeout handling and a reset.
>> -         */
>> -        return;
>> +        qemu_announce_timer_update(timer, params);
>>      }
>>      qemu_announce_self_once(timer);
>>  }
>> -- 
>> 2.7.4
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
