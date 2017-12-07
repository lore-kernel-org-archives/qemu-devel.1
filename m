Received: from eggs.gnu.org ([2001:4830:134:3::10]:44371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eMyIo-0006Ue-UO
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eMyIl-0001fs-SH
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:41:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eMyIl-0001el-LT
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:41:31 -0500
Date: Thu, 7 Dec 2017 17:41:18 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171207174055-mutt-send-email-mst@kernel.org>
References: <201711301934.CDC21800.FSLtJFFOOVQHMO@I-love.SAKURA.ne.jp>
	<5A210C96.8050208@intel.com>
	<201712012202.BDE13557.MJFQLtOOHVOFSF@I-love.SAKURA.ne.jp>
	<286AC319A985734F985F78AFA26841F739376DA1@shsmsx102.ccr.corp.intel.com>
	<20171201172519.GA27192@bombadil.infradead.org>
	<201712031050.IAC64520.QVLFFOOJOSFtHM@I-love.SAKURA.ne.jp>
	<5A292D94.5000700@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A292D94.5000700@intel.com>
Subject: Re: [Qemu-devel] [PATCH v18 05/10] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, willy@infradead.org, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

On Thu, Dec 07, 2017 at 08:01:24PM +0800, Wei Wang wrote:
> On 12/03/2017 09:50 AM, Tetsuo Handa wrote:
> > Matthew Wilcox wrote:
> > > On Fri, Dec 01, 2017 at 03:09:08PM +0000, Wang, Wei W wrote:
> > > > On Friday, December 1, 2017 9:02 PM, Tetsuo Handa wrote:
> > > > > If start == end is legal,
> > > > > 
> > > > >     for (; start < end; start = (start | (IDA_BITMAP_BITS - 1)) + 1) {
> > > > > 
> > > > > makes this loop do nothing because 10 < 10 is false.
> > > > How about "start <= end "?
> > > Don't ask Tetsuo for his opinion, write some userspace code that uses it.
> > > 
> > Please be sure to prepare for "end == -1UL" case, for "start < end" will become
> > true when "start = (start | (IDA_BITMAP_BITS - 1)) + 1" made "start == 0" due to
> > overflow.
> 
> I think there is one more corner case with this API: searching for bit "1"
> from [0, ULONG_MAX] while no bit is set in the range, there appear to be no
> possible value that we can return (returning "end + 1" will be "ULONG_MAX +
> 1", which is 0)
> I plan to make the "end" be exclusive of the searching, that is, [start,
> end), and return "end" if no such bit is found.
> 
> For cases like [16, 16), returning 16 doesn't mean bit 16 is 1 or 0, it
> simply means there is no bits to search in the given range, since 16 is
> exclusive.
> 
> Please let me know if you have a different thought.
> 
> Best,
> Wei

Matthew is right though - you want to include tests for all
these corner cases.
