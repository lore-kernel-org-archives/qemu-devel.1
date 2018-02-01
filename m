Received: from eggs.gnu.org ([2001:4830:134:3::10]:49303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehDZe-0006ES-Be
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehDZb-0007Q0-8Y
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:02:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ehDZb-0007PR-2W
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:02:35 -0500
Date: Thu, 1 Feb 2018 13:02:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180201130226.364e6c76.cohuck@redhat.com>
In-Reply-To: <b779846e-3e25-5c33-217b-1d9f5e85ec70@linux.vnet.ibm.com>
References: <20180130094715.11578-1-zyimin@linux.vnet.ibm.com>
	<20180130094715.11578-4-zyimin@linux.vnet.ibm.com>
	<20180131124400.4f74cf1c.cohuck@redhat.com>
	<b779846e-3e25-5c33-217b-1d9f5e85ec70@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] s390x/pci: use the right pal and pba
 in reg_ioat()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, alex.williamson@redhat.com, marcel@redhat.com

On Thu, 1 Feb 2018 12:33:01 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 31/01/2018 12:44, Cornelia Huck wrote:
> > On Tue, 30 Jan 2018 10:47:15 +0100
> > Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
> >  
> >> When registering ioat, pba should be comprised of leftmost 52 bits and
> >> rightmost 12 binary zeros, and pal should be comprised of leftmost 52
> >> bits and right most 12 binary ones. Let's fixup this.
> >>
> >> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> >> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> >> ---
> >>   hw/s390x/s390-pci-inst.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> >> index 997a9cc2e9..3fcc330fe3 100644
> >> --- a/hw/s390x/s390-pci-inst.c
> >> +++ b/hw/s390x/s390-pci-inst.c
> >> @@ -865,6 +865,8 @@ static int reg_ioat(CPUS390XState *env, S390PCIIOMMU *iommu, ZpciFib fib,
> >>       uint8_t dt = (g_iota >> 2) & 0x7;
> >>       uint8_t t = (g_iota >> 11) & 0x1;
> >>   
> >> +    pba &= ~0xfff;
> >> +    pal |= 0xfff;
> >>       if (pba > pal || pba < ZPCI_SDMA_ADDR || pal > ZPCI_EDMA_ADDR) {
> >>           s390_program_interrupt(env, PGM_OPERAND, 6, ra);
> >>           return -EINVAL;  
> > It seems like pba and pal are part of the fib, which in turn seems to
> > be provided by the caller. Is that correct? If yes, is it valid for
> > them to not have the rightmost 12 bits as 0s resp. 1s?
> >
> > (Probably answered in the architecture, I know. Might make sense to be
> > a tad more explicit in the description.)
> >  
> Yes it is, only word6 and the bits 0-19 of word 7 are used for PAL and
> the zPCI facility treats the right most 12 bits of the PAL as containing 
> ones.
> 
> For PBA words 4 and 0-19 bits of word 5 with 12 0 append on the right 
> provides the PBA.
> 
> The lower 12 bits of words 5 and 7 of the FIB are ignored by the facility.
> 
> @Yi Min: may be add the last sentence to the commit message.
> 
> @Conny: Is it clearer?

Yes, adding the last sentence makes it clearer. Thanks!
