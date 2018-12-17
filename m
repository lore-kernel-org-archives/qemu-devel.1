Received: from eggs.gnu.org ([2001:4830:134:3::10]:44236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gYjM4-0002ZA-Ra
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 22:14:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gYjM1-0001IW-K0
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 22:14:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongli.zhang@oracle.com>)
	id 1gYjLy-0001Dj-1X
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 22:13:59 -0500
References: <1545003279-17233-1-git-send-email-dongli.zhang@oracle.com>
	<20181216212319-mutt-send-email-mst@kernel.org>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <a8026b40-9556-c9c1-1bbc-e2991d6473cb@oracle.com>
Date: Mon, 17 Dec 2018 11:15:46 +0800
MIME-Version: 1.0
In-Reply-To: <20181216212319-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] msix: correct pba size calculation
 used for msix_exclusive_bar initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, Jason Wang <jasowang@redhat.com>

Hi Michael,

CCed Jason as this is related to commit a0ccd2123ee2 "pci: remove hard-coded bar
size in msix_init_exclusive_bar()"

Please see my reply inline.

On 12/17/2018 10:24 AM, Michael S. Tsirkin wrote:
> On Mon, Dec 17, 2018 at 07:34:39AM +0800, Dongli Zhang wrote:
>> The bar_pba_size is more than what the pba is expected to have, although
>> this usually would not affect the bar_size used for dev->msix_exclusive_bar
>> initialization.
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> 
> 
> If this does ever have an effect, we need a compat config
> for old machine types.
> Could you explain a bit more? Are there configs affected?
> What are these?

Here I copy parts of msix_init_exclusive_bar() and msix_init().

'bar_pba_size' is computed (line 348) in msix_init_exclusive_bar(), while
'pba_size' is computed (line 291) in msix_init().

msix_init_exclusive_bar() is one of callers of msix_init().

I think both 'bar_pba_size' and 'pba_size' are indicating the size of pba. The
difference is, while 'bar_pba_size' is used to initialize the size of
MemoryRegion (dev->msix_exclusive_bar), 'pba_size' is used to initialize the
config space in msix_init().

However, the equations to compute the two variables are different. Why would we
use different size for MemoryRegion and config space?


Thanks to line 365, both equations would reach at the same bar_size.

For instance, assuming nvme with 1333 queues,

with "uint32_t bar_pba_size = (nentries / 8 + 1) * 8;", bar_pba_size=1336 (line
348) and bar_size=32768 (line 365).

with "uint32_t bar_pba_size = QEMU_ALIGN_UP(nentries, 64) / 8;",
bar_pba_size=168 (line 348) and bar_size=32768 (line 365).

That's why I mentioned "this usually would not affect the bar_size used for
dev->msix_exclusive_bar initialization."



341 int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
342                             uint8_t bar_nr, Error **errp)
343 {
344     int ret;
345     char *name;
346     uint32_t bar_size = 4096;
347     uint32_t bar_pba_offset = bar_size / 2;
348     uint32_t bar_pba_size = (nentries / 8 + 1) * 8;
349
350     /*
351      * Migration compatibility dictates that this remains a 4k
352      * BAR with the vector table in the lower half and PBA in
353      * the upper half for nentries which is lower or equal to 128.
354      * No need to care about using more than 65 entries for legacy
355      * machine types who has at most 64 queues.
356      */
357     if (nentries * PCI_MSIX_ENTRY_SIZE > bar_pba_offset) {
358         bar_pba_offset = nentries * PCI_MSIX_ENTRY_SIZE;
359     }
360
361     if (bar_pba_offset + bar_pba_size > 4096) {
362         bar_size = bar_pba_offset + bar_pba_size;
363     }
364
365     bar_size = pow2ceil(bar_size);
366
367     name = g_strdup_printf("%s-msix", dev->name);
368     memory_region_init(&dev->msix_exclusive_bar, OBJECT(dev), name, bar_size);
369     g_free(name);
370
371     ret = msix_init(dev, nentries, &dev->msix_exclusive_bar, bar_nr,
372                     0, &dev->msix_exclusive_bar,
373                     bar_nr, bar_pba_offset,
374                     0, errp);
375     if (ret) {
376         return ret;
377     }
378
379     pci_register_bar(dev, bar_nr, PCI_BASE_ADDRESS_SPACE_MEMORY,
380                      &dev->msix_exclusive_bar);
381
382     return 0;
383 }


269 int msix_init(struct PCIDevice *dev, unsigned short nentries,
270               MemoryRegion *table_bar, uint8_t table_bar_nr,
271               unsigned table_offset, MemoryRegion *pba_bar,
272               uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos,
273               Error **errp)
274 {
275     int cap;
276     unsigned table_size, pba_size;
277     uint8_t *config;
278
279     /* Nothing to do if MSI is not supported by interrupt controller */
280     if (!msi_nonbroken) {
281         error_setg(errp, "MSI-X is not supported by interrupt controller");
282         return -ENOTSUP;
283     }
284
285     if (nentries < 1 || nentries > PCI_MSIX_FLAGS_QSIZE + 1) {
286         error_setg(errp, "The number of MSI-X vectors is invalid");
287         return -EINVAL;
288     }
289
290     table_size = nentries * PCI_MSIX_ENTRY_SIZE;
291     pba_size = QEMU_ALIGN_UP(nentries, 64) / 8;


Dongli Zhang


> 
> 
>> ---
>>  hw/pci/msix.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
>> index 702dac4..234c0a3 100644
>> --- a/hw/pci/msix.c
>> +++ b/hw/pci/msix.c
>> @@ -345,7 +345,7 @@ int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
>>      char *name;
>>      uint32_t bar_size = 4096;
>>      uint32_t bar_pba_offset = bar_size / 2;
>> -    uint32_t bar_pba_size = (nentries / 8 + 1) * 8;
>> +    uint32_t bar_pba_size = QEMU_ALIGN_UP(nentries, 64) / 8;
>>  
>>      /*
>>       * Migration compatibility dictates that this remains a 4k
>> -- 
>> 2.7.4
