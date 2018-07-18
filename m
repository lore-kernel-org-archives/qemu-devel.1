Received: from eggs.gnu.org ([2001:4830:134:3::10]:40949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ffiBg-00088N-Ip
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ffiBd-0006He-Gq
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:51:56 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:51129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1ffiBd-0006G9-AQ
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:51:53 -0400
Received: by mail-it0-x241.google.com with SMTP id w16-v6so3045296ita.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 01:51:53 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-6-xiaoguangrong@tencent.com>
	<20180613162508.GM2676@work-vm>
	<b64e1091-7fe4-fe65-4b28-2597491993e1@gmail.com>
	<20180716190122.GE2664@work-vm>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <2e9a96cc-4d94-1081-15cb-f307175fa6d7@gmail.com>
Date: Wed, 18 Jul 2018 16:51:46 +0800
MIME-Version: 1.0
In-Reply-To: <20180716190122.GE2664@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 07/17/2018 03:01 AM, Dr. David Alan Gilbert wrote:
> * Xiao Guangrong (guangrong.xiao@gmail.com) wrote:
>>
>>
>> On 06/14/2018 12:25 AM, Dr. David Alan Gilbert wrote:
>>   }
>>>>    static void migration_bitmap_sync(RAMState *rs)
>>>> @@ -1412,6 +1441,9 @@ static void flush_compressed_data(RAMState *rs)
>>>>            qemu_mutex_lock(&comp_param[idx].mutex);
>>>>            if (!comp_param[idx].quit) {
>>>>                len = qemu_put_qemu_file(rs->f, comp_param[idx].file);
>>>> +            /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
>>>> +            compression_counters.reduced_size += TARGET_PAGE_SIZE - len + 8;
>>>
>>> I think I'd rather save just len+8 rather than than the subtraction.
>>>
>> Hmmmmmm, is this what you want?
>>        compression_counters.reduced_size += len - 8;
>>
>> Then calculate the real reduced size in populate_ram_info() where we return this
>> info to the user:
>>        info->compression->reduced_size = compression_counters.pages * PAGE_SIZE - compression_counters.reduced_size;
>>
>> Right?
> 
> I mean I'd rather see the actual size presented to the user rather than
> the saving compared to uncompressed.
> 

These statistics are used to help people to see whether compression works efficiently or not,
so maybe reduced-size is more straightforward?　:)
