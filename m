Received: from eggs.gnu.org ([2001:4830:134:3::10]:59924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f1OxZ-0002ct-LI
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 00:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f1OxW-0004J2-Fu
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 00:14:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54392 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f1OxW-0004In-B4
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 00:14:42 -0400
Date: Thu, 29 Mar 2018 12:14:30 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180329041430.GB8456@xz-mi>
References: <20180327091043.30220-1-xiaoguangrong@tencent.com>
	<20180327091043.30220-4-xiaoguangrong@tencent.com>
	<20180328094239.GF29554@xz-mi>
	<ac8c2b63-90b8-11bb-f221-15fe190a89a1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac8c2b63-90b8-11bb-f221-15fe190a89a1@gmail.com>
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
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Thu, Mar 29, 2018 at 11:43:07AM +0800, Xiao Guangrong wrote:
> 
> 
> On 03/28/2018 05:42 PM, Peter Xu wrote:
> > On Tue, Mar 27, 2018 at 05:10:36PM +0800, guangrong.xiao@gmail.com wrote:
> > 
> > [...]
> > 
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
> > 
> > Same question as the encoding patch here, otherwise looks good to me.
> 
> Thanks for you pointed out, will fix.
> 
> Hmm, can i treat it as your Reviewed-by for the next version?

Yes :), as long as we drop the usage of zstream.opaque and use any
existing fields.

And also for the previous patch too, since they are mostly the same.

Thanks,

-- 
Peter Xu
