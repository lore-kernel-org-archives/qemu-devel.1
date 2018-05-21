Received: from eggs.gnu.org ([2001:4830:134:3::10]:60216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fKmet-0005Mq-KN
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fKmeo-0006qR-IW
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:23:35 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fKmeo-0006qJ-BY
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:23:30 -0400
Received: by mail-wr0-x242.google.com with SMTP id j1-v6so5454549wrm.1
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 08:23:30 -0700 (PDT)
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <287ca613-aaeb-b2b6-77ac-df3b9ceaf7cd@gmail.com>
Date: Mon, 21 May 2018 18:23:26 +0300
MIME-Version: 1.0
In-Reply-To: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC 0/3] pci_expander_brdige: Put pxb host bridge
 into separate pci domain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org

Hi Zihan

On 05/20/2018 10:28 AM, Zihan Yang wrote:

You do have patch 0, sorry for not seeing it, please disregard my prev 
comment.

> Currently only q35 host bridge is allocated an item in MCFG table, all pxb
> host bridges stay within pci domain 0. This series of patches put each pxb
> host bridge in separate pci domain, allocating a new MCFG table item for it.

Maybe we should add a parameter to the pxb-pci device specifying the PCI 
domain
instead of adding it on the fly. It will help ensuring the PCI domain 
will not change over
time due to code changes.In this case "bus sharing" should be off. For 
the moment
the pxb devices get the bus range from the same PCI domain.
> The pxb host does not have an mch in it, as q35 host already has one. All
> pxb host bridges just serve as expander bridges in QEMU, which makes them
> a lit
> tle simpler than q35 host bridge.
Agreed

> NOTE: These patches are just initial proof of concept, asking for suggestions.
>        The aml part and seabios part are not finished at all. This means it
>        still behaves like before, that all pci expander bridges stay in the
>        same pci domain as a35 host.

Looks promising!

Thanks,
Marcel

> Zihan Yang (3):
>    pci_expander_bridge: reserve enough mcfg space for pxb host
>    pci: Link pci_host_bridges with QTAILQ
>    acpi-build: allocate mcfg for multiple host bridges
>
>   hw/i386/acpi-build.c                        | 83 ++++++++++++++++++-------
>   hw/i386/pc.c                                |  5 ++
>   hw/pci-bridge/pci_expander_bridge.c         | 96 ++++++++++++++++++++++++++++-
>   hw/pci/pci.c                                |  9 +--
>   include/hw/pci-bridge/pci_expander_bridge.h |  7 +++
>   include/hw/pci/pci_host.h                   |  2 +-
>   6 files changed, 175 insertions(+), 27 deletions(-)
>   create mode 100644 include/hw/pci-bridge/pci_expander_bridge.h
>
