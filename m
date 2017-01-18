Received: from eggs.gnu.org ([2001:4830:134:3::10]:58935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTsKC-0005OW-R9
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:39:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTsK9-0003xv-PK
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:39:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cTsK9-0003xg-JX
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:38:57 -0500
Date: Wed, 18 Jan 2017 17:38:53 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170118173139-mutt-send-email-mst@kernel.org>
References: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
	<2a32f616-25a8-ba5a-f74c-d619fc8ab333@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a32f616-25a8-ba5a-f74c-d619fc8ab333@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 kernel 0/5] Extend virtio-balloon for
 fast (de)inflating & fast live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Liang Li <liang.z.li@intel.com>, kvm@vger.kernel.org, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, amit.shah@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, aarcange@redhat.com, dgilbert@redhat.com, quintela@redhat.com

On Wed, Jan 18, 2017 at 11:09:30AM +0100, David Hildenbrand wrote:
> Am 21.12.2016 um 07:52 schrieb Liang Li:
> > This patch set contains two parts of changes to the virtio-balloon.
> > 
> > One is the change for speeding up the inflating & deflating process,
> > the main idea of this optimization is to use {pfn|length} to present
> > the page information instead of the PFNs, to reduce the overhead of
> > virtio data transmission, address translation and madvise(). This can
> > help to improve the performance by about 85%.
> > 
> > Another change is for speeding up live migration. By skipping process
> > guest's unused pages in the first round of data copy, to reduce needless
> > data processing, this can help to save quite a lot of CPU cycles and
> > network bandwidth. We put guest's unused page information in a
> > {pfn|length} array and send it to host with the virt queue of
> > virtio-balloon. For an idle guest with 8GB RAM, this can help to shorten
> > the total live migration time from 2Sec to about 500ms in 10Gbps network
> > environment. For an guest with quite a lot of page cache and with little
> > unused pages, it's possible to let the guest drop it's page cache before
> > live migration, this case can benefit from this new feature too.
> 
> I agree that both changes make sense (although the second change just smells
> very racy, as you also pointed out in the patch description),
> however I am not sure if virtio-balloon is really the right place for
> the latter change.
> 
> virtio-balloon is all about ballooning, nothing else. What you're doing
> is using it as a way to communicate balloon-unrelated data from/to the
> hypervisor. Yes, it is also about guest memory, but completely unrelated
> to the purpose of the balloon device.
> 
> Maybe using virtio-balloon for this purpose is okay - I have mixed
> feelings (especially as I can't tell where else this could go). I would
> like to get a second opinion on this.

As long as the interface is similar, it seems to make
sense for me - why invent a completely new device that
looks very much like the old one?

So this boils down to whether the speedup patches are merged.


> -- 
> 
> David
