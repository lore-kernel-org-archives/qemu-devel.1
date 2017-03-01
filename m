Received: from eggs.gnu.org ([2001:4830:134:3::10]:52342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cj7tD-0006fU-Dv
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cj7t8-00049F-GK
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:18:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cj7t8-00048h-6X
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:18:06 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v21HDvc9106499
	for <qemu-devel@nongnu.org>; Wed, 1 Mar 2017 12:18:04 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28x140ctnf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 12:18:04 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 1 Mar 2017 17:18:01 -0000
Date: Wed, 1 Mar 2017 18:17:57 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170301190609-mutt-send-email-mst@kernel.org>
References: <20170301165656.80456-1-cornelia.huck@de.ibm.com>
	<20170301190609-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170301181757.274c97da.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] virtio: guard vring access when setting
 notification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, borntraeger@de.ibm.com

On Wed, 1 Mar 2017 19:07:14 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Mar 01, 2017 at 05:56:56PM +0100, Cornelia Huck wrote:
> > Switching to vring caches exposed an existing bug in
> > virtio_queue_set_notification(): We can't access vring structures
> > if they have not been set up yet. This may happen, for example,
> > for virtio-blk devices with multiple queues: The code will try to
> > switch notifiers for every queue, but the guest may have only set up
> > a subset of them.
> > 
> > Fix this by (1) guarding access to the vring memory by checking
> > for vring.desc and (2) triggering an update to the vring flags
> > for consistency with the configured notification state once the
> > queue is actually configured AND the device is in a state that
> > the rings may be actually accessed (i.e. DRIVER_OK has been set
> > or a legacy device kicks for the first time).
> 
> I am still puzzled about 2. drivers pre-zero rings as they
> are set up so notification is on by default. Why do you want to poke
> at it one extra time? You might get an extra notification
> if you tried to disable too early but is this really so bad?

Just checking for !desc and then leaving the queues alone might be the
right thing. See also my reply in the other thread.
