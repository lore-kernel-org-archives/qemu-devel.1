Received: from eggs.gnu.org ([2001:4830:134:3::10]:51966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gRC6W-0003Um-84
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gRC6R-00045f-AO
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:18:52 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gRC6N-0003dY-DJ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:18:45 -0500
Received: by mail-pl1-x642.google.com with SMTP id f12-v6so13519277plo.1
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 00:18:31 -0800 (PST)
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-3-xiaoguangrong@tencent.com>
	<20181124001734.GF17229@flamenco>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <122f7c3b-ebaf-a2c0-3181-cce82d857058@gmail.com>
Date: Mon, 26 Nov 2018 16:18:24 +0800
MIME-Version: 1.0
In-Reply-To: <20181124001734.GF17229@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/5] util: introduce threaded workqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 11/24/18 8:17 AM, Emilio G. Cota wrote:
> On Thu, Nov 22, 2018 at 15:20:25 +0800, guangrong.xiao@gmail.com wrote:
>> +static uint64_t get_free_request_bitmap(Threads *threads, ThreadLocal *thread)
>> +{
>> +    uint64_t request_fill_bitmap, request_done_bitmap, result_bitmap;
>> +
>> +    request_fill_bitmap = atomic_rcu_read(&thread->request_fill_bitmap);
>> +    request_done_bitmap = atomic_rcu_read(&thread->request_done_bitmap);
>> +    bitmap_xor(&result_bitmap, &request_fill_bitmap, &request_done_bitmap,
>> +               threads->thread_requests_nr);
> 
> This is not wrong, but it's a big ugly. Instead, I would:
> 
> - Introduce bitmap_xor_atomic in a previous patch
> - Use bitmap_xor_atomic here, getting rid of the rcu reads

Hmm, however, we do not need atomic xor operation here... that should be slower than
just two READ_ONCE calls.
