Received: from eggs.gnu.org ([2001:4830:134:3::10]:52142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHV1v-0006Xz-AG
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 08:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHV1r-0001pY-BP
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 08:25:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eHV1r-0001pP-2i
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 08:25:27 -0500
Date: Wed, 22 Nov 2017 14:25:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171122142521.2f4493f4.cohuck@redhat.com>
In-Reply-To: <c7ab1846-30ef-cd18-e905-a2b41c7fd9fd@linux.vnet.ibm.com>
References: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510854715-7081-3-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171121113845.0a0377d1.cohuck@redhat.com>
	<20171121152503.1f0a023b.cohuck@redhat.com>
	<c7ab1846-30ef-cd18-e905-a2b41c7fd9fd@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/7] s390x/pci: rework PCI STORE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Tue, 21 Nov 2017 19:03:17 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 21/11/2017 15:25, Cornelia Huck wrote:
> > On Tue, 21 Nov 2017 11:38:45 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> >> On Thu, 16 Nov 2017 18:51:50 +0100
> >> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:  
> >   
> >>> @@ -493,9 +494,13 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
> >>>           break;
> >>>       }
> >>>   
> >>> -    data = env->regs[r1];
> >>> -    if (pcias < 6) {
> >>> -        if ((8 - (offset & 0x7)) < len) {
> >>> +    /* Test that the pcias is valid and do the appropriates operations */
> >>> +    switch (pcias) {
> >>> +    case 0 ... 5:  
> >>
> >> Make this
> >> case 0...5:
> >> ?  
> > 
> > ...only that it confuses the compiler when using numbers. We can either  
> 
> I did not see this as I replied to the previous email, sorry.
> 
> > keep the slightly ugly version, or introduce #defines.
> > ZPCI_PCIAS_IOREGION_{MIN,MAX} (and maybe ZPCI_PCIAS_CONFIG for 15)?  
> 
> 
> I agree something is missing.
> But I am not sure that a #define brings clarity.
> I would prefer to add a comment.
> 	/* A ZPCI PCI card may use any BAR from BAR 0 to BAR 5 */
> 
> ?

It's more a speaking value vs. magic numbers thing. A comment does not
hurt either, though :)

(And we get rid of the spacing as well.)

> 
> 
> >>> +         * A length of 0 is invalid and length should not cross a double word
> >>> +         */
> >>> +        if (!len || (len > (8 - (offset & 0x7)))) {
> >>>               program_interrupt(env, PGM_OPERAND, 4);
> >>>               return 0;
> >>>           }
> >>> @@ -513,21 +518,21 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
> >>>               program_interrupt(env, PGM_OPERAND, 4);
> >>>               return 0;
> >>>           }
> >>> -    } else if (pcias == 15) {
> >>> -        if ((4 - (offset & 0x3)) < len) {
> >>> -            program_interrupt(env, PGM_OPERAND, 4);
> >>> -            return 0;
> >>> -        }
> >>> -
> >>> -        if (zpci_endian_swap(&data, len)) {
> >>> +        break;
> >>> +    case 15:
> >>> +        /* ZPCI uses the pseudo BAR number 15 as configuration space */
> >>> +        /* possible access lengths are 1,2,4 and must not cross a word */
> >>> +        if (!len || (len > (4 - (offset & 0x3))) || len == 3) {
> >>>               program_interrupt(env, PGM_OPERAND, 4);
> >>>               return 0;
> >>>           }
> >>> -
> >>> +        /* len = 1,2,4 so we do not need to test */
> >>> +        zpci_endian_swap(&data, len);
> >>>           pci_host_config_write_common(pbdev->pdev, offset,
> >>>                                        pci_config_size(pbdev->pdev),
> >>>                                        data, len);
> >>> -    } else {
> >>> +        break;
> >>> +    default:
> >>>           DPRINTF("pcistg invalid space\n");
> >>>           setcc(cpu, ZPCI_PCI_LS_ERR);
> >>>           s390_set_status_code(env, r2, ZPCI_PCI_ST_INVAL_AS);  
> >>
> >> Other than the nits, looks good.  
> >   
> 
> 
