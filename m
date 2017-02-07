Received: from eggs.gnu.org ([2001:4830:134:3::10]:40449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cb58c-0005Na-Q2
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:44:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cb58b-00056P-PU
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:44:50 -0500
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
	<1479837270-79005-12-git-send-email-vsementsov@virtuozzo.com>
	<8760l4aiwb.fsf@emacs.mitica>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8323e47e-6981-c702-f98b-a63de839eff8@virtuozzo.com>
Date: Tue, 7 Feb 2017 15:44:34 +0300
MIME-Version: 1.0
In-Reply-To: <8760l4aiwb.fsf@emacs.mitica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/17] migration: add is_active_iterate
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

24.01.2017 12:48, Juan Quintela wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>> Only-postcopy savevm states (dirty-bitmap) don't need live iteration, so
>> to disable them and stop transporting empty sections there is a new
>> savevm handler.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/migration/vmstate.h | 1 +
>>   migration/savevm.c          | 5 +++++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index dc656be..2c53d0b 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -47,6 +47,7 @@ typedef struct SaveVMHandlers {
>>       /* This runs both outside and inside the iothread lock.  */
>>       bool (*is_active)(void *opaque);
>>       bool (*has_postcopy)(void *opaque);
>> +    bool (*is_active_iterate)(void *opaque);
>>   
>>       /* This runs outside the iothread lock in the migration case, and
>>        * within the lock in the savevm case.  The callback had better only
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index c58b9f9..4eb1640 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -988,6 +988,11 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
>>                   continue;
>>               }
>>           }
>> +        if (se->ops && se->ops->is_active_iterate) {
>> +            if (!se->ops->is_active_iterate(se->opaque)) {
>> +                continue;
>> +            }
>> +        }
>>           /*
>>            * In the postcopy phase, any device that doesn't know how to
>>            * do postcopy should have saved it's state in the _complete
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> I still don't see cleary why you can't "reuse" the is_active(), but
> well, it will have to add magic there, so ....

is_active_iterate=false blocks only qemu_savevm_state_iterate from 
handling the migration entity. Other qemu_savevm_state_* functions 
handle it, as is_active=true.

>
> BTW, in hindsight, this "is_active" functions are used mainly to check
> if the thing is "not active" O:-)


-- 
Best regards,
Vladimir
