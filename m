Received: from eggs.gnu.org ([2001:4830:134:3::10]:43758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fSLXX-00046R-Gl
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1fSLXR-0005de-Jr
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:03:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39636
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1fSLXR-0005d8-Df
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:03:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5BBweWK118396
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 08:03:08 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jhrcx90p2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 08:03:08 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Mon, 11 Jun 2018 13:03:07 +0100
References: <1528374154-14680-1-git-send-email-thuth@redhat.com>
	<6e3c0582-86e0-383b-d6d3-7ba127198fd6@linux.vnet.ibm.com>
	<66156118-02da-7bf4-3a7d-6261dee27180@redhat.com>
From: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Mon, 11 Jun 2018 14:03:02 +0200
MIME-Version: 1.0
In-Reply-To: <66156118-02da-7bf4-3a7d-6261dee27180@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <2d029b4f-c14c-cdd3-37ca-2e93e6690e2e@linux.vnet.ibm.com>
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
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>

On 11.06.2018 13:12, Thomas Huth wrote:
> On 11.06.2018 11:08, Viktor VM Mihajlovski wrote:
>> On 07.06.2018 14:22, Thomas Huth wrote:
>>> This patch series adds pxelinux.cfg-style network booting to the s390-ccw
>>> firmware. The core pxelinux.cfg loading and parsing logic has recently
>>> been merged to SLOF, so these patches now just have to make sure to call
>>> the right functions to get the config file loaded and parsed. Once this is
>>> done, the kernel and initrd are loaded separately, and are then glued
>>> together in RAM.
>>>
>>> v2:
>>>  - Update SLOF submodule now that the git mirror is in sync again
>>>  - Last parameter to tftp_get_error_info() must not be NULL
>>>  - Check CC when calling STSI, and use a #define for the UUID offset
>>>  - Only support files with the magic "# pxelinux" string comment when
>>>    trying to guess the contents of a file that has been downloaded via
>>>    the "bootfile" DHCP parameter. This is just for developers' convenience,
>>>    the official way to specify pxelinux.cfg files is to use the DHCP
>>>    options 209 and 210 instead.
>>>
>>> Thomas Huth (4):
>>>   roms: Update SLOF submodule to current status
>>>   pc-bios/s390-ccw/net: Update code for the latest changes in SLOF
>>>   pc-bios/s390-ccw/net: Add support for pxelinux-style config files
>>>   pc-bios/s390-ccw/net: Try to load pxelinux.cfg file accoring to the
>>>     UUID
>>>
>>>  pc-bios/s390-ccw/netboot.mak |   9 +-
>>>  pc-bios/s390-ccw/netmain.c   | 226 +++++++++++++++++++++++++++++--------------
>>>  roms/SLOF                    |   2 +-
>>>  3 files changed, 162 insertions(+), 75 deletions(-)
>>>
>> I tested the series both with a self-created pxelinux.0 blob (to verify
>> backward compatibility) and without an existing pxelinux.0 file (to
>> force the standard pxelinux pattern). Both worked as expected, although
>> the built-in search took significantly longer (timeout?).
>>
>> Tested-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> 
> Thanks a lot for the testing!
> 
> Hmm, I've got no real clue why there should be a big difference in the
> amount of time here ... is there maybe a lot of unrelated broadcast
> network traffic from other hosts going on in that network where you've
> tested it? It could be that the virtio-net driver of the s390-ccw bios
> can not deal with that situation very well yet. You could try to
> increase the "64" in virtio_net_init() in pc-bios/s390-ccw/virtio-net.c
> to see whether it makes a difference. Or if you've got some spare time,
> could you maybe run Wireshark on the server side to have a look at the
> time-stamps of the related packets, and to see whether there are
> duplicated TFTP read requests? This could indicate that the firmware
> missed a packet and thus ran into a timeout.
FWIW: I'm using the isolated libvirt network on an otherwise idle host,
so it's unlikely that there's interference. If I find the time I'll have
a look at the traffic.
> 
>  Thomas
> 
> PS: After I posted v1 of the patch set, you reported on IRC that you saw
> a problem with a corrupted initrd download or something similar. Is that
> problem now fixed for you?
> 
Yes, it was my bad. I used an older kernel with the following problem
https://lkml.org/lkml/2017/3/13/683.

-- 
Regards,
  Viktor Mihajlovski
