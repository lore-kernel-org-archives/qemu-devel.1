Received: from eggs.gnu.org ([2001:4830:134:3::10]:39737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fbZ65-0006OD-EP
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 18:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fbZ62-0005F5-9O
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 18:21:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fbZ61-0005Bp-Vv
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 18:20:58 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w66MJR8V108719
	for <qemu-devel@nongnu.org>; Fri, 6 Jul 2018 18:20:56 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k2f483ku1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 18:20:56 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 6 Jul 2018 23:20:54 +0100
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-16-git-send-email-jjherne@linux.ibm.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Sat, 7 Jul 2018 00:20:47 +0200
MIME-Version: 1.0
In-Reply-To: <1530811543-6881-16-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <68af3ea7-9d3b-d0b4-0738-dda4f62588db@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC 15/15] s390-bios: Use sense ccw to ensure
 consistent device state at boot time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com



On 07/05/2018 07:25 PM, Jason J. Herne wrote:
> If a vfio-ccw device is left in an error state (example: pending unit
> check) then it is possible for that state to persist for a vfio-ccw device even
> after the enable subchannel that we do to bring the device online. If this state
> is allowed to persist then even simple I/O operations will needlessly fail. A
> basic sense ccw is used to clear this error state for the boot device.
> 
> Signed-off-by: Jason J. Herne<jjherne@linux.ibm.com>

I don't like this. AFAIK an IPL is preceded by and subsystem reset. If
it weren't the IPL-ed OS (program) would have to take care any potential
mess left by the previous one -- and pray it gets control. A subsystem
reset should clear any device error state, so it is not supposed to
persist across subsystem resets. If the error re-emerges (unsolicited)
after the reset, it's likely something is really broken and needs investigation.
Generally IPL is supposed to fail in such cases (except for corner cases
which are not really handled by this patch).

AFAIU this patch works around a broken reset. While our bios is not guest and
one could try to argue that it's firmware -- part of 'the machine', a believe
handling the reset in the bios is wrong. AFAIR the qemu emulator is in charge,
and if needed makes kvm do what it has to.

If the reset is broken for vfio-ccw (which is very possible, but I would have
to check), I think we should fix it in the right place. A workaround may be
still justified (if kernel changes  like clear support are needed). But we
should indicate that clearly in the commit message and in the code.

Regards,
Halil

  
