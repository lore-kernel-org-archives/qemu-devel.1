Received: from eggs.gnu.org ([2001:4830:134:3::10]:51550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1ciJqJ-0000gu-DC
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:51:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1ciJqG-0001NS-9V
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:51:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43323
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1ciJqG-0001NA-3i
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:51:48 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RBiLSW115368
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 06:51:46 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28u703v2k1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 06:51:46 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 27 Feb 2017 11:51:43 -0000
Date: Mon, 27 Feb 2017 12:51:38 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <4fe97bb7-d6f0-7b58-916f-94dc0ae81616@redhat.com>
References: <20170223122025.10420-1-cornelia.huck@de.ibm.com>
	<20170223122025.10420-4-cornelia.huck@de.ibm.com>
	<4fe97bb7-d6f0-7b58-916f-94dc0ae81616@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170227125138.18c3f43c.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] s390x/ipl: Load network boot image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, jfrei@linux.vnet.ibm.com, Farhan Ali <alifm@linux.vnet.ibm.com>, agraf@suse.de

On Sat, 25 Feb 2017 07:18:29 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 23.02.2017 13:20, Cornelia Huck wrote:
> > From: Farhan Ali <alifm@linux.vnet.ibm.com>
> > 
> > Load the network boot image into guest RAM when the boot
> > device selected is a network device. Use some of the reserved
> > space in IplBlockCcw to store the start address of the netboot
> > image.
> > 
> > A user could also use 'chreipl'(diag 308/5) to change the boot device.
> > So every time we update the IPLB, we need to verify if the selected
> > boot device is a network device so we can appropriately load the
> > network boot image.
> > 
> > Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> >  hw/s390x/ipl.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  hw/s390x/ipl.h |  4 ++-
> >  2 files changed, 92 insertions(+), 1 deletion(-)

> > +static bool is_virtio_net_device(IplParameterBlock *iplb)
> > +{
> > +    uint8_t cssid;
> > +    uint8_t ssid;
> > +    uint16_t devno;
> > +    uint16_t schid;
> > +    SubchDev *sch = NULL;
> > +
> > +    if (iplb->pbt != S390_IPL_TYPE_CCW) {
> > +        return false;
> > +    }
> > +
> > +    devno = be16_to_cpu(iplb->ccw.devno);
> > +    ssid = iplb->ccw.ssid & 3;
> > +
> > +    for (schid = 0; schid < MAX_SCHID; schid++) {
> > +        for (cssid = 0; cssid < MAX_CSSID; cssid++) {
> > +            sch = css_find_subch(1, cssid, ssid, schid);
> > +
> > +            if (sch && sch->devno == devno) {
> > +                return sch->id.cu_model == VIRTIO_ID_NET;
> > +            }
> > +        }
> > +    }
> > +   return false;
> 
> The above line has only 3 instead of 4 spaces. I wonder why checkpatch
> does not complain here...?

Odd. Will fixup.

> 
> > +}

> > +    if (ipl->netboot) {
> > +        if (load_netboot_image(&err) < 0) {
> > +            error_report_err(err);
> > +            vm_stop(RUN_STATE_INTERNAL_ERROR);
> > +        }
> > +        ipl->iplb.ccw.netboot_start_addr = ipl->start_addr;
> 
> Not sure whether it matters, but in case of early errors during
> load_netboot_image(), ipl->start_addr could be used uninitialized here.
> Maybe you should move the "ipl->start_addr = KERN_IMAGE_START;" there at
> the beginning of the function, to make it also the default value for the
> other error cases?

ipl->start_addr has already been set to some value in the realize
function (either the kernel entry address, or the bios address).

But that should not matter with the vm_stop() on error anyway, no?
