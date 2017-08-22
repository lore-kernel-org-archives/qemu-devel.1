Received: from eggs.gnu.org ([2001:4830:134:3::10]:38974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dk9yO-00023D-DK
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dk9yI-0000LS-1p
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:16:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dk9yH-0000Ki-Os
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:15:57 -0400
Date: Tue, 22 Aug 2017 16:15:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170822161553.03faaab4.cohuck@redhat.com>
In-Reply-To: <4a85cfd0-7b36-175c-4671-f8dbc10f4d9e@linux.vnet.ibm.com>
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-8-cohuck@redhat.com>
	<0d8dcac1-f536-5d69-0187-23656d003348@linux.vnet.ibm.com>
	<17cb7925-e4eb-d174-2886-49ab9af0852c@linux.vnet.ibm.com>
	<20170822103955.1cbc0714.cohuck@redhat.com>
	<b7e7810c-7822-2fb8-2a2e-d67c08126639@linux.vnet.ibm.com>
	<20170822113914.3ff24d75.cohuck@redhat.com>
	<ff247730-9d10-352c-b6dc-8d98198181cf@linux.vnet.ibm.com>
	<20170822152434.068b5038.cohuck@redhat.com>
	<4a85cfd0-7b36-175c-4671-f8dbc10f4d9e@linux.vnet.ibm.com>
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

On Tue, 22 Aug 2017 15:54:32 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 08/22/2017 03:24 PM, Cornelia Huck wrote:
> > On Tue, 22 Aug 2017 14:58:37 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> >> The availability of SCLP_CMDW_{,DE}CONFIGURE_IOA is indicated
> >> by the result of the read scp info command read info in
> >> ReadInfo.facilities. I think we should assume that the read scp
> >> info command is always there.  
> > 
> > Sure. But see the question in my other mail regarding the sclp
> > facilities bit (does it cover pci or adapter reconfiguration?)  
> 
> It (SCLP_HAS_PCI_RECONFIG) exactly  covers adapter reconfiguration.
> That's what I tried to say with the paragraph above.

Sorry, I did not get that before. So we have another confusing name...

I'll just provide SCLP_HAS_PCI_RECONFIG unconditionally. Maybe
s/PCI/IOA/ here as well?

> 
> >   
> >>
> >> I would appreciate someone with AR access double checking.  
> > 
> > I'd have hoped you had AR access :p  
> 
> Yes, my statements are based solely on my reading of the AR (me
> still lacks druid-knowledge). What I've asked for is a second
> opinion (because AR-s are a twisty maze).

Be careful that you don't get eaten by a grue.

> 
> >   
> >>  
> >>>
> >>> There's still the question of when this sclp command first became
> >>> available...
> >>>     
> >>
> >> I would argue that it should not be important for AR
> >> compliance. Currently it operates only on PCI so I doubt it
> >> pre-dates PCI. But I don't think the current implementation
> >> is buggy because it offers the sclp command regardless
> >> of the zPCI facility.  
> > 
> > I'm just wondering if there's another facility we're missing. The zpci
> > facility might imply presence of adapter reconfiguration, but are there
> > other facilities implying that as well, or even a dedicated facility?  
> 
> Yes. The SCLP facility with the facility code 33 (aka SCLP_HAS_PCI_RECONFIG).
> It is the dedicated facility.

OK.

> 
> I don't think zPCI architecturally implies the presence of this SCLP
> command. And logically I would say it's either the other way around
> adapter reconfiguration implies zPCI (because otherwise adapter
> reconfiguration would be completely useless) or bidirectional. 

Not sure how useful pci would be without this. I'll just assume that we
have the facility, regardless whether pci is enabled for that
particular machine or not.

> 
> >   
> >>
> >> I don't know where should I look for the historical details
> >> which go beyond the AR.  
> > 
> > If there is no independent facility, it is probably best to just always
> > provide the command, but fail for pci adapter type if the zpci facility
> > is off.  
> 
> IMHO we should SCLP_RC_INVALID_SCLP_COMMAND iff we don't provide
> SCLP_HAS_PCI_RECONFIG (which has bad name again s/PCI/IOA).

Nod.

> 
> I don't know of any facility except basic SCLP on which 
> SCLP_HAS_PCI_RECONFIG depends on. 
> 
> For me both presenting and not presenting SCLP_HAS_PCI_RECONFIG
> to the guest (via read SCP info SCLP command) in the absence of
> the zPCI feature makes sense. The late because of the likely historical
> reasons, the former because I think the AR allows it and it gives us more
> flexibility.

I'll go with always presenting it. We'll just fail with invalid adapter
type for !pci.

Thanks for digging through the AR!
