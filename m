Received: from eggs.gnu.org ([209.51.188.92]:45021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hC5GP-00046f-Hf
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 12:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hC5GO-0006XK-DM
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 12:30:53 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190404071421.4891-1-thuth@redhat.com>
	<298ccbd7-9af5-8303-e42b-33dd1cb94b9e@redhat.com>
	<158fe22a-5781-73e5-5955-2fe9db019236@redhat.com>
	<3ba3c765-589f-4c0a-38dc-d9126f515e7b@redhat.com>
Date: Thu, 04 Apr 2019 18:30:43 +0200
In-Reply-To: <3ba3c765-589f-4c0a-38dc-d9126f515e7b@redhat.com> (Thomas Huth's
	message of "Thu, 4 Apr 2019 16:19:27 +0200")
Message-ID: <87lg0p4tsc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/input/pckbd: The i8042 device should
 not be user_creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Michael S.
	Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> On 04/04/2019 15.29, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 4/4/19 12:07 PM, Paolo Bonzini wrote:
>>> On 04/04/19 09:14, Thomas Huth wrote:
>>>> The i8042 PS/2 controller is part of the chipset on the motherboard.
>>>> It is instantiated by the machine init code, and it does not make sense
>>>> to allow the user to plug an additional i8042 in any of the free ISA s=
lots.
>>>> Thus let's mark the device with user_creatable =3D false.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  hw/input/pckbd.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>
>>> user_creatable is not for devices that are not pluggable in real life;
>>> it is for devices that crash QEMU (!) or always fail if plugged by the =
user.
>
> ... hmm, but presenting devices to the user that are clearly not
> intended for direct use is also not very nice, is it?

Maybe, but hiding them should be separate from marking devices that
still defeat device_add.

In the ideal world, we'd be able to start with an empty board, then
build a machine with by wiring together devices.  Say like use
device_add to create and plug into parent bus, qom-set link properties
to create additional wires.

Plenty of devices fail at the device_add stage, or require additional
wiring by code.  These are marked not user_creatable.

See also commit e90f2a8c3e0e677eeea46a9b401c3f98425ffa37.

>>> So the question to ask is: would it make sense, and especially work, to
>>> add an i8042 to machines that do have an ISA bridge (for example the Al=
pha?)

Scratch the "would it make sense" part, keep the "would it work" part.

> I don't think so. It is a device that is supposed to be part of the
> chipset on the motherboard, so operating systems certainly don't know
> how to use this device on other machines.
>
> And at least some part of the device have to be set up in source code
> (see e.g. i8042_setup_a20_line() ...).

If (and only if) the parts that need code are essential to the
functioning the device, it should be marked not user_creatable.

>> Correct me if I'm wrong but it seems no machine directly use a 8042 on a
>> ISA bus, it is always part of a SuperIO chipset. It is not reflected in
>> the code (in particular the X86 machines, but I'm working on cleaning th=
is).

Known issue: we model a bunch of x86 devices as ISA devices, even though
they're actually part of a super i/o device connected via LPC bus.

[...]
