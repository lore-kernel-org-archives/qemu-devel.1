Received: from eggs.gnu.org ([2001:4830:134:3::10]:60504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gHQuD-0000rV-Fp
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 06:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gHQuA-0005ew-P9
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 06:05:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:33424 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gHQu9-000572-P6
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 06:05:46 -0400
References: <20181029125818.28720-1-fli@suse.com>
	<20181029125818.28720-6-fli@suse.com> <20181030060502.GG22523@xz-x1>
From: Fei Li <fli@suse.com>
Message-ID: <0273e52f-ba16-fef0-22bc-bb3103dbdab2@suse.com>
Date: Tue, 30 Oct 2018 18:05:18 +0800
MIME-Version: 1.0
In-Reply-To: <20181030060502.GG22523@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH RFC v6 5/7] migration: fix the multifd code
 when receiving less channels
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



On 10/30/2018 02:05 PM, Peter Xu wrote:
> On Mon, Oct 29, 2018 at 08:58:16PM +0800, Fei Li wrote:
>> In our current code, when multifd is used during migration, if there
>> is an error before the destination receives all new channels, the
>> source keeps running, however the destination does not exit but keeps
>> waiting until the source is killed deliberately.
>>
>> Fix this by simply killing the destination when it fails to receive
>> packet via some channel.
>>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>>   migration/channel.c   |  7 ++++++-
>>   migration/migration.c |  9 +++++++--
>>   migration/migration.h |  2 +-
>>   migration/ram.c       | 17 ++++++++++++++---
>>   migration/ram.h       |  2 +-
>>   5 files changed, 29 insertions(+), 8 deletions(-)
>>
>> diff --git a/migration/channel.c b/migration/channel.c
>> index 33e0e9b82f..572be4245a 100644
>> --- a/migration/channel.c
>> +++ b/migration/channel.c
>> @@ -44,7 +44,12 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>>               error_report_err(local_err);
> [1]
>
>>           }
>>       } else {
>> -        migration_ioc_process_incoming(ioc);
>> +        Error *local_err = NULL;
>> +        migration_ioc_process_incoming(ioc, &local_err);
>> +        if (local_err) {
>> +            error_report_err(local_err);
>> +            exit(EXIT_FAILURE);
> I would still suggest that you don't quit.  See TLS error at [1], it
> only dumps the error.  IMHO users can quit easily for dst vm, I'll
> just let them decide if they want.
>
> Then you can merge the error path for both.
Ok, got it, thanks :)
>
>> +        }
>>       }
>>   }
>>   
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 8b36e7f184..87dfc7374f 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -541,7 +541,7 @@ void migration_fd_process_incoming(QEMUFile *f)
>>       migration_incoming_process();
>>   }
>>   
>> -void migration_ioc_process_incoming(QIOChannel *ioc)
>> +void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>>   {
>>       MigrationIncomingState *mis = migration_incoming_get_current();
>>       bool start_migration;
>> @@ -563,9 +563,14 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
>>            */
>>           start_migration = !migrate_use_multifd();
>>       } else {
>> +        Error *local_err = NULL;
>>           /* Multiple connections */
>>           assert(migrate_use_multifd());
>> -        start_migration = multifd_recv_new_channel(ioc);
>> +        start_migration = multifd_recv_new_channel(ioc, &local_err);
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            return;
>> +        }
>>       }
>>   
>>       if (start_migration) {
>> diff --git a/migration/migration.h b/migration/migration.h
>> index f7813f8261..7df4d426d0 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -229,7 +229,7 @@ struct MigrationState
>>   void migrate_set_state(int *state, int old_state, int new_state);
>>   
>>   void migration_fd_process_incoming(QEMUFile *f);
>> -void migration_ioc_process_incoming(QIOChannel *ioc);
>> +void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>>   void migration_incoming_process(void);
>>   
>>   bool  migration_has_all_channels(void);
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 4db3b3e8f4..8f03afe228 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1072,6 +1072,7 @@ out:
>>   static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>>   {
>>       MultiFDSendParams *p = opaque;
>> +    MigrationState *s = migrate_get_current();
> This seems to be the source part, then I'll suggest you split the
> patch and keep this patch only touches the dest vm path.
ok
>
>>       QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
>>       Error *local_err = NULL;
>>   
>> @@ -1080,6 +1081,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>>       }
>>   
>>       if (qio_task_propagate_error(task, &local_err)) {
>> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>>           if (multifd_save_cleanup(&local_err) != 0) {
>>               migrate_set_error(migrate_get_current(), local_err);
>>           }
>> @@ -1337,16 +1339,20 @@ bool multifd_recv_all_channels_created(void)
>>   }
>>   
>>   /* Return true if multifd is ready for the migration, otherwise false */
>> -bool multifd_recv_new_channel(QIOChannel *ioc)
>> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>>   {
>> +    MigrationIncomingState *mis = migration_incoming_get_current();
>>       MultiFDRecvParams *p;
>>       Error *local_err = NULL;
>>       int id;
>>   
>>       id = multifd_recv_initial_packet(ioc, &local_err);
>>       if (id < 0) {
>> +        error_propagate_prepend(errp, local_err,
>> +                        "failed to receive packet via multifd channel %x: ",
>> +                        multifd_recv_state->count);
>>           multifd_recv_terminate_threads(local_err, false);
>> -        return false;
>> +        goto fail;
>>       }
>>   
>>       p = &multifd_recv_state->params[id];
>> @@ -1354,7 +1360,8 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>>           error_setg(&local_err, "multifd: received id '%d' already setup'",
>>                      id);
>>           multifd_recv_terminate_threads(local_err, true);
>> -        return false;
>> +        error_propagate(errp, local_err);
>> +        goto fail;
>>       }
>>       p->c = ioc;
>>       object_ref(OBJECT(ioc));
>> @@ -1366,6 +1373,10 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>>                          QEMU_THREAD_JOINABLE);
>>       atomic_inc(&multifd_recv_state->count);
>>       return multifd_recv_state->count == migrate_multifd_channels();
>> +fail:
>> +    qemu_fclose(mis->from_src_file);
>> +    mis->from_src_file = NULL;
>> +    return false;
> Do we need this?
>
> I'd suggest to put all cleanups into a single function.  For dest vm
> I say it's process_incoming_migration_bh.
>
> Regards,
>
Not sure whether I understand correctly, if multifd_recv_new_channel() 
fails,
that means migration_incoming_process() will not be called, then
process_incoming_migration_co() and process_incoming_migration_bh()
will not be called either. In that way, there is no cleanup.

Have a nice day, thanks
Fei
