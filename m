Received: from eggs.gnu.org ([2001:4830:134:3::10]:33922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f17bd-0000NM-En
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f17ba-0002Oc-64
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:42:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41318 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f17ba-0002OP-1O
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:42:54 -0400
Date: Wed, 28 Mar 2018 17:42:39 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180328094239.GF29554@xz-mi>
References: <20180327091043.30220-1-xiaoguangrong@tencent.com>
	<20180327091043.30220-4-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180327091043.30220-4-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/10] migration: stop decompression to
 allocate and free memory frequently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Tue, Mar 27, 2018 at 05:10:36PM +0800, guangrong.xiao@gmail.com wrote:

[...]

> +static int compress_threads_load_setup(void)
> +{
> +    int i, thread_count;
> +
> +    if (!migrate_use_compression()) {
> +        return 0;
> +    }
> +
> +    thread_count = migrate_decompress_threads();
> +    decompress_threads = g_new0(QemuThread, thread_count);
> +    decomp_param = g_new0(DecompressParam, thread_count);
> +    qemu_mutex_init(&decomp_done_lock);
> +    qemu_cond_init(&decomp_done_cond);
> +    for (i = 0; i < thread_count; i++) {
> +        if (inflateInit(&decomp_param[i].stream) != Z_OK) {
> +            goto exit;
> +        }
> +        decomp_param[i].stream.opaque = &decomp_param[i];

Same question as the encoding patch here, otherwise looks good to me.

Thanks,

-- 
Peter Xu
