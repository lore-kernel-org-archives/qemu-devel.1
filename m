Received: from eggs.gnu.org ([2001:4830:134:3::10]:43477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eZLDs-0005Hq-3o
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eZLDn-0000rg-6l
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:35:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eZLDm-0000qd-ND
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:35:31 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0AIYqAR063583
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 13:35:29 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fdphucrp5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 13:35:28 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 10 Jan 2018 11:35:27 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 10 Jan 2018 13:35:15 -0500
Message-Id: <1515609318-1897-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 0/3] Implement Pysical Presence Interface
 for TPM 1.2 and 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanb@linux.vnet.ibm.com, kevin@koconnor.net, marcandre.lureau@redhat.com

The following patches implement the TPM Physical Presence Interface that
allows a user to set a command via ACPI (sysfs entry in Linux) that, upon
the next reboot, the firmware (BIOS, UEFI) looks for an acts upon by sending
sequences of commands to the TPM 1.2 or 2.

My first goal is to get the virtual memory device accepted since it extends
the TPM TIS (and TPM CRB) interface's internal data structure with another
256 bytes that would have to be written out when suspending the VM. So this
patch would have to come before we support VM with TPM suspend and resume.
The device supports 256 bytes at address 0xffff0000. This is the address that
EDK2 uses and that I have patches for for SeaBIOS support.

Regards,
   Stefan

Stefan Berger (3):
  tpm: Implement virtual memory device for TPM PPI
  acpi: implement aml_lless_equal
  acpi: Build TPM Physical Presence interface

 hw/acpi/aml-build.c         |  10 ++
 hw/i386/acpi-build.c        | 227 ++++++++++++++++++++++++++++++++++++++++++++
 hw/tpm/Makefile.objs        |   2 +-
 hw/tpm/tpm_ppi.c            |  79 +++++++++++++++
 hw/tpm/tpm_ppi.h            |  25 +++++
 hw/tpm/tpm_tis.c            |   5 +
 include/hw/acpi/aml-build.h |   1 +
 include/hw/acpi/tpm.h       |  21 ++++
 8 files changed, 369 insertions(+), 1 deletion(-)
 create mode 100644 hw/tpm/tpm_ppi.c
 create mode 100644 hw/tpm/tpm_ppi.h

-- 
2.5.5
