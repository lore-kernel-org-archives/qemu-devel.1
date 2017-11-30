Received: from eggs.gnu.org ([2001:4830:134:3::10]:53291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eKDWF-0007MK-RO
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 20:20:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eKDWB-0004s0-3h
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 20:20:03 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2050 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fangying1@huawei.com>)
	id 1eKDWA-0004o5-LV
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 20:19:59 -0500
References: <20171127073233.15376-1-fangying1@huawei.com>
	<20171128101834.GA3256@work-vm>
	<6e8a7f10-8d19-c098-8288-94aef34969eb@huawei.com>
	<20171129094247.GA2523@work-vm>
From: Ying Fang <fangying1@huawei.com>
Message-ID: <0226dead-df4b-b0ec-b854-c4ace169129e@huawei.com>
Date: Thu, 30 Nov 2017 09:19:41 +0800
MIME-Version: 1.0
In-Reply-To: <20171129094247.GA2523@work-vm>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] vhost: Cancel migration when vhost-user
 process restarted during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, quintela@redhat.com


On 2017/11/29 17:42, Dr. David Alan Gilbert wrote:
> * Ying Fang (fangying1@huawei.com) wrote:
>>
>> On 2017/11/28 18:18, Dr. David Alan Gilbert wrote:
>>> * fangying (fangying1@huawei.com) wrote:
>>>> QEMU will abort when vhost-user process is restarted during migration
>>>> and vhost_log_global_start/stop is called. The reason is clear that
>>>> vhost_dev_set_log returns -1 because network connection is temporarily
>>>> lost. To handle this situation, let's cancel migration here.
>>>>
>>>> Signed-off-by: Ying Fang <fangying1@huawei.com>
>>>
>>> I thought we had agreed not to use migrate_fd_cancel here - that's for
>>> cancelling not erroring.
>>>
>>> Dave
>> We can not use migrate_fd_error(migrate_get_current(),...) here,
>> since it will touch the assertion of "s->to_dst_file",
>> Is there any better solution ?  Thanks.
> 
> How about:
>   error_report(....)
>   qemu_file_set_error(migrate_get_current()->to_dst_file, -ECHILD);
> 
>   But please, don't use cancel.
> 
> Dave
Thanks for your advise, I test this approach and send the V4.

Ying
> 
>> void migrate_fd_error(MigrationState *s, const Error *error)
>> {
>>     trace_migrate_fd_error(error_get_pretty(error));
>> --> assert(s->to_dst_file == NULL);
>>     migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>>                       MIGRATION_STATUS_FAILED);
>>     migrate_set_error(s, error);
>>     notifier_list_notify(&migration_state_notifiers, s);
>>     block_cleanup_parameters(s);
>> }
>>
>>>
>>>> ---
>>>>  hw/virtio/vhost.c     | 15 +++++++++++++--
>>>>  migration/migration.c |  2 +-
>>>>  migration/migration.h |  2 +-
>>>>  3 files changed, 15 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>>> index ddc42f0..e2ade93 100644
>>>> --- a/hw/virtio/vhost.c
>>>> +++ b/hw/virtio/vhost.c
>>>> @@ -26,6 +26,7 @@
>>>>  #include "hw/virtio/virtio-bus.h"
>>>>  #include "hw/virtio/virtio-access.h"
>>>>  #include "migration/blocker.h"
>>>> +#include "migration/migration.h"
>>>>  #include "sysemu/dma.h"
>>>>  
>>>>  /* enabled until disconnected backend stabilizes */
>>>> @@ -882,20 +883,30 @@ static int vhost_migration_log(MemoryListener *listener, int enable)
>>>>  static void vhost_log_global_start(MemoryListener *listener)
>>>>  {
>>>>      int r;
>>>> +    MigrationState *s = NULL;
>>>>  
>>>>      r = vhost_migration_log(listener, true);
>>>>      if (r < 0) {
>>>> -        abort();
>>>> +        error_report("Failed to start vhost dirty log");
>>>> +        s = migrate_get_current();
>>>> +        if (s->migration_thread_running) {
>>>> +            migrate_fd_cancel(s);
>>>> +        }
>>>>      }
>>>>  }
>>>>  
>>>>  static void vhost_log_global_stop(MemoryListener *listener)
>>>>  {
>>>>      int r;
>>>> +    MigrationState *s = NULL;
>>>>  
>>>>      r = vhost_migration_log(listener, false);
>>>>      if (r < 0) {
>>>> -        abort();
>>>> +        error_report("Failed to stop vhost dirty log");
>>>> +        s = migrate_get_current();
>>>> +        if (s->migration_thread_running) {
>>>> +            migrate_fd_cancel(s);
>>>> +        }
>>>>      }
>>>>  }
>>>>  
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 4de3b55..6d2b7df 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -1131,7 +1131,7 @@ void migrate_fd_error(MigrationState *s, const Error *error)
>>>>      block_cleanup_parameters(s);
>>>>  }
>>>>  
>>>> -static void migrate_fd_cancel(MigrationState *s)
>>>> +void migrate_fd_cancel(MigrationState *s)
>>>>  {
>>>>      int old_state ;
>>>>      QEMUFile *f = migrate_get_current()->to_dst_file;
>>>> diff --git a/migration/migration.h b/migration/migration.h
>>>> index 663415f..f0261e3 100644
>>>> --- a/migration/migration.h
>>>> +++ b/migration/migration.h
>>>> @@ -167,7 +167,7 @@ uint64_t migrate_max_downtime(void);
>>>>  
>>>>  void migrate_set_error(MigrationState *s, const Error *error);
>>>>  void migrate_fd_error(MigrationState *s, const Error *error);
>>>> -
>>>> +void migrate_fd_cancel(MigrationState *s);
>>>>  void migrate_fd_connect(MigrationState *s);
>>>>  
>>>>  MigrationState *migrate_init(void);
>>>> -- 
>>>> 1.8.3.1
>>>>
>>>>
>>>>
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>
>>> .
>>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> .
> 
