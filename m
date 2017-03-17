Received: from eggs.gnu.org ([2001:4830:134:3::10]:41821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1coqzk-0001DP-VB
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 08:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1coqzh-0000Xz-SK
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 08:28:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45771
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1coqzh-0000Xo-MC
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 08:28:33 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2HCOPnp099462
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 08:28:32 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 298dge6jhj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 08:28:32 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 17 Mar 2017 12:28:30 -0000
Date: Fri, 17 Mar 2017 13:28:26 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170317121816.rsvch6lewyr54lwy@kamzik.brq.redhat.com>
References: <20170317113353.26297-1-famz@redhat.com>
	<20170317121816.rsvch6lewyr54lwy@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170317132826.4ec82a0a.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] virtio: Fix error handling in
 virtio_bus_device_plugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, 17 Mar 2017 13:18:16 +0100
Andrew Jones <drjones@redhat.com> wrote:

> On Fri, Mar 17, 2017 at 07:33:53PM +0800, Fam Zheng wrote:
> > For one thing we shouldn't continue if an error happened, for the other
> > two steps failing can cause an abort() in error_setg because we reuse
> > the same errp blindly.
> > 
> > Add error handling checks to fix both issues.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  hw/virtio/virtio-bus.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)

> >  
> >      if (klass->device_plugged != NULL) {
> >          klass->device_plugged(qbus->parent, errp);
> 
> Did you intend to change this errp to &local_err, as well? If not,
> then the body of the below hunk is unreachable, as local_err can
> never be non-null there.

Oh, I managed to overlook this.

So my r-b applies if this is changed to use local_err :)

> 
> Thanks,
> drew
> 
> >      }
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> >  
> >      if (klass->get_dma_as != NULL && has_iommu) {
> >          virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> > -- 
> > 2.9.3
> > 
> > 
> 
> 
