Received: from eggs.gnu.org ([2001:4830:134:3::10]:53072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cQrz5-0005WE-7U
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:40:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cQrz2-0005TE-6T
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:40:47 -0500
References: <1482459390-14386-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170110003733-mutt-send-email-mst@kernel.org>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58749F4C.9080902@cn.fujitsu.com>
Date: Tue, 10 Jan 2017 16:46:04 +0800
MIME-Version: 1.0
In-Reply-To: <20170110003733-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pcie: remove duplicate assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, qemu-trivial@nongnu.org



On 01/10/2017 06:37 AM, Michael S. Tsirkin wrote:
> On Fri, Dec 23, 2016 at 10:16:30AM +0800, Cao jin wrote:
>> "size >= 8" connote "size > 0"
>>
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> 
> Isn't the point to check for overflows?
> 

Make sense. If it is intended to check overflows, the following sequence
would make more sense:

    assert(offset >= PCI_CONFIG_SPACE_SIZE);
    assert(size >= 8);
    assert(offset < offset + size);
    assert(offset + size <= PCIE_CONFIG_SPACE_SIZE);

or else, size 0 will pass the assert(offset < offset + size) first and
hit assert(size >= 8)
-- 
Sincerely,
Cao jin

>> ---
>>  hw/pci/pcie.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>> index 39b10b852d91..f864c5cd5458 100644
>> --- a/hw/pci/pcie.c
>> +++ b/hw/pci/pcie.c
>> @@ -668,7 +668,6 @@ void pcie_add_capability(PCIDevice *dev,
>>      uint16_t next;
>>  
>>      assert(offset >= PCI_CONFIG_SPACE_SIZE);
>> -    assert(offset < offset + size);
>>      assert(offset + size <= PCIE_CONFIG_SPACE_SIZE);
>>      assert(size >= 8);
>>      assert(pci_is_express(dev));
>> -- 
>> 2.1.0
>>
>>
> 
> 
> 
