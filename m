Received: from eggs.gnu.org ([2001:4830:134:3::10]:38991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmJ4-000676-5n
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:39:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmJ1-00046H-3N
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:39:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmJ0-000461-Qv
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:39:31 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:38:57 +0100
Message-Id: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/28] TPM: code cleanup (not 2.11)
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

Various code cleanups accumulated while doing reviews and implementing
a CRB device (postponed for later), aiming at a tpm-next development
branch for after qemu 2.11.

v2: after Stefan review
- rebased (half of v1 is merged upstream)
- add & use a DEFINE_PROP_TPMBE()
- remove tpm_register_model()
- fix wrong locty_number usage & regression
- tpm-tis: check that at most one TPM device exists
- I changed "tpm-passthrough: remove error cleanup from
  handle_device_opts" to "tpm-passthrough: simplify create()", it is
  mostly the same patch that Stefan didn't like much but with a
  different rationale to have code closer to tpm-emulator create().
- added some signed-offs

Marc-Andr=C3=A9 Lureau (28):
  tpm-tis: remove unused locty_number
  tpm: move TpmIf in include/sysemu/tpm.h
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
  tpm-passthrough: simplify create()
  tpm-passthrough: workaround a possible race
  tpm-tis: simplify header inclusion
  tpm: rename qemu_find_tpm() -> qemu_find_tpm_be()
  tpm: lookup the the TPM interface instead of TIS device
  tpm: add TPM interface to lookup TPM version
  tpm: add tpm_cmd_get_size() to tpm_util
  acpi: change TPM TIS data conditions
  tpm-emulator: add a FIXME comment about blocking cancel
  tpm-tis: remove redundant 'tpm_tis:' in error messages
  tpm-tis: check that at most one TPM device exists
  tpm-emulator: protect concurrent ctrl_chr access
  qdev: add DEFINE_PROP_TPMBE
  tpm-tis: use DEFINE_PROP_TPMBE
  tpm: remove tpm_register_model()

 hw/tpm/tpm_int.h                 | 22 +----------
 hw/tpm/tpm_util.h                |  8 +++-
 include/hw/qdev-properties.h     |  3 ++
 include/sysemu/tpm.h             | 48 +++++++++++++++++------
 include/sysemu/tpm_backend.h     | 32 ++++++----------
 backends/tpm.c                   | 83 +++++++++++++---------------------=
------
 hw/core/qdev-properties-system.c | 64 +++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c             | 14 ++++---
 hw/tpm/tpm_emulator.c            | 59 +++++++++++++++-------------
 hw/tpm/tpm_passthrough.c         | 66 +++++++++++---------------------
 hw/tpm/tpm_tis.c                 | 83 +++++++++++++++-------------------=
------
 tpm.c                            | 34 ++++++----------
 12 files changed, 255 insertions(+), 261 deletions(-)

--=20
2.15.0.rc0.40.gaefcc5f6f
