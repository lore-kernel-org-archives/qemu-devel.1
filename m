Received: from eggs.gnu.org ([2001:4830:134:3::10]:42011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dk4jD-0005KF-Gj
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 04:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dk4jA-0007Ax-Dv
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 04:40:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dk4jA-0007Af-4t
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 04:40:00 -0400
Date: Tue, 22 Aug 2017 10:39:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170822103955.1cbc0714.cohuck@redhat.com>
In-Reply-To: <17cb7925-e4eb-d174-2886-49ab9af0852c@linux.vnet.ibm.com>
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-8-cohuck@redhat.com>
	<0d8dcac1-f536-5d69-0187-23656d003348@linux.vnet.ibm.com>
	<17cb7925-e4eb-d174-2886-49ab9af0852c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 07/10] s390x/sclp: properly guard
 pci-specific functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Mon, 21 Aug 2017 18:24:15 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 08/21/2017 04:58 PM, Pierre Morel wrote:
> > On 21/08/2017 11:16, Cornelia Huck wrote:  
> >> If we do not provide zpci, pci reconfiguration via sclp is not available
> >> either. Don't indicate it in the sclp facilities and return an invalid
> >> command if the guest tries to issue pci configure/deconfigure.
> >>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >> ---
> >>   hw/s390x/sclp.c | 19 +++++++++++++++----
> >>   1 file changed, 15 insertions(+), 4 deletions(-)
> >>

> >> @@ -385,10 +388,18 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
> >>           sclp_c->unassign_storage(sclp, sccb);
> >>           break;
> >>       case SCLP_CMDW_CONFIGURE_PCI:
> >> -        s390_pci_sclp_configure(sccb);
> >> +        if (s390_has_feat(S390_FEAT_ZPCI)) {
> >> +            s390_pci_sclp_configure(sccb);
> >> +        } else {
> >> +            sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);  
> > 
> > Hello Conny,
> > 
> > I find more logical if the response would be 0x06F0 : "Adapter type in SCCB not recognized"
> > Since we could have more than one adapter type... someday.
> > then the SCLP command would be valid but not the adapter type.  
> 
> I agree, 01F0 does not seem to be the correct answer, based on
> the AR as it seems to be tied to the command code.

What I'm wondering here: SCLP_CMDW_CONFIGURE_PCI was introduced at some
point in time (probably when pci was first introduced). On older
machines, invalid command sounds like the most logical response. Do you
know whether there's some tie-in to the machine version?

> Verifying what the machine does would be great though -- frankly
> I cant tell with absolute confidence what's the right thing to
> do based on my understanding of the AR. 

Multiply this by not having access to the AR :)

> > However, I will try to find a real hardware to test this since I noticed that my logic sometime... :) .
> > 
> > Another point is that don't you think that this test on S390_FEAT_ZPCI better belong to the dedicated PCI code inside of the s390_pci_sclp_configure().
> >  
> 
> I'm fine either way. If I imagine having a lots of adapter types, then I
> would expect a switch or a jumptable on the type before handling control
> to the pci specific function. In this case statically not supported types
> would probably get caught by the default branch of the switch and for a
> jumptable it could even handle the dynamic case (based on the facilities)
> trivially. In short both approaches can make sense.

I'm also wondering at the naming (the command sounds very
pci-specific). I'd just stick with this approach (modulo a possible
change of the response code, for which I need to rely on you guys).
