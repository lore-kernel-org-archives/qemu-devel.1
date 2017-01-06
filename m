Received: from eggs.gnu.org ([2001:4830:134:3::10]:36686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cPcNQ-0000Wk-0Y
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 16:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cPcNL-0006o9-7N
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 16:48:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cPcNL-0006nt-0s
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 16:48:39 -0500
Date: Fri, 6 Jan 2017 23:48:37 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170106234743-mutt-send-email-mst@kernel.org>
References: <bd0ad06c-1dce-03c9-73b0-d8d6e4ca333b@roeck-us.net>
	<4b04ec32-b647-5047-7830-269cfc217550@ilande.co.uk>
	<3bee832c-1d2a-50a2-a763-c58ab34caf08@roeck-us.net>
	<3a90611b-a7c4-31c4-b373-3a16ddae5f4c@ilande.co.uk>
	<20170106183436.GA19862@roeck-us.net>
	<ea13ef16-ff0d-024f-2fa3-5cc11fa5f777@ilande.co.uk>
	<20170106210546.GA27764@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170106210546.GA27764@roeck-us.net>
Subject: Re: [Qemu-devel] Problems with qemu "modern" virtio on sparc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "qemu-devel@nongnu.org >> QEMU Developers" <qemu-devel@nongnu.org>

On Fri, Jan 06, 2017 at 01:05:46PM -0800, Guenter Roeck wrote:
> On Fri, Jan 06, 2017 at 07:42:19PM +0000, Mark Cave-Ayland wrote:
> > On 06/01/17 18:34, Guenter Roeck wrote:
> > 
> > > On Fri, Jan 06, 2017 at 05:04:58PM +0000, Mark Cave-Ayland wrote:
> > >> On 30/12/16 19:57, Guenter Roeck wrote:
> > >>
> > >> Disabling "modern" mode enables boot to proceed as normal:
> > >>
> > >> $ ./qemu-system-sparc64 \
> > >> -drive
> > >> file=debian-9.0-sparc64-NETINST1.iso,if=none,index=0,id=cd,media=cdrom \
> > >> -device virtio-blk-pci,disable-modern=on,drive=cd \
> > >> -nographic \
> > >> -bios openbios-builtin.elf.nostrip \
> > >> -m 256
> > >>
> > > ...
> > >>
> > >> Guenter, can you try a similar command line and confirm whether it fixes
> > >> the issue for you under QEMU 2.7 and 2.8? I have no idea as to why the
> > >> difference in legacy/non-legacy codepaths should crash the kernel though.
> > >>
> > > Unfortunately, my qemu command line wizard capabilities are somewhat lacking.
> > > I had tried that before, but just could not figure out how to change my command
> > > line to include "disable-modern=on". If you have an idea, please let me know.
> > > Here it is:
> > > 
> > > ${QEMU} -M ${mach} -cpu "${cpu}" -m 512 \
> > > 	        -drive file=${rootfs},if=virtio \
> > > 		-net nic,model=virtio \
> > > 		-kernel arch/sparc/boot/image -no-reboot \
> > > 		-append "root=/dev/vda init=/sbin/init.sh console=ttyS0" \
> > > 		-nographic 
> > 
> > If you apply the same principles from my example above to your command
> > line then you should end up with something like:
> > 
> > ${QEMU} -M ${mach} -cpu "${cpu}" -m 512 \
> >         -drive file=${rootfs},if=none,id=hd \
> > 	-device virtio-blk-pci,disable-modern=on,drive=hd \
> > 	-net nic,model=virtio \
> > 	-kernel arch/sparc/boot/image -no-reboot \
> > 	-append "root=/dev/vda init=/sbin/init.sh console=ttyS0" \
> > 	-nographic
> > 
> That works, but only if I drop "-net nic,model=virtio". Otherwise I get
> the same crash again. Any idea how to set the network configuration
> the same way ?
> 
> Thanks,
> Guenter


Replace it with -device virtio-net-pci.

-- 
MST
