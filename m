Received: from eggs.gnu.org ([2001:4830:134:3::10]:52754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d3PAx-0008HF-BR
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d3PAs-0006iN-Fy
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:48:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48070
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1d3PAs-0006i2-9f
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:48:14 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QFiWFh078872
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 11:48:11 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a2ebwu8e7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 11:48:11 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 26 Apr 2017 11:48:10 -0400
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 26 Apr 2017 17:48:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Message-Id: <76868ba7-610d-ef56-bbd4-ed26f55164dd@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 0/5] Enable virtio-scsi boot from
 /dev/sgX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alexander Graf <agraf@suse.de>

On 04/26/2017 04:46 PM, Eric Farman wrote:
> Today, trying to boot a guest from a SCSI LUN on s390x yields the following:
> 
>   virtio-blk               = OK
>   virtio-scsi and /dev/sdX = OK
>   virtio-scsi and /dev/sgX = FAIL
> 
> Example of the failing scenario:
> 
>   /usr/bin/qemu-system-s390x ...
>     -device virtio-scsi-ccw,id=scsi0,devno=fe.0.0001
>     -drive file=/dev/sg2,if=none,id=drive0,format=raw
>     -device scsi-generic,bus=scsi0.0,channel=0,scsi-id=0,drive=drive0,id=disk0
>   LOADPARM=[........]
>   Using virtio-scsi.
>   Using SCSI scheme.
>   ..
>   ! virtio-scsi:read_many: STATUS=02 RSPN=70 KEY=0b CODE=00 QLFR=06, sure !
> 
> Why do we care?  Well, libvirt converts a virtio-scsi device from the host
> SCSI address (host:bus:target:lun) into the associated /dev/sgX device,
> which means we can't boot from virtio-scsi and have to rely on virtio-blk
> for this action.
> 
> The short version of what happens is the host device driver rejects our
> requests because the transfer lengths are too long for it to satisfy.
> A virtio-scsi disk connected via scsi-generic is fine as a non-boot device
> because the guest kernel is able to break up the requests for us.  So we just
> need to handle this situation for the boot process.

Out of curiosity. Why is the guest kernel submitting "short enough" requests?
If it querying the device itself via scsi commands before issuing commands?
