Received: from eggs.gnu.org ([2001:4830:134:3::10]:36960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQLdl-0001ua-Oq
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 19:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQLdh-00066M-Bm
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 19:17:41 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39383)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gQLdh-0005zF-7h
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 19:17:37 -0500
Date: Fri, 23 Nov 2018 19:17:34 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181124001734.GF17229@flamenco>
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-3-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122072028.22819-3-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] util: introduce threaded workqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Thu, Nov 22, 2018 at 15:20:25 +0800, guangrong.xiao@gmail.com wrote:
> +static uint64_t get_free_request_bitmap(Threads *threads, ThreadLocal *thread)
> +{
> +    uint64_t request_fill_bitmap, request_done_bitmap, result_bitmap;
> +
> +    request_fill_bitmap = atomic_rcu_read(&thread->request_fill_bitmap);
> +    request_done_bitmap = atomic_rcu_read(&thread->request_done_bitmap);
> +    bitmap_xor(&result_bitmap, &request_fill_bitmap, &request_done_bitmap,
> +               threads->thread_requests_nr);

This is not wrong, but it's a big ugly. Instead, I would:

- Introduce bitmap_xor_atomic in a previous patch
- Use bitmap_xor_atomic here, getting rid of the rcu reads

Thanks,

		Emilio
