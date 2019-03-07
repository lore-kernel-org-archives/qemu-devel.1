Received: from eggs.gnu.org ([209.51.188.92]:48480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1h20Z0-0004kg-BD
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1h20Yy-0000OY-8c
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:28:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57316
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1h20Yw-0000NE-MS
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:28:23 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27LJ56r166709
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 16:28:22 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r3a3abfsq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 16:28:21 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Thu, 7 Mar 2019 21:28:21 -0000
References: <20190301093902.27799-1-cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Thu, 7 Mar 2019 16:28:14 -0500
MIME-Version: 1.0
In-Reply-To: <20190301093902.27799-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <cb6d20d2-0ffe-ba93-716d-f5a079e5dc78@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/6] vfio-ccw: support hsch/csch (kernel
 part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>



On 03/01/2019 04:38 AM, Cornelia Huck wrote:
> [This is the Linux kernel part, git tree is available at
> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-eagain-caps-v3
> 
> The companion QEMU patches are available at
> https://github.com/cohuck/qemu vfio-ccw-caps]
> 
> Currently, vfio-ccw only relays START SUBCHANNEL requests to the real
> device. This tends to work well for the most common 'good path' scenarios;
> however, as we emulate {HALT,CLEAR} SUBCHANNEL in QEMU, things like
> clearing pending requests at the device is currently not supported.
> This may be a problem for e.g. error recovery.
> 
> This patch series introduces capabilities (similar to what vfio-pci uses)
> and exposes a new async region for handling hsch/csch.
> 
> Lightly tested (I can interact with a dasd as before, and reserve/release
> seems to work well.) Not sure if there is a better way to test this, ideas
> welcome.

Hi Connie,

Thanks for the updated branches!  I promise that I'll get back to 
reviewing them "soon," though I've been on some other tangents as of late.

In terms of testing, Farhan and I have been playing around with some 
exercisers/data pushers both with and without your new code, and things 
seem to be okay.  Some of the problems we've reproduced without this 
code (and would fall into the area Pierre's FSM code would address), and 
some seem wholly unrelated.  We're looking into them, but didn't want a 
whole week to go by without you hearing anything on this series.

If I have nothing meaningful tomorrow, enjoy your weekend!

  - Eric

> 
> Changes v3->v4:
> - shrunk the capability offset, we don't need to accommodate as much as pci
> - make checks in patch 1 more consistent and less buggy
> - rebased on top of my current vfio-ccw branch
> 
> Changes v2->v3:
> - Unb0rked patch 1, improved scope
> - Split out the new mutex from patch 2 into new patch 3; added missing
>    locking and hopefully improved description
> - Patch 2 now reworks the state handling by splitting the BUSY state
>    into CP_PROCESSING and CP_PENDING
> - Patches 3 and 5 adapted on top of the reworked patches; hsch/csch
>    are allowed in CP_PENDING, but not in CP_PROCESSING (did not add
>    any R-b due to that)
> - Added missing free in patch 5
> - Probably some small changes I forgot to note down
> 
> Changes v1->v2:
> - New patch 1: make it safe to use the cp accessors at any time; this
>    should avoid problems with unsolicited interrupt handling
> - New patch 2: handle concurrent accesses to the io region; the idea is
>    to return -EAGAIN to userspace more often (so it can simply retry)
> - also handle concurrent accesses to the async io region
> - change VFIO_REGION_TYPE_CCW
> - merge events for halt and clear to a single async event; this turned out
>    to make the code quite a bit simpler
> - probably some small changes I forgot to note down
> 
> Cornelia Huck (6):
>    vfio-ccw: make it safe to access channel programs
>    vfio-ccw: rework ssch state handling
>    vfio-ccw: protect the I/O region
>    vfio-ccw: add capabilities chain
>    s390/cio: export hsch to modules
>    vfio-ccw: add handling for async channel instructions
> 
>   drivers/s390/cio/Makefile           |   3 +-
>   drivers/s390/cio/ioasm.c            |   1 +
>   drivers/s390/cio/vfio_ccw_async.c   |  88 ++++++++++++
>   drivers/s390/cio/vfio_ccw_cp.c      |  21 ++-
>   drivers/s390/cio/vfio_ccw_cp.h      |   2 +
>   drivers/s390/cio/vfio_ccw_drv.c     |  57 ++++++--
>   drivers/s390/cio/vfio_ccw_fsm.c     | 143 +++++++++++++++++-
>   drivers/s390/cio/vfio_ccw_ops.c     | 215 +++++++++++++++++++++++-----
>   drivers/s390/cio/vfio_ccw_private.h |  48 ++++++-
>   include/uapi/linux/vfio.h           |   4 +
>   include/uapi/linux/vfio_ccw.h       |  12 ++
>   11 files changed, 537 insertions(+), 57 deletions(-)
>   create mode 100644 drivers/s390/cio/vfio_ccw_async.c
> 
