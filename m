Received: from eggs.gnu.org ([2001:4830:134:3::10]:45829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eP9U7-0006Bf-QM
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:02:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eP9U1-0002xs-Vf
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:02:15 -0500
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-4-git-send-email-peter.maydell@linaro.org>
	<5A2F6ED9.5030605@huawei.com>
	<ac182406-8011-9f19-38e7-37328434095b@redhat.com>
	<CAFEAcA8ySsNx-rz__Nfbmd+QM3nKbgRXJtwSYjhRRvqbokt+uQ@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <0355e1ee-2f48-81ce-55e6-bed7bdeac771@redhat.com>
Date: Wed, 13 Dec 2017 17:01:53 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ySsNx-rz__Nfbmd+QM3nKbgRXJtwSYjhRRvqbokt+uQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Drew Jones <drjones@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On 12/13/17 14:56, Peter Maydell wrote:
> On 12 December 2017 at 11:06, Laszlo Ersek <lersek@redhat.com> wrote:
>> BTW, has anyone tested this with the ArmVirtQemu firmware? As far as I
>> can see from the firmware code, the firmware will use the PL011 whose
>> description comes first in the DTB (and ignore the other PL011), in an
>> fdt_next_node() traversal. Is that OK for the intended use case?
> 
> I have now tested this,

Thank you!

> and annoyingly UEFI and the kernel seem
> to disagree about enumeration order. That is, if QEMU creates
> them in the code in the order 0x09050000 (uart 2), 0x09000000 (uart 1),
> then they appear in the dtb with uart 1 first, and the kernel enumerates
> them as ttyAMA0 being uart 1 and ttyAMA1 being uart 2, but UEFI
> outputs to uart 2...

Ouch. This reminds me (remotely) of QEMU commit 587078f0ed63
("hw/arm/virt: explain device-to-transport mapping in
create_virtio_devices()", 2015-02-05).

I'd still like to avoid the "sophisticated" /chosen lookup (the lookup
itself is not too complex, but evaluating whatever we find there against
each of the scanned UART nodes appears difficult, if I'm to understand
Ard's earlier point correctly). I hope that we can match the kernel's
logic with simple modifications to our scanning loops, e.g. we could
simply pick the last UART rather than the first, or else do a maximum
(or minimum) search for the UART base, and stick with the maximum (or
minimum) found.

However, for that, we first have to understand what the kernel does. Can
someone explain that? (I tried taking a look, but it's turtles all the
way down.)

Thanks,
Laszlo
