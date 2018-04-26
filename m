Received: from eggs.gnu.org ([2001:4830:134:3::10]:46077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fBgms-0007oY-DB
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fBgmm-0001Py-MM
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:18:14 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:40561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fBgmm-0001Pn-FY
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:18:08 -0400
Received: by mail-pf0-x241.google.com with SMTP id f189so9240983pfa.7
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 06:18:08 -0700 (PDT)
References: <20180426091519.26934-1-xiaoguangrong@tencent.com>
	<20180426093443.GA2631@work-vm>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <34c11cfa-3199-6097-3412-d7214fde0a08@gmail.com>
Date: Thu, 26 Apr 2018 21:18:01 +0800
MIME-Version: 1.0
In-Reply-To: <20180426093443.GA2631@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: introduce decompress-error-check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 04/26/2018 05:34 PM, Dr. David Alan Gilbert wrote:
> * guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> QEMU 2.13 enables strict check for compression & decompression to
>> make the migration more robuster, that depends on the source to fix
>> the internal design which triggers the unexpected error conditions
> 
> Hmm that's painful!

Yup, i will think it more carefully next time. :(

> 
>> To make it work for migrating old version QEMU to 2.13 QEMU, we
>> introduce this parameter to disable the error check on the
>> destination
>>
>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
>> ---
>>   hmp.c                 |  8 ++++++++
>>   migration/migration.c | 19 +++++++++++++++++++
>>   migration/migration.h |  1 +
>>   migration/ram.c       |  2 +-
>>   qapi/migration.json   | 43 +++++++++++++++++++++++++++++++++++++++----
>>   5 files changed, 68 insertions(+), 5 deletions(-)
>>
>> diff --git a/hmp.c b/hmp.c
>> index 898e25f3e1..f0b934368b 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -329,6 +329,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>           monitor_printf(mon, "%s: %u\n",
>>               MigrationParameter_str(MIGRATION_PARAMETER_DECOMPRESS_THREADS),
>>               params->decompress_threads);
>> +        assert(params->has_decompress_error_check);
>> +        monitor_printf(mon, "%s: %s\n",
>> +            MigrationParameter_str(MIGRATION_PARAMETER_DECOMPRESS_ERROR_CHECK),
>> +            params->decompress_error_check ? "on" : "off");
> 
> Since it's a bool, this should be a migration-capability rather than a
> parameter I think.
> 

The parameter, @block-incremental, it is also a bool, i think it is okay to
decompress-error-check as well, and it is one of the configurations
of decompression, it is better to group them. Right? :)

> Also, we need to make sure it defaults to off for compatibility.

Yes, the parameter is allocated by zalloc, it has already been false on
default, do you think we should make it be false explicitly?

> 
> Other than that, I think it's OK.

Thank you, Dave!
