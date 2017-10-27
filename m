Received: from eggs.gnu.org ([2001:4830:134:3::10]:40009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e8Dec-0002eV-9P
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e8DeU-0003oW-4e
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:03:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45776
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e8DeT-0003np-VD
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:02:58 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9RMwm7c023967
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 19:02:53 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dvdeb986a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 19:02:53 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 27 Oct 2017 19:02:52 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 27 Oct 2017 19:02:34 -0400
Message-Id: <1509145361-11218-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/7] tpm: Extend TPM with state migration
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

This set of patches implements support for migrating the state of the
external 'swtpm' TPM emulator as well as that of the emulated device
interfaces. I have primarily tested this with TPM 1.2 so far, but it
also seems to work with TPM 2 and the CRB interface.

This series applies on top of Marc-Andre's patch set with all 42 patches
applied (21 of them have been applied).

One of the challenges that is addressed by this set of patches is the fact
that the TPM emulator may be processing a command while the state
serialization of the devices is supposed to happen. A necessary first step
has been implemented here that ensures that a response has been received
from the exernal emulator and the bottom half function, which delivers the
response and adjusts device registers (TIS or CRB), has been executed,
before the device's state is serialized.

A subsequent extension may need to address the live migration loop and delay
the serialization of devices until the response from the external TPM has
been received. Though the likelihood that someone executes a long-lasting
TPM command while this is occurring is certainly rare.

   Stefan

Stefan Berger (7):
  tpm: Introduce condition to notify waiters of completed command
  tpm: Introduce condition in TPM backend for notification
  tpm: implement tpm_backend_wait_cmd_completed
  tpm: Implement tpm_sized_buffer_reset
  tpm: extend TPM emulator with state migration support
  tpm: extend TPM TIS with state migration support
  tpm: extend TPM CRB with state migration support

 backends/tpm.c               |  29 ++++
 hw/tpm/tpm_crb.c             |  73 +++++++++-
 hw/tpm/tpm_emulator.c        | 309 +++++++++++++++++++++++++++++++++++++++++--
 hw/tpm/tpm_tis.c             | 151 +++++++++++++++++++--
 hw/tpm/tpm_util.c            |   7 +
 hw/tpm/tpm_util.h            |   7 +
 include/sysemu/tpm_backend.h |  22 +++
 7 files changed, 572 insertions(+), 26 deletions(-)

-- 
2.5.5
