Received: from eggs.gnu.org ([2001:4830:134:3::10]:33790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eFOCI-0003U7-CI
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:43:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eFOCF-0002zn-4F
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:43:30 -0500
From: Thomas Huth <thuth@redhat.com>
References: <20171106203520.7880-1-michael.nawrocki@gtri.gatech.edu>
	<20171106203520.7880-2-michael.nawrocki@gtri.gatech.edu>
	<41891d99-8cb7-79a6-9aa7-0bfe3d192f41@redhat.com>
Message-ID: <59e0dcbc-ed53-8fc5-4a0f-3830056f2145@redhat.com>
Date: Thu, 16 Nov 2017 18:43:14 +0100
MIME-Version: 1.0
In-Reply-To: <41891d99-8cb7-79a6-9aa7-0bfe3d192f41@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Fix eepro100 simple transmission
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-s390x@nongnu.org, mst@redhat.com

On 16.11.2017 17:59, Thomas Huth wrote:
> On 06.11.2017 21:35, Mike Nawrocki wrote:
>> The simple transmission mode was treating the area immediately after the
>> transmit command block (TCB) as if it were a transmit buffer descriptor,
>> when in reality it is simply the packet data. This change simply copies
>> the data following the TCB into the packet buffer.
>>
>> Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
>> ---
>>  hw/net/eepro100.c | 18 +++---------------
>>  1 file changed, 3 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
>> index 80b8f47c4b..91dd058010 100644
>> --- a/hw/net/eepro100.c
>> +++ b/hw/net/eepro100.c
>> @@ -774,23 +774,11 @@ static void tx_command(EEPRO100State *s)
>>      }
>>      assert(tcb_bytes <= sizeof(buf));
>>      while (size < tcb_bytes) {
>> -        uint32_t tx_buffer_address = ldl_le_pci_dma(&s->dev, tbd_address);
>> -        uint16_t tx_buffer_size = lduw_le_pci_dma(&s->dev, tbd_address + 4);
>> -#if 0
>> -        uint16_t tx_buffer_el = lduw_le_pci_dma(&s->dev, tbd_address + 6);
>> -#endif
>> -        if (tx_buffer_size == 0) {
>> -            /* Prevent an endless loop. */
>> -            logout("loop in %s:%u\n", __FILE__, __LINE__);
>> -            break;
>> -        }
>> -        tbd_address += 8;
>>          TRACE(RXTX, logout
>>              ("TBD (simplified mode): buffer address 0x%08x, size 0x%04x\n",
>> -             tx_buffer_address, tx_buffer_size));
>> -        tx_buffer_size = MIN(tx_buffer_size, sizeof(buf) - size);
>> -        pci_dma_read(&s->dev, tx_buffer_address, &buf[size], tx_buffer_size);
>> -        size += tx_buffer_size;
>> +             tbd_address, tcb_bytes));
>> +        pci_dma_read(&s->dev, tbd_address, &buf[size], tcb_bytes);
>> +        size += tcb_bytes;
>>      }
>>      if (tbd_array == 0xffffffff) {
>>          /* Simplified mode. Was already handled by code above. */
>>
> 
>  Hi,
> 
> I've got no clue why, but apparently this patch introduced a regression
> in rc1: The tests/pxe-test is now failing on a big endian (s390x) host
> when testing the i82550 device.
> It's working fine with commit 8fa5ad6dfb66b6c695aa6a6b54b7031c (and
> 2.11-rc0), and it's broken starting with commit
> 1865e288a823c764cd4344d704e33344 ... do you have any clue what might be
> wrong here now?

This patch seems to fix the issue for me:

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index a63ed2c..03e00f7 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -756,8 +756,8 @@ static void read_cb(EEPRO100State *s)
 
 static void tx_command(EEPRO100State *s)
 {
-    uint32_t tbd_array = le32_to_cpu(s->tx.tbd_array_addr);
-    uint16_t tcb_bytes = (le16_to_cpu(s->tx.tcb_bytes) & 0x3fff);
+    uint32_t tbd_array = s->tx.tbd_array_addr;
+    uint16_t tcb_bytes = s->tx.tcb_bytes & 0x3fff;
     /* Sends larger than MAX_ETH_FRAME_SIZE are allowed, up to 2600 bytes. */
     uint8_t buf[2600];
     uint16_t size = 0;

Does that make sense? I think the fields are already swapped in
read_cb(), so no need to swap them in tx_command() again?

 Thomas
