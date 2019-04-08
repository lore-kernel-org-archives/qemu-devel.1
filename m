Received: from eggs.gnu.org ([209.51.188.92]:60777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1hDJM9-0002ib-LA
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 21:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1hDJM8-0005aJ-GB
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 21:45:53 -0400
References: <1554624893-8363-1-git-send-email-guoheyi@huawei.com>
	<CAFEAcA-N=y3k41oexvYaQ+tKj1d2tCZh8MhPvdq8Uz7dh-eWWA@mail.gmail.com>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <cb3534ef-2bd0-0518-c6ca-01c1f6511199@huawei.com>
Date: Mon, 8 Apr 2019 09:45:32 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-N=y3k41oexvYaQ+tKj1d2tCZh8MhPvdq8Uz7dh-eWWA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] arm/virt: add one more uart for UEFI runtime
 debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, wanghaibin.wang@huawei.com, Laszlo Ersek <lersek@redhat.com>



On 2019/4/7 21:16, Peter Maydell wrote:
> On Sun, 7 Apr 2019 at 09:19, Heyi Guo <guoheyi@huawei.com> wrote:
>> This patch is based on the discussion in TianoCore edk2-devel mailing
>> list:
>> https://lists.01.org/pipermail/edk2-devel/2019-March/037986.html
>>
>> The conclusion is that we need an individual UART for UEFI runtime
>> services to print debug message at runtime, to avoid conflicting with
>> the system UART. We cannot use the secure UART either, for we may both
>> have Trusted Firmware and UEFI runtime services running on the VM, and
>> it is not easy to keep synchronization between the two components.
> I don't think it makes much sense to keep adding UARTs for every
> bit of the system software stack. We don't have an infinite
> supply of UARTs on real hardware either -- how is this handled
> there ?
As you were in the edk2 mail thread, I supposed you also agreed to add one more UART. What did you mean by "I do still have a todo list item to add a 2nd UART"? How shall we do that?

On our real hardware platforms, we don't have a separate serial port for UEFI runtime services; that's the reason for why I had wanted to have an adaptable approach for platform without one more serial port...

>
> Also adding new UARTs to this board is awkward because of
> the weird choices various bits of software have made in
> reading the dtb and picking a UART if there's more than one
> listed.
>
>> @@ -713,13 +715,23 @@ static void create_uart(const VirtMachineState *vms, qemu_irq *pic, int uart,
>>       if (uart == VIRT_UART) {
>>           qemu_fdt_setprop_string(vms->fdt, "/chosen", "stdout-path", nodename);
>>       } else {
>> +        const char *status_string;
>> +
>> +        if (uart == VIRT_SECURE_UART) {
>> +            status_string = "secure-status";
>> +        } else {
>> +            status_string = "uefi-status";
> Where does this status string come from? The "secure-status" one
> is documented in the device tree spec and has a well defined
> meaning.
Sorry this came from my imagination, so I sent it as a "RFC" :)

Thanks,
Heyi

>
> thanks
> -- PMM
>
> .
>
