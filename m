Received: from eggs.gnu.org ([2001:4830:134:3::10]:45665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdJgX-0006w0-25
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdJgT-0001Nl-4x
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:41:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdJgS-0001MZ-M4
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:41:00 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C306380F90
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 16:41:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170202120319.GB2549@work-vm> (David Alan Gilbert's message of
	"Thu, 2 Feb 2017 12:03:20 +0000")
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-12-git-send-email-quintela@redhat.com>
	<20170202120319.GB2549@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 13 Feb 2017 17:40:51 +0100
Message-ID: <87wpcu3uy4.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 11/17] migration: Create thread
 infrastructure for multifd send side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> We make the locking and the transfer of information specific, even if we
>> are still transmiting things through the main thread.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 52 insertions(+), 1 deletion(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index c71929e..9d7bc64 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -392,17 +392,25 @@ void migrate_compress_threads_create(void)
>>  /* Multiple fd's */
>> 
>>  struct MultiFDSendParams {
>> +    /* not changed */
>>      QemuThread thread;
>>      QIOChannel *c;
>>      QemuCond cond;
>>      QemuMutex mutex;
>> +    /* protected by param mutex */
>>      bool quit;
>>      bool started;
>> +    uint8_t *address;
>> +    /* protected by multifd mutex */
>> +    bool done;
>>  };
>>  typedef struct MultiFDSendParams MultiFDSendParams;
>> 
>>  static MultiFDSendParams *multifd_send;
>> 
>> +QemuMutex multifd_send_mutex;
>> +QemuCond multifd_send_cond;
>> +
>>  static void *multifd_send_thread(void *opaque)
>>  {
>>      MultiFDSendParams *params = opaque;
>> @@ -416,7 +424,17 @@ static void *multifd_send_thread(void *opaque)
>> 
>>      qemu_mutex_lock(&params->mutex);
>>      while (!params->quit){
>> -        qemu_cond_wait(&params->cond, &params->mutex);
>> +        if (params->address) {
>> +            params->address = 0;
>
> This confused me (I wondered what happens to the 1st block) but
> I see in the next patch this gets replaced by something more complex;
> so I suggest just using params->dummy and commented it's about
> to get replaced.

if you preffer, I wanted to minimize the change on the next patch,
otherwise I also have to change the places where I check the value of
address.


>> +    qemu_mutex_unlock(&multifd_send_mutex);
>> +    qemu_mutex_lock(&multifd_send[i].mutex);
>
> Having a 'multifd_send_mutex' and a
>          'multifd_send[i].mutex'
> is pretty confusing!

For different reason, I have moved all the

  multifd_send[i]. to "p->"

Better?


>
>> +    multifd_send[i].address = address;
>> +    qemu_cond_signal(&multifd_send[i].cond);
>> +    qemu_mutex_unlock(&multifd_send[i].mutex);
>> +
>> +    return 0;
>> +}
>> +
>>  struct MultiFDRecvParams {
>>      QemuThread thread;
>>      QIOChannel *c;
>> @@ -1015,6 +1065,7 @@ static int ram_multifd_page(QEMUFile *f, PageSearchStatus *pss,
>>          *bytes_transferred +=
>>              save_page_header(f, block, offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
>>          qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
>> +        multifd_send_page(p);
>>          *bytes_transferred += TARGET_PAGE_SIZE;
>>          pages = 1;
>>          acct_info.norm_pages++;
>> -- 
>> 2.9.3
>
> I think I'm pretty OK with this; but we'll see what it looks like
> after you think about Paolo's suggestion; it does feel like it should
> be possible to do the locking etc simpler; I just don't know how.

Locking can be simpler, but the problem is being speed :-(
Paolo suggestion have helped.
That our meassurement of bandwidth is lame, haven't :-(

Later, Juan.
