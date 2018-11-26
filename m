Received: from eggs.gnu.org ([2001:4830:134:3::10]:48387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gRBup-0005f8-VI
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gRBum-000132-K7
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:06:47 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gRBum-000122-EF
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:06:44 -0500
Received: by mail-pl1-x643.google.com with SMTP id a14so13470701plm.12
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 00:06:44 -0800 (PST)
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-3-xiaoguangrong@tencent.com>
	<20181124001231.GE17229@flamenco>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <60635ba4-7db8-c0c0-6ce2-23f6fab8ac25@gmail.com>
Date: Mon, 26 Nov 2018 16:06:37 +0800
MIME-Version: 1.0
In-Reply-To: <20181124001231.GE17229@flamenco>
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 11/24/18 8:12 AM, Emilio G. Cota wrote:
> On Thu, Nov 22, 2018 at 15:20:25 +0800, guangrong.xiao@gmail.com wrote:
>> +   /*
>> +     * the bit in these two bitmaps indicates the index of the ＠requests
> 
> This @ is not ASCII, is it?
> 

Good eyes. :)

Will fix it.

>> +     * respectively. If it's the same, the corresponding request is free
>> +     * and owned by the user, i.e, where the user fills a request. Otherwise,
>> +     * it is valid and owned by the thread, i.e, where the thread fetches
>> +     * the request and write the result.
>> +     */
>> +
>> +    /* after the user fills the request, the bit is flipped. */
>> +    uint64_t request_fill_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
>> +    /* after handles the request, the thread flips the bit. */
>> +    uint64_t request_done_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
> 
> Use DECLARE_BITMAP, otherwise you'll get type errors as David
> pointed out.

If we do it, the field becomes a pointer... that complicates the
thing.

Hmm, i am using the same trick applied by kvm module when it handles
vcpu->requests:
static inline bool kvm_test_request(int req, struct kvm_vcpu *vcpu)
{
	return test_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->requests);
}

Is it good?
