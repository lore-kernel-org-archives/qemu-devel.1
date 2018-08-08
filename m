Received: from eggs.gnu.org ([2001:4830:134:3::10]:43834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fnVMP-0004pH-Va
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 16:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fnVMM-0002E2-2K
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 16:47:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fnVML-0002DT-RI
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 16:47:09 -0400
Date: Wed, 8 Aug 2018 17:47:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180808204706.GA23195@localhost.localdomain>
References: <20180808191951.23193-1-mark.cave-ayland@ilande.co.uk>
	<20180808195334.GX23195@localhost.localdomain>
	<1dcbf6a5-8824-97d4-16a9-db73ce93767d@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dcbf6a5-8824-97d4-16a9-db73ce93767d@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: add bootdevice-ignore-suffixes
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: lersek@redhat.com, qemu-devel@nongnu.org

On Wed, Aug 08, 2018 at 09:19:31PM +0100, Mark Cave-Ayland wrote:
> On 08/08/18 20:53, Eduardo Habkost wrote:
> 
> > On Wed, Aug 08, 2018 at 08:19:51PM +0100, Mark Cave-Ayland wrote:
> > > For the older machines (such as Mac and SPARC) the DT nodes representing
> > > bootdevices for disk nodes are irregular for mainly historical reasons.
> > > 
> > > Since the majority of bootdevice nodes for these machines either do not have a
> > > separate disk node or require different (custom) names then it is much easier
> > > to disable all suffixes for a particular machine by setting the ignore_suffixes
> > > parameter to get_boot_devices_list() to true, and customise the disk nodes as
> > > required.
> > > 
> > > Here we add a new bootdevice-ignore-suffixes property to the FW_CFG device to
> > > allow the generation of disk suffixes to be controlled on a per-machine basis.
> > > 
> > > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > 
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> > 
> > But I would prefer to see this merged only after we see machines
> > actually using the property.  Can you send that as a single
> > series later?
> 
> I don't have any more time until tomorrow evening now, but FWIW I've pushed
> my working branch to
> https://github.com/mcayland/qemu/commits/openbios-bootindex3 if you want to
> take a quick look. Example command line:
> 
> $ ./qemu-system-sparc64 -drive
> file=disk.img,if=none,index=0,id=cd,media=cdrom -device
> virtio-blk-pci,bus=pciB,drive=cd,bootindex=0 -m 256 -nographic
> 
> Would you still like me to post this to the list properly tomorrow evening?

It's up to you (I don't know when you think your series will be
ready).  Maybe you'll want to adopt the patch below so you don't
need to inline your fw_cfg_init*() calls anymore?  (also, up to
you)


> > Also, maybe we can do it in a simpler way:
> > 
> > I now see that fw_cfg is not the only user of
> > get_boot_devices_list().  I didn't want to have a fw_cfg-specific
> > field in MachineClass, but but we can make it not fw_cfg-specific
> > if we make it affect all get_boot_devices_list() calls.
> > 
> > What do you think of the patch below?
> > 
> > (Patch is untested)
[...]

-- 
Eduardo
