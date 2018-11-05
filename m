Received: from eggs.gnu.org ([2001:4830:134:3::10]:50379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gJac1-0004TJ-29
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:52:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gJaZA-00047n-II
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:49:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1gJaZA-00040R-B6
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:49:00 -0500
Date: Mon, 5 Nov 2018 03:48:59 -0500 (EST)
From: Frediano Ziglio <fziglio@redhat.com>
Message-ID: <112173151.40470994.1541407739361.JavaMail.zimbra@redhat.com>
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
Cc: qemu-devel@nongnu.org, spice-devel@lists.freedesktop.org

> 
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

yes

>   * without the patch we break the qxl->id == channel_id requirement.

no, why? qxl->id is not Qemu index.

> 
> So, what now?
> 
> cheers,
>   Gerd
> 

Frediano
