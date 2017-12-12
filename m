Received: from eggs.gnu.org ([2001:4830:134:3::10]:46440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eOrPV-0001uO-Hc
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 15:44:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eOrPQ-0003os-OO
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 15:44:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eOrPQ-0003oE-G2
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 15:44:12 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBCKg1rG063896
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 15:44:09 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2etnr8stxf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 15:44:09 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 12 Dec 2017 15:44:08 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 12 Dec 2017 15:44:01 -0500
Message-Id: <1513111443-22790-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/2] Add vTPM emulator supportfor ppc64
 platform
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, clg@kaod.org, lo1@us.ibm.com, James.Bottomley@HansenPartnership.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

The following series of patches adds vTPM emulator support for the
ppc64 platform (pSeries). 

It can be tested as follows with swtpm/libtpms:

#> swtpm socket --tpmstate dir=/tmp/mytpm1 \
	--ctrl type=unixio,path=/tmp/mytpm1/ctrl.sock \
	--log level=2

If TPM 2 is desired, add --tpm2 as parameter to the above
and use the latest tpm2-preview branches of libtpms and swtpm.

In another terminal start QEMU:

#> sudo ./ppc64-softmmu/qemu-system-ppc64 -m 1024 \
	-monitor stdio -vnc :12 -vga std \
	--chardev socket,id=chrtpm,path=/tmp/mytpm1/ctrl.sock \
	-tpmdev emulator,id=tpm0,chardev=chrtpm \
	-device tpm-spapr,tpmdev=tpm0 \
	-L /tmp -bios boot_rom.bin \
	myimage.raw

Links:
 - libtpms: https://github.com/stefanberger/libtpms/wiki
 - swtpm: https://github.com/stefanberger/swtpm/wiki

Changes:
 v1->v2:
  - followed Cedric Le Goater's suggestions to patch 1
  - send appropriate CRQ error responses if DMA read or write fails
  - renamed tpm_spapr_got_payload to tpm_spapr_process_cmd and
    pass endianess-adjusted data pointer from CRQ to it

Regards,
    Stefan


Stefan Berger (2):
  tpm_spapr: Support TPM for ppc64 using CRQ based interface
  tpm_spapr: Support suspend and resume

 hw/tpm/Makefile.objs |   1 +
 hw/tpm/tpm_spapr.c   | 435 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/sysemu/tpm.h |   3 +
 qapi/tpm.json        |   5 +-
 4 files changed, 442 insertions(+), 2 deletions(-)
 create mode 100644 hw/tpm/tpm_spapr.c

-- 
2.5.5
