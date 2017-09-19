Received: from eggs.gnu.org ([2001:4830:134:3::10]:53004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duNFV-0003mt-9D
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duNFQ-0002Au-Bg
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:27:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49831
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1duNFQ-00029s-6e
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:27:52 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8JIOHrc138930
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 14:27:51 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d33drv5hf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 14:27:51 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 19:27:49 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 20:27:40 +0200
Message-Id: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/5] add CCW indirect data access support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Abstract
--------

The objective of this series is introducing CCW IDA (indirect data
access) support to our virtual channel subsystem implementation. Briefly
CCW IDA can be thought of as a kind of a scatter gather support for a
single CCW. If certain flags are set, the cda is to be interpreted as an
address to a list which in turn holds further addresses designating the
actual data.  Thus the scheme which we are currently using for accessing
CCW payload does not work in general case. Currently there is no
immediate need for proper IDA handling (no use case), but since it IDA is
a non-optional part of the architecture, the only way towards AR
compliance is actually implementing IDA.

Testing
-------

On request the things meant for testing from v1 were factored out into a
separate series (requested by Connie). Please look for the series  'tests
for CCW IDA' (see [1]) or use the stuff form v1.  

[1] https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg03489.html

Changelog
---------

v2 --> v3:
* added maximum data address checking (see patch #4) (Dong Jia)
  To not mix converting to the new infrastructure and changing
  behavior, this is done after the conversion. For IDA the same
  (on both IDAL and data  level) is now a part of the respective
  patch (was missing in v2).
* even less nits, and improved aesthetics (mostly Dong Jia)
v1 --> v2:
* factored out the stuff added only for testing
* use g_assert instead of assert
* fixed a lot's of typos
* removed some TODOs addressed by another series of mine
* refactored ccw_dstream_rw_ida (structured programming)
* done some rewording of commit message #3

Halil Pasic (5):
  s390x/css: introduce css data stream
  s390x/css: use ccw data stream
  virtio-ccw: use ccw data stream
  390x/css: introduce maximum data address checking
  s390x/css: support ccw IDA

 hw/s390x/css.c         | 189 +++++++++++++++++++++++++++++++++++++++++++++++--
 hw/s390x/virtio-ccw.c  | 157 ++++++++++++----------------------------
 include/hw/s390x/css.h |  68 ++++++++++++++++++
 3 files changed, 299 insertions(+), 115 deletions(-)

-- 
2.13.5
