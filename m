Received: from eggs.gnu.org ([2001:4830:134:3::10]:48253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1eRdRj-0001oM-Ug
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 07:26:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1eRdRe-0000nt-R9
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 07:26:02 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:51415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1eRdRe-0000iM-Hz
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 07:25:58 -0500
Date: Wed, 20 Dec 2017 04:25:47 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20171220122547.GA1654@bombadil.infradead.org>
References: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com>
	<201712192305.AAE21882.MtQHJOFFSFVOLO@I-love.SAKURA.ne.jp>
	<5A3A3CBC.4030202@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A3A3CBC.4030202@intel.com>
Subject: Re: [Qemu-devel] [PATCH v20 0/7] Virtio-balloon Enhancement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On Wed, Dec 20, 2017 at 06:34:36PM +0800, Wei Wang wrote:
> On 12/19/2017 10:05 PM, Tetsuo Handa wrote:
> > I think xb_find_set() has a bug in !node path.
> 
> I think we can probably remove the "!node" path for now. It would be good to
> get the fundamental part in first, and leave optimization to come as
> separate patches with corresponding test cases in the future.

You can't remove the !node path.  You'll see !node when the highest set
bit is less than 1024.  So do something like this:

	unsigned long bit;
	xb_preload(GFP_KERNEL);
	xb_set_bit(xb, 700);
	xb_preload_end();
	bit = xb_find_set(xb, ULONG_MAX, 0);
	assert(bit == 700);
