Received: from eggs.gnu.org ([2001:4830:134:3::10]:48293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cHRNd-0002My-KH
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 03:27:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cHRNY-0008LH-M2
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 03:27:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50472
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cHRNY-0008L1-GH
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 03:27:04 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF8Nuj9040040
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 03:27:03 -0500
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bnute700-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 03:27:03 -0500
Received: from localhost
	by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 15 Dec 2016 08:27:01 -0000
Date: Thu, 15 Dec 2016 09:26:56 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20161215073808.GB26169@stefanha-x1.localdomain>
References: <20161214163035.3297-1-maxime.coquelin@redhat.com>
	<20161215073808.GB26169@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161215092656.2e1244c0.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] virtio-pci: Fix cross-version migration
 with older machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, mdroth@linux.vnet.ibm.com, stefanha@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, marcel@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, 15 Dec 2016 07:38:09 +0000
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Wed, Dec 14, 2016 at 05:30:35PM +0100, Maxime Coquelin wrote:
> > This patch fixes a cross-version migration regression introduced
> > by commit d1b4259f ("virtio-bus: Plug devices after features are
> > negotiated").
> > 
> > The problem is encountered when host's vhost backend does not support
> > VIRTIO_F_VERSION_1, and migration is initiated from a v2.7 or prior
> > machine with virtio-pci modern capabilities enabled to a v2.8 machine.
> > 
> > In this case, modern capabilities get exposed to the guest by the source,
> > whereas the target will detect version 1 is not supported so will only
> > expose legacy capabilities.
> > 
> > The problem is fixed by introducing a new "x-ignore-backend-features"
> > property, which is set in v2.7 and prior compatibility modes. Doing this,
> > v2.7 machine keeps its broken behaviour (enabling modern while version
> > is not supported), and newer machines will behave correctly.
> > 
> > Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > ---
> > 
> > V3 fixes commit message with the new property name.
> > V2 changes the naming as proposed by Michael T.and Cornelia, and
> > fixes commit message.
> > 
> >  hw/virtio/virtio-pci.c | 5 ++++-
> >  hw/virtio/virtio-pci.h | 1 +
> >  include/hw/compat.h    | 4 ++++
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> Thanks, applied to my staging tree:
> https://github.com/stefanha/qemu/commits/staging
> 
> Stefan

Hm, missing my R-b I gave for v2... feel free to add

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>

if you still want to change it.
