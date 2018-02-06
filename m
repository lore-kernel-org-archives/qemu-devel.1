Received: from eggs.gnu.org ([2001:4830:134:3::10]:57583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eizUX-00051N-T6
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eizUT-00012W-Tg
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:24:41 -0500
Received: from mail-eopbgr20136.outbound.protection.outlook.com
	([40.107.2.136]:24160
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eizUT-00011X-28
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:24:37 -0500
References: <151790197381.27004.13241184632371976036.stgit@bahia.lan>
	<9f1237f2-5194-1cc5-dbc4-b453ff3ee7c4@virtuozzo.com>
	<20180206094310.2a9cdc5c@bahia.lan>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <37d2afca-0b5a-8c69-4caf-8e0c190cba7e@virtuozzo.com>
Date: Tue, 6 Feb 2018 12:24:30 +0300
MIME-Version: 1.0
In-Reply-To: <20180206094310.2a9cdc5c@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] migration: incoming postcopy advise sanity
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

06.02.2018 11:43, Greg Kurz wrote:
> On Tue, 6 Feb 2018 10:49:47 +0300
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>
>> 06.02.2018 10:26, Greg Kurz wrote:
>>> If postcopy-ram was set on the source but not on the destination,
>>> migration doesn't occur, the destination prints an error and boots
>>> the guest:
>>>
>>> qemu-system-ppc64: Expected vmdescription section, but got 0
>>>
>>> We end up with two running instances.
>>>
>>> This behaviour was introduced in 2.11 by commit 58110f0acb1a "migration:
>>> split common postcopy out of ram postcopy" to prepare ground for the
>>> upcoming dirty bitmap postcopy support. It adds a new case where the
>>> source may send an empty postcopy advise because dirty bitmap doesn't
>>> need to check page sizes like RAM postcopy does.
>>>
>>> If the source has enabled postcopy-ram, then it sends an advise with
>>> the page size values. If the destination hasn't enabled postcopy-ram,
>>> then loadvm_postcopy_handle_advise() leaves the page size values on
>>> the stream and returns. This confuses qemu_loadvm_state() later on
>>> and causes the destination to start execution.
>>>
>>> As discussed several times, postcopy-ram should be enabled both sides
>>> to be functional. This patch changes the destination to perform some
>>> extra checks on the advise length to ensure this is the case. Otherwise
>>> an error is returned and migration is aborted.
>>>
>>> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>> ---
>>>    migration/savevm.c |   18 +++++++++++++++---
>>>    1 file changed, 15 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>> index b7908f62be3c..1c516fcbb8d7 100644
>>> --- a/migration/savevm.c
>>> +++ b/migration/savevm.c
>>> @@ -1376,7 +1376,8 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
>>>     * *might* happen - it might be skipped if precopy transferred everything
>>>     * quickly.
>>>     */
>>> -static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
>>> +static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
>>> +                                         uint16_t len)
>>>    {
>>>        PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_ADVISE);
>>>        uint64_t remote_pagesize_summary, local_pagesize_summary, remote_tps;
>>> @@ -1387,8 +1388,19 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
>>>            return -1;
>>>        }
>>>    
>>> -    if (!migrate_postcopy_ram()) {
>>> +    switch (len) {
>>> +    case 0:
>>> +        /* The source hasn't enabled postcopy-ram. Nothing to do. */
>> should we error-out here if (migrate_postcopy_ram()) ?
>>
> I was also thinking so at first, but if the source hasn't enabled postcopy-ram,
> then RAM postcopy won't happen. Not sure why we should error out...

if user enables dirty-bitmaps postcopy on source, and enables 
postcopy-ram on target,
we will be here, with migrate_postcopy_ram()=true. and it should be error.

>
>>>            return 0;
>>> +    case 8 + 8:
>>> +        if (!migrate_postcopy_ram()) {
>>> +            error_report("RAM postcopy is disabled");
>>> +            return -EINVAL;
>>> +        }
>>> +        break;
>>> +    default:
>>> +        error_report("CMD_POSTCOPY_ADVISE invalid length (%d)", len);
>>> +        return -EINVAL;
>>>        }
>>>    
>>>        if (!postcopy_ram_supported_by_host(mis)) {
>>> @@ -1807,7 +1819,7 @@ static int loadvm_process_command(QEMUFile *f)
>>>            return loadvm_handle_cmd_packaged(mis);
>>>    
>>>        case MIG_CMD_POSTCOPY_ADVISE:
>>> -        return loadvm_postcopy_handle_advise(mis);
>>> +        return loadvm_postcopy_handle_advise(mis, len);
>>>    
>>>        case MIG_CMD_POSTCOPY_LISTEN:
>>>            return loadvm_postcopy_handle_listen(mis);
>>>   
>>


-- 
Best regards,
Vladimir
