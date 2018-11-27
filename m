Received: from eggs.gnu.org ([2001:4830:134:3::10]:59679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gRYmW-0001Yi-VV
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 03:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gRYmR-0008EX-Vo
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 03:31:44 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gRYmR-0008DV-N8
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 03:31:39 -0500
Received: by mail-pl1-x641.google.com with SMTP id p8so4967030plo.2
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 00:31:39 -0800 (PST)
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-3-xiaoguangrong@tencent.com>
	<20181124001734.GF17229@flamenco>
	<122f7c3b-ebaf-a2c0-3181-cce82d857058@gmail.com>
	<e6a87a89-e667-5c8d-9016-1d6c2a65fc6a@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <ec16d438-9897-6308-813f-290bf920dd5d@gmail.com>
Date: Tue, 27 Nov 2018 16:31:31 +0800
MIME-Version: 1.0
In-Reply-To: <e6a87a89-e667-5c8d-9016-1d6c2a65fc6a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/5] util: introduce threaded workqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>
Cc: mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 11/26/18 6:28 PM, Paolo Bonzini wrote:
> On 26/11/18 09:18, Xiao Guangrong wrote:
>>>
>>>> +static uint64_t get_free_request_bitmap(Threads *threads,
>>>> ThreadLocal *thread)
>>>> +{
>>>> +    uint64_t request_fill_bitmap, request_done_bitmap, result_bitmap;
>>>> +
>>>> +    request_fill_bitmap =
>>>> atomic_rcu_read(&thread->request_fill_bitmap);
>>>> +    request_done_bitmap =
>>>> atomic_rcu_read(&thread->request_done_bitmap);
>>>> +    bitmap_xor(&result_bitmap, &request_fill_bitmap,
>>>> &request_done_bitmap,
>>>> +               threads->thread_requests_nr);
>>>
>>> This is not wrong, but it's a big ugly. Instead, I would:
>>>
>>> - Introduce bitmap_xor_atomic in a previous patch
>>> - Use bitmap_xor_atomic here, getting rid of the rcu reads
>>
>> Hmm, however, we do not need atomic xor operation here... that should be
>> slower than
>> just two READ_ONCE calls.
> 
> Yeah, I'd just go with Guangrong's version.  Alternatively, add
> find_{first,next}_{same,different}_bit functions (whatever subset of the
> 4 you need).

That's good to me. will try it. ;)
