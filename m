Received: from eggs.gnu.org ([2001:4830:134:3::10]:43210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1epHNG-0003gc-Ld
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1epHNC-0008Ju-La
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:43:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1epHNC-0008I2-DQ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:43:06 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1NHfDDU056157
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 12:43:05 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gam6ysbvj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 12:43:04 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Fri, 23 Feb 2018 17:43:01 -0000
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Fri, 23 Feb 2018 18:42:55 +0100
Message-Id: <1519407778-23095-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 0/3] s390x/sclp: 64 bit event masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cohuck@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com

Until 67915de9f0383ccf4a ("s390x/event-facility: variable-length event masks")
we only supported 32bit sclp event masks, even though the archiecture
allows the guests to set up sclp event masks up to 1021 bytes in length.
With that patch the behaviour was almost compliant, but some issues were
still remaining, in particular regarding the handling of selective reads
and migration.

This patchset fixes migration and the handling of selective reads, and
puts in place the support for 64-bit sclp event masks internally.

A new property of the sclp-event device switches between the 32bit masks
and the compliant behaviour. The property is bound to the machine
version, so older machines keep the old broken behaviour, allowing for
migration, but the default is the compliant implementation.

Fixes: 67915de9f0383ccf4a ("s390x/event-facility: variable-length event masks")

v3 -> v4
* removed all pre_load hooks
* split the internal represntation of the receive mask into an array of
  uint32_t and added accessors; the union would not work on little
  endian hosts!
* fixed the pre-existing documentation comment for copy_mask

v2 -> v3
* fixed some typos in the first patch description
* updated an existing comment in the third patch: newer Linux versions
  will support masks larger than 4 bytes.

v1 -> v2 
* improved comments and patch descriptions to better explain why we need
  this, including better description of the old broken behaviour
* rename SCLPEVMSK to SCLP_EVMASK to improve readability
* removed some unneded variable initializations
* fixed a pre-existing typo

Claudio Imbrenda (3):
  s390x/sclp: proper support of larger send and receive masks
  s390x/sclp: clean up sclp masks
  s390x/sclp: extend SCLP event masks to 64 bits

 hw/char/sclpconsole-lm.c          |   4 +-
 hw/char/sclpconsole.c             |   4 +-
 hw/s390x/event-facility.c         | 153 ++++++++++++++++++++++++++++++--------
 hw/s390x/s390-virtio-ccw.c        |   8 +-
 hw/s390x/sclpcpu.c                |   4 +-
 hw/s390x/sclpquiesce.c            |   4 +-
 include/hw/s390x/event-facility.h |  22 +++---
 7 files changed, 148 insertions(+), 51 deletions(-)

-- 
2.7.4
