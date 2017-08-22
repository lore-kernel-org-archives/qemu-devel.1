Received: from eggs.gnu.org ([2001:4830:134:3::10]:60169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkB8h-0008Qa-Ux
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkB8g-0003TM-9r
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:30:47 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:37898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dkB8g-0003Sg-38
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:30:46 -0400
Received: by mail-wr0-x229.google.com with SMTP id p8so64524057wrf.5
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 08:30:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <443135b4-4b36-bae6-b50a-12fb4a55a858@redhat.com>
References: <1503414375-21009-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-92Jjz2uCC387oX2u0NWfijPwB_8zGaagC1m=sKD8zhQ@mail.gmail.com>
	<443135b4-4b36-bae6-b50a-12fb4a55a858@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 16:30:24 +0100
Message-ID: <CAFEAcA-AG5XoOJr3p_UU9dACjawp3OtKDy8GMRMpdFfE8foqTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/misc/auxbus.c: Mark the
 aux-to-i2c-bridge device as non-hotpluggable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, KONRAD Frederic <frederic.konrad@adacore.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 22 August 2017 at 16:26, Thomas Huth <thuth@redhat.com> wrote:
> On 22.08.2017 17:12, Peter Maydell wrote:
>> Why is our default "hotpluggable" rather than "not hotpluggable" ?
>> We must have way more non-hotpluggable devices than hotpluggable
>> ones, and it takes active effort to make a hotpluggable device
>> model, so it seems like it would be much less bug-prone to
>> require hotpluggable devices to set dc->hotpluggable true
>> rather than all the non-hotpluggable ones to set it false...
>
> I think most devices are already non-hotpluggable automatically because
> they sit on a bus that is not hot-pluggable (e.g. sysbus devices). The
> problematic ones are the devices with .parent = TYPE_DEVICE. And for
> these, I think it is quite hard to say whether they should be
> hot-pluggable by default or not?

To implement hotplug you need to write extra code (notably some
kind of unrealize method to undo whatever you did in realize),
at which point also setting the hotpluggable flag is trivial.

> Anyway, according to my tests (I'm currently working on a test that
> automatically does device_add + device_del for all devices, as you might
> have guessed already), there are not that many devices that cause
> problems here, so I guess marking some few with hotpluggable = false
> should be OK?

The problem is not the devices we have today but the ones we're
going to write tomorrow. Having hotpluggable default to false
"fails safe" -- the worst that happens is that somebody writing
a hotpluggable device finds in their testing that they need to
set the flag to make it work. Having it default to true fails
non-safely -- as you've found, people writing devices that
were never expected to be hotplugged don't try to test the
error case of attempting hotplug anyway, and in code review
the absence of a line of code is very hard to reliably spot,
so we get devices in tree that crash QEMU if you try to
hotplug them. If we make the default be not-hotpluggable
we fix this not just today but forever.

thanks
-- PMM
