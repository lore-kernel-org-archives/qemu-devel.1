Received: from eggs.gnu.org ([2001:4830:134:3::10]:57769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eeGzx-0006dc-H8
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 04:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eeGzs-00073q-GU
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 04:05:37 -0500
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:36752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eeGzs-00072Z-7T
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 04:05:32 -0500
Received: from player692.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 918AC11241F
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 10:05:26 +0100 (CET)
Date: Wed, 24 Jan 2018 10:05:00 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180124100500.1f9bf54a@bahia.lan>
In-Reply-To: <20180124094621.46ff2f43@bahia.lan>
References: <1516747387-31760-1-git-send-email-mst@redhat.com>
	<1516747387-31760-2-git-send-email-mst@redhat.com>
	<20180124094621.46ff2f43@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 1/1] kvm-all: Partially reverts 4fe6d78b2e
 to remove the cleanup call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Anton Blanchard <anton@samba.org>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

On Wed, 24 Jan 2018 09:46:21 +0100
Greg Kurz <groug@kaod.org> wrote:

> Please note that Peter usually doesn't work on Wednesdays. The master branch
> might remain broken for everyone until tomorrow... :-\
> 
> And I don't think this is the right fix anyway. See below.
> 
> On Wed, 24 Jan 2018 00:44:14 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> > 
> > This commit partially reverts the commit 4fe6d78b2e because of issues
> > reported in the virtio.
> > 
> > Examples:
> > 
> > $ qemu-system-ppc64 -cpu POWER8 -nographic -vga none -m 4G \
> >   -M pseries,accel=kvm -netdev type=user,id=net0 \
> >   -device virtio-net-pci,netdev=net0 -drive file=../disk.qcow2,if=virtio
> > 
> > Populating /vdevice/nvram@71000001
> > Populating /vdevice/v-scsi@71000002
> >        SCSI: Looking for devices
> >           8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
> > Populating /pci@800000020000000
> >                      00 0000 (D) : 1af4 1000    virtio [ net ]
> > Aborted
> > 
> > $ qemu-system-x86_64 -m 4G -enable-kvm -drive file=util.qcow2,if=virtio
> > 
> > Running QEMU with GTK 2.x is deprecated, and will be removed
> > in a future release. Please switch to GTK 3.x instead
> > [1]    5282 abort
> > 
> > Reference http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg05457.html
> > 
> > Reported-by: Anton Blanchard <anton@samba.org>
> > Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> > Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > Tested-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  accel/kvm/kvm-all.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 071f4f5..f290f48 100644
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
> 
> This looks wrong as the cleanup is expected to do things like closing fds:
> 
> static void virtio_bus_cleanup_event_notifier(EventNotifier *notifier)
> {
>     /* Test and clear notifier after disabling event,
>      * in case poll callback didn't have time to run.
>      */
>     virtio_queue_host_notifier_read(notifier);
>     event_notifier_cleanup(notifier);
> }
> 
> void event_notifier_cleanup(EventNotifier *e)
> {
>     if (e->rfd != e->wfd) {
>         close(e->rfd);
>     }
>     close(e->wfd);
>     e->rfd = -1;
>     e->wfd = -1;
>     e->cleanup = NULL;
> }
> 
> And indeed, with this patch applied, QEMU leaks eventfds on every machine
> reset.
> 

Reverting 4fe6d78b2e entirely isn't even enough and QEMU aborts at the
next machine reset. The following commit must be reverted as well:

commit 6f0bb230722931d17fb284eee8efd40b9d653822
Author: Gal Hammer <ghammer@redhat.com>
Date:   Sun Jan 14 12:06:56 2018 +0200

    virtio: improve virtio devices initialization time

> >  }
> >  
> >  static void kvm_io_ioeventfd_add(MemoryListener *listener,  
> 
> 
