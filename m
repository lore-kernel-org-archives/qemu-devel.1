Received: from eggs.gnu.org ([2001:4830:134:3::10]:60256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1cwUu1-00051W-SI
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1cwUtz-0002UX-3W
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:30:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:7706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1cwUty-0002Sr-Nv
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:30:15 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Fri,  7 Apr 2017 17:30:22 +0300
Message-Id: <1491575431-32170-1-git-send-email-amarnath.valluri@intel.com>
Subject: [Qemu-devel] [PATCH v2 0/9] Provide support for the software TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@gmail.com, berrange@redhat.com, Amarnath Valluri <amarnath.valluri@intel.com>

Briefly, Theses set of patches introduces:
  - new TPM backend driver to support software TPM emulators(swtpm(1)).
  - and few supported fixes/enhancements/cleanup to existing tpm backend code.

  The similar idea was initiated earliar(2) by Stefan Berger(CCed) with slightly
  different approach, using CUSE. As swtpm has excellent support for unix domain
  sockets, hence this implementation uses unix domain sockets to communicate
  with
  swtpm.

  When Qemu is configured with 'emulator' tpm backend, it spawns 'swtpm' and
  communicates its via Unix domain sockets.

  1) https://github.com/stefanberger/swtpm
  2) https://lists.nongnu.org/archive/html/qemu-devel/2016-01/msg00089.html

** Changes in V2:
- Made spawnning swtpm optional
- used QIOChannel instead of plain unix sockets
- incorporated other fixes pointed in v1 review

Amarnath Valluri (9):
  tpm-backend: Remove unneeded member variable from backend class
  tpm-backend: Move thread handling inside TPMBackend
  tpm-backend: Initialize and free data members in it's own methods
  tpm-backend: Made few interface methods optional
  tmp backend: Add new api to read backend TpmInfo
  tpm-backend: Remove unneeded destroy() method from TpmDriverOps
    interface
  tpm-backend: Move realloc_buffer() implementation to base class
  tpm-passthrough: move reusable code to utils
  tpm: Added support for TPM emulator

 backends/tpm.c                   | 121 +++--
 configure                        |  15 +-
 hmp.c                            |  31 +-
 hw/tpm/Makefile.objs             |   1 +
 hw/tpm/tpm_emulator.c            | 927 +++++++++++++++++++++++++++++++++++++++
 hw/tpm/tpm_ioctl.h               | 243 ++++++++++
 hw/tpm/tpm_passthrough.c         | 221 +++-------
 hw/tpm/tpm_util.c                |  25 ++
 hw/tpm/tpm_util.h                |   4 +
 include/sysemu/tpm_backend.h     |  65 ++-
 include/sysemu/tpm_backend_int.h |  41 --
 qapi-schema.json                 |  67 ++-
 qemu-options.hx                  |  53 ++-
 tpm.c                            |  36 +-
 14 files changed, 1529 insertions(+), 321 deletions(-)
 create mode 100644 hw/tpm/tpm_emulator.c
 create mode 100644 hw/tpm/tpm_ioctl.h
 delete mode 100644 include/sysemu/tpm_backend_int.h

-- 
2.7.4
