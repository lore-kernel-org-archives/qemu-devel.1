Received: from eggs.gnu.org ([2001:4830:134:3::10]:37800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eOjsm-0006oc-Cy
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 07:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eOjsl-0004OT-Hm
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 07:42:00 -0500
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-4-git-send-email-peter.maydell@linaro.org>
	<5A2F6ED9.5030605@huawei.com>
	<ac182406-8011-9f19-38e7-37328434095b@redhat.com>
	<CAFEAcA_9pee99KpL4zwVS5jJuiv2MCGp79crufpU1kH1Okg-Hg@mail.gmail.com>
	<6b4b6351-eeb4-a4d3-8ddf-5401516671ae@redhat.com>
	<CAKv+Gu-Ugm1g8twoKwgXAPtDfETvXntk2h4WzMVuUTDF7GhMvA@mail.gmail.com>
	<5e3798f7-e280-b6c3-1504-828283617c52@redhat.com>
	<CAFEAcA_+NnpeP9Le7bp9yrYQDwtuP79pt8GpVzJ4RBDMx1iomA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <09e7b89f-27f2-1787-b371-7b0c0eff78b8@redhat.com>
Date: Tue, 12 Dec 2017 13:41:46 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_+NnpeP9Le7bp9yrYQDwtuP79pt8GpVzJ4RBDMx1iomA@mail.gmail.com>
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Drew Jones <drjones@redhat.com>, Andrea Bolognani <abologna@redhat.com>

On 12/12/17 13:07, Peter Maydell wrote:
> On 12 December 2017 at 11:59, Laszlo Ersek <lersek@redhat.com> wrote:
>> Peter, what is the intended use of the second UART?
> 
> Per the commit message:
> # there are some
> # use cases where having a second UART would be useful (like
> # bare-metal testing where you don't really want to have to
> # probe and set up a PCI device just to have a second comms
> # channel).
> 
> From QEMU's point of view this is just "some people would like
> more than one UART, x86 provides more than one UART, it's
> easy to provide an extra UART and it's up to the guest what
> it would like to do with it". If there's utility for the
> OVMF firmware in having 2 UARTs that's doubly good reason
> to have it.

I agree. There's one user-visible complication: while with one UART,
it's not possible to mix things up, with two UARTs, users will
inevitably want to assign inverse roles to them, relative to what QEMU /
the firmware assigns originally.

E.g. if one PL011 is redirected to a regular file (debug messages) and
the other one to stdio (console), there will be complaints that "I
wanted it the other way around". The redirection happens on the backend
(chardev) level, but the firmware won't see the difference on the
frontend (PL011) level.

Is it possible to add a new property to the UART nodes in the DTB, like
"purpose"?

Or can we make a virt-arm policy that "first -serial is always ...,
second -serial is always ..."?

(
Technically the latter could work, because:

- QEMU_OPTION_serial / add_device_config() keeps the command line order,
- the traversal of DEV_SERIAL with serial_parse() also keeps that order,
- machvirt_init() uses the same order via serial_hds[]
- create_uart() always prepends the new node to the DTB, via
  qemu_fdt_add_subnode() (if I understood Ard right).

I'm not sure though whether libvirt would like the ordering of -serial
options to carry any meaning.
)

Sorry if these questions don't belong on the QEMU level.

Thanks
Laszlo
