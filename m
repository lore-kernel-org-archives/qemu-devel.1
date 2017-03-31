Received: from eggs.gnu.org ([2001:4830:134:3::10]:41002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1ctwK0-0003ml-CI
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1ctwJw-0000bZ-7I
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:10:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:64202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1ctwJv-0000aR-To
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:10:28 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Fri, 31 Mar 2017 16:10:09 +0300
Message-Id: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
Subject: [Qemu-devel] [PATCH 0/7] Provide support for the software TPM
 emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, patrick.ohly@intel.com, Amarnath Valluri <amarnath.valluri@intel.com>

Briefly, Theses set of patches introduces:
 - new TPM backend driver to support software TPM emulators(swtpm(1)).
 - and few supported fixes/enhancements/cleanup to existing tpm backend code.

The similar idea was initiated earliar(2) by Stefan Berger(CCed) with slightly
different approach, using CUSE. As swtpm has excellent support for unix domain
sockets, hence this implementation uses unix domain sockets to communicate with
swtpm.

When Qemu is configured with 'emulator' tpm backend, it spawns 'swtpm' and
communicates its via Unix domain sockets.

1) https://github.com/stefanberger/swtpm
2) https://lists.nongnu.org/archive/html/qemu-devel/2016-01/msg00089.html

Amarnath Valluri (7):
  tpm-backend: Remove unneeded member variable from backend class
  tpm-backend: Move thread handling inside TPMBackend
  tpm-backend: Initialize and free data members in it's own methods
  tpm-backend: Call interface methods only if backend implements them
  tmp backend: Add new api to read backend tpm options
  tpm-passthrough: move reusable code to utils
  tpm: New backend driver to support TPM emulator

 backends/tpm.c                   | 102 ++++--
 configure                        |   6 +
 hmp.c                            |  14 +
 hw/tpm/Makefile.objs             |   1 +
 hw/tpm/tpm_emulator.c            | 740 +++++++++++++++++++++++++++++++++++++++
 hw/tpm/tpm_ioctl.h               | 243 +++++++++++++
 hw/tpm/tpm_passthrough.c         | 213 +++--------
 hw/tpm/tpm_util.c                |  94 +++++
 hw/tpm/tpm_util.h                |  11 +
 include/sysemu/tpm_backend.h     |  35 +-
 include/sysemu/tpm_backend_int.h |  19 +-
 qapi-schema.json                 |  34 +-
 qemu-options.hx                  |  25 +-
 tpm.c                            |  22 +-
 14 files changed, 1326 insertions(+), 233 deletions(-)
 create mode 100644 hw/tpm/tpm_emulator.c
 create mode 100644 hw/tpm/tpm_ioctl.h

-- 
2.7.4
