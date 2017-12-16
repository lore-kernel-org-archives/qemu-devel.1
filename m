Received: from eggs.gnu.org ([2001:4830:134:3::10]:45706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTP-0005lt-DA
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTL-00087p-Fq
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39710
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTL-00086Q-9T
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:03 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHdWSr028116
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:00 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ew0jdk1aq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:41:59 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:41:58 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 00/32] Merge tpm 2017/12/15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

The following patch series refactors the TPM TIS and backend drivers for
easier addition of new front-end devices. Further, the TPM buffer sizes
are read from the backend and the backend's buffer size can be adjusted
by the frontend, if necessary.


The following changes since commit 0ef0583d5adceb9138bdb47494dabd1549ac5b=
6d:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20171214' =
into staging (2017-12-14 15:32:32 +0000)

are available in the git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-12-15-1

for you to fetch changes up to 683c4b775355cc7acd301e8efe7d4c1c9acdafd8:

  tpm: tpm_passthrough: Fail startup if FE buffer size < BE buffer size (=
2017-12-14 23:39:15 -0500)

----------------------------------------------------------------
Merge tpm 2017/12/15 v1

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (27):
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
      qdev: add DEFINE_PROP_TPMBE
      tpm-tis: use DEFINE_PROP_TPMBE
      tpm: remove tpm_register_model()

Stefan Berger (5):
      tpm: Move getting TPM buffer size to backends
      tpm: pull tpm_util_request() out of tpm_util_test()
      tpm: tpm_passthrough: Read the buffer size from the host device
      tpm: tpm_emulator: get and set buffer size of device
      tpm: tpm_passthrough: Fail startup if FE buffer size < BE buffer si=
ze

 backends/tpm.c                   |  92 +++++++++++++++------------------=
-----
 hw/core/qdev-properties-system.c |  64 +++++++++++++++++++++++++++
 hw/i386/acpi-build.c             |  14 +++---
 hw/tpm/tpm_emulator.c            |  98 +++++++++++++++++++++++++++++++++=
+------
 hw/tpm/tpm_int.h                 |  31 +++++--------
 hw/tpm/tpm_ioctl.h               |  28 +++++++++++-
 hw/tpm/tpm_passthrough.c         |  90 ++++++++++++++++++++-------------=
----
 hw/tpm/tpm_tis.c                 | 101 +++++++++++++++++----------------=
---------
 hw/tpm/tpm_util.c                | 155 +++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++----
 hw/tpm/tpm_util.h                |  11 ++++-
 include/hw/qdev-properties.h     |   3 ++
 include/sysemu/tpm.h             |  48 +++++++++++++++-----
 include/sysemu/tpm_backend.h     |  50 +++++++++++----------
 tpm.c                            |  34 +++++---------
 14 files changed, 553 insertions(+), 266 deletions(-)

--=20
2.5.5
