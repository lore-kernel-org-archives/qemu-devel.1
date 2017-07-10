Received: from eggs.gnu.org ([2001:4830:134:3::10]:45814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUX11-00044G-97
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUX0x-0003q7-8w
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:38:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dUX0w-0003pb-VU
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:38:07 -0400
Date: Mon, 10 Jul 2017 13:38:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170710133800.339857f2@dhcp-192-215.str.redhat.com>
In-Reply-To: <946e7983-15ad-08fe-41c5-6913113a3cd3@redhat.com>
References: <1499423224-23060-1-git-send-email-thuth@redhat.com>
	<1499423224-23060-8-git-send-email-thuth@redhat.com>
	<20170707143736.08062610@dhcp-192-215.str.redhat.com>
	<946e7983-15ad-08fe-41c5-6913113a3cd3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 7/8] pc-bios/s390-ccw: Add
 virtio-net driver code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On Mon, 10 Jul 2017 13:23:07 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 07.07.2017 14:37, Cornelia Huck wrote:
> > On Fri,  7 Jul 2017 12:27:03 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> The driver provides the recv() and send() functions which will
> >> be required by SLOF's libnet code for receiving and sending
> >> packets.  
> [...]
> >> +int virtio_net_init(void *mac_addr)
> >> +{
> >> +    VDev *vdev = virtio_get_device();
> >> +    VRing *rxvq = &vdev->vrings[VQ_RX];
> >> +    void *buf;
> >> +    int i;
> >> +
> >> +    virtio_setup_ccw(vdev);
> >> +
> >> +    memcpy(mac_addr, vdev->config.net.mac, ETH_ALEN);  
> > 
> > The mac address in the config space is only valid if the mac feature
> > flag has been negotiated (although the field always exists).  
> 
> QEMU seems to always set it ... but yes, let's better negotiate
> VIRTIO_NET_F_MAC here.

Ah, feature negotiation in the bios, nice :)

> 
> >> +
> >> +    for (i = 0; i < 64; i++) {
> >> +        buf = malloc(ETH_MTU_SIZE + sizeof(VirtioNetHdr));
> >> +        IPL_assert(buf != NULL, "Can not allocate memory for receive buffers");
> >> +        vring_send_buf(rxvq, buf, ETH_MTU_SIZE + sizeof(VirtioNetHdr),
> >> +                       VRING_DESC_F_WRITE);
> >> +    }
> >> +    vring_notify(rxvq);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +int send(int fd, const void *buf, int len, int flags)
> >> +{
> >> +    VirtioNetHdr tx_hdr;
> >> +    VDev *vdev = virtio_get_device();
> >> +    VRing *txvq = &vdev->vrings[VQ_TX];
> >> +
> >> +    /* Set up header - we do not use anything special, so simply clear it */
> >> +    memset(&tx_hdr, 0, sizeof(tx_hdr));
> >> +
> >> +    vring_send_buf(txvq, &tx_hdr, sizeof(tx_hdr), VRING_DESC_F_NEXT);
> >> +    vring_send_buf(txvq, (void *)buf, len, VRING_HIDDEN_IS_CHAIN);
> >> +    while (!vr_poll(txvq)) {
> >> +        yield();
> >> +    }
> >> +    if (drain_irqs(txvq->schid)) {
> >> +        puts("send: drain irqs failed");
> >> +        return -1;  
> > 
> > Does the caller try again later? drain_irqs() errors may be transient.  
> 
> Yes, the TFTP code retries to send packets after a certain amount of
> time (since the packets could also be lost in the network somewhere).

Sounds good. (Not that I expect many errors in drain_irqs()...)
