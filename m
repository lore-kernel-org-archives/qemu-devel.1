Received: from eggs.gnu.org ([2001:4830:134:3::10]:58749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5XyR-0001Es-6V
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5XyO-0001lN-2F
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53686
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d5XyN-0001kv-Sg
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:12 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42DYHe2009694
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 09:36:10 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a6rrc7beu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 09:36:10 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 2 May 2017 14:36:09 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue,  2 May 2017 15:35:52 +0200
Message-Id: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 00/12] next batch of s390x patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

The following changes since commit 38bb54f323bf7c83496b6a044cfd28896e997a00:

  replication: Make --disable-replication compile again (2017-04-28 16:50:16 +0100)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20170502

for you to fetch changes up to 99efaa2696caaf6182958e27d553449674894b27:

  hw/s390x/ipl: Fix crash with virtio-scsi-pci device (2017-05-02 15:08:54 +0200)

----------------------------------------------------------------
More s390x patches, this time boot related:
- LOADPARM machine property, exposed to the guest via SCLP and
  diagnose 308
- Use LOADPARM in the s390-ccw bios to select a boot entry
- Fix a crash in the ipl device code when a virtio-scsi-pci device
  has been specified

----------------------------------------------------------------

Cornelia Huck (1):
  pc-bios/s390-ccw.img: update image

Eugene (jno) Dvurechenski (2):
  pc-bios/s390-ccw: Make ebcdic/ascii conversion public
  pc-bios/s390-ccw: add boot entry selection to El Torito routine

Farhan Ali (8):
  hw/s390x: provide loadparm property for the machine
  hw/s390x/ipl: enable LOADPARM in IPIB for a boot device
  hw/s390x/sclp: update LOADPARM in SCP Info
  util/qemu-config: Add loadparm to qemu machine_opts
  pc-bios/s390-ccw: get LOADPARM stored in SCP Read Info
  pc-bios/s390-ccw: provide a function to interpret LOADPARM value
  pc-bios/s390-ccw: provide entry selection on LOADPARM for SCSI disk
  pc-bios/s390-ccw: add boot entry selection for ECKD DASD

Thomas Huth (1):
  hw/s390x/ipl: Fix crash with virtio-scsi-pci device

 hw/s390x/ipl.c                            |  39 +++++++++++++++++++++++++++---
 hw/s390x/ipl.h                            |   3 +++
 hw/s390x/s390-virtio-ccw.c                |  37 ++++++++++++++++++++++++++++
 hw/s390x/sclp.c                           |   9 +++++++
 include/hw/s390x/s390-virtio-ccw.h        |   1 +
 pc-bios/s390-ccw.img                      | Bin 26456 -> 26472 bytes
 pc-bios/s390-ccw/Makefile                 |   2 +-
 pc-bios/s390-ccw/bootmap.c                |  34 +++++++++++++++++---------
 pc-bios/s390-ccw/bootmap.h                |  24 +-----------------
 pc-bios/s390-ccw/main.c                   |  38 ++++++++++++++++++++++++++++-
 pc-bios/s390-ccw/s390-ccw.h               |  17 ++++++++++++-
 pc-bios/s390-ccw/{sclp-ascii.c => sclp.c} |  12 +++++++++
 pc-bios/s390-ccw/sclp.h                   |   2 ++
 util/qemu-config.c                        |   6 +++++
 14 files changed, 184 insertions(+), 40 deletions(-)
 rename pc-bios/s390-ccw/{sclp-ascii.c => sclp.c} (87%)

-- 
2.11.0
