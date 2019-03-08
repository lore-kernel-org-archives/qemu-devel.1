Received: from eggs.gnu.org ([209.51.188.92]:53929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2Am1-00028J-GN
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 03:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2Am0-0003uT-IB
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 03:22:33 -0500
References: <20190307172401.29451-1-armbru@redhat.com>
	<20190307172401.29451-12-armbru@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <12af2068-ecd6-4b77-495e-2f52b0b0b13e@redhat.com>
Date: Fri, 8 Mar 2019 09:22:16 +0100
MIME-Version: 1.0
In-Reply-To: <20190307172401.29451-12-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/12] pc: Support firmware
 configuration with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com

On 03/07/19 18:24, Markus Armbruster wrote:
> The PC machines put firmware in ROM by default.  To get it put into
> flash memory (required by OVMF), you have to use -drive
> if=3Dpflash,unit=3D0,... and optionally -drive if=3Dpflash,unit=3D1,...
>=20
> Why two -drive?  This permits setting up one part of the flash memory
> read-only, and the other part read/write.  Below the hood, it creates
> two separate flash devices, because we were too lazy to improve our
> flash device models to support sector protection.
>=20
> The problem at hand is to do the same with -blockdev somehow, as one
> more step towards deprecating -drive.
>=20
> Mapping -drive if=3Dnone,... to -blockdev is a solved problem.  With
> if=3DT other than if=3Dnone, -drive additionally configures a block dev=
ice
> frontend.  For non-onboard devices, that part maps to -device.  Also a
> solved problem.  For onboard devices such as PC flash memory, we have
> an unsolved problem.
>=20
> This is actually an instance of a wider problem: our general device
> configuration interface doesn't cover onboard devices.  Instead, we
> have a zoo of ad hoc interfaces that are much more limited.  Some of
> them we'd rather deprecate (-drive, -net), but can't until we have
> suitable replacements.
>=20
> Sadly, I can't attack the wider problem today.  So back to the narrow
> problem.
>=20
> My first idea was to reduce it to its solved buddy by using pluggable
> instead of onboard devices for the flash memory.  Workable, but it
> requires some extra smarts in firmware descriptors and libvirt.  Paolo
> had an idea that is simpler for libvirt: keep the devices onboard, and
> add machine properties for their block backends.
>=20
> The implementation is less than straightforward, I'm afraid.
>=20
> First, block backend properties are *qdev* properties.  Machines can't
> have those, as they're not devices.  I could duplicate these qdev
> properties as QOM properties, but I hate that.
>=20
> More seriously, the properties do not belong to the machine, they
> belong to the onboard flash devices.  Adding them to the machine would
> then require bad magic to somehow transfer them to the flash devices.
> Fortunately, QOM provides the means to handle exactly this case: add
> alias properties to the machine that forward to the onboard devices'
> properties.
>=20
> Properties need to be created in .instance_init() methods.  For PC
> machines, that's pc_machine_initfn().  To make alias properties work,
> we need to create the onboard flash devices there, too.  Requires
> several bug fixes, in the previous commits.  We also have to realize
> the devices.  More on that below.
>=20
> If the user sets pflash0, firmware resides in flash memory.
> pc_system_firmware_init() maps and realizes the flash devices.
>=20
> Else, firmware resides in ROM.  The onboard flash devices aren't used
> then.  pc_system_firmware_init() destroys them unrealized, along with
> the alias properties.
>=20
> The existing code to pick up drives defined with -drive if=3Dpflash is
> replaced by code to desugar into the machine properties.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/i386/pc.c         |   2 +
>  hw/i386/pc_sysfw.c   | 243 ++++++++++++++++++++++++++++---------------
>  include/hw/i386/pc.h |   3 +
>  3 files changed, 166 insertions(+), 82 deletions(-)

Thanks for addressing my comments!

Acked-by: Laszlo Ersek <lersek@redhat.com>

Laszlo
