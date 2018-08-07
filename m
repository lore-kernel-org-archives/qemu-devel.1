Received: from eggs.gnu.org ([2001:4830:134:3::10]:55963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fn23o-0004Hu-HJ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fn23l-0003FQ-By
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:30:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39646 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fn23l-0003F9-6t
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:30:01 -0400
References: <20180807091209.13531-1-xiaoguangrong@tencent.com>
	<20180807091209.13531-2-xiaoguangrong@tencent.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6fb46b1e-5cae-24ec-acd6-72ba562a5c05@redhat.com>
Date: Tue, 7 Aug 2018 08:29:54 -0500
MIME-Version: 1.0
In-Reply-To: <20180807091209.13531-2-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/10] migration: do not wait for free
 thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, Xiao Guangrong <xiaoguangrong@tencent.com>

On 08/07/2018 04:12 AM, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Instead of putting the main thread to sleep state to wait for
> free compression thread, we can directly post it out as normal
> page that reduces the latency and uses CPUs more efficiently
> 
> A parameter, compress-wait-thread, is introduced, it can be
> enabled if the user really wants the old behavior
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---

> +++ b/qapi/migration.json
> @@ -462,6 +462,11 @@
>   # @compress-threads: Set compression thread count to be used in live migration,
>   #          the compression thread count is an integer between 1 and 255.
>   #
> +# @compress-wait-thread: Wait if no thread is free to compress the memory page
> +#          if it's enabled, otherwise, the page will be posted out immediately
> +#          in the main thread without compression. It's true on default.
> +#          (Since: 3.1)

Grammar suggestion:

@compress-wait-thread: Controls behavior when all compression threads 
are currently busy. If true (default), wait for a free compression 
thread to become available; otherwise, send the page uncompressed. 
(Since 3.1)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
