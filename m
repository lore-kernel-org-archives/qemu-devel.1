Received: from eggs.gnu.org ([209.51.188.92]:33412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJotu-0001qT-OE
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 20:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJots-0000yc-2g
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 20:39:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:1806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJotn-0000oX-JU
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 20:39:33 -0400
Date: Fri, 26 Apr 2019 08:39:01 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190426003901.GA25513@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190424004700.12766-1-richardw.yang@linux.intel.com>
	<20190424004700.12766-2-richardw.yang@linux.intel.com>
	<e9cd3438-345f-2a68-daec-1ce4cba37ef1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9cd3438-345f-2a68-daec-1ce4cba37ef1@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] migration/savevm: remove duplicate
 check of migration_is_blocked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com

On Thu, Apr 25, 2019 at 04:20:57PM -0300, Daniel Henrique Barboza wrote:
>
>
>On 4/23/19 9:46 PM, Wei Yang wrote:
>> Current call flow of save_snapshot is:
>> 
>>    save_snapshot
>>      migration_is_blocked
>>        qemu_savevm_state
>>          migration_is_blocked
>> 
>> Since qemu_savevm_state is only called in save_snapshot, this means
>> migration_is_blocked has been already checked.
>
>I think it would be a nice touch to add a comment in qemu_savevm_state,
>saying that the function must be called with migration_is_blocked()
>context. Just in case someone else in the future ends up re-using the
>function.
>

That's reasonable, let me add a comment for qemu_savevm_state().

>
>Other than that, +1 for less code duplication.
>
>
>Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>
>
>
>
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>   migration/savevm.c | 4 ----
>>   1 file changed, 4 deletions(-)
>> 
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 92af2471cd..2eea604624 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1412,10 +1412,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>>           return -EINVAL;
>>       }
>> -    if (migration_is_blocked(errp)) {
>> -        return -EINVAL;
>> -    }
>> -
>>       if (migrate_use_block()) {
>>           error_setg(errp, "Block migration and snapshots are incompatible");
>>           return -EINVAL;

-- 
Wei Yang
Help you, Help me
