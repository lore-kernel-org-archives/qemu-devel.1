Received: from eggs.gnu.org ([2001:4830:134:3::10]:37005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f17sK-0006C0-LH
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 06:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f17sD-00017a-03
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 06:00:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58720 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f17sC-00017S-R6
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 06:00:04 -0400
Date: Wed, 28 Mar 2018 17:59:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180328095952.GG29554@xz-mi>
References: <20180327091043.30220-1-xiaoguangrong@tencent.com>
	<20180327091043.30220-5-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180327091043.30220-5-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/10] migration: detect compression and
 decompression errors
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

On Tue, Mar 27, 2018 at 05:10:37PM +0800, guangrong.xiao@gmail.com wrote:

[...]

> -static int compress_threads_load_setup(void)
> +static int compress_threads_load_setup(QEMUFile *f)
>  {
>      int i, thread_count;
>  
> @@ -2665,6 +2685,7 @@ static int compress_threads_load_setup(void)
>          }
>          decomp_param[i].stream.opaque = &decomp_param[i];
>  
> +        decomp_param[i].file = f;

On the source side the error will be set via:

        qemu_file_set_error(migrate_get_current()->to_dst_file, blen);

Maybe we can do similar things using migrate_incoming_get_current() to
avoid caching the QEMUFile multiple times?

I think both are not good since qemu_file_set_error() can be called by
multiple threads, but it's only setting a fault value so maybe it's
fine.  Other than that it looks good to me.

Thanks,

-- 
Peter Xu
