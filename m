Received: from eggs.gnu.org ([2001:4830:134:3::10]:35796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dD8lm-0001V3-B2
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dD8li-0003T3-Dy
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:18:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43667
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dD8li-0003Sl-9M
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:18:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4NC3k77055896
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 08:18:29 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2amgxytttb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 08:18:29 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 23 May 2017 13:18:27 +0100
Date: Tue, 23 May 2017 14:18:21 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170518111405.56947-1-pasic@linux.vnet.ibm.com>
References: <20170518111405.56947-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170523141821.79db6b2b.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] s390x/css: catch section mismatch
 on load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Thu, 18 May 2017 13:14:05 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Prior to the virtio-ccw-2.7 machine (and commit 2a79eb1a), our virtio
> devices residing under the virtual-css bus do not have qdev_path based
> migration stream identifiers (because their qdev_path is NULL). The ids
> are instead generated when the device is registered as a composition of
> the so called idstr, which takes the vmsd name as its value, and an
> instance_id, which is which is calculated as a maximal instance_id
> registered with the same idstr plus one, or zero (if none was registered
> previously).
> 
> That means, under certain circumstances, one device might try, and even
> succeed, to load the state of a different device. This can lead to
> trouble.
> 
> Let us fail the migration if the above problem is detected during load.
> 
> How to reproduce the problem:
> 1) start qemu-system-s390x making sure you have the following devices
>    defined on your command line:
>      -device virtio-rng-ccw,id=rng1,devno=fe.0.0001
>      -device virtio-rng-ccw,id=rng2,devno=fe.0.0002
> 2) detach the devices and reattach in reverse order using the monitor:
>      (qemu) device_del rng1
>      (qemu) device_del rng2
>      (qemu) device_add virtio-rng-ccw,id=rng2,devno=fe.0.0002
>      (qemu) device_add virtio-rng-ccw,id=rng1,devno=fe.0.0001
> 3) save the state of the vm into a temporary file and quit QEMU:
>      (qemu) migrate "exec:gzip -c > /tmp/tmp_vmstate.gz"
>      (qemu) q
> 4) use your command line from step 1 with
>      -incoming "exec:gzip -c -d /tmp/tmp_vmstate.gz"
>    appended to reproduce the problem (while trying to to load the saved vm)
> 
> CC: qemu-stable@nongnu.org
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

Hum, missed that one for my pull request, sorry.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Christian, can you please pick for the next set of s390x patches?
