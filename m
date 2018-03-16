Received: from eggs.gnu.org ([2001:4830:134:3::10]:55127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ewlD9-0002Xx-AA
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ewlD4-0000Wd-GC
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:59:39 -0400
Received: from mail-io0-x22f.google.com ([2607:f8b0:4001:c06::22f]:42629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1ewlD4-0000WJ-Ap
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:59:34 -0400
Received: by mail-io0-x22f.google.com with SMTP id u84so11807278iod.9
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 01:59:34 -0700 (PDT)
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-6-xiaoguangrong@tencent.com>
	<20180315114715.GE3062@work-vm>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <5aa7923b-2b4c-4d44-7861-63c05e25c75f@gmail.com>
Date: Fri, 16 Mar 2018 16:59:26 +0800
MIME-Version: 1.0
In-Reply-To: <20180315114715.GE3062@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/8] migration: move calling
 control_save_page to the common place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org



On 03/15/2018 07:47 PM, Dr. David Alan Gilbert wrote:

>>       /* Check the pages is dirty and if it is send it */
>>       if (migration_bitmap_clear_dirty(rs, pss->block, pss->page)) {
>> +        RAMBlock *block = pss->block;
>> +        ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
>> +
>> +        if (control_save_page(rs, block, offset, &res)) {
>> +            goto page_saved;
> 
> OK, but I'd prefer if you avoided this forward goto;  we do use goto but
> we tend to keep it just for error cases.
> 

There is a common operation, clearing unsentmap, for save_control,
save_zero, save_compressed and save_normal, if we do not use 'goto',
the operation would to be duplicated several times or we will have
big if...elseif...elseif... section.

So it may be not too bad to have 'goto' under this case? :)
