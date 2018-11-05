Received: from eggs.gnu.org ([2001:4830:134:3::10]:53657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gJc56-0007Wj-0I
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:26:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gJbqW-0007wt-O3
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:11:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1gJbqW-0007mu-6h
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:11:00 -0500
Date: Mon, 5 Nov 2018 05:10:58 -0500 (EST)
From: Frediano Ziglio <fziglio@redhat.com>
Message-ID: <516990483.40490676.1541412658356.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181105084351.sfokm7j2ho5npaz2@sirius.home.kraxel.org>
References: <20181029124703.11123-1-kraxel@redhat.com>
	<20181029124703.11123-2-kraxel@redhat.com>
	<317924534.39835893.1541149813210.JavaMail.zimbra@redhat.com>
	<20181105084351.sfokm7j2ho5npaz2@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 1/2] qxl: store channel id in qxl->id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

> Hi,
> 
> > >      vga->con = graphic_console_init(DEVICE(dev), 0, &qxl_ops, qxl);
> > > +    qxl->id = qemu_console_get_index(vga->con); /* == channel_id */
> > > +    if (qxl->id != 0) {
> > > +        error_setg(errp, "primary qxl-vga device must be console 0 "
> > > +                   "(first display device on the command line)");
> > > +        return;
> > > +    }
> > 
> > In the comment this seems no more required so why testing it?
> 
> I'd expect it'll confuse guests.
> 
> If you are sure this is not the case feel free to send a patch dropping
> this check.
> 

Had a look more deep into Qemu code. Both qxl_realize_primary and
qxl_realize_secondary calls qxl_realize_common which calls 
qemu_spice_add_display_interface to register the interface to spice.
Both qxl_realize_primary and qxl_realize_secondary set qxl->id
(first with 0 second from 1 as code below was doing).
There are 2 fields "id": PCIQXLDevice->id and PCIQXLDevice->ssd.qxl.id,
having PCIQXLDevice->ssd.qxl.id == qemu_console_get_index(PCIQXLDevice->vga->con)
== channel_id (PCIQXLDevice->ssd.qxl.id is set in qemu_spice_add_display_interface).
Looks like PCIQXLDevice->id, beside to distinguish if primary or not is
only used for tracing. Would not be better to remove PCIQXLDevice->id
at all after adding the have_vga flag?

> > >  static void qxl_realize_secondary(PCIDevice *dev, Error **errp)
> > >  {
> > > -    static int device_id = 1;
> > >      PCIQXLDevice *qxl = PCI_QXL(dev);
> > >  
> > > -    qxl->id = device_id++;
> > >      qxl_init_ramsize(qxl);
> > >      memory_region_init_ram(&qxl->vga.vram, OBJECT(dev), "qxl.vgavram",
> > >                             qxl->vga.vram_size, &error_fatal);
> > >      qxl->vga.vram_ptr = memory_region_get_ram_ptr(&qxl->vga.vram);
> > >      qxl->vga.con = graphic_console_init(DEVICE(dev), 0, &qxl_ops, qxl);
> > > +    qxl->id = qemu_console_get_index(qxl->vga.con); /* == channel_id */
> > >  
> > 
> > As these IDs must be contiguous this means that there must be the
> > requirement
> > that if there is a qxl interface only qxl interfaces are used and no other
> > console which seems to me wrong.
> 
> Hmm.  Didn't know this is a requirement.  But as far I know qxl->id is
> also expected to be the channel_id.  So with qxl and non-qxl mixed we
> are in trouble no matter what:
> 
>   * with the patch we break the contiguous id requirement.

PCIQXLDevice->id? No reason actually to be contiguous.
PCIQXLDevice->ssd.qxl.id is already qemu_console_get_index so potentially
not contiguous.

>   * without the patch we break the qxl->id == channel_id requirement.

Yes, can be broken although I suspect for other reasons this is true.

> 
> So, what now?
> 
> cheers,
>   Gerd
> 

I would personally add the "have_vga" field and use a single id field,
this will make sure to have the same consistent value.

Frediano
