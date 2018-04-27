Received: from eggs.gnu.org ([2001:4830:134:3::10]:47540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fBtrQ-0003ve-E3
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 23:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fBtrN-00022G-9s
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 23:15:48 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:41457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fBtrN-000213-3K
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 23:15:45 -0400
Received: by mail-pg0-x229.google.com with SMTP id m21-v6so429381pgv.8
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 20:15:45 -0700 (PDT)
References: <20180426091519.26934-1-xiaoguangrong@tencent.com>
	<32eaad8e-35a0-5240-37a2-4242b7890ab9@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <a14b1b5b-4f0c-c085-35b8-9539afa5091f@gmail.com>
Date: Fri, 27 Apr 2018 11:15:37 +0800
MIME-Version: 1.0
In-Reply-To: <32eaad8e-35a0-5240-37a2-4242b7890ab9@redhat.com>
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
To: Eric Blake <eblake@redhat.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn



On 04/26/2018 10:01 PM, Eric Blake wrote:
> On 04/26/2018 04:15 AM, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> QEMU 2.13 enables strict check for compression & decompression to
>> make the migration more robuster, that depends on the source to fix
> 
> s/robuster/robust/
> 

Will fix, thank you for pointing it out.

>> the internal design which triggers the unexpected error conditions
> 
> 2.13 hasn't been released yet.  Why do we need a knob to explicitly turn
> off strict checking?  Can we not instead make 2.13 automatically smart
> enough to tell if the incoming stream is coming from an older qemu
> (which might fail if the strict checks are enabled) vs. a newer qemu
> (the sender gave us what we need to ensure the strict checks are
> worthwhile)?
> 

Really smart.

How about introduce a new command, MIG_CMD_DECOMPRESS_ERR_CHECK,
the destination will do strict check if got this command (i.e, new
QEMU is running on the source), otherwise, turn the check off.

>>
>> To make it work for migrating old version QEMU to 2.13 QEMU, we
>> introduce this parameter to disable the error check on the
>> destination
>>
>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
>> ---
> 
>> +++ b/qapi/migration.json
>> @@ -455,6 +455,17 @@
>>   #          compression, so set the decompress-threads to the number about 1/4
>>   #          of compress-threads is adequate.
>>   #
>> +# @decompress-error-check: check decompression errors. When false, the errors
>> +#                          triggered by memory decompression are ignored.
> 
> What are the consequences of such an error?  Is it a security hole to
> leave this at false, when a malicious migration stream can cause us to
> misbehave by ignoring the errors?

The issue fixed by strict error check is avoiding VM corruption if zlib failed
to compress & decompress the memory, i.e, catch error conditions returned by
zlib API.

> 
>> +#                          When true, migration is aborted if the errors are
>> +#                          detected. For the old QEMU versions (< 2.13) the
>> +#                          internal design will cause decompression to fail
>> +#                          so the destination should completely ignore the
>> +#                          error conditions, i.e, make it be false if these
>> +#                          QEMUs are going to be migrated. Since 2.13, this
>> +#                          design is fixed, make it be true to avoid corrupting
>> +#                          the VM silently (Since 2.13)
> 
> Rather wordy; I'd suggest:
> 
> @decompress-error-check: Set to true to abort the migration if
>          decompression errors are detected at the destination. Should be
>          left at false (default) for qemu older than 2.13, since only
>          newer qemu sends streams that do not trigger spurious
>          decompression errors. (Since 2.13)
> 

Yup, much better.

> But that's if we even need it (it SHOULD be possible to design something
> into the migration stream so that you can detect this property
> automatically instead of relying on the user to set the property).
> 

Yes, can not agree with you more. :)
