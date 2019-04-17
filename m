Received: from eggs.gnu.org ([209.51.188.92]:38772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hGsg4-0000pi-SB
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 18:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hGsg3-0008Uo-OB
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 18:05:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hGsg3-0008O7-DC
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 18:05:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2BFC81F11
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 22:05:08 +0000 (UTC)
Date: Wed, 17 Apr 2019 16:05:08 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190417160508.7b87d59a@x1.home>
In-Reply-To: <20190417190641.26814-8-armbru@redhat.com>
References: <20190417190641.26814-1-armbru@redhat.com>
	<20190417190641.26814-8-armbru@redhat.com>
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

On Wed, 17 Apr 2019 21:06:33 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/vfio/pci.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 504019c458..0142819ea6 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -947,8 +947,10 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>      if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
>          /* Since pci handles romfile, just print a message and return */
>          if (vfio_blacklist_opt_rom(vdev) && vdev->pdev.romfile) {
> -            error_printf("Warning : Device at %s is known to cause system instability issues during option rom execution. Proceeding anyway since user specified romfile\n",
> -                         vdev->vbasedev.name);
> +            warn_report("Device at %s is known to cause system instability"
> +                        " issues during option rom execution",
> +                        vdev->vbasedev.name);
> +            error_printf("Proceeding anyway since user specified romfile\n");

I'm confused, the original warning is "this device is know to have
issues, proceeding because you asked me to".  Are we categorizing the
first half as a warning and the latter as random uncategorized error
spew?  Did an automated script chunk it this way because of the period
and strict application of the "single phrase" specification of
warn_report()?  If this is the recommended semantics, I'm not sure how
I'd know to generate this myself for similar situations.  Should we
instead try to express this in something acceptable as a single
phrase?  Thanks,

Alex

>          }
>          return;
>      }
> @@ -973,11 +975,16 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>  
>      if (vfio_blacklist_opt_rom(vdev)) {
>          if (dev->opts && qemu_opt_get(dev->opts, "rombar")) {
> -            error_printf("Warning : Device at %s is known to cause system instability issues during option rom execution. Proceeding anyway since user specified non zero value for rombar\n",
> -                         vdev->vbasedev.name);
> +            warn_report("Device at %s is known to cause system instability"
> +                        " issues during option rom execution",
> +                        vdev->vbasedev.name);
> +            error_printf("Proceeding anyway since user specified"
> +                         " non zero value for rombar\n");
>          } else {
> -            error_printf("Warning : Rom loading for device at %s has been disabled due to system instability issues. Specify rombar=1 or romfile to force\n",
> -                         vdev->vbasedev.name);
> +            warn_report("Rom loading for device at %s has been disabled"
> +                        " due to system instability issues",
> +                        vdev->vbasedev.name);
> +            error_printf("Specify rombar=1 or romfile to force\n");
>              return;
>          }
>      }
