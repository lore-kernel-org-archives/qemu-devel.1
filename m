Received: from eggs.gnu.org ([2001:4830:134:3::10]:43428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f2qCP-00050Z-N0
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 23:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f2qCM-0001bW-Js
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 23:32:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50502 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f2qCM-0001aF-Ef
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 23:31:58 -0400
Date: Mon, 2 Apr 2018 12:26:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180402042633.GA26441@xz-mi>
References: <20180327091043.30220-1-xiaoguangrong@tencent.com>
	<20180327091043.30220-5-xiaoguangrong@tencent.com>
	<20180328095952.GG29554@xz-mi>
	<c3c7cf6e-709b-64ee-a090-741d9633114d@gmail.com>
	<20180329042510.GC8456@xz-mi>
	<e92d75bc-8f53-039b-f4ac-04eb94e54bd1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e92d75bc-8f53-039b-f4ac-04eb94e54bd1@gmail.com>
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
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Fri, Mar 30, 2018 at 11:11:27AM +0800, Xiao Guangrong wrote:
> 
> 
> On 03/29/2018 12:25 PM, Peter Xu wrote:
> > On Thu, Mar 29, 2018 at 11:51:03AM +0800, Xiao Guangrong wrote:
> > > 
> > > 
> > > On 03/28/2018 05:59 PM, Peter Xu wrote:
> > > > On Tue, Mar 27, 2018 at 05:10:37PM +0800, guangrong.xiao@gmail.com wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > -static int compress_threads_load_setup(void)
> > > > > +static int compress_threads_load_setup(QEMUFile *f)
> > > > >    {
> > > > >        int i, thread_count;
> > > > > @@ -2665,6 +2685,7 @@ static int compress_threads_load_setup(void)
> > > > >            }
> > > > >            decomp_param[i].stream.opaque = &decomp_param[i];
> > > > > +        decomp_param[i].file = f;
> > > > 
> > > > On the source side the error will be set via:
> > > > 
> > > >           qemu_file_set_error(migrate_get_current()->to_dst_file, blen);
> > > > 
> > > > Maybe we can do similar things using migrate_incoming_get_current() to
> > > > avoid caching the QEMUFile multiple times?
> > > > 
> > > 
> > > I have considered it, however, it can not work as the @file used by ram
> > > loader is not the file got from migrate_incoming_get_current() under some
> > > cases.
> > > 
> > > For example, in colo_process_incoming_thread(), the file passed to
> > > qemu_loadvm_state() is a internal buffer and it is not easy to switch it
> > > to incoming file.
> > 
> > I see. How about cache it in a global variable?  We have these
> > already:
> > 
> >      thread_count = migrate_decompress_threads();
> >      decompress_threads = g_new0(QemuThread, thread_count);
> >      decomp_param = g_new0(DecompressParam, thread_count);
> >      ...
> > 
> > IMHO we can add a new one too, at least we don't cache it multiple
> > times (after all decomp_param[i]s are global variables too).
> > 
> 
> Nice, that's good to me. Will add your Reviewed-by on this patch
> as well if you do not mind. :)

Yes, please. :)

Thanks,

-- 
Peter Xu
