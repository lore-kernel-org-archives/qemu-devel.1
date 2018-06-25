Received: from eggs.gnu.org ([2001:4830:134:3::10]:44756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXMYU-0007sw-9M
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXMYP-0003Ul-9D
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:08:58 -0400
Date: Mon, 25 Jun 2018 10:08:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180625100849.42ebfe78.cohuck@redhat.com>
In-Reply-To: <947bbba3-dcd0-7f5b-1d92-b41be764c2f5@de.ibm.com>
References: <20180622194736.GA5794@roeck-us.net>
	<126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
	<88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
	<947bbba3-dcd0-7f5b-1d92-b41be764c2f5@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] s390 qemu boot failure in -next
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>

On Mon, 25 Jun 2018 10:02:28 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 06/25/2018 09:27 AM, Christian Borntraeger wrote:
> > Also adding QEMU.
> > 
> > On 06/25/2018 09:10 AM, Christian Borntraeger wrote:  
> >>
> >>
> >> On 06/22/2018 09:47 PM, Guenter Roeck wrote:  
> >>> Hi,
> >>>
> >>> starting with commit 's390/boot: make head.S and als.c be part of the
> >>> decompressor only' in -next, s390 immages no longer boot in qemu.
> >>> As far as I can see, the reason is that the command line is no longer
> >>> passed from qemu to the kernel, which results in a panic because the
> >>> root file system can not be mounted.
> >>>
> >>> Was this change made on purpose ? If so, is there a way to get qemu
> >>> back to working ?  
> >>
> >> Certainly not on purpose.
> >>
> >> Vasily, I can reproduce this with KVM and an external kernel boot of the vmlinux file (the elf file)
> >>
> >> e.g.
> >>
> >> qemu-system-s390 -enable-kvm -nographic -kernel vmlinux -append "this string no longer is command line"
> >>
> >> The compressed image (bzImage) seems to work fine though.
> >>
> >> This seems to be an unfortunate side effect of QEMUs ways to "guess" its Linux (checking for start
> >> address 0x10000, which is no longer true for the vmlinux file). With the pure vmlinux elf file
> >> the load address is 0x100000 as there is no unpacker.
> >>
> >> Guenter, can you check if arch/s390/boot/bzImage works for you as a workaround?  
> > 
> > Something like this in QEMU 
> > 
> > diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> > index f278036fa7..14153ce880 100644
> > --- a/hw/s390x/ipl.c
> > +++ b/hw/s390x/ipl.c
> > @@ -187,11 +187,13 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
> >           */
> >          if (pentry == KERN_IMAGE_START || pentry == 0x800) {
> >              ipl->start_addr = KERN_IMAGE_START;
> > -            /* Overwrite parameters in the kernel image, which are "rom" */
> > -            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
> >          } else {
> >              ipl->start_addr = pentry;
> >          }
> > +       if (ipl->cmdline) {
> > +            /* If there is a command line, put it in the right place */
> > +            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
> > +       }
> >  
> >          if (ipl->initrd) {
> >              ram_addr_t initrd_offset;
> > 
> > would put the command line in no matter what the start address is.  
> 
> Ideally we would do 2 changes:
> - change QEMU to add a commandline to 10480 if specified
> - have a way to fix the kernel elf file to still boot with older QEMUs 
> 

Agreed on both. Even if we change QEMU now (+ stable), there are many
versions out there that will now fail.
