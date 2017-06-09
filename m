Received: from eggs.gnu.org ([2001:4830:134:3::10]:34040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1dJQ5U-0005Pw-T6
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 16:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1dJQ5R-0000cb-SF
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 16:00:53 -0400
Received: from mail1.windriver.com ([147.11.146.13]:43631)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Chris.Friesen@windriver.com>)
	id 1dJQ5R-0000c2-Ji
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 16:00:49 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v59K0im8017781
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <qemu-devel@nongnu.org>; Fri, 9 Jun 2017 13:00:44 -0700 (PDT)
Message-ID: <593AFE69.7090206@windriver.com>
Date: Fri, 9 Jun 2017 14:00:41 -0600
From: Chris Friesen <chris.friesen@windriver.com>
MIME-Version: 1.0
References: <593AC202.5000404@windriver.com>
In-Reply-To: <593AC202.5000404@windriver.com>
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

On 06/09/2017 09:42 AM, Chris Friesen wrote:
> Hi,
>
> I'm investigating an issue seen over a live migration from a modified
> qemu-kvm-ev-2.3.0-31.el7_2.7.1 to a modified qemu-kvm-ev-2.6.0-28.el7_3.9.1.  We
> hit an issue down in get_pci_config_device() that caused the migration to fail.
>
> The qemu logs on the destination are included below.
>
> I'm looking for some guidance on the call flow that leads to this function, and
> the likely causes of the bad config data.  And if anyone can help me decode the
> config data information in the log (cmask/wmask/wlcmask) and the logic of the
> "bad config data" check I'd appreciate it.

I think what I end up with is that byte 0x20 (ie 32) of the PCI config for the 
virtio-blk device is 0 in the data coming over the wire, and 0xC in the local 
copy.  Since cmask is 0xff we need to check all the bits in the byte, and both 
wmask and w1cmask are 0 so the version on the wire and the local version should 
be the same.

Does that seem right?

Chris
