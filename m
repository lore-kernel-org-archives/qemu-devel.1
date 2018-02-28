Received: from eggs.gnu.org ([2001:4830:134:3::10]:33378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1er7Ha-0007Ms-GA
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1er7HZ-0000XF-Iw
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:20:54 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-20-jsnow@redhat.com>
	<20180228182526.GN4855@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <d306211f-54f3-16bb-bbf9-bdf5ed99aeec@redhat.com>
Date: Wed, 28 Feb 2018 14:20:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180228182526.GN4855@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 19/21] blockjobs: Expose manual property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 02/28/2018 01:25 PM, Kevin Wolf wrote:
> Am 24.02.2018 um 00:51 hat John Snow geschrieben:
>> Expose the "manual" property via QAPI for the backup-related jobs.
>> As of this commit, this allows the management API to request the
>> "concluded" and "dismiss" semantics for backup jobs.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  blockdev.c           | 19 ++++++++++++++++---
>>  qapi/block-core.json | 32 ++++++++++++++++++++++++++------
>>  2 files changed, 42 insertions(+), 9 deletions(-)
>>
>> diff --git a/blockdev.c b/blockdev.c
>> index 05fd421cdc..2eddb0e726 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -3260,7 +3260,7 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
>>      AioContext *aio_context;
>>      QDict *options = NULL;
>>      Error *local_err = NULL;
>> -    int flags;
>> +    int flags, job_flags = BLOCK_JOB_DEFAULT;
>>      int64_t size;
>>      bool set_backing_hd = false;
>>  
>> @@ -3279,6 +3279,9 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
>>      if (!backup->has_job_id) {
>>          backup->job_id = NULL;
>>      }
>> +    if (!backup->has_manual) {
>> +        backup->manual = false;
>> +    }
> 
> I think this is unnecessary these days, NULL/0/false is the default
> value for QMP/QAPI.
> 

That's what I get for cargo cult. Eric, confirm/deny? Should I remove
the other auto-false defaults too?

Either we have them all or none of them for consistency.

--js

>>      if (!backup->has_compress) {
>>          backup->compress = false;
>>      }
>> @@ -3422,6 +3429,9 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
>>      if (!backup->has_job_id) {
>>          backup->job_id = NULL;
>>      }
>> +    if (!backup->has_manual) {
>> +        backup->manual = false;
>> +    }
> 
> Same here.
> 
>>      if (!backup->has_compress) {
>>          backup->compress = false;
>>      }
> 
> Kevin
> 
