Received: from eggs.gnu.org ([2001:4830:134:3::10]:57558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fAvnB-0007zq-Gc
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fAvn8-0000y7-8v
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:07:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34570
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1fAvn8-0000x6-2V
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:07:22 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3OB67m3192602
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 07:07:21 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hj29dkkpc-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 07:07:19 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 24 Apr 2018 12:07:18 +0100
References: <1524470305-26484-1-git-send-email-thuth@redhat.com>
	<1524470305-26484-3-git-send-email-thuth@redhat.com>
From: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 24 Apr 2018 13:07:13 +0200
MIME-Version: 1.0
In-Reply-To: <1524470305-26484-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <06bd598b-7c14-03fc-9720-36a4b68f10b4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] pc-bios/s390-ccw/net: Add support
 for pxelinux-style config files
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

On 23.04.2018 09:58, Thomas Huth wrote:
> Since it is quite cumbersome to manually create a combined kernel with
> initrd image for network booting, we now support loading via pxelinux
> configuration files, too. In these files, the kernel, initrd and command
> line parameters can be specified seperately, and the firmware then takes
> care of glueing everything together in memory after the files have been
> downloaded.
> 
> The user can either specify a config file directly as bootfile via DHCP
> (but in this case, the file has to start either with "default" or a "#"
> comment so we can distinguish it from binary kernels), or a folder (i.e.
> the bootfile name must end with "/") where the firmware should look for
> the typical pxelinux.cfg file names based on MAC or IP address. If no
> direct file or folder has been specified, we still look for certain
> files in the default "pxelinux.cfg/" folder, but omit some of the file
> names to avoid to download x86 config files here by mistake.
I don't think this is necessary, since the DHCP server configuration
SHOULD take into consideration the processor architecture. In fact it is
even annoying and hard to understand that an attempt is made to load the
uuid, mac and "full ip" based config files but not the "abbreviated ip"
or default file. After all, even if the config file for x86 was loaded,
the effect will be that the network boot fails (as it does now).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/netboot.mak |   5 +-
>  pc-bios/s390-ccw/netmain.c   | 225 +++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 222 insertions(+), 8 deletions(-)
> 
[...]
-- 
Regards,
  Viktor Mihajlovski
