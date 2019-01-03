Received: from eggs.gnu.org ([208.118.235.92]:50240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gf32T-0002n8-Qu
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gf32Q-0004EI-LA
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:27:57 -0500
Received: from m50-112.126.com ([123.125.50.112]:57286)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gf32P-0004CT-Uw
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:27:54 -0500
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-6-fli@suse.com> <20190103112538.GF2316@work-vm>
From: Fei Li <lifei1214@126.com>
Message-ID: <102bcca6-da72-6f4c-c160-e9351e238317@126.com>
Date: Thu, 3 Jan 2019 21:27:48 +0800
MIME-Version: 1.0
In-Reply-To: <20190103112538.GF2316@work-vm>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 05/16] migration: unify error
 handling for process_incoming_migration_co
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>


ÔÚ 2019/1/3 ÏÂÎç7:25, Dr. David Alan Gilbert Ð´µÀ:
> * Fei Li (fli@suse.com) wrote:
>> In the current code, if process_incoming_migration_co() fails we do
>> the same error handing: set the error state, close the source file,
>> do the cleanup for multifd, and then exit(EXIT_FAILURE). To make the
>> code clearer, add a "goto fail" to unify the error handling.
>>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>>   migration/migration.c | 26 +++++++++++++-------------
>>   1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 5d322eb9d6..ded151b1bf 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -438,15 +438,13 @@ static void process_incoming_migration_co(void *opaque)
>>           /* Make sure all file formats flush their mutable metadata */
>>           bdrv_invalidate_cache_all(&local_err);
>>           if (local_err) {
>> -            migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>> -                    MIGRATION_STATUS_FAILED);
>>               error_report_err(local_err);
>> -            exit(EXIT_FAILURE);
>> +            goto fail;
>>           }
>>   
>>           if (colo_init_ram_cache() < 0) {
>>               error_report("Init ram cache failed");
>> -            exit(EXIT_FAILURE);
>> +            goto fail;
>>           }
>>   
>>           qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
>> @@ -461,20 +459,22 @@ static void process_incoming_migration_co(void *opaque)
>>       }
>>   
>>       if (ret < 0) {
>> -        Error *local_err = NULL;
>> -
>> -        migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>> -                          MIGRATION_STATUS_FAILED);
>>           error_report("load of migration failed: %s", strerror(-ret));
>> -        qemu_fclose(mis->from_src_file);
>> -        if (multifd_load_cleanup(&local_err) != 0) {
>> -            error_report_err(local_err);
>> -        }
>> -        exit(EXIT_FAILURE);
>> +        goto fail;
>>       }
>>       mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
>>       qemu_bh_schedule(mis->bh);
>>       mis->migration_incoming_co = NULL;
>> +    return;
>> +fail:
>> +    local_err = NULL;
>> +    migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>> +                      MIGRATION_STATUS_FAILED);
>> +    qemu_fclose(mis->from_src_file);
>> +    if (multifd_load_cleanup(&local_err) != 0) {
>> +        error_report_err(local_err);
>> +    }
>> +    exit(EXIT_FAILURE);
>>   }
>>   
>>   static void migration_incoming_setup(QEMUFile *f)
> OK, so this is really unifying the normal error case and the two
> colo-incoming error cases; so I think that's fine.
>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks for the review :)

Fei

>
>> -- 
>> 2.13.7
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
