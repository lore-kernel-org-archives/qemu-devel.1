Received: from eggs.gnu.org ([2001:4830:134:3::10]:43182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ee2gb-0007tP-MD
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 12:48:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ee2gY-0008D6-JS
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 12:48:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1ee2gY-0008BT-8e
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 12:48:38 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0NHlaCl037009
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 12:48:36 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fp780r4ps-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 12:48:36 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 23 Jan 2018 10:48:35 -0700
Date: Tue, 23 Jan 2018 15:48:28 -0200
From: joserz@linux.vnet.ibm.com
References: <20180123132021.27593-1-joserz@linux.vnet.ibm.com>
	<20180123172106-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180123172106-mutt-send-email-mst@kernel.org>
Message-Id: <20180123174828.GA22001@pacoca.br.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] Revert "virtio: postpone the execution of
 event_notifier_cleanup function"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: ghammer@redhat.com, pbonzini@redhat.com, danielhb@linux.vnet.ibm.com, qemu-devel@nongnu.org, anton@samba.org

On Tue, Jan 23, 2018 at 05:22:12PM +0200, Michael S. Tsirkin wrote:
> On Tue, Jan 23, 2018 at 11:20:21AM -0200, Jose Ricardo Ziviani wrote:
> > This reverts commit 4fe6d78b2e241f41208dfb07605aace4becfc747.
> > 
> > As reported http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg05457.html
> > The referred commit is causing regression issues in virtio.
> > 
> > Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> > Reported-by: Anton Blanchard <anton@samba.org>

Hello Michael,

> Can you limit the patch to virtio bus please?

Unfortunately it doesn't work. I made the change on virtio bus only but
the error persists. Actually the only way I found to fix it is by
reverting only the kvm_mem_ioeventfd_del() @ kvm-all.c, removing that
if (e->cleanup) code. I'm sending the V2.

thank you!!


> Maybe we want to drop the callback from the structure
> but we don't want it to be there and just be ignored
> I think.
> 
> > ---
> >  accel/kvm/kvm-all.c    |  4 ----
> >  hw/virtio/virtio-bus.c | 19 ++++++++-----------
> >  2 files changed, 8 insertions(+), 15 deletions(-)
> > 
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 071f4f57c0..f290f487a5 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -812,10 +812,6 @@ static void kvm_mem_ioeventfd_del(MemoryListener *listener,
> >      if (r < 0) {
> >          abort();
> >      }
> > -
> > -    if (e->cleanup) {
> > -        e->cleanup(e);
> > -    }
> >  }
> >  
> >  static void kvm_io_ioeventfd_add(MemoryListener *listener,
> > diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> > index 8106346927..3042232daf 100644
> > --- a/hw/virtio/virtio-bus.c
> > +++ b/hw/virtio/virtio-bus.c
> > @@ -256,15 +256,6 @@ bool virtio_bus_ioeventfd_enabled(VirtioBusState *bus)
> >      return k->ioeventfd_assign && k->ioeventfd_enabled(proxy);
> >  }
> >  
> > -static void virtio_bus_cleanup_event_notifier(EventNotifier *notifier)
> > -{
> > -    /* Test and clear notifier after disabling event,
> > -     * in case poll callback didn't have time to run.
> > -     */
> > -    virtio_queue_host_notifier_read(notifier);
> > -    event_notifier_cleanup(notifier);
> > -}
> > -
> >  /*
> >   * This function switches ioeventfd on/off in the device.
> >   * The caller must set or clear the handlers for the EventNotifier.
> > @@ -292,13 +283,19 @@ int virtio_bus_set_host_notifier(VirtioBusState *bus, int n, bool assign)
> >          r = k->ioeventfd_assign(proxy, notifier, n, true);
> >          if (r < 0) {
> >              error_report("%s: unable to assign ioeventfd: %d", __func__, r);
> > -            virtio_bus_cleanup_event_notifier(notifier);
> > +            goto cleanup_event_notifier;
> >          }
> > +        return 0;
> >      } else {
> > -        notifier->cleanup = virtio_bus_cleanup_event_notifier;
> >          k->ioeventfd_assign(proxy, notifier, n, false);
> >      }
> >  
> > +cleanup_event_notifier:
> > +    /* Test and clear notifier after disabling event,
> > +     * in case poll callback didn't have time to run.
> > +     */
> > +    virtio_queue_host_notifier_read(notifier);
> > +    event_notifier_cleanup(notifier);
> >      return r;
> >  }
> >  
> > -- 
> > 2.14.3
> 
