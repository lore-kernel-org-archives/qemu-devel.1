Received: from eggs.gnu.org ([2001:4830:134:3::10]:34239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fL0K7-0003m0-VV
	for qemu-devel@nongnu.org; Tue, 22 May 2018 01:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fL0K6-0000wN-OV
	for qemu-devel@nongnu.org; Tue, 22 May 2018 01:59:04 -0400
Received: from mail-lf0-x231.google.com ([2a00:1450:4010:c07::231]:45771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fL0K6-0000vp-FL
	for qemu-devel@nongnu.org; Tue, 22 May 2018 01:59:02 -0400
Received: by mail-lf0-x231.google.com with SMTP id w202-v6so27252936lff.12
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 22:59:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <aa70021d-242e-5923-9e37-154a93d36e95@gmail.com>
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-2-git-send-email-whois.zihan.yang@gmail.com>
	<aa70021d-242e-5923-9e37-154a93d36e95@gmail.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Tue, 22 May 2018 13:59:00 +0800
Message-ID: <CAKwiv-hBJHbOdEBn-_oQodfOirFCyQVaUoswpns0TW_xMX8d=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hi Marcel,

Thanks a lot for your feedback.

> I don't think we should try to place the MMCFGs before 4G even if there
> is enough room. Is better to place them always after 4G.
>
> "above_4g_mem" PCI hole it is reserved for PCI devices hotplug. We cannot
use if for
> MMCFGs. What I think we can do is to "move" the 64 bit PCI hole after the
MMCFGs.
> So the layout of over 4G space will be:
>
> [RAM hotplug][MMCFGs][PCI hotplug]...

OK, I will reorganize the memory layout. Should the number of MMCFG be
limited,
as there might be insufficient memory above 4G?

> Do you need the  number of existing expander hosts? We have a
pxbdev_list, just query it.

Great, I think I missed that list.

> The above will need to change. We move the pci hole, not resize it.
> I am not sure this is the right place to handle it, maybe we add a new
property
> right beside pci_hole ones (extra-mmcfg?) and default it to 0.

That sounds good, so that we just need to check this range when setting
mcfg table instead of traversing the host bridge list.

> You cannot use the MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT as it is in use
> by the "main" root complex MMCFG. Actually I don't think we can come up
> with a valid default.

I see, I'll replcae it with unmapped then.

> Be aware this is used by both pxb and pxb-pcie devices, I think you
should split the type
>for each one and let the pxb's one as before.

OK, I had thought it would make codes simpler, as TYPE_PCIE_HOST_BRIDGE
is also the child of TYPE_PCI_HOST_BRIDGE, but I did forget about the pxb
devices. I'll split it in v2.

Thanks
Zihan
