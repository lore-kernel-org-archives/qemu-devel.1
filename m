Received: from eggs.gnu.org ([2001:4830:134:3::10]:54327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyP-0005Jz-9b
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyM-0004ip-6U
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gyL-0004gC-TN
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:30 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:55:41 +0200
Message-Id: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/42] TPM: code cleanup & CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

I accumulated a series of patch doing some TPM code cleanup while
doing review. I removed some dead code, simplified other parts, and
tried to isolate implementation of the backend and frontend by using a
new TPMIf interface. I solved a few issues, and added some FIXME for
what should be tackled.  Finally, I implemented a simple CRB device
(tpm 2.0) that is work in progress for now - it works fine with
passthrough, but swtpm/libtpms with win10 has some issues that need
more investigations.

seabios CRB support is required for TPM 2.0 & emulation
(https://mail.coreboot.org/pipermail/seabios/2017-October/011839.html)

Comments/review welcome!

Based-on: <1507222112-20315-1-git-send-email-stefanb@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau (42):
  tpm-tis: remove unused hw_access argument
  tpm-tis: remove RAISE_STS_IRQ
  tpm: make tpm_get_backend_driver() static
  tpm: lookup tpm backend class in tpm_driver_find_by_type()
  tpm: replace tpm_get_backend_driver() to drop be_drivers
  tpm: remove tpm_register_driver()
  tpm: move TPMSizedBuffer to tpm_tis.h
  tpm: remove TPMDriverOps
  tpm: remove init() class method
  tpm: remove configure_tpm() hop
  tpm: remove unused TPMBackendCmd
  tpm: remove needless cast
  tpm: remove locty argument from receive_cb
  tpm: add TPMBackendCmd to hold the request state
  tpm-emulator: fix error handling
  tpm: remove locty_data from TPMState
  tpm-tis: move TPMState to TIS header
  tpm-tis: remove tpm_tis.h header
  tpm-tis: fold TPMTISEmuState in TPMState
  tpm: add a QOM TPM interface
  tpm: move recv_data_callback to TPM interface
  tpm-backend: store TPMIf interface, improve backend_init()
  tpm-tis: no longer expose TPMState
  tpm-be: call request_completed() out of thread
  tpm-be: report error instead of front-end
  tpm-be: ask model to the TPM interface
  tpm: remove unused opened code
  tpm-passthrough: don't save guessed cancel_path in options
  tpm-be: update optional function pointers
  tpm-passthrough: pass TPMPassthruState to handle_device_opts
  tpm-backend: move set 'id' to common code
  tpm-passthrough: make it safer to destroy after creation
  tpm-passthrough: remove error cleanup from handle_device_opts
  tpm-passthrough: workaround a possible race
  tpm-tis: simplify header inclusion
  tpm: rename qemu_find_tpm() -> qemu_find_tpm_be()
  tpm: lookup the the TPM interface instead of TIS device
  tpm: add TPM interface to lookup TPM version
  tpm: add tpm_cmd_get_size() to tpm_util
  acpi: change TPM TIS data conditions
  tpm-emulator: add a FIXME comment about blocking cancel
  WIP: add TPM CRB device

 qapi/tpm.json                      |   7 +-
 hw/tpm/tpm_int.h                   |  25 +-
 hw/tpm/tpm_tis.h                   |  70 ------
 hw/tpm/tpm_util.h                  |   8 +-
 include/hw/acpi/tpm.h              |  65 +++++
 include/sysemu/tpm.h               |  59 +++--
 include/sysemu/tpm_backend.h       |  70 ++----
 backends/tpm.c                     | 121 ++++-----
 hw/i386/acpi-build.c               |  33 ++-
 hw/tpm/tpm_crb.c                   | 320 ++++++++++++++++++++++++
 hw/tpm/tpm_emulator.c              |  95 +++----
 hw/tpm/tpm_passthrough.c           | 114 +++------
 hw/tpm/tpm_tis.c                   | 499 +++++++++++++++++++------------=
------
 hw/tpm/tpm_util.c                  |   1 +
 tpm.c                              |  63 ++---
 default-configs/i386-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak |   1 +
 hw/tpm/Makefile.objs               |   1 +
 scripts/checkpatch.pl              |   1 -
 19 files changed, 899 insertions(+), 655 deletions(-)
 delete mode 100644 hw/tpm/tpm_tis.h
 create mode 100644 hw/tpm/tpm_crb.c

--=20
2.14.1.146.gd35faa819
