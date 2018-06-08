Received: from eggs.gnu.org ([2001:4830:134:3::10]:57883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fRHD5-0001GO-2X
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fRHD1-0000j2-0C
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:13:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fRHD0-0000iF-OI
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:13:38 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w58D9MkN052776
	for <qemu-devel@nongnu.org>; Fri, 8 Jun 2018 09:13:37 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jfqpt7psu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 09:13:37 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 8 Jun 2018 14:13:34 +0100
References: <20180509154822.23510-1-cohuck@redhat.com>
	<20180509154822.23510-3-cohuck@redhat.com>
	<c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
	<20180515181006.0cb1dfc2.cohuck@redhat.com>
	<a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
	<20180522145208.310143ea.cohuck@redhat.com>
	<4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
	<20180605151449.22aafbfc.cohuck@redhat.com>
	<e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
	<20180606142131.74ea2eb7.cohuck@redhat.com>
	<5b77ec9c-41b8-2e32-ce79-d9005b93fdd0@linux.ibm.com>
	<20180607115442.6a779ed9.cohuck@redhat.com>
	<86d57698-3ea7-a390-2217-07c6d41ca9ed@linux.ibm.com>
	<20180608142022.7dd6a658.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 8 Jun 2018 15:13:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180608142022.7dd6a658.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d68340a2-bb1b-cef9-e394-f0d55983c0bb@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] vfio-ccw: support for halt/clear
 subchannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 06/08/2018 02:20 PM, Cornelia Huck wrote:
>>> My proposal is to do the same
>>> copying to scsw(r) again, which would mean we get a request with both
>>> the halt and the start bit set. The vfio code now needs to do a hsch
>>> (instead of a ssch). The real channel subsystem should figure this out,
>>> as we can't reliably check whether the start function has concluded
>>> already (there's always a race window).
>> This I do not agree scsw(r) is part of the driver.
>> The interface here is not a device interface anymore but a driver
>> interface.
>> SCSW is a status, it is at its place in QEMU device interface with the
>> guest
>> but here pwrite() sends a command.
> Hm, I rather consider that "we write a status, and the backend figures
> out what to do based on that status".
> 

The status of what? Kind of a target status?

I think this approach is the source of lots of complications. For instance
take xsch. How are we supposed to react to a guest xsch (in QEMU and
in the kernel module)? My guess is that the right thing to do is to issue
an xsch in the vfio-ccw kernel module on the passed through subchannel.
But there is no bit in fctl for cancel.

Bottom line is: I'm not happy with the current design but I'm not sure
if it's practical to do something about it (i.e. change it radically).

Regards,
Halil
