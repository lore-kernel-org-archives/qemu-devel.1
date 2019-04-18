Received: from eggs.gnu.org ([209.51.188.92]:58918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hHA1G-0000vo-Us
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hHA1F-0007ja-3K
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:36:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hHA1D-0007ig-AO
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:36:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91F945F79B
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 16:36:09 +0000 (UTC)
Date: Thu, 18 Apr 2019 10:36:08 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190418103608.70668bda@x1.home>
In-Reply-To: <87a7gnrg33.fsf@dusky.pond.sub.org>
References: <20190417190641.26814-1-armbru@redhat.com>
	<20190417190641.26814-8-armbru@redhat.com>
	<20190417160508.7b87d59a@x1.home>
	<87a7gnrg33.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/15] vfio: Report warnings with
 warn_report(), not error_printf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, 18 Apr 2019 08:18:56 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Alex Williamson <alex.williamson@redhat.com> writes:
> 
> > On Wed, 17 Apr 2019 21:06:33 +0200
> > Markus Armbruster <armbru@redhat.com> wrote:
> >  
> >> Cc: Alex Williamson <alex.williamson@redhat.com>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>  hw/vfio/pci.c | 19 +++++++++++++------
> >>  1 file changed, 13 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> >> index 504019c458..0142819ea6 100644
> >> --- a/hw/vfio/pci.c
> >> +++ b/hw/vfio/pci.c
> >> @@ -947,8 +947,10 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
> >>      if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
> >>          /* Since pci handles romfile, just print a message and return */
> >>          if (vfio_blacklist_opt_rom(vdev) && vdev->pdev.romfile) {
> >> -            error_printf("Warning : Device at %s is known to cause system instability issues during option rom execution. Proceeding anyway since user specified romfile\n",
> >> -                         vdev->vbasedev.name);
> >> +            warn_report("Device at %s is known to cause system instability"
> >> +                        " issues during option rom execution",
> >> +                        vdev->vbasedev.name);
> >> +            error_printf("Proceeding anyway since user specified romfile\n");  
> >
> > I'm confused, the original warning is "this device is know to have
> > issues, proceeding because you asked me to".  Are we categorizing the
> > first half as a warning and the latter as random uncategorized error
> > spew?  Did an automated script chunk it this way because of the period
> > and strict application of the "single phrase" specification of
> > warn_report()?  If this is the recommended semantics, I'm not sure how
> > I'd know to generate this myself for similar situations.  Should we
> > instead try to express this in something acceptable as a single
> > phrase?  Thanks,  
> 
> This is an instance of the following error reporting pattern:
> 
>     concise error / warning message (one line, single phrase)
>     additional information (free format)
> 
> We use error_report() / warn_report() for the former (this adds
> decorations to the message), and error_printf() for the latter.
> 
> "git-grep -w error_printf" will lead you to other instances.  Recommend
> to look with this series applied, because it removes misuses of
> error_printf().
> 
> Particularly relevant instances are error_report_err() and
> warn_report_err(): these print the error proper with error_report() /
> warn_report_err(), and the hint, if any, with error_printf().
> 
> Clearer now?

I can't guarantee that I'd be able to reproduce these sorts of
semantics without prompting, but yes, there does seem to be some method
to the madness ;)  Thanks,

Acked-by: Alex Williamson <alex.williamson@redhat.com>
