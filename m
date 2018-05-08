Received: from eggs.gnu.org ([2001:4830:134:3::10]:56325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fG2iR-0001yr-PR
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fG2iL-00018u-QP
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:31:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35766
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fG2iL-00018D-LA
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:31:33 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w48DVIFQ052511
	for <qemu-devel@nongnu.org>; Tue, 8 May 2018 09:31:31 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2huc1gtruh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 09:31:26 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Tue, 8 May 2018 14:29:55 +0100
References: <20180507155130.21085-1-cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Tue, 8 May 2018 15:29:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180507155130.21085-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2a6f6a2a-ddaf-27ae-de04-581dcc67fdd0@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] s390x: reset handling for ccw devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 05/07/2018 05:51 PM, Cornelia Huck wrote:
> On Friday, Thomas noticed some problems with 3270 devices. One result
> was "s390x/css: disabled subchannels cannot be status pending", but
> a reboot did not cure the previous broken status. Turns out that 3270
> devices are missing a reset handler.
> 
> This series cleans up reset handling a bit and makes sure that the base
> ccw device class provides a subchannel reset handler. I'm currently
> not sure what we should do with vfio-ccw, so the behaviour there is
> left unchanged.

Had a look, and LGTM (will tag separately) modulo what follows here. I'm
a bit concerned about vfio-ccw not being made compliant to this new
he reset of CCWDeviceClass is taking care of resetting the subchannel data
structures. This feels like introducing a common abstraction
to me, but then some things bother me.

In particular the the pim, the lpm and the pam set in css_reset_sch
seems to suit only devices that use the virtual chp. That
is it ain't suits any CCWDevice instance.

Do you plan to tackle vfio-ccw reset?

> 
> Cornelia Huck (2):
>    virtio-ccw: common reset handler
>    s390x/ccw: make sure all ccw devices are properly reset
> 
>   hw/s390x/ccw-device.c |  8 ++++++++
>   hw/s390x/virtio-ccw.c | 20 ++++++--------------
>   hw/s390x/virtio-ccw.h |  1 +
>   3 files changed, 15 insertions(+), 14 deletions(-)
> 
