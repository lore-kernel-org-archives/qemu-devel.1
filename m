Received: from eggs.gnu.org ([2001:4830:134:3::10]:48202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eP7Y1-0001jM-Pc
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 08:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eP7Xw-0004oJ-Sw
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 08:58:09 -0500
Received: from 1.mo4.mail-out.ovh.net ([178.33.248.196]:34511)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eP7Xw-0004eE-M0
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 08:58:04 -0500
Received: from player694.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 90DA5117CB6
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 14:57:53 +0100 (CET)
Date: Wed, 13 Dec 2017 14:57:47 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171213145747.47832f65@bahia.lan>
In-Reply-To: <alpine.DEB.2.10.1712121508370.8052@sstabellini-ThinkPad-X260>
References: <20171204203619.GA16349@juliacomputing.com>
	<20171207180424.4592e144@bahia.lan>
	<20171208075740.7f87a491@bahia.lan>
	<alpine.DEB.2.10.1712121508370.8052@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] 9pfs: Correctly handle cancelled
 requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Keno Fischer <keno@juliacomputing.com>, stefano@aporeto.com, qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com

On Tue, 12 Dec 2017 15:14:06 -0800 (PST)
Stefano Stabellini <sstabellini@kernel.org> wrote:

> On Fri, 8 Dec 2017, Greg Kurz wrote:
> > Cc'ing Stefano using a more appropriate address :)  
> 
> Thanks Greg for the ping, one comment inline below.
> 
[...]
> 
> I think we also need to:
> 
>     /* this is required to consume the request */
>     ring->intf->out_cons = ring->out_cons;
>     xen_wmb();
> 
>     /* this is required to complete the cancellation of the pdu operation */
>     ring->inprogress = false;
> 
>     /* this is required to let the other end know that there is more
>      * space on the ring available */
>     xenevtchn_notify(ring->evtchndev, ring->local_port);
> 

That makes me think that we should also probably notify the guest with
virtio since this isn't a reset... :)

>     /* trigger the read of the next request */
>     qemu_bh_schedule(ring->bh);
> 
> 
> Which is basically almost everything else from xen_9pfs_push_and_notify,
> except the modification of in_prod, because we are not going to write
> back anything to the ring.
> 

... in which case, the same statement stands for virtio_9pfs_push_and_notify()

We should probably unify push_and_notify and discard into a single operation:

-    void        (*push_and_notify)(V9fsPDU *pdu);
+    void        (*return_to_guest)(V9fsPDU *pdu, bool discard);

Let's do this in a separate patch, and respin this fix on top.

> 
> 
> > > > +}
> > > > +
> > > >  static const struct V9fsTransport xen_9p_transport = {
> > > >      .pdu_vmarshal = xen_9pfs_pdu_vmarshal,
> > > >      .pdu_vunmarshal = xen_9pfs_pdu_vunmarshal,
> > > >      .init_in_iov_from_pdu = xen_9pfs_init_in_iov_from_pdu,
> > > >      .init_out_iov_from_pdu = xen_9pfs_init_out_iov_from_pdu,
> > > >      .push_and_notify = xen_9pfs_push_and_notify,
> > > > +    .discard = xen_9pfs_discard,
> > > >  };
> > > >  
> > > >  static int xen_9pfs_init(struct XenDevice *xendev)    
> 
