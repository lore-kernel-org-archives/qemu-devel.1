Received: from eggs.gnu.org ([2001:4830:134:3::10]:57153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fnbJl-0005Np-MV
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fnbJg-0006QW-Rp
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:08:53 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fnbJg-0006Pv-KV
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:08:48 -0400
Received: by mail-pg1-x544.google.com with SMTP id k3-v6so2034277pgq.5
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 20:08:48 -0700 (PDT)
References: <20180807091209.13531-1-xiaoguangrong@tencent.com>
	<20180807091209.13531-9-xiaoguangrong@tencent.com>
	<20180808050846.GG24415@xz-mi>
	<503d7733-e2e7-09c5-75a3-1e250f549065@gmail.com>
	<20180808141112.GK2734@work-vm>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <76174d1d-fcd7-b58a-8950-5f6c6795f49f@gmail.com>
Date: Thu, 9 Aug 2018 11:08:39 +0800
MIME-Version: 1.0
In-Reply-To: <20180808141112.GK2734@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/10] migration: handle the error
 condition properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 08/08/2018 10:11 PM, Dr. David Alan Gilbert wrote:
> * Xiao Guangrong (guangrong.xiao@gmail.com) wrote:
>>
>>
>> On 08/08/2018 01:08 PM, Peter Xu wrote:
>>> On Tue, Aug 07, 2018 at 05:12:07PM +0800, guangrong.xiao@gmail.com wrote:
>>>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>>>
>>>> ram_find_and_save_block() can return negative if any error hanppens,
>>>> however, it is completely ignored in current code
>>>
>>> Could you hint me where we'll return an error?
>>>
>>
>> I think control_save_page() may return a error condition but i am not
>> good at it ... Other places look safe _currently_. These functions were
>> designed to have error returned anyway.
> 
> ram_control_save_page's return is checked by control_save_page which
> returns true/false but sets *pages to a return value.
> 
> What I'd need to follow closely is the case where ram_control_save_page
> returns RAM_SAVE_CONTROL_DELAYED, in that case control_save_page I think
> returns with *pages=-1 and returns true.
> And I think in that case ram_save_target_page can leak that -1 - hmm.
> 
> Now, ram_save_host_page already checks for <0 and will return that,
> but I think that would potentially loop in ram_find_and_save_block; I'm
> not sure we want to change that or not!

ram_find_and_save_block() will continue the look only if ram_save_host_page
returns zero:

......
         if (found) {
             pages = ram_save_host_page(rs, &pss, last_stage);
         }
     } while (!pages && again);

IMHO, how to change the code really depends on the semantic of these functions,
based on the comments of them, returning error conditions is the current
semantic.

Another choice would be the one squashes error conditions to QEMUFile and
adapt comments and code of these functions to reflect the new semantic
clearly.

Which one do you guys prefer to? :)
