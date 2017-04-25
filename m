Received: from eggs.gnu.org ([2001:4830:134:3::10]:36180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1d2q2P-0003qS-9A
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 22:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1d2q2M-0000KN-4a
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 22:17:09 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3522
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1d2q2L-0000IO-Fr
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 22:17:06 -0400
References: <58FDF9BD.2030100@huawei.com>
	<20170425024324-mutt-send-email-mst@kernel.org>
From: "Herongguang (Stephen)" <herongguang.he@huawei.com>
Message-ID: <58FEB184.4060102@huawei.com>
Date: Tue, 25 Apr 2017 10:16:36 +0800
MIME-Version: 1.0
In-Reply-To: <20170425024324-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] pci: deassert intx when pci device
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: marcel@redhat.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxinxin.wang@huawei.com >> wangxin (U)" <wangxinxin.wang@huawei.com>



On 2017/4/25 7:45, Michael S. Tsirkin wrote:
> On Mon, Apr 24, 2017 at 09:12:29PM +0800, Herongguang (Stephen) wrote:
>> If a pci device is not reset by VM (by writing into config space)
>> and unplugged by VM, after that when VM reboots, qemu may assert:
>> pcibus_reset: Assertion `bus->irq_count[i] == 0' failed
>>
>> Signed-off-by: herongguang <herongguang.he@huawei.com>
>
> Good grief, I can't believe we have had this bug for so long.
> Thanks a lot for finding this.
>
> Pls Cc stable on this patch.
>
>> ---
>>
>> Is there need to call pci_do_device_reset()?
>
> I don't think so, why?
>
>> ---
>>   hw/pci/pci.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 259483b..afe6397 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -1078,6 +1078,7 @@ static void pci_qdev_unrealize(DeviceState *dev, Error **errp)
>>
>>       pci_unregister_io_regions(pci_dev);
>>       pci_del_option_rom(pci_dev);
>> +    pci_device_deassert_intx(pci_dev);
>
> I think the right place to call this is after class exit
> when we know no one will try to assert the interrupt.

OK, it's safer, will resend a new patch.

>
>>
>>       if (pc->exit) {
>>           pc->exit(pci_dev);
>> --
>> 1.7.12.4
> .
>
