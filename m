Received: from eggs.gnu.org ([2001:4830:134:3::10]:46504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCgyS-0002gh-9N
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCgyO-0000xu-B8
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:14:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gCgyK-0000jQ-2P
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:14:30 -0400
References: <20181016111006.629-1-xiaoguangrong@tencent.com>
	<20181016111006.629-2-xiaoguangrong@tencent.com>
	<20181016164019.GA5666@flamenco>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <40c0df2a-5a3e-5296-0894-efadf47f3d56@redhat.com>
Date: Wed, 17 Oct 2018 10:14:14 +0200
MIME-Version: 1.0
In-Reply-To: <20181016164019.GA5666@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] ptr_ring: port ptr_ring from linux
 kernel to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, guangrong.xiao@gmail.com
Cc: mst@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn

On 16/10/2018 18:40, Emilio G. Cota wrote:
>> +#define SMP_CACHE_BYTES      64
>> +#define ____cacheline_aligned_in_smp \
>> +        __attribute__((__aligned__(SMP_CACHE_BYTES)))
> You could use QEMU_ALIGNED() here.
> 
>> +
>> +#define WRITE_ONCE(ptr, val) \
>> +    (*((volatile typeof(ptr) *)(&(ptr))) = (val))
>> +#define READ_ONCE(ptr) (*((volatile typeof(ptr) *)(&(ptr))))
> Why not atomic_read/set, like in the rest of the QEMU code base?

Or even atomic_rcu_read/atomic_rcu_set, which includes the necessary
barriers.

Also, please do not use __ identifiers in QEMU code.
____cacheline_aligned_in_smp can become just QEMU_ALIGNED(SMP_CACHE_BYTES).

Paolo
