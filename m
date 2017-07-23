Received: from eggs.gnu.org ([2001:4830:134:3::10]:56102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZN1j-0004Ov-LJ
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 15:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZN1i-0004Oo-Hy
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 15:58:55 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZN1i-0004MS-8m
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 15:58:54 -0400
Received: by mail-wr0-x22b.google.com with SMTP id k71so45242981wrc.2
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 12:58:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <86339fc5-002a-5f20-272b-b0c76006e63f@amsat.org>
References: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
	<86339fc5-002a-5f20-272b-b0c76006e63f@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 23 Jul 2017 20:58:30 +0100
Message-ID: <CAFEAcA-z997nAPX256-H0Byr5USOupW9+gdqSAUZk-94vsv=xA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/11] Make memory_region_init_ram() and
 friends handle migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 22 July 2017 at 05:47, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> I'm seeing memleaks using the malta machine, they come from the
> smbus_eeprom_init() in hw/i2c/smbus_eeprom.c which does:
>
>     uint8_t *eeprom_buf =3D g_malloc0(8 * 256); /* XXX: make this persist=
ent
> */

(This isn't actually a leak because the eeprom device
can't be hotplugged/unplugged, so once created it will
live for the life of the simulation.)

> Question for 2.11: is this device a candidate to use one of the function =
you
> enumerated? My guess is memory_region_init_rom_device()

A quick look at that device suggests that it's doing some
pretty weird stuff which probably should be being
cleaned up to use a memory region to handle the backing
store for the EEPROM (although there are other ways to do it;
since there's only 2K of data there it could also be
handled by a byte-array in the device migrated via
VMState).

Do you know what the intention is of the code which
passes the device an offset into the eeprom_buf buffer
rather than just passing the start of the buffer ?

> Question for 2.10: does that mean than the malta machine is not migratabl=
e?

Depends whether the guest is actually writing to the EEPROM :-)
The smbus_eeprom device doesn't have any support for migration
at all -- it is neither migrating the data, nor the internal
state (the offset). But if the guest doesn't ever write to
the EEPROM and it doesn't happen to be relying on the offset
having a particular value at the point of migration, you
won't notice.

In particular, the pc_piix and pc_q35 machines both create
one of these devices, so this is an issue for the pc
machine migration too... (and any fix we make to
smbus_eeprom needs to handle migration compat as a result)

thanks
-- PMM
