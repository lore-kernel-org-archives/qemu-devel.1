Received: from eggs.gnu.org ([2001:4830:134:3::10]:37096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzlo8-00026b-W0
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzlo5-0003IU-PK
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dzlo5-0003HU-Gk
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:41:57 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94FdOun032541
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 11:41:53 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dcyft4c5u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 11:41:52 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 4 Oct 2017 16:41:50 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed,  4 Oct 2017 17:41:36 +0200
Message-Id: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/8] improve error handling for IO instr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

This is the v2 of my infamous nameless series (archive link:
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06076.html).

Abstract
=======

The basic idea is: tell how to handle an unusual condition where it's
identified, instead of mapping it to an errno (more or less arbitrarily),
then possibly mapping these errnos around, to finally (mentally) map the
errno back to the condition and take appropriate action.

According to Dong Jia the patch-set also has a functional value: for ccw
pass-through, he is planing to pass-through the instruction completion
information (cc or interruption condition) from the kernel, and this
patch set can pretty much be seen as a preparation for that.

Changelog
=========

There was a fair amount of discussion regarding during the review of v1.
For certain issues we have decided to address them differently (e.g. use
unit-exception for VFIO if extra constraints are not respected, get rid
of the addressing check, assert if do_subchannel_work called without
improperly) and for some we decided to not address them for now (e.g.
use if callbacks are null).

Although this was not part of the v1 discussion, I have also decided to
go back to return values (opposed to adding new state to SubchDev). There
are multiple reasons for doing so: 
* Most of, but not all IO instructions
operate on a subchannel, thus having the instruction ending control in
SubchDev is a bit weird. 
* Get both the compiler and the good habits on ours side (e.g. non-void
control reaches end of non-void function warning (-Wreturn-type), no
overwrites possible, instead of having to check a certain member of a
certain struct after a function call just don't ignore return values).

v1 -> v2:
* use assert if do_subchannel_work without any functions being
  accepted 
* generate unit-exception if ccw-vfio can't handle an otherwise
  good channel program (due to extra limitations) 
* keep using return values opposed to recording into SubchDev
* split out 'add infrastructure' from 'refactor first handler'
* reworded some commit messanges and comments
* rebased on top of current master
* dropped r-b's and acks because of the magnitude of the
  changes

Testing
=======

Regarding vfio-ccw Dong Jia did some quick testing with an equivalent
version. Regarding virtual ccw I did only some rudimentary testing.
Should the series be deemed promising more testing would make
sense.

Halil Pasic (8):
  s390x/css: be more consistent if broken beyond repair
  s390x/css: IO instr handler ending control
  s390x: improve error handling for SSCH and RSCH
  s390x: refactor error handling for XSCH handler
  s390x: refactor error handling for CSCH handler
  s390x: refactor error handling for HSCH handler
  s390x: refactor error handling for MSCH handler
  s390x: factor out common ioinst handler logic

 hw/s390x/css.c              | 162 ++++++++++++------------------------------
 hw/s390x/s390-ccw.c         |  11 ++-
 hw/vfio/ccw.c               |  30 ++++++--
 include/hw/s390x/css.h      |  44 +++++++++---
 include/hw/s390x/s390-ccw.h |   2 +-
 target/s390x/ioinst.c       | 169 +++++++-------------------------------------
 6 files changed, 131 insertions(+), 287 deletions(-)

-- 
2.13.5
