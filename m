Received: from eggs.gnu.org ([2001:4830:134:3::10]:44563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dk8kE-00071V-KK
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dk8k9-0008NJ-LZ
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:57:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dk8k9-0008N2-Ey
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:57:17 -0400
Date: Tue, 22 Aug 2017 14:57:13 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170822145713.7f2da9cf.cohuck@redhat.com>
In-Reply-To: <20170822113914.3ff24d75.cohuck@redhat.com>
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-8-cohuck@redhat.com>
	<0d8dcac1-f536-5d69-0187-23656d003348@linux.vnet.ibm.com>
	<17cb7925-e4eb-d174-2886-49ab9af0852c@linux.vnet.ibm.com>
	<20170822103955.1cbc0714.cohuck@redhat.com>
	<b7e7810c-7822-2fb8-2a2e-d67c08126639@linux.vnet.ibm.com>
	<20170822113914.3ff24d75.cohuck@redhat.com>
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

On Tue, 22 Aug 2017 11:39:14 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 22 Aug 2017 11:20:51 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
> > On 08/22/2017 10:39 AM, Cornelia Huck wrote:  
> > >> I'm fine either way. If I imagine having a lots of adapter types, then I
> > >> would expect a switch or a jumptable on the type before handling control
> > >> to the pci specific function. In this case statically not supported types
> > >> would probably get caught by the default branch of the switch and for a
> > >> jumptable it could even handle the dynamic case (based on the facilities)
> > >> trivially. In short both approaches can make sense.    
> > > I'm also wondering at the naming (the command sounds very
> > > pci-specific). I'd just stick with this approach (modulo a possible
> > > change of the response code, for which I need to rely on you guys).
> > >     
> > 
> > 
> > Well, the QEMU name of the command is misleading misleading. In the AR
> > it's called 'Configure I/O Adapter'. The PCI comes into the picture via
> > byte 8 of the SCCB, the so called adapter type. Valid values for the
> > adapter type are: 00-01 reserved; 02 PCI function; 03-FF reserved. So
> > at this point we only have PCI.  
> 
> OK, misleading naming combined with missing documentation leads to
> confusion...
> 
> So:
> 
> - s/PCI/IOA/ for SCLP_CMDW_{CONFIGURE,DECONFIGURE}_PCI
> - have a switch/case over byte 8 with only one case (pci)

- switch to response code 0x06f0 instead of invalid command

> - move the pci feature check into the pci code(? - not sure)
> 
> There's still the question of when this sclp command first became
> available...

...because we probably want to indicate invalid command for older
machine types (or is there another facility bit?)

Another question: There's the sclp facilities bit SCLP_HAS_PCI_RECONFIG
- is that really pci, or I/O adapter as for the actual commands?

[The Linux kernel uses the _PCI naming scheme, so I can't derive
anything from that.]
