Received: from eggs.gnu.org ([2001:4830:134:3::10]:40254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f6XLG-0000ES-8X
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f6XLC-0007q4-Vz
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:12:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:10047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1f6XLC-0007mZ-Ix
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:12:22 -0400
Date: Thu, 12 Apr 2018 16:10:14 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180412081014.l6umfz6hurczorl4@debian>
References: <20180411072027.5656-1-tiwei.bie@intel.com>
	<fc66437c-ae8c-15fa-c8d3-6aa6bdb22a36@redhat.com>
	<20180411083853.qa6y6zevjpvamrdx@debian>
	<20180411200127-mutt-send-email-mst@kernel.org>
	<20180412014439.d7uzqukwdejtmofh@debian>
	<0372329a-5106-e3ca-260a-8fe8aa5396b4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0372329a-5106-e3ca-260a-8fe8aa5396b4@redhat.com>
Subject: Re: [Qemu-devel] [RFC] vhost-user: introduce F_NEED_ALL_IOTLB
 protocol feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, peterx@redhat.com, qemu-devel@nongnu.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com

On Thu, Apr 12, 2018 at 03:38:50PM +0800, Jason Wang wrote:
> On 2018年04月12日 09:44, Tiwei Bie wrote:
> > On Wed, Apr 11, 2018 at 08:37:17PM +0300, Michael S. Tsirkin wrote:
> > > On Wed, Apr 11, 2018 at 04:38:53PM +0800, Tiwei Bie wrote:
> > > > On Wed, Apr 11, 2018 at 04:01:19PM +0800, Jason Wang wrote:
> > > > > On 2018年04月11日 15:20, Tiwei Bie wrote:
> > > > > > This patch introduces VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB
> > > > > > feature for vhost-user. By default, vhost-user backend needs
> > > > > > to query the IOTLBs from QEMU after meeting unknown IOVAs.
> > > > > > With this protocol feature negotiated, QEMU will provide all
> > > > > > the IOTLBs to vhost-user backend without waiting for the
> > > > > > queries from backend. This is helpful when using a hardware
> > > > > > accelerator which is not able to handle unknown IOVAs at the
> > > > > > vhost-user backend.
> > > > > > 
> > > > > > Signed-off-by: Tiwei Bie<tiwei.bie@intel.com>
> > > > > > ---
> > > > > > The idea of this patch is to let QEMU push all the IOTLBs
> > > > > > to vhost-user backend without waiting for the queries from
> > > > > > the backend. Because hardware accelerator at the vhost-user
> > > > > > backend may not be able to handle unknown IOVAs.
> > > > > > 
> > > > > > This is just a RFC for now. It seems that, it doesn't work
> > > > > > as expected when guest is using kernel driver (To handle
> > > > > > this case, it seems that some RAM regions' events also need
> > > > > > to be listened). Any comments would be appreciated! Thanks!
> > > > > Interesting, a quick question is why this is needed? Can we just use exist
> > > > > IOTLB update message?
> > > > Yeah, we are still using the existing IOTLB update messages
> > > > to send the IOTLB messages to backend. The only difference
> > > > is that, QEMU won't wait for the queries before sending the
> > > > IOTLB update messages.
> > > So I have a concern with that, in that without any flow
> > > control the socket buffer used by vhost-user might become
> > > full.
> > Each IOTLB update message needs a reply. So I think it
> > won't happen.
> 
> Is this what we've already done now? I don't find any statement on this in
> vhost-user.txt?
> 
> """
>  * VHOST_USER_IOTLB_MSG
> 
>       Id: 22
>       Equivalent ioctl: N/A (equivalent to VHOST_IOTLB_MSG message type)
>       Master payload: struct vhost_iotlb_msg
>       Slave payload: u64
> 
>       Send IOTLB messages with struct vhost_iotlb_msg as payload.
>       Master sends such requests to update and invalidate entries in the
> device
>       IOTLB. The slave has to acknowledge the request with sending zero as
> u64
>       payload for success, non-zero otherwise.
>       This request should be send only when VIRTIO_F_IOMMU_PLATFORM feature
>       has been successfully negotiated.
> """

Yeah, it's what we've already done now. It's in the above
statement you quoted:

"The slave has to acknowledge the request with sending zero as
u64 payload for success, non-zero otherwise."

> 
> And you probably need to modify the following statement:
> 
> """
> The master isn't expected to take the initiative to send IOTLB update
> messages,
> as the slave sends IOTLB miss messages for the guest virtual memory areas it
> needs to access.
> """

Yeah, you're right. Thanks! This statement needs some minor updates.

Best regards,
Tiwei Bie

> 
> Thanks
> 
> 
> > 
> > Best regards,
> > Tiwei Bie
> > 
> 
