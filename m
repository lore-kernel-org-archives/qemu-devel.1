Received: from eggs.gnu.org ([2001:4830:134:3::10]:50497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f4QW7-0000mE-Vj
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f4QW4-0000UG-RB
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:30:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53122
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1f4QW4-0000U1-Jl
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:30:52 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w36CTvbF140139
	for <qemu-devel@nongnu.org>; Fri, 6 Apr 2018 08:30:51 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h68g99evx-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 08:30:51 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 6 Apr 2018 13:30:49 +0100
References: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 6 Apr 2018 14:30:45 +0200
MIME-Version: 1.0
In-Reply-To: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f766fb2e-f5b9-c117-fc2a-b51c485d6742@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] s390: Fix virtio-scsi IPL quirks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, cohuck@redhat.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org



On 04/05/2018 05:07 PM, Viktor Mihajlovski wrote:
> IPL from virtio-scsi currently uses a non-standard parameter
> type definition to pass boot parameters from QEMU to the
> BIOS.
> 
> There are two potential issues with this approach:
> o If the guest operating systems requests a re-ipl of type CCW
>   where the boot device is a virtio-scsi HBA, this goes unnoticed
>   by QEMU. The BIOS will detect that it's IPLing from a SCSI
>   device, but it will boot the first LUN found, which might not
>   be the one used for the initial boot.
> o The guest operating system can be confused by an unknown
>   IPL parameter block type. If the OS hasn't previously used 
>   diag308 to store the IPL info but is changed to do so, a
>   user-observable change in behavior will happen.
> 
> The following patches address the issues above. 
> 
> Viktor Mihajlovski (3):
>   s390: Refactor IPL parameter block generation
>   s390: Ensure IPL from SCSI works as expected
>   s390: Do not pass inofficial IPL type to the guest
> 
>  hw/s390x/ipl.c             | 112 ++++++++++++++++++++++++++++++++-------------
>  pc-bios/s390-ccw/bootmap.c |   7 +++
>  pc-bios/s390-ccw/iplb.h    |  15 +++++-
>  3 files changed, 100 insertions(+), 34 deletions(-)
> 

Test looks good so far.
