Received: from eggs.gnu.org ([2001:4830:134:3::10]:36591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deniz.eren@icloud.com>) id 1eehvQ-0000bW-Pf
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deniz.eren@icloud.com>) id 1eehvN-0007yT-O3
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:50:44 -0500
Received: from st13p11im-asmtp004.me.com ([17.164.40.219]:23108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deniz.eren@icloud.com>)
	id 1eehvN-0007xa-Jy
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:50:41 -0500
Received: from process-dkim-sign-daemon.st13p11im-asmtp004.me.com by
	st13p11im-asmtp004.me.com
	(Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built
	Jun 7 2017)) id <0P340000063YY100@st13p11im-asmtp004.me.com> for
	qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:50:29 +0000 (GMT)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (1.0)
From: Deniz Eren <deniz.eren@icloud.com>
In-reply-to: <201801250924.50877.pisa@cmp.felk.cvut.cz>
Date: Fri, 26 Jan 2018 00:50:23 +1100
Content-transfer-encoding: quoted-printable
Message-id: <D29E4E2D-17A7-41FC-B3BE-F848AEAA35F6@icloud.com>
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<201801242122.31033.pisa@cmp.felk.cvut.cz>
	<abe89c1b-b6fa-3021-fad1-469d2eb2060a@amsat.org>
	<201801250924.50877.pisa@cmp.felk.cvut.cz>
Subject: Re: [Qemu-devel] [PATCH V4 0/7] CAN bus support for QEMU (SJA1000
 PCI so far)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>

Hi Pavel, Philippe,

I=E2=80=99m happy with whatever way is best for the project.

However I would personally think merging the different drivers into one C fi=
le would not be a very modular way of handling the problem. As you can see f=
rom the Advantech drivers for example, the card supplier end can pose diffic=
ult Bar allocation logic, which I would think is best isolated within the pa=
rticular driver model C file. Trying to come up with mechanisms to handle th=
ese could prove difficult.

Also keep in mind there should be more driver support added in future, which=
 could pose other driver model specific difficulties that are best isolated t=
o their own C files.

Having said all that, there might be a nice way of merging them all generica=
lly which I fail to see currently.



Best regards,
Deniz

Sent from my iPhone

Deniz Eren
+61 400 307 762

> On 25 Jan 2018, at 7:24 pm, Pavel Pisa <pisa@cmp.felk.cvut.cz> wrote:
>=20
> Hello Philippe,
>=20
>> On Wednesday 24 of January 2018 22:41:16 Philippe Mathieu-Daud=C3=A9 wrot=
e:
>> Hi Pavel,
>>> I have seen that a few other type_init-s do more
>>> than simple sequence of type_register_static().
>>> Is it acceptable to use type_init for registration
>>> to CAN core by function call for now? Conversion simplifies
>>> makefiles and unnecessary stub file is removed.
>>>=20
>>> But I would use attribute if that solution is preferred because
>>> it is allways present on Linux where SocketCAN is used anyway
>>> and it is used in other Qemu subsystems as well.
>>=20
>> using stubs/monitor.c as a template for stubs/can_host_variant.c doesn't
>> work?
>=20
> If that is preferred then I implement the stub this way.
> As for the location, can I add
>=20
>  stub-obj-y +=3D can_host_stub.o
>=20
> into hw/can/Makefile.objs same as it is in crypto/Makefile.objs
> to keep CAN stuff together at least for now or it should go
> to stubs directory?
>=20
>  stub-obj-$(CONFIG_CAN_BUS) +=3D can_host_variant.o
>=20
> As for connection to host, again I have weak preference
> to keep it in hw/can to keep CAN related code together
> but if you think that it should go t chardev, I would prepare
> patch that way
>=20
>  chardev/can-socketcan.c
>=20
> As for the rest of the remarks
>=20
> You are right that there is some code duplication
> in the SJA1000 CAN PCI cards support but problem
> is that KVASER single uses S5920 PCI local bus bridge
> which requires additional BARs and additional bridge
> specific interrupt enable support. There are more KVASER
> variants which combine multiple SJA1000 in a single BAR.
> pcm3680 and mioe3680 have different BAR structure,
> each SJA1000 uses one BAR. The first uses I/O mapped
> SJA1000 and another memory mapped with stride 4.
> Yes, it all can be combined into one C file.
> But it would require to to add more more fields
> into CardX_PCIState structure and some mechanisms
> and code to select right combination of the BARs,
> handlers etc for each card. It all can be done,
> but I am not sure if I find time for such changes now.
> I expect to have time again in summer when my teaching
> semester ends.
> Another disadvantage is that if somebody else wants
> to implement other card emulation then actual simple
> can_kvaser_pci.c is easily readable. Code gets much
> more complex with all variants selection logic and
> we have already abandoned that simple PCI example
> (can_pci.c) with dummy PCI ID which as been included
> in the past.
>=20
> If the code duplication is a problem for now then
> I vote to include only can_kvaser_pci.c for now.
> But Deniz Eren would be sad because he uses the
> cards (which he has contributed) in his test environment.
>=20
> Anyway, I would follow what is proposed.
>=20
> Thanks for your review and time,
>=20
> Pavel
