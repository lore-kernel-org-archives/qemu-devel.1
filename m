Received: from eggs.gnu.org ([2001:4830:134:3::10]:49981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gYsk7-0005vL-RF
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:15:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gYse3-00017q-12
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:09:18 -0500
References: <20181207160806.13569-1-mark.cave-ayland@ilande.co.uk>
	<20181207160806.13569-3-mark.cave-ayland@ilande.co.uk>
	<20181212083250.56xfzy5j4t4o6ale@sirius.home.kraxel.org>
	<f7fb9204-bfc1-f27b-d66c-51e650a30cd5@ilande.co.uk>
	<20181212133809.evtizdym6awwkw7f@sirius.home.kraxel.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <4d66d1ac-8b4a-748d-543a-1642e153e323@ilande.co.uk>
Date: Mon, 17 Dec 2018 13:09:05 +0000
MIME-Version: 1.0
In-Reply-To: <20181212133809.evtizdym6awwkw7f@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] mac_newworld: enable access to EDID
 data for the VGA device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On 12/12/2018 13:38, Gerd Hoffmann wrote:

> On Wed, Dec 12, 2018 at 08:54:37AM +0000, Mark Cave-Ayland wrote:
>> On 12/12/2018 08:32, Gerd Hoffmann wrote:
>>
>>> On Fri, Dec 07, 2018 at 04:08:05PM +0000, Mark Cave-Ayland wrote:
>>>> This is in preparation for some upcoming QEMU NDRV driver changes that pass
>>>> display information from the host to the guest.
>>>
>>>> -    pci_vga_init(pci_bus);
>>>> +    dev = qdev_create(BUS(pci_bus), "VGA");
>>>> +    qdev_prop_set_int32(dev, "addr", -1);
>>>> +    qdev_prop_set_bit(dev, "edid", true);
>>>> +    qdev_init_nofail(dev);
>>>
>>> Hmm.  IMO you should not overwrite the device defaults here.
>>>
>>> edid is off by default only because it is new and I'm conservative.
>>> I want a release (or two) with it being available for user testing.
>>> If no issues pop up flip it to default on.
>>
>> Oh, okay. I already have some unreleased guest code that makes use of this, so my
>> questions would be: how can EDID be enabled from the command line for in-built VGA
>> devices,
> 
> "-global VGA.edid=on" should do.
> 
>> and how do I detect whether EDID support is present from the guest?
> 
> Check whenever the header is present.  The edid blob has a fixed 8 byte
> header (00 FF FF FF FF FF FF 00).  The linux kernel driver is lazy and
> checks the first two bytes only.
> 
>> Otherwise a guest driver that assumes it is always present and tries
>> to read from that area of memory will crash.
> 
> Oh, reading should work no matter what.  You just don't find valid edid
> data there if it is turned off.

Thanks for the info. My current use case for this is passing a set of possible guest
display resolutions from the host to the guest driver, rather than using an internal
hard-coded list. I guess that over time QEMU could become "smarter" about building
the list of supported resolutions depending upon the capabilities of the host?


ATB,

Mark.
