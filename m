Received: from eggs.gnu.org ([2001:4830:134:3::10]:41007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gCSOV-0005zJ-5B
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gCSOS-0003L1-03
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:40:31 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34139)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gCSOP-0003Gk-BO
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:40:26 -0400
Date: Tue, 16 Oct 2018 12:40:19 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181016164019.GA5666@flamenco>
References: <20181016111006.629-1-xiaoguangrong@tencent.com>
	<20181016111006.629-2-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016111006.629-2-xiaoguangrong@tencent.com>
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
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn

On Tue, Oct 16, 2018 at 19:10:03 +0800, guangrong.xiao@gmail.com wrote:
(snip)
> diff --git a/include/qemu/ptr_ring.h b/include/qemu/ptr_ring.h
> new file mode 100644
> index 0000000000..d8266d45f6
> --- /dev/null
> +++ b/include/qemu/ptr_ring.h
> @@ -0,0 +1,235 @@
(snip)
> +#define SMP_CACHE_BYTES      64
> +#define ____cacheline_aligned_in_smp \
> +        __attribute__((__aligned__(SMP_CACHE_BYTES)))

You could use QEMU_ALIGNED() here.

> +
> +#define WRITE_ONCE(ptr, val) \
> +    (*((volatile typeof(ptr) *)(&(ptr))) = (val))
> +#define READ_ONCE(ptr) (*((volatile typeof(ptr) *)(&(ptr))))

Why not atomic_read/set, like in the rest of the QEMU code base?

Furthermore, READ_ONCE in the kernel implies smp_read_barrier_depends,
whereas here you're not bringing that in. That means that your
barrier pairing, e.g.

> +    /* Pairs with READ_ONCE in ptr_ring_consume. */
> +    smp_wmb();

is incorrect for Alpha.

Thanks,

		E.
