Received: from eggs.gnu.org ([2001:4830:134:3::10]:44614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eeOXZ-0003kK-8o
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eeOXU-0003ca-WB
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:08:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eeOXU-0003cE-NY
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:08:44 -0500
Date: Wed, 24 Jan 2018 19:08:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180124190820-mutt-send-email-mst@kernel.org>
References: <1516747387-31760-1-git-send-email-mst@redhat.com>
	<1516747387-31760-2-git-send-email-mst@redhat.com>
	<20180124094621.46ff2f43@bahia.lan>
	<20180124100500.1f9bf54a@bahia.lan>
	<d0698024-65ae-fb6b-397d-cccdc1fb36f4@redhat.com>
	<20180124103402.6ef42523@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180124103402.6ef42523@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Anton Blanchard <anton@samba.org>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

On Wed, Jan 24, 2018 at 10:34:02AM +0100, Greg Kurz wrote:
> On Wed, 24 Jan 2018 10:14:57 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > On 24/01/2018 10:05, Greg Kurz wrote:
> > > On Wed, 24 Jan 2018 09:46:21 +0100
> > > Greg Kurz <groug@kaod.org> wrote:
> > >   
> > >> Please note that Peter usually doesn't work on Wednesdays. The master branch
> > >> might remain broken for everyone until tomorrow... :-\
> > >>
> > >> And I don't think this is the right fix anyway. See below.
> > >>
> > >> On Wed, 24 Jan 2018 00:44:14 +0200
> > >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >>  
> > >>> From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> > >>>
> > >>> This commit partially reverts the commit 4fe6d78b2e because of issues
> > >>> reported in the virtio.
> > >>>
> > >>> Examples:
> > >>>
> > >>> $ qemu-system-ppc64 -cpu POWER8 -nographic -vga none -m 4G \
> > >>>   -M pseries,accel=kvm -netdev type=user,id=net0 \
> > >>>   -device virtio-net-pci,netdev=net0 -drive file=../disk.qcow2,if=virtio
> > >>>
> > >>> Populating /vdevice/nvram@71000001
> > >>> Populating /vdevice/v-scsi@71000002
> > >>>        SCSI: Looking for devices
> > >>>           8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
> > >>> Populating /pci@800000020000000
> > >>>                      00 0000 (D) : 1af4 1000    virtio [ net ]
> > >>> Aborted
> > >>>
> > >>> $ qemu-system-x86_64 -m 4G -enable-kvm -drive file=util.qcow2,if=virtio
> > >>>
> > >>> Running QEMU with GTK 2.x is deprecated, and will be removed
> > >>> in a future release. Please switch to GTK 3.x instead
> > >>> [1]    5282 abort
> > >>>
> > >>> Reference http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg05457.html
> > >>>
> > >>> Reported-by: Anton Blanchard <anton@samba.org>
> > >>> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> > >>> Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > >>> Tested-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > >>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > >>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >>> ---
> > >>>  accel/kvm/kvm-all.c | 4 ----
> > >>>  1 file changed, 4 deletions(-)
> > >>>
> > >>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > >>> index 071f4f5..f290f48 100644
> > >>> --- a/accel/kvm/kvm-all.c
> > >>> +++ b/accel/kvm/kvm-all.c
> > >>> @@ -812,10 +812,6 @@ static void kvm_mem_ioeventfd_del(MemoryListener *listener,
> > >>>      if (r < 0) {
> > >>>          abort();
> > >>>      }
> > >>> -
> > >>> -    if (e->cleanup) {
> > >>> -        e->cleanup(e);
> > >>> -    }    
> > >>
> > >> This looks wrong as the cleanup is expected to do things like closing fds:
> > >>
> > >> static void virtio_bus_cleanup_event_notifier(EventNotifier *notifier)
> > >> {
> > >>     /* Test and clear notifier after disabling event,
> > >>      * in case poll callback didn't have time to run.
> > >>      */
> > >>     virtio_queue_host_notifier_read(notifier);
> > >>     event_notifier_cleanup(notifier);
> > >> }
> > >>
> > >> void event_notifier_cleanup(EventNotifier *e)
> > >> {
> > >>     if (e->rfd != e->wfd) {
> > >>         close(e->rfd);
> > >>     }
> > >>     close(e->wfd);
> > >>     e->rfd = -1;
> > >>     e->wfd = -1;
> > >>     e->cleanup = NULL;
> > >> }
> > >>
> > >> And indeed, with this patch applied, QEMU leaks eventfds on every machine
> > >> reset.
> > >>  
> > > 
> > > Reverting 4fe6d78b2e entirely isn't even enough and QEMU aborts at the
> > > next machine reset. The following commit must be reverted as well:
> > > 
> > > commit 6f0bb230722931d17fb284eee8efd40b9d653822
> > > Author: Gal Hammer <ghammer@redhat.com>
> > > Date:   Sun Jan 14 12:06:56 2018 +0200
> > > 
> > >     virtio: improve virtio devices initialization time  
> > 
> > I'm a bit confused by this patch.  The basic idea of wrapping with
> > transaction_begin/commit is clear (without it you have quadratic
> > behavior from removing one ioeventfd at a time), but I don't understand
> > why the new ->cleanup member is needed.
> > 
> 
> I don't understand either... the cover letter of the series says:
> 
> "The patch wraps all the changes made to the Memory Regions during the
> eventfd registrations in a memory regions transaction. I had to add a
> cleanup callback function to the EventNotifier struct, so it will be
> possible to use a transaction in the shutdown code path as well."
> 
> Until this is sorted out, maybe best to revert both commits or even
> the full series (ie, f87d72f5c5bf as well), no ?

OK I guess that's best.

> > Paolo
