Received: from eggs.gnu.org ([2001:4830:134:3::10]:58897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciiJ6-0004cY-9T
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciiJ5-0000S9-Bv
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:59:12 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:33378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciiJ5-0000Rl-6D
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:59:11 -0500
Received: by mail-wm0-x232.google.com with SMTP id i17so2985485wmf.0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:59:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170224164021.9066-3-clement.deschamps@antfield.fr>
References: <20170224164021.9066-1-clement.deschamps@antfield.fr>
	<20170224164021.9066-3-clement.deschamps@antfield.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 13:58:49 +0000
Message-ID: <CAFEAcA_ZRB9VRQkWTJRh7D9fg-3+Bb=JGnMduhvu6WbOF2YWMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 2/4] hw/sd: add card-reparenting function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Clement Deschamps <clement.deschamps@antfield.fr>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Baumann <andrew.baumann@microsoft.com>

On 24 February 2017 at 16:40, Clement Deschamps
<clement.deschamps@antfield.fr> wrote:
> Provide a new function sdbus_reparent_card() in sd core for reparenting
> a card from a SDBus to another one.
>
> This function is required by the raspi platform, where the two SD
> controllers can be dynamically switched.
>
> Signed-off-by: Clement Deschamps <clement.deschamps@antfield.fr>
> ---
>  hw/sd/core.c       | 30 ++++++++++++++++++++++++++++++
>  include/hw/sd/sd.h |  1 +
>  2 files changed, 31 insertions(+)
>

It turns out we got the logic wrong here -- it causes random
crashes on OSX, and this valgrind error on Linux:

==19695== Invalid read of size 8
==19695==    at 0x7DD59C: object_unparent (object.c:446)
==19695==    by 0x6E920A: sdbus_reparent_card (core.c:158)
==19695==    by 0x3ED0D5: bcm2835_gpio_reset (bcm2835_gpio.c:268)
==19695==    by 0x5DE10E: device_reset (qdev.c:1148)
==19695==    by 0x5DBFA3: qdev_reset_one (qdev.c:295)
==19695==    by 0x5DCBA7: qdev_walk_children (qdev.c:610)
==19695==    by 0x5E0D4A: qbus_walk_children (bus.c:59)
==19695==    by 0x5DC0BD: qbus_reset_all (qdev.c:321)
==19695==    by 0x5DC0E0: qbus_reset_all_fn (qdev.c:327)
==19695==    by 0x5E1690: qemu_devices_reset (reset.c:69)
==19695==    by 0x5258C6: qemu_system_reset (vl.c:1695)
==19695==    by 0x52D915: main (vl.c:4645)
==19695==  Address 0x354c9bc0 is 0 bytes after a block of size 32 alloc'd
==19695==    at 0x4C2FB55: calloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==19695==    by 0x1B7A5770: g_malloc0 (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
==19695==    by 0x5DB77C: bus_add_child (qdev.c:85)
==19695==    by 0x5DB8C9: qdev_set_parent_bus (qdev.c:107)
==19695==    by 0x5DBA17: qdev_try_create (qdev.c:153)
==19695==    by 0x5DB8EF: qdev_create (qdev.c:117)
==19695==    by 0x49E3AB: raspi2_init (raspi.c:152)
==19695==    by 0x52D68C: main (vl.c:4523)

I've dropped it (and the following patches) from the pull request
for the moment and will have a look at what the fix is.

thanks
-- PMM
