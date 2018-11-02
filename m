Received: from eggs.gnu.org ([2001:4830:134:3::10]:45965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gISYn-0005P4-1m
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 02:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gISYj-0008JO-Lr
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 02:03:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:57614 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gISYj-0008Ih-Am
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 02:03:53 -0400
References: <20181101101715.9443-1-fli@suse.com>
	<20181101101715.9443-5-fli@suse.com> <20181102023158.GC7804@xz-x1>
From: Fei Li <fli@suse.com>
Message-ID: <80eb6add-711d-c3d8-795d-afecc63727f7@suse.com>
Date: Fri, 2 Nov 2018 14:03:43 +0800
MIME-Version: 1.0
In-Reply-To: <20181102023158.GC7804@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH RFC v7 4/9] migration: fix some
 segmentation faults when using multifd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, famz@redhat.com, quintela@redhat.com



On 11/02/2018 10:31 AM, Peter Xu wrote:
> On Thu, Nov 01, 2018 at 06:17:10PM +0800, Fei Li wrote:
>> When multifd is used during migration, a segmentaion fault will
>> occur in the source when multifd_save_cleanup() is called again if
>> the multifd_send_state has been freed in earlier error handling. This
>> can happen when migrate_fd_connect() fails and multifd_fd_cleanup()
>> is called, and then multifd_new_send_channel_async() fails and
>> multifd_save_cleanup() is called again.
>>
>> If the QIOChannel *c of multifd_recv_state->params[i] (p->c) is not
>> initialized, there is no need to close the channel. Or else a
>> segmentation fault will occur in multifd_recv_terminate_threads()
>> when multifd_recv_initial_packet() fails.
> It's a bit odd to me when I see that multifd_send_thread() calls
> multifd_send_terminate_threads().  Is that the reason that you
> encountered the problem?
Yes, this is one of the reason. Actually this problem almost does not occur
before this patch series, but as this patch series is trying to make 
qemu_thread_create()
be more robust, I find this problem during the debugging. ;)

The second situation is when using multifd (in this way 
multifd_new_send_channel_asyn()[1]
is called several times) and once one channel fails in [1], the later 
channels
will encounter the segmentation fault problem when enters [1] again.
And the third is after applying the last patch, I mean after 
multifd_save_setup=>
socket_send_channel_create(multifd_new_send_channel_async, p) successfully,
but then qemu_thread_create(migration_thread) fails, I assume here we 
need to
do some migration cleanup, like migrate_fd_cleanup() or something 
similar like
the vm_start() in migration_iteration_finish()?
The fourth is when multifd_new_send_channel_async()[1] fails and 
multifd_save_cleanup()
is called, then multifd_send_sync_main <= qemu_savevm_state_setup <= 
migration_thread[2]
is called. (BTW, I find that sometimes [2] is called earlier than [1], 
but sometimes
later the first channel)
> Instead of checking all these null pointers, IMHO we should just let
> multifd_send_terminate_threads() be called only in the main thread...
Ok, from your reply in patch5/9, I know we should offer better isolation and
just let the main thread handle these cleanup.:)
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>>   migration/ram.c | 28 +++++++++++++++++++++-------
>>   1 file changed, 21 insertions(+), 7 deletions(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 7e7deec4d8..4db3b3e8f4 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -907,6 +907,11 @@ static void multifd_send_terminate_threads(Error *err)
>>           }
>>       }
>>   
>> +    /* in case multifd_send_state has been freed earlier */
>> +    if (!multifd_send_state) {
>> +        return;
>> +    }
>> +
>>       for (i = 0; i < migrate_multifd_channels(); i++) {
>>           MultiFDSendParams *p = &multifd_send_state->params[i];
The above one is the first case.
>>   
>> @@ -922,7 +927,7 @@ int multifd_save_cleanup(Error **errp)
>>       int i;
>>       int ret = 0;
>>   
>> -    if (!migrate_use_multifd()) {
>> +    if (!migrate_use_multifd() || !multifd_send_state) {
>>           return 0;
>>       }
>>       multifd_send_terminate_threads(NULL);
The above one is the third case.
>> @@ -960,7 +965,7 @@ static void multifd_send_sync_main(void)
>>   {
>>       int i;
>>   
>> -    if (!migrate_use_multifd()) {
>> +    if (!migrate_use_multifd() || !multifd_send_state) {
>>           return;
>>       }
>>       if (multifd_send_state->pages->used) {
The above one is the fourth case.
>> @@ -1070,6 +1075,10 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>>       QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
>>       Error *local_err = NULL;
>>   
>> +    if (!multifd_send_state) {
>> +        return;
>> +    }
>> +
>>       if (qio_task_propagate_error(task, &local_err)) {
>>           if (multifd_save_cleanup(&local_err) != 0) {
>>               migrate_set_error(migrate_get_current(), local_err);
The above one is the second case.
>> @@ -1131,7 +1140,7 @@ struct {
>>       uint64_t packet_num;
>>   } *multifd_recv_state;
Below is to fix the second paragraph (p->c) in the commit message. :)
>>   
>> -static void multifd_recv_terminate_threads(Error *err)
>> +static void multifd_recv_terminate_threads(Error *err, bool channel)
>>   {
>>       int i;
>>   
>> @@ -1145,6 +1154,11 @@ static void multifd_recv_terminate_threads(Error *err)
>>           }
>>       }
>>   
>> +    /* in case p->c is not initialized */
>> +    if (!channel) {
>> +        return;
>> +    }
>> +
>>       for (i = 0; i < migrate_multifd_channels(); i++) {
>>           MultiFDRecvParams *p = &multifd_recv_state->params[i];
>>   
>> @@ -1166,7 +1180,7 @@ int multifd_load_cleanup(Error **errp)
>>       if (!migrate_use_multifd()) {
>>           return 0;
>>       }
>> -    multifd_recv_terminate_threads(NULL);
>> +    multifd_recv_terminate_threads(NULL, true);
>>       for (i = 0; i < migrate_multifd_channels(); i++) {
>>           MultiFDRecvParams *p = &multifd_recv_state->params[i];
>>   
>> @@ -1269,7 +1283,7 @@ static void *multifd_recv_thread(void *opaque)
>>       }
>>   
>>       if (local_err) {
>> -        multifd_recv_terminate_threads(local_err);
>> +        multifd_recv_terminate_threads(local_err, true);
>>       }
>>       qemu_mutex_lock(&p->mutex);
>>       p->running = false;
>> @@ -1331,7 +1345,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>>   
>>       id = multifd_recv_initial_packet(ioc, &local_err);
>>       if (id < 0) {
>> -        multifd_recv_terminate_threads(local_err);
>> +        multifd_recv_terminate_threads(local_err, false);
>>           return false;
>>       }
>>   
>> @@ -1339,7 +1353,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>>       if (p->c != NULL) {
>>           error_setg(&local_err, "multifd: received id '%d' already setup'",
>>                      id);
>> -        multifd_recv_terminate_threads(local_err);
>> +        multifd_recv_terminate_threads(local_err, true);
>>           return false;
>>       }
>>       p->c = ioc;
>> -- 
>> 2.13.7
>>
> Regards,
>
Have a nice day, thanks for the comment. :)
Fei
