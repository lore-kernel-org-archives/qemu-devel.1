Received: from eggs.gnu.org ([2001:4830:134:3::10]:45048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ewPSi-0006DJ-1a
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 05:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ewPSe-0006os-SK
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 05:46:16 -0400
Received: from 5.mo4.mail-out.ovh.net ([188.165.44.50]:35068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ewPSe-0006cZ-KV
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 05:46:12 -0400
Received: from player796.ha.ovh.net (unknown [10.109.122.194])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id E356215699C
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 10:46:03 +0100 (CET)
Date: Thu, 15 Mar 2018 10:45:57 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180315104557.541280bb@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <OFE3A7F910.3814D427-ON6525824A.001BEDE1-6525824A.001C48BE@notes.na.collabserv.com>
References: <152044905701.22965.8924520463227226351.stgit@bahia.lan>
	<OFE3A7F910.3814D427-ON6525824A.001BEDE1-6525824A.001C48BE@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio_net: flush uncompleted TX on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Nageswara R Sastry <nasastry@in.ibm.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

Ping ?

On Thu, 8 Mar 2018 10:38:56 +0530
"Nageswara R Sastry" <nasastry@in.ibm.com> wrote:

> Greg Kurz <groug@kaod.org> wrote on 08/03/2018 12:27:37 AM:
> 
> > From: Greg Kurz <groug@kaod.org>
> > To: qemu-devel@nongnu.org
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang 
> > <jasowang@redhat.com>, R Nageswara Sastry <nasastry@in.ibm.com>
> > Date: 08/03/2018 12:27 AM
> > Subject: [PATCH] virtio_net: flush uncompleted TX on reset
> > 
> > If the backend could not transmit a packet right away for some reason,
> > the packet is queued for asynchronous sending. The corresponding vq
> > element is tracked in the async_tx.elem field of the VirtIONetQueue,
> > for later freeing when the transmission is complete.
> > 
> > If a reset happens before completion, virtio_net_tx_complete() will push
> > async_tx.elem back to the guest anyway, and we end up with the inuse   
> flag
> > of the vq being equal to -1. The next call to virtqueue_pop() is then
> > likely to fail with "Virtqueue size exceeded".
> > 
> > This can be reproduced easily by starting a guest without a net backend,
> > doing a system reset when it is booted, and finally snapshotting it.
> > 
> > The appropriate fix is to ensure that such an asynchronous transmission
> > cannot survive a device reset. So for all queues, we first try to send
> > the packet again, and eventually we purge it if the backend still could
> > not deliver it.
> > 
> > Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>  
> 
> Tested-by: R. Nageswara Sastry <nasastry@in.ibm.com>
> 
> > Buglink: https://urldefense.proofpoint.com/v2/url?
> >   
> u=https-3A__github.com_open-2Dpower-2Dhost-2Dos_qemu_issues_37&d=DwICaQ&c=jf_iaSHvJObTbx-
> > siA1ZOg&r=mxAxqGE8eb0FlPPFjDZkTNaoci-GdQbkJayE4r-
> >   
> wzYY&m=hPoY6b601IXJbUV2uh22jBrnYuByNQpwi1d7gvN4yZs&s=Ic3NN3mM_Nv1gAJ7dY22-
> > ebnJsG7c0yNkbThX8Tu6xg&e=
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/net/virtio-net.c |   11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 188744e17d57..eea3cdb2c700 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -422,6 +422,7 @@ static RxFilterInfo 
> > *virtio_net_query_rxfilter(NetClientState *nc)
> >  static void virtio_net_reset(VirtIODevice *vdev)
> >  {
> >      VirtIONet *n = VIRTIO_NET(vdev);
> > +    int i;
> > 
> >      /* Reset back to compatibility mode */
> >      n->promisc = 1;
> > @@ -445,6 +446,16 @@ static void virtio_net_reset(VirtIODevice *vdev)
> >      memcpy(&n->mac[0], &n->nic->conf->macaddr, sizeof(n->mac));
> >      qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
> >      memset(n->vlans, 0, MAX_VLAN >> 3);
> > +
> > +    /* Flush any async TX */
> > +    for (i = 0;  i < n->max_queues; i++) {
> > +        NetClientState *nc = qemu_get_subqueue(n->nic, i);
> > +
> > +        if (!qemu_net_queue_flush(nc->peer->incoming_queue)) {
> > +            qemu_net_queue_purge(nc->peer->incoming_queue, nc);
> > +        }
> > +        assert(!virtio_net_get_subqueue(nc)->async_tx.elem);
> > +    }
> >  }
> > 
> >  static void peer_test_vnet_hdr(VirtIONet *n)
> >   
> 
> 
> With out patch:
> (qemu) system_reset
> (qemu) savevm 1
> Virtqueue size exceeded
> (qemu) loadvm 1
> VQ 1 size 0x100 < last_avail_idx 0x0 - used_idx 0x1
> Failed to load virtio-net:virtio
> error while loading state for instance 0x0 of device
> 'pci@800000020000000:00.0/virtio-net'
> Error -1 while loading VM state
> 
> With patch:
> (qemu) system_reset
> (qemu) savevm 1
> (qemu) loadvm 1
> 
> 
> 
> 
