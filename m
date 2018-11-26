Received: from eggs.gnu.org ([2001:4830:134:3::10]:55768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gRM4S-0003Lx-CA
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:57:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gRM4M-00067X-9c
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:57:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41884
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gRM4K-00064u-1P
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:57:18 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAQIiT6E026896
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 13:57:12 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p0p61gyu8-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 13:57:12 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Mon, 26 Nov 2018 18:57:11 -0000
References: <20181122165432.4437-1-cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 26 Nov 2018 13:57:06 -0500
MIME-Version: 1.0
In-Reply-To: <20181122165432.4437-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <fb3c895c-3e3a-8588-5fee-85910840a794@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] vfio-ccw: support hsch/csch (kernel
 part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>



On 11/22/2018 11:54 AM, Cornelia Huck wrote:
> [This is the Linux kernel part, git tree is available at
> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-caps
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
> Very lightly tested (I can interact with a dasd as before; I have not
> found a reliable way to trigger hsch/csch in the Linux dasd guest driver.)
> 

I was able to trigger the guest DASD driver to issue a csch instruction, 
and from my brief testing it seems to be working just like it would on 
the LPAR. (I basically tested with 2 threads trying to issue DASD device 
reserve and release ioctls, on the same DASD device, in a busy loop).

I am going to spend some time doing a deeper review.

Thanks
Farhan


> Cornelia Huck (3):
>    vfio-ccw: add capabilities chain
>    s390/cio: export hsch to modules
>    vfio-ccw: add handling for asnyc channel instructions
> 
>   drivers/s390/cio/Makefile           |   3 +-
>   drivers/s390/cio/ioasm.c            |   1 +
>   drivers/s390/cio/vfio_ccw_async.c   |  88 +++++++++++++
>   drivers/s390/cio/vfio_ccw_drv.c     |  48 +++++--
>   drivers/s390/cio/vfio_ccw_fsm.c     | 158 +++++++++++++++++++++-
>   drivers/s390/cio/vfio_ccw_ops.c     | 195 ++++++++++++++++++++++++----
>   drivers/s390/cio/vfio_ccw_private.h |  44 +++++++
>   include/uapi/linux/vfio.h           |   5 +
>   include/uapi/linux/vfio_ccw.h       |  12 ++
>   9 files changed, 509 insertions(+), 45 deletions(-)
>   create mode 100644 drivers/s390/cio/vfio_ccw_async.c
> 
