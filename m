Received: from eggs.gnu.org ([2001:4830:134:3::10]:51046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fQXoK-00024y-RR
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fQXoH-0007SC-Q9
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:45:08 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:40925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fQXoH-0007Ro-Ij
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:45:05 -0400
Received: by mail-pl0-x241.google.com with SMTP id t12-v6so3752441plo.7
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 05:45:05 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-6-xiaoguangrong@tencent.com>
	<09358622-9975-3aa3-6201-cdbe77b021dc@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <e3414f29-235d-0f32-3400-8976f5d20568@gmail.com>
Date: Wed, 6 Jun 2018 20:44:59 +0800
MIME-Version: 1.0
In-Reply-To: <09358622-9975-3aa3-6201-cdbe77b021dc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/12] migration: show the statistics of
 compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn



On 06/05/2018 06:31 AM, Eric Blake wrote:
> On 06/04/2018 04:55 AM, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> Then the uses can adjust the parameters based on this info
>>
>> Currently, it includes:
>> pages: amount of pages compressed and transferred to the target VM
>> busy: amount of count that no free thread to compress data
>> busy-rate: rate of thread busy
>> reduced-size: amount of bytes reduced by compression
>> compression-rate: rate of compressed size
>>
>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
>> ---
> 
>> +++ b/qapi/migration.json
>> @@ -72,6 +72,26 @@
>>              'cache-miss': 'int', 'cache-miss-rate': 'number',
>>              'overflow': 'int' } }
>> +##
>> +# @CompressionStats:
>> +#
>> +# Detailed compression migration statistics
> 
> Sounds better as s/compression migration/migration compression/

Indeed.

> 
>> +#
>> +# @pages: amount of pages compressed and transferred to the target VM
>> +#
>> +# @busy: amount of count that no free thread to compress data
> 
> Not sure what was meant, maybe:
> 
> @busy: count of times that no free thread was available to compress data
> 

Yup, that's better.

>> +#
>> +# @busy-rate: rate of thread busy
> 
> In what unit? pages per second?

It's calculated by:
    pages-directly-posted-out-without-compression / total-page-posted-out

> 
>> +#
>> +# @reduced-size: amount of bytes reduced by compression
>> +#
>> +# @compression-rate: rate of compressed size
> 
> In what unit?
> 

It's calculated by:
    size-posted-out-after-compression / (compressed-page * page_size, i.e, that is
the raw data without compression)

>> +#
>> +##
> 
> Missing a 'Since: 3.0' tag
> 

Wow, directly upgrade to 3.0, big step. :-)
Will add this tag in the next version.

>> +{ 'struct': 'CompressionStats',
>> +  'data': {'pages': 'int', 'busy': 'int', 'busy-rate': 'number',
>> +       'reduced-size': 'int', 'compression-rate': 'number' } }
>> +
>>   ##
>>   # @MigrationStatus:
>>   #
>> @@ -169,6 +189,8 @@
>>   #           only present when the postcopy-blocktime migration capability
>>   #           is enabled. (Since 2.13)
> 
> Pre-existing - we need to fix this 2.13 to be 3.0 (if it isn't already fixed)

I should re-sync the repo before making patches next time.

> 
>>   #
>> +# @compression: compression migration statistics, only returned if compression
>> +#           feature is on and status is 'active' or 'completed' (Since 2.14)
> 
> There will not be a 2.14 (for that matter, not even a 2.13).  The next release is 3.0.

Okay, will fix.
