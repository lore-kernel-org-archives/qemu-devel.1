Received: from eggs.gnu.org ([2001:4830:134:3::10]:45785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1dJWh2-0005dh-HM
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 23:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1dJWgx-00075y-L3
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 23:04:04 -0400
Received: from mail.windriver.com ([147.11.1.11]:60480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Chris.Friesen@windriver.com>)
	id 1dJWgx-00075a-C0
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 23:03:59 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v59NI8qu010081
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <qemu-devel@nongnu.org>; Fri, 9 Jun 2017 16:18:12 -0700 (PDT)
Message-ID: <593B2CAD.2000200@windriver.com>
Date: Fri, 9 Jun 2017 17:18:05 -0600
From: Chris Friesen <chris.friesen@windriver.com>
MIME-Version: 1.0
References: <593AC202.5000404@windriver.com> <593AFE69.7090206@windriver.com>
In-Reply-To: <593AFE69.7090206@windriver.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] call flow to hit get_pci_config_device() during
 live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 06/09/2017 02:00 PM, Chris Friesen wrote:

> I think what I end up with is that byte 0x20 (ie 32) of the PCI config for the
> virtio-blk device is 0 in the data coming over the wire, and 0xC in the local
> copy.  Since cmask is 0xff we need to check all the bits in the byte, and both
> wmask and w1cmask are 0 so the version on the wire and the local version should
> be the same.

I've confirmed that if I boot with a machine type of pc-i440fx-2.2 on the older 
version of qemu then I get different output in lspci -vv for the virtio-blk device.

One the older version I get:

         Region 0: I/O ports at c000 [size=64]
         Region 1: Memory at febd6000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [40] MSI-X: Enable+ Count=2 Masked-
                 Vector table: BAR=1 offset=00000000
                 PBA: BAR=1 offset=00000800


On the new version I get:

         Region 0: I/O ports at c000 [size=64]
         Region 1: Memory at febd2000 (32-bit, non-prefetchable) [size=4K]
         Region 4: Memory at fe004000 (64-bit, prefetchable) [size=16K]
         Capabilities: [98] MSI-X: Enable+ Count=2 Masked-
                 Vector table: BAR=1 offset=00000000
                 PBA: BAR=1 offset=00000800
         Capabilities: [84] Vendor Specific Information: Len=14 <?>
         Capabilities: [70] Vendor Specific Information: Len=14 <?>
         Capabilities: [60] Vendor Specific Information: Len=10 <?>
         Capabilities: [50] Vendor Specific Information: Len=10 <?>
         Capabilities: [40] Vendor Specific Information: Len=10 <?>

We had to patch the CentOS/RHEL versions of qemu-kvm-ev to enable support for 
the pc-i440fx-2.2 machine type, and it seems we missed something on the newer 
version.

Can someone point me to the code that sets up the PCI config space for the 
virtio-blk device?  I'd like to figure out what's adding Region 4 and the extra 
capabilities.

Chris
