Received: from eggs.gnu.org ([2001:4830:134:3::10]:41209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cX98R-00080u-7q
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cX98O-0002IJ-0H
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:12:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cX98N-0002IA-QG
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:12:19 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B94E0C04BD56
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 16:12:19 +0000 (UTC)
References: <1483559838-8797-1-git-send-email-marcel@redhat.com>
	<1483559838-8797-2-git-send-email-marcel@redhat.com>
	<20170110051006-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <f779df7a-1c31-0c44-773e-d6ae5b74e5d6@redhat.com>
Date: Fri, 27 Jan 2017 18:12:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170110051006-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] hw/pcie: fix Extended Configuration
 Space for devices with no Extended Capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, yvugenfi@redhat.com

On 01/10/2017 05:13 AM, Michael S. Tsirkin wrote:
> On Wed, Jan 04, 2017 at 09:57:15PM +0200, Marcel Apfelbaum wrote:
>> Absence of any Extended Capabilities is required to be
>> indicated by an Extended Capability header with a Capability ID of
>> 0000h, a Capability Version of 0h, and a Next Capability Offset of 000h.
>>
>> Instead of inserting a 'NULL' capability is simpler to mark the start
>> of the Extended Configuration Space as read-only to achieve the same
>> behaviour.
>>
>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>
> Kind of hacky and only theoretical - I don't think any guest writes
> there - but ok.

I agree is theoretical, but Windows PCI Hardware Compliance WHQL tests find it.

  However I think
> 1. we should init config to 0 too

What do you mean? Have a 'Null' capability for regular PCI capabilities list?
I'll have a look on the spec to see if is required.

> 2. this needs a compat flag

Sure, I'll add one.

Thanks,
Marcel

>
>> ---
>>  hw/pci/pcie.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>> index 99cfb45..62c1def 100644
>> --- a/hw/pci/pcie.c
>> +++ b/hw/pci/pcie.c
>> @@ -109,6 +109,9 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset, uint8_t type, uint8_t port)
>>                   PCI_EXP_DEVCAP2_EFF | PCI_EXP_DEVCAP2_EETLPP);
>>
>>      pci_set_word(dev->wmask + pos + PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_EETLPPB);
>> +
>> +    /* read-only to behave like a 'NULL' Extended Capability Header */
>> +    pci_set_long(dev->wmask + PCI_CONFIG_SPACE_SIZE, 0);
>>      return pos;
>>  }
>>
>> --
>> 2.5.5
