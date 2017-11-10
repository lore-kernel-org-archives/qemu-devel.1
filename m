Received: from eggs.gnu.org ([2001:4830:134:3::10]:32945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2X-0003sg-H9
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2S-0004nQ-Jj
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eDA2S-0004iL-7x
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:08 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAAEB4er065311
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:01 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e5a22anmu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:00 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 10 Nov 2017 07:11:59 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 09:11:39 -0500
Message-Id: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 00/13] tpm: Extend TPM with state migration
 support (not 2.11)
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

This set of patches implements support for migrating the state of the
external 'swtpm' TPM emulator as well as that of the emulated device
interfaces. I have primarily tested this with the TIS and TPM 1.2 so
far, but it also seems to work with TPM 2.

The TIS is simplified first by reducing the number of buffers and read
and write offsets into these buffers. Following the state machine of the
TIS, a single buffer and r/w offset is enough for all localities since
only one locality can ever be active.

This series applies on top of my tpm-next branch.

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

Stefan Berger (13):
  tpm_tis: convert uint32_t to size_t
  tpm_tis: limit size of buffer from backend
  tpm_tis: remove TPMSizeBuffer usage
  tpm_tis: move buffers from localities into common location
  tpm_tis: merge read and write buffer into single buffer
  tpm_tis: move r/w_offsets to TPMState
  tpm_tis: merge r/w_offset into rw_offset
  tpm: Implement tpm_sized_buffer_reset
  tpm: Introduce condition to notify waiters of completed command
  tpm: Introduce condition in TPM backend for notification
  tpm: implement tpm_backend_wait_cmd_completed
  tpm: extend TPM emulator with state migration support
  tpm_tis: extend TPM TIS with state migration support

 backends/tpm.c               |  29 +++++
 hw/tpm/tpm_emulator.c        | 303 +++++++++++++++++++++++++++++++++++++++++--
 hw/tpm/tpm_tis.c             | 216 +++++++++++++++++-------------
 hw/tpm/tpm_util.c            |   7 +
 hw/tpm/tpm_util.h            |   7 +
 include/sysemu/tpm_backend.h |  22 ++++
 6 files changed, 483 insertions(+), 101 deletions(-)

-- 
2.5.5
