Received: from eggs.gnu.org ([2001:4830:134:3::10]:46411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0626c35109=borntraeger@de.ibm.com>)
	id 1f1UPV-00010L-98
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0626c35109=borntraeger@de.ibm.com>)
	id 1f1UPS-0002eM-6a
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:03:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0626c35109=borntraeger@de.ibm.com>)
	id 1f1UPR-0002dJ-TT
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:03:54 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2T9o8ZO032950
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 06:03:50 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h0v0y5dca-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 06:03:49 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 29 Mar 2018 11:03:46 +0100
References: <1522316251-16399-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 29 Mar 2018 12:03:42 +0200
MIME-Version: 1.0
In-Reply-To: <1522316251-16399-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2103b547-66aa-d1f7-a504-cb6ef3672039@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.13] pc-bios/s390-ccw: Increase virtio
 timeout to 30 seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, ldoktor@redhat.com



On 03/29/2018 11:37 AM, Thomas Huth wrote:
> The current timeout is set to only three seconds - and considering that
> vring_wait_reply() or rather get_second() is not doing any rounding,
> the real timeout is likely rather 2 seconds in most cases. When the
> host is really badly loaded and we run the guest in TCG mode instead
> of KVM, it's possible that we hit this timeout by mistake. So let's
> increase the timeout to 30 seconds instead to ease this situation (30
> seconds is also the timeout that is used by the Linux SCSI subsystem
> for example, so this seems to be a sane value for block IO timeout).

I have never seen this, but cant this also with KVM (e.g. host paging
and the swap disk is busy for some seconds).

Wouldnt it also qualify for 2.12?

> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1549079
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index 817e7f5..cdb66f4 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -14,7 +14,7 @@
>  #include "virtio-scsi.h"
>  #include "bswap.h"
> 
> -#define VRING_WAIT_REPLY_TIMEOUT 3
> +#define VRING_WAIT_REPLY_TIMEOUT 30
> 
>  static VRing block[VIRTIO_MAX_VQS];
>  static char ring_area[VIRTIO_RING_SIZE * VIRTIO_MAX_VQS]
> 
