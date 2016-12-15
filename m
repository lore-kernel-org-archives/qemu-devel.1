Received: from eggs.gnu.org ([2001:4830:134:3::10]:58668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cHbZ2-00006R-Hv
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 14:19:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cHbYx-0000Va-HQ
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 14:19:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cHbYx-0000V1-B6
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 14:19:31 -0500
Date: Thu, 15 Dec 2016 21:19:29 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20161215211838-mutt-send-email-mst@kernel.org>
References: <20161214142518.10504-1-stefanha@redhat.com>
	<20161215063226-mutt-send-email-mst@kernel.org>
	<20161215075028.GD26169@stefanha-x1.localdomain>
	<1481793479.21413.6.camel@redhat.com>
	<20161215170523-mutt-send-email-mst@kernel.org>
	<1481819150.21413.21.camel@redhat.com>
	<20161215202505-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161215202505-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] regression in 2.8: unable to exit screen grab in
 SDL mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Cole Robinson <crobinso@redhat.com>

On Thu, Dec 15, 2016 at 09:15:27PM +0200, Michael S. Tsirkin wrote:
> On Thu, Dec 15, 2016 at 05:25:50PM +0100, Gerd Hoffmann wrote:
> >   Hi,
> > 
> > > > > > The problem always reproduces for me:
> > > > > > - start qemu with -sdl
> > > > > > - wait for guest to boot
> > > > > > - click anywhere within guest screen
> > > > > > - message "press ctrl+alt to exit capture" appears on screen,
> > > > > >   but pressing that immediately restarts capture again
> > 
> > [ 2.6 good, 2.7, 2.8 bad ]
> > 
> > > I'd say SDL is mostly useless with this bug.
> > > 
> > > Do we fix this or disable SDL altogether?
> > 
> > Well, it can't be *that* bad, otherwise it would not went unnoticed for
> > a whole release cycle.
> 
> That's what I'm saying, maybe no one uses SDL anymore.
> 
> > It doesn't reproduce here.
> 
> Are you on Fedora 25 too?
> 
> > There must be some other factor which is
> > needed to trigger this.  What desktop you are using?  gnome?  kde?
> > something else?
> 
> XFCE
> 
> >  Xorg or wayland?
> 
> Xorg
> 
> > Can you try to bisect it?
> > 
> > cheers,
> >   Gerd
> 
> 
> Trying to.


One strange thing - I only see it when guest is in graphical mode.
If guest is in text mode it works ok.
Command line:

./x86_64-softmmu/qemu-system-x86_64 -enable-kvm -m 1000 -cpu host -smp 2
/home/mst/images/f20-x64.qcow2 -netdev user,id=foo -redir tcp:8022::22
-device virtio-net,netdev=foo -kernel /boot/vmlinuz-${release} -initrd
/boot/initramfs-${release}.img -append 'root=/dev/sda3 ro
vconsole.font=latarcyrheb-sun16  rhgb noquiet LANG=en_US.UTF-8
console=tty0 console=ttyS0,9600n8,9600n8' -sdl

so nothing special.
