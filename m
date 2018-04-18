Received: from eggs.gnu.org ([2001:4830:134:3::10]:49281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1f8ri0-0002NE-LQ
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 14:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1f8rhx-0003O3-Ey
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 14:21:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1f8rhx-0003My-5C
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 14:21:29 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3IIK7jT028697
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 14:21:27 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hea4ju5mr-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 14:21:27 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Wed, 18 Apr 2018 12:21:26 -0600
References: <1524054707-20663-1-git-send-email-thuth@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 18 Apr 2018 14:21:18 -0400
MIME-Version: 1.0
In-Reply-To: <1524054707-20663-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <307f8b80-fca2-d55f-6bc6-85b794afa15e@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 for-2.13 0/4] pc-bios/s390-ccw: Network
 boot improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org



On 04/18/2018 08:31 AM, Thomas Huth wrote:
> Some patches to improve the network boot experience on s390x:
> 
> First, make sure that we shut down the virtio-net device before jumping
> into the kernel. Otherwise some incoming packets might destroy some of
> the kernel's data if it has not taken over the device yet.
> 
> Then the last two patches add support for loading kernels via
> configuration files - pxelinux-style and .INS-file style. This way
> you don't have to manually glue your ramdisk to your kernel anymore,
> so this should be quite a relieve for all users who want to boot
> Linux via the network.
> 
> The config file parsers have been completely written by myself from
> scratch and only tested with some config files that I came up with
> on my own. So if anybody has some pre-existing pxelinux config files
> already for booting a s390x, I'd appreciate some testing to see whether
> this works as expected for you, too!
> 
> Thomas Huth (4):
>    pc-bios/s390-ccw/net: Split up net_load() into init, load and uninit
>      parts
>    pc-bios/s390-ccw/net: Stop virtio-net device before jumping into the
>      OS
>    pc-bios/s390-ccw/net: Add support for pxelinux-style config files
>    pc-bios/s390-ccw/net: Add support for .INS config files
> 
>   pc-bios/s390-ccw/netboot.mak  |   5 +-
>   pc-bios/s390-ccw/netmain.c    | 312 ++++++++++++++++++++++++++++++++++++++----
>   pc-bios/s390-ccw/virtio-net.c |   8 ++
>   pc-bios/s390-ccw/virtio.c     |  19 ++-
>   pc-bios/s390-ccw/virtio.h     |   3 +
>   5 files changed, 312 insertions(+), 35 deletions(-)
> 


I have tried with pxelinux default config file I had and it worked fine. 
I will try a couple more tests.

Also while going through the code again, I noticed a memory leak in the 
function virtio_net_init, and fixed it. I could send a formal patch for 
it, if you want to queue it as part of this series as I think we might 
have missed 2.12 window?

diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index ff7f4da..e83ba08 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -61,6 +61,7 @@ int virtio_net_init(void *mac_addr)
          IPL_assert(buf != NULL, "Can not allocate memory for receive 
buffers");
          vring_send_buf(rxvq, buf, ETH_MTU_SIZE + sizeof(VirtioNetHdr),
                         VRING_DESC_F_WRITE);
+        free(buf);
      }
      vring_notify(rxvq);
