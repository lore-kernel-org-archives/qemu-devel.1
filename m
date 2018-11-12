Received: from eggs.gnu.org ([2001:4830:134:3::10]:42784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gMDVZ-00009W-2m
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gMDVS-0003Zp-Vf
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:48:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gMDVS-0003VB-9v
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:48:02 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181109141447.13101-1-kraxel@redhat.com>
	<CAFEAcA89pAYe1ZQZDUHO33aP1jT7vfdsjJ4=aN7-c_fPSeYWgQ@mail.gmail.com>
	<875zx2fyga.fsf@dusky.pond.sub.org>
	<CAFEAcA8oeWv90aufHS+PfLBeBb=9d7oFuQNzDKmaiRW=YkE28w@mail.gmail.com>
Date: Mon, 12 Nov 2018 15:47:57 +0100
In-Reply-To: <CAFEAcA8oeWv90aufHS+PfLBeBb=9d7oFuQNzDKmaiRW=YkE28w@mail.gmail.com>
	(Peter Maydell's message of "Mon, 12 Nov 2018 10:19:33 +0000")
Message-ID: <87y39ycpya.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] hw/bt: drop bluetooth keyboard emulation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 12 November 2018 at 09:16, Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On 9 November 2018 at 14:14, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>>> Broken (segfaultson first keypress) and appearently unused.
>>>>
>>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>
>> Please show the reproducer in the commit message.  Stack backtrace
>> wouldn't hurt.
>>
>>>> ---
>>>>  include/hw/bt.h     |   3 -
>>>>  hw/bt/hid.c         | 554 ----------------------------------------------------
>>>>  vl.c                |  34 +---
>>>>  hw/bt/Makefile.objs |   3 +-
>>>>  qemu-options.hx     |   9 -
>>>>  5 files changed, 2 insertions(+), 601 deletions(-)
>>>>  delete mode 100644 hw/bt/hid.c
>>>
>>> Are we definitely happy that all the use cases for
>>> this code segfault, not just the one you tested ?
>>
>> Are there any others?
>>
>>> Does it cost us much to mark this deprecated in 3.1
>>> and drop it in 4.0 ?
>>
>> The cost is offering a known-to-be-broken option to users.
>>
>> The other half of the tradeoff: what would it gain us?
>
> My point is that we do not know it to be broken. We know that
> it has one bug, in the command line and segfault that Gerd
> found. I haven't seen anybody say they've done a check of
> all the use cases of this code and confirmed that all of them
> must pass through the codepath/situation that segfaults.

There's just one way to create a Bluetooth keyboard device.  It has just
one configuration knob: the Bluetooh "vlan".  This leads me to believe
there's no way to create this device that doesn't crash.  Regardless,
asking Gerd to confirm is fair.  Preferably in the commit message of v2.

> What it gains us is that we get to be sure that we are keeping
> our promise with our users that we don't just randomly remove
> features they were using without notice.

No gain unless there is a way to use it.
