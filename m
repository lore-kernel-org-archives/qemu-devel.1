Received: from eggs.gnu.org ([2001:4830:134:3::10]:49800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fduAe-0005UM-GP
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 05:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fduAd-0007oO-D6
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 05:15:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fduAd-0007nf-6a
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 05:15:23 -0400
Date: Fri, 13 Jul 2018 11:15:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180713111517.70462e8b.cohuck@redhat.com>
In-Reply-To: <77823ff9-a02a-808b-e919-b4950a64ae3c@intel.com>
References: <20180703095825.GC30904@rkaganb.sw.ru>
	<d5db37d0-5eaf-8942-8ab7-d73057a67e6f@oracle.com>
	<20180709130035.GA6271@rkaganb.sw.ru>
	<9136094e-a510-4201-7c71-d1c49226fa5f@oracle.com>
	<20180710045101-mutt-send-email-mst@kernel.org>
	<CADGSJ20H1S88S6AsYoLMns3XH+YVKh006Dqu808X7Ug+2Mgdnw@mail.gmail.com>
	<20180711115344.633eba9e.cohuck@redhat.com>
	<CADGSJ20A=sbwQQ-_YQEVwoCXwTvosCEnD2iKa0kS6ZGvbgy4rg@mail.gmail.com>
	<20180712133121.3b5f2bae.cohuck@redhat.com>
	<CADGSJ214vdTGC=-hj9pMOTqQNcZ0NaYu_r4cy2=2BB4CausWdw@mail.gmail.com>
	<20180712235500-mutt-send-email-mst@kernel.org>
	<CADGSJ23c4hHAoAwG61xmrRd-OO6EpsHgH9Fd-9R69XQAVkduCA@mail.gmail.com>
	<77823ff9-a02a-808b-e919-b4950a64ae3c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v3 0/3] Use of unique
 identifier for pairing virtio and passthrough devices...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Siwei Liu <loseweigh@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, si-wei liu <si-wei.liu@oracle.com>, Roman Kagan <rkagan@virtuozzo.com>, Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, Alexander Duyck <alexander.h.duyck@intel.com>, Netdev <netdev@vger.kernel.org>

On Thu, 12 Jul 2018 21:20:41 -0400
"Samudrala, Sridhar" <sridhar.samudrala@intel.com> wrote:

> On 7/12/2018 6:19 PM, Siwei Liu wrote:
> > On Thu, Jul 12, 2018 at 2:00 PM, Michael S. Tsirkin <mst@redhat.com> wrote:  
> >> On Thu, Jul 12, 2018 at 01:52:53PM -0700, Siwei Liu wrote:  
> >>> The definition is incomplete due to lack of spec. There's no "host"
> >>> part defined yet in the host-guest interface. If match by MAC is an
> >>> interface, the same must be done on the host(device) side as well,
> >>> which has been agreed not the way to go. However, I don't think that's
> >>> what the author intends to do by interpreting his QEMU patch - it
> >>> missed the other parts as well, such as the feature negotiation and
> >>> how it interacts with the paired device.
> >>>
> >>> What I said is that match by MAC is just a guest implementation that
> >>> one can change at any time. We now have the group ID on QEMU, why
> >>> still sticking to matching by MAC? It shoulnd't be a host-guest
> >>> interface in the first place anyway.  
> >> I think that match by MAC is a simple portable way to match devices.
> >> E.g. it will work seamlessly with niche things like zPCI. However  
> > That's a good point. I'm not sure if it's a valid assumption that zPCI
> > should always use the same MAC address as that of virtio. Someone

I think we can mostly disregard the weirdness that is zPCI right now.
There should be no fundamental reasons that matching by MAC would not
work, though.

> > who's more familiar with the use case may decide and work on that. It
> > means VFIO device has to take in the MAC address as an identifier to
> > the "-device vfio-pci,.." QEMU option. I think there's no point to
> > match device using group ID in QEMU while using MAC in the guest.
> > Based on that assumption, I'd go with making VIRTIO_NET_F_STANDBY to
> > match device based on group ID, while someone may come up with another
> > feature bit later, say VIRTIO_NET_F_STANDBY_BY_MAC when its QEMU
> > support is available. Would it make sense?  
> 
> VIRTIO_NET_F_STANDBY as defined in the guest virtio_net driver supports match
> by MAC address. I think we should add support for this feature bit in QEMU.
> If submitting a patch to update the spec is a pre-requisite to add this
> feature bit to QEMU, i can do that.

Doing a spec patch and implementing matching by MAC in QEMU sounds like
a good plan to me.

> 
> As far as i understand, group id patches to QEMU are still under review.
> Matching by group ID can be another feature bit that could support matching
> by group id as well as MAC.

That plan sounds good to me as well.
