Received: from eggs.gnu.org ([2001:4830:134:3::10]:52438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dxtBT-0002sf-9P
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dxtBN-0005we-GV
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:10:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:42442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1dxtBN-0005tE-8n
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:10:13 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Fri, 29 Sep 2017 14:10:12 +0300
Message-Id: <1506683421-27004-1-git-send-email-amarnath.valluri@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v10 0/9] Provide support for the software TPM
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, marcandre.lureau@gmail.com, Amarnath Valluri <amarnath.valluri@intel.com>
List-ID: <qemu-devel.nongnu.org>

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

** Changes in V2:
- Made spawnning swtpm optional
- used QIOChannel instead of plain unix sockets
- incorporated other fixes pointed in v1 review

** Changes in v3:
- Addressed review comments made by Stefan Berger and Deniel
P Berrange

** Changes in v4:
- Moved realloc_buffer() to TIS model
- Made TpmInfo related change backwards compatible.

** Changes in v5:
- updated Reviewed-By: tag to git commits
- added migration blocker to TPM emulator backend

** Changes in v6:
- rebased agianst latest master
- Address review comments maded by Stefan Berger

** Changes in v7:
- rebased agianst latest master
- Rewritten emulater backend using chardev backend

** Changes in v[89]:
- Address review comments maded by Stefan Berger and Marc-Andre
- Removed unneeded had_startup_error() method from TPMDriverOps

** Changes in v10:
- Kept tpm_cleanup() to a seperate commit
- used qio_channel_read_all() inplace of qio_channel_read()
- Fix typo in commit messge

Amarnath Valluri (9):
  tpm-backend: Remove unneeded member variable from backend class
  tpm-backend: Move thread handling inside TPMBackend
  tpm-backend: Initialize and free data members in it's own methods
  tpm-backend: Made few interface methods optional
  tpm backend: Add new api to read backend TpmInfo
  tpm-backend: Move realloc_buffer() implementation to tpm-tis model
  tpm-passthrough: move reusable code to utils
  tpm: Added support for TPM emulator
  tpm: Move tpm_cleanup() to right place

 backends/tpm.c                   | 115 +++++---
 configure                        |  13 +-
 hmp.c                            |   5 +
 hw/tpm/Makefile.objs             |   1 +
 hw/tpm/tpm_emulator.c            | 587 +++++++++++++++++++++++++++++++++++++++
 hw/tpm/tpm_ioctl.h               | 246 ++++++++++++++++
 hw/tpm/tpm_passthrough.c         | 242 ++++------------
 hw/tpm/tpm_tis.c                 |  14 +-
 hw/tpm/tpm_util.c                |  25 ++
 hw/tpm/tpm_util.h                |   4 +
 include/sysemu/tpm_backend.h     |  80 +++---
 include/sysemu/tpm_backend_int.h |  41 ---
 qapi/tpm.json                    |  21 +-
 qemu-options.hx                  |  22 +-
 tpm.c                            |  37 +--
 vl.c                             |   1 +
 16 files changed, 1088 insertions(+), 366 deletions(-)
 create mode 100644 hw/tpm/tpm_emulator.c
 create mode 100644 hw/tpm/tpm_ioctl.h
 delete mode 100644 include/sysemu/tpm_backend_int.h

-- 
2.7.4
