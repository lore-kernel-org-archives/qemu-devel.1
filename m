Received: from eggs.gnu.org ([2001:4830:134:3::10]:35038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eN0Ve-0001U3-7v
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eN0Vb-0007ru-3y
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:02:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eN0Va-0007rO-R0
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:02:55 -0500
Date: Thu, 7 Dec 2017 11:02:45 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20171207110245.44ef09ef@t450s.home>
In-Reply-To: <c3c2fa0d-1e93-7f17-f8d3-db8eee82bfd1@redhat.com>
References: <20171120142216.17832-1-lprosek@redhat.com>
	<c3c2fa0d-1e93-7f17-f8d3-db8eee82bfd1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] msix: don't mask already masked vectors on
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Ladi Prosek <lprosek@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, geoff@hostfission.com

On Wed, 22 Nov 2017 12:46:45 +0200
Marcel Apfelbaum <marcel@redhat.com> wrote:

> Hi Ladi,
> 
> On 20/11/2017 16:22, Ladi Prosek wrote:
> > msix_mask_all() is supposed to invoke the release vector notifier if the state of the
> > respective vector changed from unmasked or masked.   
> 
> You mean from unmasked "to" masked right?
> 
> The way it's currently called from
> > msix_reset(), though, may result in calling the release notifier even if the vector
> > is already masked.
> > 
> > 1) msix_reset() clears out the msix_cap field and the msix_table.
> > 2) msix_mask_all() runs with was_masked=false for all vectors because of 1), which
> >     results in calling the release notifier on all vectors.
> > 3) if msix_reset() is subsequently called again, it goes through the same steps and
> >     calls the release notifier on all vectors again.
> >   
> 
> As far as I can see in the code you are right.(very reset will trigger the release notifiers
> again)
> 
> > This commit moves msix_mask_all() up so it runs before the device state is lost.  
> 
> OK
> 
> > And
> > it adds a call to msix_update_function_masked() so that the device remembers that
> > MSI-X is masked.
> >   
> 
> msix_update_function_masked checks the msix is enabled or masked-off.
> You are building on the fact the msix will not be enabled to set
> "msix_function_masked" to "true", right?
> (I just want to be sure I understand the patch)
> 
> > This is likely a low impact issue, found while debugging an already broken device. It
> > is however easy to fix and the expectation that the use and release notifier invocations
> > are always balanced is very natural.
> >   
> 
> I would leave it (maybe) out of 2.11 because it may expose other bugs
> and we are after rc2 already.
> 
> Adding Alex Williamson to see it does not affect device assignment,
> other than that the patch looks OK to me.

I flip flopped around here because vfio_msix_vector_release() doesn't
care if it gets called more than once for the same vector, but then I
looked at the ordering of vfio_pci_reset() vs msix_reset().  vfio will
never leave vfio_pci_reset() with MSI-X enabled, we unset our
notifiers , release and unuse any in-use vectors, and leave with only
INTx enabled (if supported).  So I don't think the patch below has any
effect whatsoever for vfio, and probably shouldn't for most devices as
resetting back to a state of MSI-X disabled ought to be standard
procedure... but maybe other devices rely on msix_reset() for this.
Thanks,

Alex

> > Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> > ---
> >   hw/pci/msix.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> > index c944c02135..34656de9b0 100644
> > --- a/hw/pci/msix.c
> > +++ b/hw/pci/msix.c
> > @@ -500,11 +500,12 @@ void msix_reset(PCIDevice *dev)
> >           return;
> >       }
> >       msix_clear_all_vectors(dev);
> > +    msix_mask_all(dev, dev->msix_entries_nr);
> >       dev->config[dev->msix_cap + MSIX_CONTROL_OFFSET] &=
> >   	    ~dev->wmask[dev->msix_cap + MSIX_CONTROL_OFFSET];
> >       memset(dev->msix_table, 0, dev->msix_entries_nr * PCI_MSIX_ENTRY_SIZE);
> >       memset(dev->msix_pba, 0, QEMU_ALIGN_UP(dev->msix_entries_nr, 64) / 8);
> > -    msix_mask_all(dev, dev->msix_entries_nr);
> > +    msix_update_function_masked(dev);
> >   }
> >   
> >   /* PCI spec suggests that devices make it possible for software to configure
> >   
> 
