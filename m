Received: from eggs.gnu.org ([2001:4830:134:3::10]:33637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1eXQus-0002HL-TA
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 07:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1eXQuo-0006tf-S2
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 07:16:06 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1eXQuo-0006ru-BR
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 07:16:02 -0500
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <83b57241-63b2-c4c2-8b37-9fc288de53f6@samsung.com>
Date: Fri, 05 Jan 2018 15:15:55 +0300
MIME-version: 1.0
In-reply-to: <64a69d83-c575-5bd2-66f4-5b88172418a2@redhat.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
	<CGME20171030131650eucas1p183c745b845ded5e02e842582bb44fd7b@eucas1p1.samsung.com>
	<1509369390-8285-7-git-send-email-a.perevalov@samsung.com>
	<64a69d83-c575-5bd2-66f4-5b88172418a2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 6/6] migration: add postcopy total
 blocktime into query-migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: heetae82.ahn@samsung.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com, i.maximets@samsung.com

On 01/03/2018 12:26 AM, Eric Blake wrote:
> On 10/30/2017 08:16 AM, Alexey Perevalov wrote:
>> Postcopy total blocktime is available on destination side only.
>> But query-migrate was possible only for source. This patch
>> adds ability to call query-migrate on destination.
>> To be able to see postcopy blocktime, need to request postcopy-blocktime
>> capability.
> Why not display the stats unconditionally when they are available,
> instead of having to set a capability knob to request them?
That knob necessary to avoid regression if this information
is not necessary, we decided during so long discussion in previous
version of the patch set - it's not necessary always.
But if user requested blocktime and host can't calculate it,
e.g. due to appropriate feature isn't supported in host kernel,
yes, the value will be 0.

>
>> The query-migrate command will show following sample result:
>> {"return":
>>      "postcopy-vcpu-blocktime": [115, 100],
>>      "status": "completed",
>>      "postcopy-blocktime": 100
>> }}
>>
>> postcopy_vcpu_blocktime contains list, where the first item is the first
>> vCPU in QEMU.
>>
>> This patch has a drawback, it combines states of incoming and
>> outgoing migration. Ongoing migration state will overwrite incoming
>> state. Looks like better to separate query-migrate for incoming and
>> outgoing migration or add parameter to indicate type of migration.
>>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
>> ---
>> +++ b/qapi/migration.json
>> @@ -156,6 +156,13 @@
>>   #              @status is 'failed'. Clients should not attempt to parse the
>>   #              error strings. (Since 2.7)
>>   #
>> +# @postcopy-blocktime: total time when all vCPU were blocked during postcopy
>> +#           live migration (Since 2.11)
> 2.12 now.
>
> Should this mention the capability knob needed to enable this stat (or
> else get rid of the capability knob and always expose this when possible)?
>
>> +#
>> +# @postcopy-vcpu-blocktime: list of the postcopy blocktime per vCPU (Since 2.11)
> Also 2.12.
>
>> +#
>> +
>> +#
>>   # Since: 0.14.0
>>   ##
>>   { 'struct': 'MigrationInfo',
>> @@ -167,7 +174,9 @@
>>              '*downtime': 'int',
>>              '*setup-time': 'int',
>>              '*cpu-throttle-percentage': 'int',
>> -           '*error-desc': 'str'} }
>> +           '*error-desc': 'str',
>> +           '*postcopy-blocktime' : 'int64',
>> +           '*postcopy-vcpu-blocktime': ['int64']} }
>>   
>>   ##
>>   # @query-migrate:
>>

-- 
Best regards,
Alexey Perevalov
