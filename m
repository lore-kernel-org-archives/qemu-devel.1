Received: from eggs.gnu.org ([2001:4830:134:3::10]:52911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1exsQq-0006p9-Lf
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 06:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1exsQn-0002A9-JM
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 06:54:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57138 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1exsQn-00028Q-En
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 06:54:21 -0400
Date: Mon, 19 Mar 2018 10:54:06 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180319105405.GB3206@work-vm>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-3-xiaoguangrong@tencent.com>
	<20180315110350.GB3062@work-vm>
	<41a1b36c-2bb6-bc11-f59e-973e730d8c28@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a1b36c-2bb6-bc11-f59e-973e730d8c28@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/8] migration: stop allocating and freeing
 memory frequently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: quintela@redhat.com, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

* Xiao Guangrong (guangrong.xiao@gmail.com) wrote:
> 
> 
> On 03/15/2018 07:03 PM, Dr. David Alan Gilbert wrote:
> 
> > > +static int compress_threads_load_setup(void)
> > > +{
> > > +    int i, thread_count;
> > > +
> > > +    if (!migrate_use_compression()) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    thread_count = migrate_decompress_threads();
> > > +    decompress_threads = g_new0(QemuThread, thread_count);
> > > +    decomp_param = g_new0(DecompressParam, thread_count);
> > > +    qemu_mutex_init(&decomp_done_lock);
> > > +    qemu_cond_init(&decomp_done_cond);
> > > +    for (i = 0; i < thread_count; i++) {
> > > +        if (inflateInit(&decomp_param[i].stream) != Z_OK) {
> > > +            goto exit;
> > > +        }
> > > +        decomp_param[i].stream.opaque = &decomp_param[i];
> > > +
> > > +        qemu_mutex_init(&decomp_param[i].mutex);
> > > +        qemu_cond_init(&decomp_param[i].cond);
> > > +        decomp_param[i].compbuf = g_malloc0(compressBound(TARGET_PAGE_SIZE));
> > > +        decomp_param[i].done = true;
> > > +        decomp_param[i].quit = false;
> > > +        qemu_thread_create(decompress_threads + i, "decompress",
> > > +                           do_data_decompress, decomp_param + i,
> > > +                           QEMU_THREAD_JOINABLE);
> > > +    }
> > > +    return 0;
> > > +exit:
> > > +    compress_threads_load_cleanup();
> > 
> > I don't think this is safe; if inflateInit(..) fails in not-the-last
> > thread, compress_threads_load_cleanup() will try and destroy all the
> > mutex's and condition variables, even though they've not yet all been
> > _init'd.
> > 
> 
> That is exactly why we used 'opaque', please see more below...
> 
> > However, other than that I think the patch is OK; a chat with Dan
> > Berrange has convinced me this probably doesn't affect the stream
> > format, so that's OK.
> > 
> > One thing I would like is a comment as to how the 'opaque' field is
> > being used; I don't think I quite understand what you're doing there.
> 
> The zlib.h file says that:
> "     The opaque value provided by the application will be passed as the first
>    parameter for calls of zalloc and zfree.  This can be useful for custom
>    memory management.  The compression library attaches no meaning to the
>    opaque value."
> So we can use it to store our private data.
> 
> Here, we use it as a indicator which shows if the thread is properly init'd
> or not. If inflateInit() is successful we will set it to non-NULL, otherwise
> it is NULL, so that the cleanup path can figure out the first thread failed
> to do inflateInit().

OK, so I think you just need to add a comment to explain that. Put it
above the 'if (!decomp_param[i].stream.opaque) {' in
compress_threads_load_cleanup  so it'll be easy to understand.

Dave

> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
