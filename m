Received: from eggs.gnu.org ([209.51.188.92]:43197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gxAsA-0003aH-AG
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gxAs9-0007bZ-CT
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:28:14 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<87o97yi67d.fsf@dusky.pond.sub.org>
	<300bdcd7-fbde-d7a3-12a0-eafdc0aa58f6@redhat.com>
	<87ef84xn2w.fsf@dusky.pond.sub.org>
Date: Fri, 22 Feb 2019 14:28:04 +0100
In-Reply-To: <87ef84xn2w.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 19 Feb 2019 08:19:03 +0100")
Message-ID: <87imxc2brv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

The other day, I described how my attempt to implement Paolo's
suggestion to add block properties to the machine ran into difficulties.
To recap briefly, creating devices within a machine's .instance_init()
crashes.  Turns out device_post_init() calls qdev_get_machine(), which
calls container_get() for QOM path "/machine".  Since "/machine" doesn't
exist, yet (we're busy creating it), container_get() "helpfully" creates
it as a new "container" object.  Oww.  Fortunately, we crash soon after,
when we try to create the real "/machine".

I managed to rejigger global property application code to work without
qdev_get_machine().  Good.

Not so good: QEMU still crashes the same way.

Turns out we *also* call qdev_get_machine() on the first
sysbus_get_default().  We create the main system bus then, and
immediately store it in "/machine/unattached/sysbus".  So
container_get() "helpfully" creates first "/machine" and then
"/machine/unattached" for us.

I managed to rejigger that, too.  Now my QEMU survives creating a pflash
device in pc_machine_initfn(), and I can add a machine property
"pflash0" with object_property_add_alias().  Good.

Not so good: attempting to set it with -machine pflash0=pflash0 fails
with "Property 'cfi.pflash01.drive' can't find value 'pflash0'".

Turns out we set the machine's properties around line 4250, some 140
lines before we create block backends.  Block backend "pflash0" doesn't
exist, yet.

This is madness, but at least it's familiar madness; we've rejiggered
the order of creating stuff in main() numerous times already.

To be continued...
