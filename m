Received: from eggs.gnu.org ([209.51.188.92]:56465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h24NY-0001tL-Te
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h24NX-0008Ez-0V
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:32:52 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  8 Mar 2019 02:32:04 +0100
Message-Id: <20190308013222.12524-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/18] fw_cfg: reduce memleaks,
 add QMP/HMP info + edk2_add_host_crypto_policy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

Hi,

This series consists of:
- trivial cleanups, add trace events (was in v1)
- add QMP/HMP commands to display the list of fw_cfg entries (reworked fr=
om v1)
- add unrealize() method and deallocate various buffers (new in v2)
- add fw_cfg_add_file_from_host (was in v1)
- add edk2_add_host_crypto_policy (new in v2)

Since v1:
- Addressed Michael and Laszlo comments.

Please review,

Phil.

v1: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01598.html

Philippe Mathieu-Daud=C3=A9 (18):
  hw/arm/virt: Remove null-check in virt_build_smbios()
  hw/i386: Remove unused include
  cutils: Add qemu_strdup_hexlify() and qemu_strdup_unhexlify()
  hw/nvram/fw_cfg: Add trace events
  hw/nvram/fw_cfg: Use the ldst API
  hw/nvram/fw_cfg: Remove the unnecessary boot_splash_filedata_size
  hw/nvram/fw_cfg: Add fw_cfg_common_unrealize()
  hw/nvram/fw_cfg: Move fw_cfg_file_slots_allocate() to common_realize()
  hw/nvram/fw_cfg: Free file_slots in common_unrealize()
  hw/nvram/fw_cfg: Add reboot_timeout to FWCfgState
  hw/nvram/fw_cfg: Add boot_splash.time_le16 to FWCfgState
  hw/nvram/fw_cfg: Keep reference of file_data in FWCfgState
  hw/nvram/fw_cfg: Add QMP 'info fw_cfg' command
  hw/nvram/fw_cfg: Add HMP 'info fw_cfg' command
  hw/nvram/fw_cfg: Add fw_cfg_add_file_from_host()
  hw/firmware: Add Edk2Crypto and edk2_add_host_crypto_policy()
  hw/i386: Use edk2_add_host_crypto_policy()
  hw/arm/virt: Use edk2_add_host_crypto_policy()

 MAINTAINERS                             |   9 +
 hmp-commands-info.hx                    |  17 ++
 hw/Makefile.objs                        |   1 +
 hw/acpi/piix4.c                         |   1 -
 hw/arm/virt.c                           |  11 +-
 hw/firmware/Makefile.objs               |   1 +
 hw/firmware/uefi_edk2_crypto_policies.c | 166 ++++++++++++++
 hw/i386/pc.c                            |  28 +++
 hw/nvram/fw_cfg.c                       | 284 ++++++++++++++++++++++--
 hw/nvram/trace-events                   |   7 +-
 hw/ppc/Makefile.objs                    |   2 +-
 hw/ppc/fw_cfg.c                         |  31 +++
 hw/sparc/sun4m.c                        |  19 ++
 hw/sparc64/sun4u.c                      |  19 ++
 include/hw/firmware/uefi_edk2.h         |  28 +++
 include/hw/nvram/fw_cfg.h               |  42 ++++
 include/qemu/cutils.h                   |  33 +++
 include/sysemu/sysemu.h                 |   2 -
 qapi/misc.json                          |  44 ++++
 stubs/Makefile.objs                     |   1 +
 stubs/fw_cfg.c                          |  19 ++
 util/cutils.c                           |  55 +++++
 vl.c                                    |  10 -
 23 files changed, 792 insertions(+), 38 deletions(-)
 create mode 100644 hw/firmware/Makefile.objs
 create mode 100644 hw/firmware/uefi_edk2_crypto_policies.c
 create mode 100644 hw/ppc/fw_cfg.c
 create mode 100644 include/hw/firmware/uefi_edk2.h
 create mode 100644 stubs/fw_cfg.c

--=20
2.20.1
