Received: from eggs.gnu.org ([2001:4830:134:3::10]:56545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXjMQ-0000iP-Vo
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXjMM-00034F-UM
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:30:03 -0400
Date: Tue, 26 Jun 2018 10:29:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180626102954.73965b42.cohuck@redhat.com>
In-Reply-To: <d56829a3-fecf-b812-d002-8ee22ae08da2@de.ibm.com>
References: <20180622194736.GA5794@roeck-us.net>
	<126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
	<88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
	<20180625100548.64222dad.cohuck@redhat.com>
	<d56829a3-fecf-b812-d002-8ee22ae08da2@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] s390 qemu boot failure in -next
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>

On Mon, 25 Jun 2018 10:29:46 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 06/25/2018 10:05 AM, Cornelia Huck wrote:
> > On Mon, 25 Jun 2018 09:27:59 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> >> Something like this in QEMU 
> >>
> >> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> >> index f278036fa7..14153ce880 100644
> >> --- a/hw/s390x/ipl.c
> >> +++ b/hw/s390x/ipl.c
> >> @@ -187,11 +187,13 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
> >>           */
> >>          if (pentry == KERN_IMAGE_START || pentry == 0x800) {
> >>              ipl->start_addr = KERN_IMAGE_START;
> >> -            /* Overwrite parameters in the kernel image, which are "rom" */
> >> -            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
> >>          } else {
> >>              ipl->start_addr = pentry;
> >>          }
> >> +       if (ipl->cmdline) {
> >> +            /* If there is a command line, put it in the right place */
> >> +            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
> >> +       }  
> > 
> > Check for the magic Linux string (like in the non-elf case) first?  
> 
> Even that does not exists in vmlinux but only in bzImage with the latest patchset
> (in next, but not upstream yet)

Ok.

> >   
> >>  
> >>          if (ipl->initrd) {
> >>              ram_addr_t initrd_offset;
> >>
> >> would put the command line in no matter what the start address is.  
> > 
> > I'm for putting that one in (and backporting it to qemu-stable). It's a
> > bit worrying, though, that our ipl code is so fragile...  
> 
> We actually have to combine this with Thomas fix (to check for rom_ptr returning
> something sane). It seems that ipl->commandline is always there, so we have to
> check for strlen!=0 it seems..
> 
> I mean if somebody ask for "-append something" we can certainly always write something
> if there is rom/ram.

Given that the uncompressed image is not supposed to be bootable
anymore, does it make sense to add this anyway?

I'll go ahead and queue Thomas' fix, though.
