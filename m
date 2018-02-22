Received: from eggs.gnu.org ([2001:4830:134:3::10]:50138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1eopuP-00081d-37
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1eopuK-00033a-RT
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:23:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51764
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1eopuK-00033L-Ly
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:23:28 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1MCKWRF028335
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 07:23:28 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g9wex9242-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 07:23:26 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Thu, 22 Feb 2018 12:23:25 -0000
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
	<29048432-906e-5fbe-d927-0814b0c24e4d@de.ibm.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu, 22 Feb 2018 13:23:20 +0100
MIME-Version: 1.0
In-Reply-To: <29048432-906e-5fbe-d927-0814b0c24e4d@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <d31eb692-fd5e-7e83-1fa3-66d66f631043@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v8 00/13] Interactive Boot Menu for DASD
 and SCSI Guests on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com

On 22.02.2018 12:51, Christian Borntraeger wrote:
> Series
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> 
> menu on scsi and dasd bootmaps tested successfully.
> 
> There is one thing that we might want to fix (can be an addon patch since this is a non-customer
> scenario (no libvirt)).
> 
> If you start QEMU manually without a bootindex, the -boot menu=on is ignored
> if no drive has a bootindex.
> 
> For example:
> 
> -drive file=/dev/dasda,if=none,id=d1 -device virtio-blk-ccw,drive=d1,bootindex=1 -boot menu=on
> does work
> 
> -drive file=/dev/dasda -boot menu=on
> does not
> 
> instead it prints:
> qemu-system-s390x: boot menu is not supported for this device type.
> 
> and the boots up the default entry.
> 
That should indeed be a separate patch, as it would move logic currently
in the BIOS up to QEMU (find the first defined virtio disk and select it
as boot disk).
In fact it's more complicated than that, because it would have to
properly account for -boot order=[acdn] and produce the respective IPLB.
While it makes sense, I wouldn't rush that in but rather change the
error message to indicate that -device bootindex is needed to activate
the menu, at least for the time being.
[...]

-- 
Regards,
 Viktor Mihajlovski
