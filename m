Received: from eggs.gnu.org ([209.51.188.92]:36803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpBBE-000213-J2
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpBBC-0006ko-JT
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:10:52 -0500
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<87o97yi67d.fsf@dusky.pond.sub.org>
	<300bdcd7-fbde-d7a3-12a0-eafdc0aa58f6@redhat.com>
	<9dc7c83c-a63c-9cde-1267-43bc62e73436@redhat.com>
	<87imy5dy5v.fsf@dusky.pond.sub.org>
	<703ad7c6-e8bb-2b62-41a9-1a15a7634f1e@redhat.com>
	<87bm3xcgll.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0871cdaf-6a78-1dd7-d18b-ae1337a1a54e@redhat.com>
Date: Thu, 31 Jan 2019 13:10:33 +0100
MIME-Version: 1.0
In-Reply-To: <87bm3xcgll.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Libvirt <libvir-list@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Krempa <pkrempa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On 31/01/19 10:37, Markus Armbruster wrote:
>>
>>> Hmm, why is it okay to treat all pfl->cmd values the same when
>>> secure=3Don?
>> But doesn't matter.  You just don't want MMIO mode to be active outsid=
e
>> SMM: all that non-SMM code want to do with the flash is read and execu=
te
>> it, as far as they're concerned it's just ROM and the command mode is
>> nonexistent.
> Out of curiosity: what effect does secure=3Don have when the device is
> read-only (pflash_t member ro non-zero)?

Non-SMM code cannot execute commands.  This means two things:

First, in addition to writes, there are nondestructive commands such as
read device id.  Those are also inaccessible to non-SMM if secure=3Don.
Again, for non-SMM code it looks like your old ROM.  This is not
important but...

... CFI commands, even commands that are nondestructive or writes that
fail because of readonly-ness, consist of multiple writes to the flash
device.  If non-SMM code could issue a partial command, the SMM flash
driver would likely end up confused.  Therefore it's probably a good
idea to make all parallel flash devices have secure=3Don even if the
content of the flash cannot be damaged, and that's why I never
considered anything but -global to configure the property.

Paolo
