Received: from eggs.gnu.org ([2001:4830:134:3::10]:42056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eMZnI-0004Rw-TR
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 08:31:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eMZnF-0004ep-Pl
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 08:31:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eMZnF-0004X8-52
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 08:31:21 -0500
References: <20171201055832.8392-1-fangying1@huawei.com>
	<20171201163813-mutt-send-email-mst@kernel.org>
From: Ying Fang <fangying1@huawei.com>
Message-ID: <0fe53172-70f2-56b5-5d25-b3c1769098d7@huawei.com>
Date: Wed, 6 Dec 2017 21:30:27 +0800
MIME-Version: 1.0
In-Reply-To: <20171201163813-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] vhost: Don't abort when vhost-user
 connection is lost during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, marcandre.lureau@redhat.com


On 2017/12/1 22:39, Michael S. Tsirkin wrote:
> On Fri, Dec 01, 2017 at 01:58:32PM +0800, fangying wrote:
>> QEMU will abort when vhost-user process is restarted during migration
>> when vhost_log_global_start/stop is called. The reason is clear that
>> vhost_dev_set_log returns -1 because network connection is lost.
>>
>> To handle this situation, let's cancel migration by setting migrate
>> state to failure and report it to user.
> 
> In fact I don't see this as the right way to fix it. Backend is dead so why
> not just proceed with migration? We just need to make sure we re-send
> migration data on re-connect.
> This is where vhost start/stop migration dirty log. The original code aborts
qemu here beacuse vhost data stream may break down if we fail to start/stop
vhost dirty log during migration. Backend may be active after vhost_log_global_start.

             dirty log start ----------------- dirty log stop
                     ^           ^
                     |           |
----- backend dead ----- backend active

Currently we don't re-send migration data on re-connect in this situation.
May we should work it out.

>> ---
>>  hw/virtio/vhost.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index ddc42f0..92725f7 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -26,6 +26,8 @@
>>  #include "hw/virtio/virtio-bus.h"
>>  #include "hw/virtio/virtio-access.h"
>>  #include "migration/blocker.h"
>> +#include "migration/migration.h"
>> +#include "migration/qemu-file.h"
>>  #include "sysemu/dma.h"
>>  
>>  /* enabled until disconnected backend stabilizes */
>> @@ -885,7 +887,10 @@ static void vhost_log_global_start(MemoryListener *listener)
>>  
>>      r = vhost_migration_log(listener, true);
>>      if (r < 0) {
>> -        abort();
>> +        error_report("Failed to start vhost dirty log");
>> +        if (migrate_get_current()->migration_thread_running) {
>> +            qemu_file_set_error(migrate_get_current()->to_dst_file, -ECHILD);
>> +        }
>>      }
>>  }
>>  
>> @@ -895,7 +900,10 @@ static void vhost_log_global_stop(MemoryListener *listener)
>>  
>>      r = vhost_migration_log(listener, false);
>>      if (r < 0) {
>> -        abort();
>> +        error_report("Failed to stop vhost dirty log");
>> +        if (migrate_get_current()->migration_thread_running) {
>> +            qemu_file_set_error(migrate_get_current()->to_dst_file, -ECHILD);
>> +        }
>>      }
>>  }
>>  
>> -- 
>> 1.8.3.1
>>
> 
> .
> 
