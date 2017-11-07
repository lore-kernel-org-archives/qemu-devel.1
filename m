Received: from eggs.gnu.org ([2001:4830:134:3::10]:55434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBsEU-0005JP-Kd
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:59:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBsER-0003me-EU
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:59:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40984
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eBsER-0003mL-9o
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:59:11 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA70sZOf065914
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 19:59:04 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e31y4t6th-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 19:59:04 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 6 Nov 2017 19:59:03 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon,  6 Nov 2017 19:58:51 -0500
Message-Id: <1510016336-4086-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/5] tpm: Match frontend and backend buffer
 sizes (not 2.11)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Cc: amarnath.valluri@intel.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

This patch series does away with the hard coded buffer size in the TIS
frontend and instead retrieves the buffer size from the device that's
being used. So it gets it from the host device or the external emulator.
In case the frontend (CRB) cannot support the backend's current buffer size
(typically 4k) it can adjust the buffer size the emulator is working with
so that we will not run into the problem that the backend produces packets
that the frontend cannot deliver to due mismatching buffer sizes.

   Stefan

Stefan Berger (5):
  tpm: Move getting TPM buffer size to backends
  tpm: pull tpm_util_send() out of tpm_util_test()
  tpm: tpm_passthrough: Read the buffer size from the host device
  tpm: tpm_emulator: get and set buffer size of device
  tpm: tpm_passthrough: Fail startup if FE buffer size < BE buffer size

 backends/tpm.c               |  13 +++-
 hw/tpm/tpm_emulator.c        |  83 +++++++++++++++++++++++-
 hw/tpm/tpm_int.h             |   9 +++
 hw/tpm/tpm_ioctl.h           |  28 +++++++-
 hw/tpm/tpm_passthrough.c     |  30 +++++++++
 hw/tpm/tpm_tis.c             |  18 +++---
 hw/tpm/tpm_util.c            | 149 +++++++++++++++++++++++++++++++++++++++++--
 hw/tpm/tpm_util.h            |   3 +
 include/sysemu/tpm_backend.h |  17 ++++-
 9 files changed, 327 insertions(+), 23 deletions(-)

-- 
2.5.5
