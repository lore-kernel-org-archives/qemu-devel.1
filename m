Received: from eggs.gnu.org ([2001:4830:134:3::10]:56511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fBJnC-0000Ku-Ry
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fBJn8-0007mE-Un
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:45:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34122
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1fBJn8-0007k6-PR
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:44:58 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3PCinaw089802
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 08:44:58 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hjp4har7a-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 08:44:57 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Wed, 25 Apr 2018 13:44:56 +0100
References: <1524647323-6449-1-git-send-email-thuth@redhat.com>
From: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Wed, 25 Apr 2018 14:44:51 +0200
MIME-Version: 1.0
In-Reply-To: <1524647323-6449-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <a3989d86-5376-8fe9-3bb3-e40be6dcc777@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] pc-bios/s390-ccw: Some few network
 boot improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 25.04.2018 11:08, Thomas Huth wrote:
> Note: I've decided to removed the pxelinux.cfg patches from this series
> for now, since full pxelinux support requires to parse some additional
> DHCP options (see https://tools.ietf.org/html/rfc5071), and for this, the
> SLOF libnet code needs to be changed first. So I guess I first have to
> implement pxelinux.cfg support for PPC, too, which will likely take a
> little bit longer...
> Thus to keep this series short and reviewable, and to avoid that the other
> patches bit-rot on my hard disk, I've now only included the patches that
> are not related to pxelinux.cfg.
Makes sense to me.
> 
> The first patch is just a minor code refactoring which should not have
> any visible impact, but makes the following patches easier.
> 
> The second patch makes sure that we leave the machine in a sane state
> before jumping into the Linux kernel - i.e. the netboot firmware now
> resets the machine with diag308, too, just like the main s390-ccw
> is doing it already.
> 
> Patch 3 adds support for loading kernels via .INS configuration files.
> You can find these .INS config files on ISO images, so with this patch,
> it should be possible to boot if the TFTP server is configured to use
> the contents of such an ISO image.
I will try out this insfile support but probably won't be able to do
that before next week.
> 
> Thomas Huth (3):
>   pc-bios/s390-ccw/net: Split up net_load() into init, load and uninit
>     parts
>   pc-bios/s390-ccw/net: Use diag308 to reset machine before jumping to
>     the OS
>   pc-bios/s390-ccw/net: Add support for .INS config files
> 
>  pc-bios/s390-ccw/Makefile    |   4 +-
>  pc-bios/s390-ccw/bootmap.c   |  63 +---------------
>  pc-bios/s390-ccw/bootmap.h   |   4 --
>  pc-bios/s390-ccw/jump2ipl.c  |  81 +++++++++++++++++++++
>  pc-bios/s390-ccw/netboot.mak |   3 +-
>  pc-bios/s390-ccw/netmain.c   | 168 +++++++++++++++++++++++++++++++++++--------
>  pc-bios/s390-ccw/s390-ccw.h  |   4 ++
>  7 files changed, 230 insertions(+), 97 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/jump2ipl.c
> 


-- 
Regards,
  Viktor Mihajlovski
