Received: from eggs.gnu.org ([2001:4830:134:3::10]:38860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fSJ3l-0005pZ-Tj
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fSJ3g-0007x8-1Q
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:24:21 -0400
Date: Mon, 11 Jun 2018 11:24:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180611112410.4e2eb406.cohuck@redhat.com>
In-Reply-To: <3a7d6318-c827-3aa3-2799-7e383132beb3@de.ibm.com>
References: <1528636325-4237-1-git-send-email-thuth@redhat.com>
	<3a7d6318-c827-3aa3-2799-7e383132beb3@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/ipl: Fix crash that occurs when
 -kernel is used with small images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Mon, 11 Jun 2018 09:49:39 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 06/10/2018 03:12 PM, Thomas Huth wrote:
> > Add a sanity check to fix the following crash:
> > 
> > $ echo "Insane in the mainframe" > /tmp/test.txt
> > $ s390x-softmmu/qemu-system-s390x -nographic -kernel /tmp/test.txt
> > Segmentation fault (core dumped)
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>  
> 
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> I think a similar problem exists for INITRD_PARM_START and INITRD_PARM_SIZE. No?

I think so as well.

> 
> 
> > ---
> >  hw/s390x/ipl.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> > index 04245b5..9bb9b50 100644
> > --- a/hw/s390x/ipl.c
> > +++ b/hw/s390x/ipl.c
> > @@ -168,7 +168,8 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
> >           * we can not rely on the ELF entry point - it was 0x800 (the SALIPL
> >           * loader) and it won't work. For this case we force it to 0x10000, too.
> >           */
> > -        if (pentry == KERN_IMAGE_START || pentry == 0x800) {
> > +        if ((pentry == KERN_IMAGE_START || pentry == 0x800) &&
> > +            kernel_size > KERN_PARM_AREA + strlen(ipl->cmdline)) {
> >              ipl->start_addr = KERN_IMAGE_START;
> >              /* Overwrite parameters in the kernel image, which are "rom" */
> >              strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
> >   
> 

The outcome of this is that we don't write into areas we must not write
into, but we still have a broken "kernel" and will simply fail if the
thing we're pointing to isn't a valid PSW. I guess that's what we want
("crap in, crap out"), i.e. no fallback to the bios or something like
that?
