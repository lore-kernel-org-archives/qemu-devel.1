Received: from eggs.gnu.org ([209.51.188.92]:61000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hGyaN-0006X6-7f
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:23:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hGyaH-0003IQ-Cy
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:23:39 -0400
References: <20190417220147.67648-1-stephen.checkoway@oberlin.edu>
	<20190417220147.67648-5-stephen.checkoway@oberlin.edu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0d2705ba-edea-7922-d812-69cc5fe5b870@redhat.com>
Date: Thu, 18 Apr 2019 06:23:03 +0200
MIME-Version: 1.0
In-Reply-To: <20190417220147.67648-5-stephen.checkoway@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 04/10] block/pflash_cfi02: Implement
 intereleaved flash devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 18/04/2019 00.01, Stephen Checkoway wrote:
> It's common for multiple narrow flash chips to be hooked up in parallel
> to support wider buses. For example, four 8-bit wide flash chips (x8)
> may be combined in parallel to produce a 32-bit wide device. Similarly,
> two 16-bit wide chips (x16) may be combined.
> 
> This commit introduces `device-width` and `max-device-width` properties,
> similar to pflash_cfi01, with the following meanings:
> - `width`: The width of the logical, qemu device (same as before);
> - `device-width`: The width of an individual flash chip, defaulting to
>   `width`; and
> - `max-device-width`: The maximum width of an individual flash chip,
>   defaulting to `device-width`.
> 
> Nothing needs to change to support reading such interleaved devices but
> commands (e.g., erase and programming) must be sent to all devices at
> the same time or else the various chips will be in different states.
> 
> For example, a 4-byte wide logical device can be composed of four x8/x16
> devices in x8 mode. That is, each device supports both x8 or x16 and
> they're being used in the byte, rather than word, mode. This
> configuration would have `width=4`, `device-width=1`, and
> `max-device-width=2`.
> 
> In addition to commands being sent to all devices, guest firmware
> expects the status and CFI queries to be replicated for each device.
> (The one exception to the response replication is that each device gets
> to report its own status bit DQ7 while programming because its value
> depends on the value being programmed which will usually differ for each
> device.)
> 
> Testing is limited to 16-bit wide devices due to the current inability
> to override the properties set by `pflash_cfi02_register`, but multiple
> configurations are tested.
> 
> Stop using global_qtest. Instead, package the qtest variable inside the
> FlashConfig structure.

Thanks for doing that change wrt global_qtest!

Acked-by: Thomas Huth <thuth@redhat.com>
