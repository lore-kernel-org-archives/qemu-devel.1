Received: from eggs.gnu.org ([2001:4830:134:3::10]:44321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIRtw-0008BZ-OH
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIRtt-0004Z3-Lt
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:44:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dIRtt-0004WY-GH
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:44:53 -0400
Date: Wed, 7 Jun 2017 11:44:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170607034443.GA7983@pxdev.xzpeter.org>
References: <1496404254-17429-1-git-send-email-peterx@redhat.com>
	<1496404254-17429-3-git-send-email-peterx@redhat.com>
	<20170602194523-mutt-send-email-mst@kernel.org>
	<20170605030725.GF4056@pxdev.xzpeter.org>
	<f68502e6-875c-0e46-f7cf-127c23513d20@redhat.com>
	<20170606234705.GG13397@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170606234705.GG13397@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH 2/3] exec: simplify
 address_space_get_iotlb_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>

On Wed, Jun 07, 2017 at 09:47:05AM +1000, David Gibson wrote:
> On Tue, Jun 06, 2017 at 04:34:30PM +0200, Paolo Bonzini wrote:
> > 
> > 
> > On 05/06/2017 05:07, Peter Xu wrote:
> > > I don't sure whether it'll be a good interface for IOTLB. AFAIU at
> > > least for VT-d, the IOMMU translation is page aligned which is defined
> > > by spec, so it makes sense that (again at least for VT-d) here we'd
> > > better just use page_mask/addr_mask.
> > > 
> > > That's also how I know about IOMMU in general - I assume it do the
> > > translations always with page masks (never arbitary length), though
> > > page size can differ from platfrom to platform, that's why here the
> > > IOTLB interface used addr_mask, then it works for all platforms. I
> > > don't know whether I'm 100% correct here though.
> > > 
> > > Maybe David/Paolo/... would comment as well?
> > 
> > I would ask David.  There are PowerPC MMUs that allow fast lookup of
> > arbitrarily-sized windows (not necessarily power of two),
> 
> Uh.. I'm not sure what you mean here.  You might be thinking of the
> BATs which really old (32-bit) PowerPC MMUs had - those allow
> arbitrary large block translations, but they do have to be a power of
> two.
> 
> > so maybe the
> > IOMMUs can do the same.
> 
> The only Power IOMMU I know about uses a fixed, power-of-two page size
> per DMA window.

If so, I would still be inclined to keep using masks for QEMU IOTLB.
Then, my first two patches should still stand.

I am just afraid that not using masks will diverge the emulation from
real hardware and brings trouble one day.

For vhost IOTLB interface, it does not need to be strictly aligned to
QEMU IOMMU IOTLB definition, and that's how it's working now (current
vhost iotlb allows arbitary length, and I think it's good). So imho we
don't really need to worry about the performance - after all, we can
do everything customized for vhost, just like what patch 3 did (yeah,
it can be better...).

Thanks,

-- 
Peter Xu
