Received: from eggs.gnu.org ([2001:4830:134:3::10]:45240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df32e-0007QA-32
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df32a-0004WZ-51
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:51:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1df32Z-0004W0-RT
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:51:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C02DF81235
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 11:51:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170720102945.GC2101@work-vm> (David Alan Gilbert's message of
	"Thu, 20 Jul 2017 11:29:46 +0100")
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-14-quintela@redhat.com>
	<20170720102945.GC2101@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 08 Aug 2017 13:51:11 +0200
Message-ID: <871som9t1s.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 13/17] migration: Create thread
 infrastructure for multifd recv side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> We make the locking and the transfer of information specific, even if we
>> are still receiving things through the main thread.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 60 insertions(+), 8 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index ac0742f..49c4880 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -49,6 +49,7 @@
>>  #include "migration/colo.h"
>>  #include "sysemu/sysemu.h"
>>  #include "qemu/uuid.h"
>> +#include "qemu/iov.h"
>>  
>>  /***********************************************************/
>>  /* ram save/restore */
>> @@ -527,7 +528,7 @@ int multifd_save_setup(void)
>>      return 0;
>>  }
>>  
>> -static int multifd_send_page(uint8_t *address)
>> +static uint16_t multifd_send_page(uint8_t *address, bool last_page)
>>  {
>>      int i, j;
>>      MultiFDSendParams *p = NULL; /* make happy gcc */
>> @@ -543,8 +544,10 @@ static int multifd_send_page(uint8_t *address)
>>      pages.iov[pages.num].iov_len = TARGET_PAGE_SIZE;
>>      pages.num++;
>>  
>> -    if (pages.num < (pages.size - 1)) {
>> -        return UINT16_MAX;
>> +    if (!last_page) {
>> +        if (pages.num < (pages.size - 1)) {
>> +            return UINT16_MAX;
>> +        }
>>      }
>
> This doesn't feel like it should be in a recv patch.


I will change it, until here we don't need it :p

>
>>      qemu_sem_wait(&multifd_send_state->sem);
>> @@ -572,12 +575,17 @@ static int multifd_send_page(uint8_t *address)
>>  }
>>  
>>  struct MultiFDRecvParams {
>> +    /* not changed */
>>      uint8_t id;
>>      QemuThread thread;
>>      QIOChannel *c;
>> +    QemuSemaphore ready;
>>      QemuSemaphore sem;
>>      QemuMutex mutex;
>> +    /* proteced by param mutex */
>>      bool quit;
>> +    multifd_pages_t pages;
>> +    bool done;
>>  };
>>  typedef struct MultiFDRecvParams MultiFDRecvParams;
>
> The params between Send and Recv keep looking very similar; I wonder
> if we can share them.

We use other parameters.  We could do, but I am not sure if it makes
sense the trouble.

>>   * save_page_header: write page header to wire
>>   *
>> @@ -1155,7 +1210,7 @@ static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
>>          ram_counters.transferred +=
>>              save_page_header(rs, rs->f, block,
>>                               offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
>> -        fd_num = multifd_send_page(p);
>> +        fd_num = multifd_send_page(p, rs->migration_dirty_pages == 1);
>
> I think that belongs in the previous patch and probably answers one of
> my questions.

Ok, I change that.
