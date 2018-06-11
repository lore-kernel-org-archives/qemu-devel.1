Received: from eggs.gnu.org ([2001:4830:134:3::10]:35945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fSIoD-0000WG-0I
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fSIo8-0002mo-0s
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:08:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1fSIo7-0002mV-NU
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:08:11 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5B9518M038060
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 05:08:10 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jhm6ux6kn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 05:08:10 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Mon, 11 Jun 2018 10:08:07 +0100
References: <1528374154-14680-1-git-send-email-thuth@redhat.com>
From: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Mon, 11 Jun 2018 11:08:02 +0200
MIME-Version: 1.0
In-Reply-To: <1528374154-14680-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <6e3c0582-86e0-383b-d6d3-7ba127198fd6@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] pc-bios/s390-ccw: Allow network
 booting via pxelinux.cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>

On 07.06.2018 14:22, Thomas Huth wrote:
> This patch series adds pxelinux.cfg-style network booting to the s390-ccw
> firmware. The core pxelinux.cfg loading and parsing logic has recently
> been merged to SLOF, so these patches now just have to make sure to call
> the right functions to get the config file loaded and parsed. Once this is
> done, the kernel and initrd are loaded separately, and are then glued
> together in RAM.
> 
> v2:
>  - Update SLOF submodule now that the git mirror is in sync again
>  - Last parameter to tftp_get_error_info() must not be NULL
>  - Check CC when calling STSI, and use a #define for the UUID offset
>  - Only support files with the magic "# pxelinux" string comment when
>    trying to guess the contents of a file that has been downloaded via
>    the "bootfile" DHCP parameter. This is just for developers' convenience,
>    the official way to specify pxelinux.cfg files is to use the DHCP
>    options 209 and 210 instead.
> 
> Thomas Huth (4):
>   roms: Update SLOF submodule to current status
>   pc-bios/s390-ccw/net: Update code for the latest changes in SLOF
>   pc-bios/s390-ccw/net: Add support for pxelinux-style config files
>   pc-bios/s390-ccw/net: Try to load pxelinux.cfg file accoring to the
>     UUID
> 
>  pc-bios/s390-ccw/netboot.mak |   9 +-
>  pc-bios/s390-ccw/netmain.c   | 226 +++++++++++++++++++++++++++++--------------
>  roms/SLOF                    |   2 +-
>  3 files changed, 162 insertions(+), 75 deletions(-)
> 
I tested the series both with a self-created pxelinux.0 blob (to verify
backward compatibility) and without an existing pxelinux.0 file (to
force the standard pxelinux pattern). Both worked as expected, although
the built-in search took significantly longer (timeout?).

Tested-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

-- 
Regards,
  Viktor Mihajlovski
