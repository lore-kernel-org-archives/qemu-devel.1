Received: from eggs.gnu.org ([2001:4830:134:3::10]:59825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f17LG-0003OA-1a
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f17LB-000418-Uc
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:26:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40260 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f17LB-00040y-P7
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:25:57 -0400
Date: Wed, 28 Mar 2018 17:25:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180328092544.GE29554@xz-mi>
References: <20180327091043.30220-1-xiaoguangrong@tencent.com>
	<20180327091043.30220-3-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180327091043.30220-3-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/10] migration: stop compression to
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

On Tue, Mar 27, 2018 at 05:10:35PM +0800, guangrong.xiao@gmail.com wrote:

[...]

> @@ -357,10 +358,20 @@ static void compress_threads_save_cleanup(void)
>      terminate_compression_threads();
>      thread_count = migrate_compress_threads();
>      for (i = 0; i < thread_count; i++) {
> +        /*
> +         * stream.opaque can be used to store private data, we use it
> +         * as a indicator which shows if the thread is properly init'd
> +         * or not
> +         */
> +        if (!comp_param[i].stream.opaque) {
> +            break;
> +        }

How about using comp_param[i].file?  The opaque seems to be hiding
deeper, and...

>          qemu_thread_join(compress_threads + i);
>          qemu_fclose(comp_param[i].file);
>          qemu_mutex_destroy(&comp_param[i].mutex);
>          qemu_cond_destroy(&comp_param[i].cond);
> +        deflateEnd(&comp_param[i].stream);
> +        comp_param[i].stream.opaque = NULL;
>      }
>      qemu_mutex_destroy(&comp_done_lock);
>      qemu_cond_destroy(&comp_done_cond);
> @@ -370,12 +381,12 @@ static void compress_threads_save_cleanup(void)
>      comp_param = NULL;
>  }
>  
> -static void compress_threads_save_setup(void)
> +static int compress_threads_save_setup(void)
>  {
>      int i, thread_count;
>  
>      if (!migrate_use_compression()) {
> -        return;
> +        return 0;
>      }
>      thread_count = migrate_compress_threads();
>      compress_threads = g_new0(QemuThread, thread_count);
> @@ -383,6 +394,12 @@ static void compress_threads_save_setup(void)
>      qemu_cond_init(&comp_done_cond);
>      qemu_mutex_init(&comp_done_lock);
>      for (i = 0; i < thread_count; i++) {
> +        if (deflateInit(&comp_param[i].stream,
> +                           migrate_compress_level()) != Z_OK) {

(indent issue)

> +            goto exit;
> +        }
> +        comp_param[i].stream.opaque = &comp_param[i];

...here from document:

        ZEXTERN int ZEXPORT deflateInit OF((z_streamp strm, int level));

        Initializes the internal stream state for compression. The
        fields zalloc, zfree and opaque must be initialized before by
        the caller. If zalloc and zfree are set to Z_NULL, deflateInit
        updates them to use default allocation functions.

So shall we init opaque first?  Otherwise looks good to me.

> +
>          /* comp_param[i].file is just used as a dummy buffer to save data,
>           * set its ops to empty.
>           */

Thanks,

-- 
Peter Xu
