Received: from eggs.gnu.org ([2001:4830:134:3::10]:36507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d0oMg-0003wb-Dx
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d0oMa-0008PZ-PW
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:05:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41746
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d0oMa-0008P4-KJ
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:05:36 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3JC3ZML059731
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 08:05:35 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29x77cs6jp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 08:05:35 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 19 Apr 2017 13:05:31 +0100
Date: Wed, 19 Apr 2017 14:05:22 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170419014207.GT25239@thinpad.lan.raisama.net>
References: <20170418221724.5707-1-ehabkost@redhat.com>
	<20170418221724.5707-4-ehabkost@redhat.com>
	<20170419002926.GC23273@umbus.fritz.box>
	<20170419014207.GT25239@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170419140522.391f0b50.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC v2 3/6] pci: Rename and change signatures of
 pci_bus_new() & related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Paul Burton <paul.burton@imgtec.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Scott Wood <scottwood@freescale.com>, Yongbok Kim <yongbok.kim@imgtec.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Tue, 18 Apr 2017 22:42:07 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, Apr 19, 2017 at 10:29:26AM +1000, David Gibson wrote:
> > On Tue, Apr 18, 2017 at 07:17:21PM -0300, Eduardo Habkost wrote:
> > > pci_bus_new*() and pci_register_bus() work only when the 'parent'
> > > argument is a PCI_HOST_BRIDGE object. Rename them to reflect that they
> > > are meant to initialize a bus that's in a PCI host bridge.
> > > 
> > > The new function names are:
> > > * pci_host_bus_init() (replacing pci_bus_new())
> > > * pci_host_bus_init_inplace() (replacing pci_bus_new_inplace())
> > > * pci_host_bus_init_irqs() (replacing pci_register_bus())
> > 
> > I like the idea, but I'm not terribly convinced by these names.
> > Aren't functions which allocate objects usually called whatever_new()
> > rather than whatever_init()?  And pci_register_bus() appears to do
> > more than just initialize irqs.
> 
> I agree the names aren't terribly clear. This is what they are
> supposed to mean:
> 
> * pci_host_bus_init(phb) initializes phb->bus.
> * pci_host_bus_init(phb) initializes phb->bus using an
>   already-allocated object.
> * pci_host_bus_init_irqs() does the same as pci_host_bus_init(),
>   but also calls pci_bus_irqs().
> 
> I plan to submit API documentation comments later. I am open to
> alternative name suggestions.
> 

pci_host_bus_init_irqs() sounds as if it would only init irqs. What
about:

pci_host_bus_new()
pci_host_bus_new_inplace()
pci_host_bus_new_with_irqs()

(the last one might be a bit long, though, especially as it takes so
many arguments already)
