Received: from eggs.gnu.org ([2001:4830:134:3::10]:52293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eOjDu-0007y4-At
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 06:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eOjDt-0005gb-AO
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 06:59:46 -0500
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-4-git-send-email-peter.maydell@linaro.org>
	<5A2F6ED9.5030605@huawei.com>
	<ac182406-8011-9f19-38e7-37328434095b@redhat.com>
	<CAFEAcA_9pee99KpL4zwVS5jJuiv2MCGp79crufpU1kH1Okg-Hg@mail.gmail.com>
	<6b4b6351-eeb4-a4d3-8ddf-5401516671ae@redhat.com>
	<CAKv+Gu-Ugm1g8twoKwgXAPtDfETvXntk2h4WzMVuUTDF7GhMvA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5e3798f7-e280-b6c3-1504-828283617c52@redhat.com>
Date: Tue, 12 Dec 2017 12:59:35 +0100
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-Ugm1g8twoKwgXAPtDfETvXntk2h4WzMVuUTDF7GhMvA@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Drew Jones <drjones@redhat.com>, Andrea Bolognani <abologna@redhat.com>

On 12/12/17 12:44, Ard Biesheuvel wrote:
> On 12 December 2017 at 11:33, Laszlo Ersek <lersek@redhat.com> wrote:
>> On 12/12/17 12:11, Peter Maydell wrote:
>>> On 12 December 2017 at 11:06, Laszlo Ersek <lersek@redhat.com> wrote:
>>>> BTW, has anyone tested this with the ArmVirtQemu firmware? As far as I
>>>> can see from the firmware code, the firmware will use the PL011 whose
>>>> description comes first in the DTB (and ignore the other PL011), in an
>>>> fdt_next_node() traversal. Is that OK for the intended use case?
>>>> (Perhaps I should have asked this under the second patch, which updates
>>>> the DTB generator.)
>>>
>>> I haven't tested, since I don't have a working setup for that to hand.
>>> (Do you have instructions somewhere for getting it working?)
>>
>> The Wiki page I most frequently refer to (for a libvirt-less description
>> anyway) is Ard's:
>>
>>   https://wiki.linaro.org/LEG/UEFIforQEMU
>>
>> There's also:
>>
>>   https://www.kraxel.org/repos/
>>   https://fedoraproject.org/wiki/Architectures/AArch64/Install_with_QEMU
>>
>>> The behaviour we would want would be for the firmware to keep using
>>> the PL011 at 0x09000000.
>>
>> With these QEMU patches, I reckon that's going to happen, yes.
>>
> 
> IIRC the DT nodes appear in the opposite order as they are added,

Oh! Thanks for catching that!

> so
> adding the second UART after adding the original one is probably going
> to cause trouble.
> 
> We do check the 'status' though, so if backward compatibility with
> older firmwares is a concern, we could set status=disabled, and let
> newer firmware builds enable it on the fly.

Peter, what is the intended use of the second UART?

(In the firmware, a second PL011 could be useful: it might make it
possible to separate the debug output (debug messages) from interactive
serial console IO. (On x86, in the default OVMF build, debug messages
are written to the QEMU debug IO port, and the serial port is used only
for interactive console IO.) I don't remember how important we deemed
this separation for aarch64, last time it surfaced.)

>>> (In an ideal world the firmware would
>>> prefer the UART marked in the 'stdout-path' in the DTB /chosen node,
>>> as the kernel does, I guess.)
>>
>> Hmmm, I recall that we used to have some code related to the /chosen
>> node... We have a helper function for locating that
>> (GetOrInsertChosenNode), but we no longer use it, it seems? The last
>> (only?) use was apparently removed in:
>>
>> https://github.com/tianocore/edk2/commit/29589acf1010
>>
>> I'll let Ard comment too.
>>
> 
> That would require us to implement some non-trivial parsing and alias
> resolution, given that stdout-path is simply a string that may refer
> to a UART node via an alias.

Let's not do that please...

Thanks
Laszlo
