Received: from eggs.gnu.org ([2001:4830:134:3::10]:46898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gRBoy-0003mN-Ip
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:00:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gRBov-0004XF-EG
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:00:44 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gRBov-0004Wt-8C
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:00:41 -0500
Received: by mail-pg1-x542.google.com with SMTP id s198so5790346pgs.2
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 00:00:41 -0800 (PST)
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-4-xiaoguangrong@tencent.com>
	<20181123181717.GH2373@work-vm>
	<ec42ec4b-652d-807e-2d88-94a2d52e9cec@redhat.com>
	<20181123182918.GI2373@work-vm>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <c36abd0a-fcca-c9c2-11a7-c5d39a386418@gmail.com>
Date: Mon, 26 Nov 2018 16:00:34 +0800
MIME-Version: 1.0
In-Reply-To: <20181123182918.GI2373@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/5] migration: use threaded workqueue
 for compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>



On 11/24/18 2:29 AM, Dr. David Alan Gilbert wrote:

>>>>   static void
>>>> -update_compress_thread_counts(const CompressParam *param, int bytes_xmit)
>>>> +update_compress_thread_counts(CompressData *cd, int bytes_xmit)
>>>
>>> Keep the const?

Yes, indeed. Will correct it in the next version.

>>>> +    if (deflateInit(&cd->stream, migrate_compress_level()) != Z_OK) {
>>>> +        g_free(cd->originbuf);
>>>> +        return -1;
>>>> +    }
>>>
>>> Please print errors if you fail in any case so we can easily tell what
>>> happened.

Sure, will do.

>>>> +        if (wait) {
>>>> +            cpu_relax();
>>>> +            goto retry;
>>>
>>> Is there nothing better we can use to wait without eating CPU time?
>>
>> There is a mechanism to wait without eating CPU time in the data
>> structure, but it makes sense to busy wait.  There are 4 threads in the
>> workqueue, so you have to compare 1/4th of the time spent compressing a
>> page, with the trip into the kernel to wake you up.  You're adding 20%
>> CPU usage, but I'm not surprised it's worthwhile.
> 
> Hmm OK; in that case it does at least need a comment because it's a bit
> odd, and we should watch out how that scales - I guess it's less of
> an overhead the more threads you use.
> 

Sure, will add some comments to explain the purpose.
