Received: from eggs.gnu.org ([2001:4830:134:3::10]:56292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dNeku-0001Op-M6
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dNekq-0002e2-Pv
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:29:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dNekq-0002dn-JV
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:29:04 -0400
Date: Wed, 21 Jun 2017 15:28:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170621151922-mutt-send-email-mst@kernel.org>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-7-git-send-email-wei.w.wang@intel.com>
	<20170620190343-mutt-send-email-mst@kernel.org>
	<5949E7C0.3050106@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5949E7C0.3050106@intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v11 6/6] virtio-balloon:
 VIRTIO_BALLOON_F_CMD_VQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, riel@redhat.com, nilal@redhat.com

On Wed, Jun 21, 2017 at 11:28:00AM +0800, Wei Wang wrote:
> On 06/21/2017 12:18 AM, Michael S. Tsirkin wrote:
> > On Fri, Jun 09, 2017 at 06:41:41PM +0800, Wei Wang wrote:
> > > -	if (!virtqueue_indirect_desc_table_add(vq, desc, num)) {
> > > +	if (!virtqueue_indirect_desc_table_add(vq, desc, *num)) {
> > >   		virtqueue_kick(vq);
> > > -		wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> > > -		vb->balloon_page_chunk.chunk_num = 0;
> > > +		if (busy_wait)
> > > +			while (!virtqueue_get_buf(vq, &len) &&
> > > +			       !virtqueue_is_broken(vq))
> > > +				cpu_relax();
> > > +		else
> > > +			wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> > 
> > This is something I didn't previously notice.
> > As you always keep a single buffer in flight, you do not
> > really need indirect at all. Just add all descriptors
> > in the ring directly, then kick.
> > 
> > E.g.
> > 	virtqueue_add_first
> > 	virtqueue_add_next
> > 	virtqueue_add_last
> > 
> > ?
> > 
> > You also want a flag to avoid allocations but there's no need to do it
> > per descriptor, set it on vq.
> > 
> 
> Without using the indirect table, I'm thinking about changing to use
> the standard sg (i.e. struct scatterlist), instead of vring_desc, so that
> we don't need to modify or add any new functions of virtqueue_add().
> 
> In this case, we will kmalloc an array of sgs in probe(), and we can add
> the sgs one by one to the vq, which won't trigger the allocation of an
> indirect table inside virtqueue_add(), and then kick when all are added.
> 
> Best,
> Wei

And allocate headers too? This can work. API extensions aren't
necessarily a bad idea though. The API I suggest above is preferable
for the simple reason that it can work without INDIRECT flag
support in hypervisor.

I wonder which APIs would Nitesh find useful.

-- 
MST
