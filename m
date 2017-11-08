Received: from eggs.gnu.org ([2001:4830:134:3::10]:36765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCVc9-0000c8-SZ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCVc3-0000PZ-U6
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:02:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eCVc3-0000P4-M6
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:02:11 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA8J06LN095251
	for <qemu-devel@nongnu.org>; Wed, 8 Nov 2017 14:02:07 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e45b80nny-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 14:02:07 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 8 Nov 2017 12:02:06 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed,  8 Nov 2017 14:01:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1510167719-4357-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/5] tpm: Match frontend and backend buffer
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
In case the frontend (CRB) cannot support the backend's current buffer si=
ze
(typically 4k) it can adjust the buffer size the emulator is working with
so that we will not run into the problem that the backend produces packet=
s
that the frontend cannot deliver to due mismatching buffer sizes.

   Stefan

v1->v2:
  - followed Marc-Andr=C3=A9's suggestions


Stefan Berger (5):
  tpm: Move getting TPM buffer size to backends
  tpm: pull tpm_util_request() out of tpm_util_test()
  tpm: tpm_passthrough: Read the buffer size from the host device
  tpm: tpm_emulator: get and set buffer size of device
  tpm: tpm_passthrough: Fail startup if FE buffer size < BE buffer size

 backends/tpm.c               |  11 ++-
 hw/tpm/tpm_emulator.c        |  83 ++++++++++++++++++++++-
 hw/tpm/tpm_int.h             |   9 +++
 hw/tpm/tpm_ioctl.h           |  28 +++++++-
 hw/tpm/tpm_passthrough.c     |  30 +++++++++
 hw/tpm/tpm_tis.c             |  18 ++---
 hw/tpm/tpm_util.c            | 155 +++++++++++++++++++++++++++++++++++++=
+++---
 hw/tpm/tpm_util.h            |   3 +
 include/sysemu/tpm_backend.h |  18 ++++-
 9 files changed, 330 insertions(+), 25 deletions(-)

--=20
2.5.5
