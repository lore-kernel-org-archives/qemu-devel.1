Received: from eggs.gnu.org ([2001:4830:134:3::10]:38148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eOnZe-0004xe-58
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 11:38:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eOnZc-0001BE-P5
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 11:38:30 -0500
References: <09e7b89f-27f2-1787-b371-7b0c0eff78b8@redhat.com>
	<CAFEAcA-357eVt3s_7ULWxssQttvAV0DkUv_tGkyk8umVgfH1QA@mail.gmail.com>
	<d776710c-2255-947b-22c6-336e9491bb81@redhat.com>
	<CAKv+Gu9e6qwJ4=t=UHHGsVs1XM26agh17Mgy0ckAvUsy+2xi2A@mail.gmail.com>
	<CAFEAcA9JzK8sNF5TmENfXZ-NBJwfp03b2La4YQ=N2i1ZCzrNBw@mail.gmail.com>
	<CAKv+Gu_mzynBKSBSdtUhKRgNd3KmuJTwiNZpmvPCfkRDo_QCgA@mail.gmail.com>
	<CAFEAcA9HAcZTi6bT-FbsG9LtqO=4s7rpcz0niZbimG834t4uHA@mail.gmail.com>
	<CAKv+Gu8gZ-Y4-zV2GRgbXPcignAg3vi8__XaFXqAhYOZOL7GcQ@mail.gmail.com>
	<CAFEAcA8OY3PFk_bermKxQBuF_th7SudHgaRk8wf76EAGYnoCGw@mail.gmail.com>
	<CAKv+Gu_939a=cui76H5FqCZwbWqDUYhegNe18T+tBpq7CW+TrA@mail.gmail.com>
	<20171212145138.dqw6op2orgynlykk@kamzik.brq.redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a4410334-b9c9-3158-7b01-f1ba2db6d7f5@redhat.com>
Date: Tue, 12 Dec 2017 17:38:19 +0100
MIME-Version: 1.0
In-Reply-To: <20171212145138.dqw6op2orgynlykk@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/arm/virt-acpi-build: Add second
 UART to ACPI tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrea Bolognani <abologna@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>

On 12/12/17 15:51, Andrew Jones wrote:
> On Tue, Dec 12, 2017 at 02:31:05PM +0000, Ard Biesheuvel wrote:
>> On 12 December 2017 at 14:17, Peter Maydell
>> <peter.maydell@linaro.org> wrote:
>>> On 12 December 2017 at 14:16, Ard Biesheuvel
>>> <ard.biesheuvel@linaro.org> wrote:
>>>> On 12 December 2017 at 14:13, Peter Maydell
>>>> <peter.maydell@linaro.org> wrote:
>>>>> On 12 December 2017 at 14:12, Ard Biesheuvel
>>>>> <ard.biesheuvel@linaro.org> wrote:
>>>>>> On 12 December 2017 at 14:10, Peter Maydell
>>>>>> <peter.maydell@linaro.org> wrote:
>>>>>>> That doesn't actually usefully separate debug output from the
>>>>>>> console, though, because stdout-path is also going to point
>>>>>>> to the UART with the lowest physical address...
>>>>>>>
>>>>>>
>>>>>> By default, yes, just like is currently the case. But I would
>>>>>> assume this new serial port could be appointed 'console' and put
>>>>>> into stdout-path by QEMU, based on the command line options?
>>>>>
>>>>> We don't have any command line options for doing that, and I'm
>>>>> generally reluctant to introduce new command line UI, especially
>>>>> new command line UI that's specific to Arm and not also needed
>>>>> for x86.
>>>>>
>>>>
>>>> If stdout-path is always going to point to pl011@0x9000000, why
>>>> would we need to parse it?
>>>
>>> If you had always parsed stdout-path, we wouldn't need to worry
>>> about the order in which the UART nodes appear in the dtb...
>>>
>>
>> That's a fair point. But it still does not justify introducing added
>> complexity in the firmware, if the conclusion is always going to be
>> that the console will be on pl011@9000000.
>>
>> To Drew's point re DEBUG builds, I don't think we should generally
>> enable DEBUG and send the output to nowhereland if the user does not
>> wire it up. That's a MMIO trap and two world switches for each
>> character written, if I am not mistaken, and the DEBUG builds are
>> very noisy.
>
> 100% agree, which is why I said "If a user wires up a second UART...",
> but I guess my "Not wiring it up would lose the messages..." sentence
> was ambiguous. I didn't mean they'd output to no where, I meant those
> messages wouldn't be output. I.e. some sort of debug_printf() function
> would be written that only actually does a write when there's a debug
> UART on the other end to write to.

Right; this can be implemented based on the DTB. Please see below.


> I just commented on patch 2/3 of this series asking if we shouldn't
> just not allocate the second UART's MMIO region and IRQ, when the user
> doesn't provide a '-serial' option for it. If we didn't, then AAVMF
> would just not output debug messages when only one UART (the console)
> is found in the DT.

This is what we ultimately want down-stream, yes; but up-stream, it
would be an incompatible change -- DEBUG builds used with one UART only
would suddenly not produce debug messages.


I don't think I can continue discussing this without going into
ArmVirtQemu specifics. We have the following layers of drivers and
library classes / instances (more abstract higher up on the diagram).

The top left node stands for debug messages written by any modules, and
the top right node stands for the abstraction (EFI_SERIAL_IO_PROTOCOL)
through which interactive console / terminal IO occurs ultimately (it
requires a few more layers on top but those don't matter for now).


[any driver that writes debug messages]    SerialDxe
  |  |                                     (DXE driver that produces
  |  |                                     EFI_SERIAL_IO_PROTOCOL;
  |  DebugLib:BaseDebugLibNull  +-----+----uses DebugLib for one
  |  (used for RELEASE builds; /     /     ASSERT_EFI_ERROR();
  |  DEBUG messages are dropped     /      uses SerialPortLib for
  |  indiscriminately)             /       producing
  |                               /        EFI_SERIAL_IO_PROTOCOL)
  |                              /           |
  DebugLib:BaseDebugLibSerialPort            |
  (for DEBUG / NOOPT builds;                 |
  debug messages are written to              |
  the serial port)                           |
    |  |                                     |
    |  |                                     |
    |  SerialPortLib: FdtPL011SerialPortLib  |
    |  (used by DXE and later modules, the UART
    |  base need not be parsed repeatedly from the
    |  DTB)                                       \
    |                                              \
    |                                               \
    SerialPortLib: EarlyFdtPL011SerialPortLib        \
    (used for early (pre-DXE) modules; the   \        +
    DTB is parsed on every serial port        \       |
    action for the UART base address)          \      |
                                                \     |
                                                 \    |
                                                  PL011UartLib
                                                  (actual hw access)

This is super messy, because in a DEBUG build, debug messages (such as
an assertion failure report) in SerialDxe itself would have to be logged
to "one" serial port, but the exact same driver should use the "other"
serial port for implementing EFI_SERIAL_IO_PROTOCOL. Currently both
"paths" go through FdtPL011SerialPortLib, which -- i.e., the
SerialPortLib *class* itself -- cannot handle more than one serial port
(in the same UEFI executable).

So, for upstream,

(1) we need two new DebugLib instances (pre-DXE, and DXE-or-later), for
    the ArmVirtQemu platform, such that they use PL011UartLib directly,
    without going through the SerialPortLib class.

    These DebugLib instances will have to parse the DTB for the UART
    base address (on all calls, or initially). If there is only one
    UART, use that, otherwise, use the one that is found second in the
    DTB.

(2) In RELEASE builds, BaseDebugLibNull should remain OK (DEBUG messages
    are dropped statically).

(3) The current SerialPortLib instances need not be changed; they can
    continue using the first UART found in the DTB.


For downstream, the DebugLib instances from (1) can be customized so
that debug messages are dropped if only one UART is found in the DTB.
(I.e., never write a DEBUG message unless you can write it separate from
whatever port is used by FdtPL011SerialPortLib.)

Thanks,
Laszlo
