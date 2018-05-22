Received: from eggs.gnu.org ([2001:4830:134:3::10]:51046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fLCKI-0002VE-Tx
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fLCKF-0007kl-0w
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:48:02 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fLCKE-0007kX-Ne
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:47:58 -0400
Received: by mail-wm0-x235.google.com with SMTP id l1-v6so2569170wmb.2
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 11:47:58 -0700 (PDT)
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-2-git-send-email-whois.zihan.yang@gmail.com>
	<aa70021d-242e-5923-9e37-154a93d36e95@gmail.com>
	<CAKwiv-hBJHbOdEBn-_oQodfOirFCyQVaUoswpns0TW_xMX8d=g@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <218ab985-cacd-c635-6c61-3193dadb7975@gmail.com>
Date: Tue, 22 May 2018 21:47:54 +0300
MIME-Version: 1.0
In-Reply-To: <CAKwiv-hBJHbOdEBn-_oQodfOirFCyQVaUoswpns0TW_xMX8d=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC 1/3] pci_expander_bridge: reserve enough mcfg
 space for pxb host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>



On 05/22/2018 08:59 AM, Zihan Yang wrote:
> Hi Marcel,
>
> Thanks a lot for your feedback.
>
> > I don't think we should try to place the MMCFGs before 4G even if there
> > is enough room. Is better to place them always after 4G.
> >
> > "above_4g_mem" PCI hole it is reserved for PCI devices hotplug. We 
> cannot use if for
> > MMCFGs. What I think we can do is to "move" the 64 bit PCI hole 
> after the MMCFGs.
> > So the layout of over 4G space will be:
> >
> > [RAM hotplug][MMCFGs][PCI hotplug]...
>
> OK, I will reorganize the memory layout. Should the number of MMCFG be 
> limited,
> as there might be insufficient memory above 4G?
>

Is not about the memory, is about the address space that can be reached 
by the CPU
(CPU addressable bits).
The total address space used by all MMCFGs should be CPU addressable.
But is too early at this stage to discuss that, just keep it in mind.

> > Do you need the  number of existing expander hosts? We have a 
> pxbdev_list, just query it.
>
> Great, I think I missed that list.
>
> > The above will need to change. We move the pci hole, not resize it.
> > I am not sure this is the right place to handle it, maybe we add a 
> new property
> > right beside pci_hole ones (extra-mmcfg?) and default it to 0.
>
> That sounds good, so that we just need to check this range when setting
> mcfg table instead of traversing the host bridge list.
>
> > You cannot use the MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT as it is in use
> > by the "main" root complex MMCFG. Actually I don't think we can come up
> > with a valid default.
>
> I see, I'll replcae it with unmapped then.
>
> > Be aware this is used by both pxb and pxb-pcie devices, I think you 
> should split the type
> >for each one and let the pxb's one as before.
>
> OK, I had thought it would make codes simpler, as TYPE_PCIE_HOST_BRIDGE
> is also the child of TYPE_PCI_HOST_BRIDGE, but I did forget about the pxb
> devices. I'll split it in v2.
>

Thanks,
Marcel

> Thanks
> Zihan
