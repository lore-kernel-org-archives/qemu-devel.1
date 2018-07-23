Received: from eggs.gnu.org ([2001:4830:134:3::10]:58611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhXKX-0007vn-GL
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 05:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhXKU-0006dI-Cj
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 05:40:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55834 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fhXKU-0006cs-7v
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 05:40:34 -0400
Date: Mon, 23 Jul 2018 17:40:21 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180723094021.GN2491@xz-mi>
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
	<20180719121520.30026-7-xiaoguangrong@tencent.com>
	<20180723050325.GF2491@xz-mi>
	<d0e8afdb-dafb-709b-15d5-7b33c086d6c7@gmail.com>
	<20180723082838.GJ2491@xz-mi>
	<bf5df13e-5b2a-ab5e-4cef-9e417b40347c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf5df13e-5b2a-ab5e-4cef-9e417b40347c@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/8] migration: move handle of zero page
 to the thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Mon, Jul 23, 2018 at 04:44:49PM +0800, Xiao Guangrong wrote:

[...]

> > > 
> > > However, it is not safe to do ram_release_pages in the thread as it's
> > > not protected it multithreads. Fortunately, compression will be disabled
> > > if it switches to post-copy, so i preferred to keep current behavior and
> > > deferred to fix it after this patchset has been merged.
> > 
> > Do you mean ram_release_pages() is not thread-safe?  Why?  I didn't
> > notice it before but I feel like it is safe.
> 
> bitmap_clear() called in the function is not safe.

Yeah, and the funny thing is that I don't think ram_release_pages()
should even touch the receivedmap...  It's possible that the
release-ram feature for postcopy is broken.

Never mind on that.  I'll post a patch to fix it, then I think the
ram_release_pages() will be thread safe.

Then this patch shouldn't be affected and it should be fine after that
fix.

Regards,

-- 
Peter Xu
