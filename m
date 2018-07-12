Received: from eggs.gnu.org ([2001:4830:134:3::10]:57845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdd8v-0006Nx-Ik
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdd8u-00009B-Oz
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:04:29 -0400
Date: Thu, 12 Jul 2018 17:04:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180712150417.GF4541@localhost.localdomain>
References: <20180711205813.22346-1-danielhb413@gmail.com>
	<d4353326-28db-0094-e998-f92026d8e7a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4353326-28db-0094-e998-f92026d8e7a9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/1] scsi-disk: Block Device
 Characteristics emulation fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, famz@redhat.com, qemu block <qemu-block@nongnu.org>

Am 12.07.2018 um 16:53 hat Paolo Bonzini geschrieben:
> On 11/07/2018 22:58, Daniel Henrique Barboza wrote:
> > The current BDC VPD page (page 0xb1) is too short. This can be
> > seen running sg_utils:
> > 
> > $ sg_vpd --page=bdc /dev/sda
> > Block device characteristics VPD page (SBC):
> > Block device characteristics VPD page length too short=8
> > 
> > By the SCSI spec, the expected size of the SBC page is 0x40.
> > There is no telling how the guest will behave with a shorter
> > message - it can ignore it, or worse, make (wrong)
> > assumptions.
> > 
> > This patch fixes the emulation by setting the size to 0x40.
> > This is the output of the previous sg_vpd command after
> > applying it:
> > 
> > $ sg_vpd --page=bdc /dev/sda -v
> >     inquiry cdb: 12 01 b1 00 fc 00
> > Block device characteristics VPD page (SBC):
> >    [PQual=0  Peripheral device type: disk]
> >   Medium rotation rate is not reported
> >   Product type: Not specified
> >   WABEREQ=0
> >   WACEREQ=0
> >   Nominal form factor not reported
> >   FUAB=0
> >   VBULS=0
> > 
> > To improve readability, this patch also adds the VBULS value
> > explictly and add comments on the existing fields we're
> > setting.
> > 
> > Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> 
> Kevin kindly agreed to take this through the block tree, so
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks, applied to the block branch.

Kevin
