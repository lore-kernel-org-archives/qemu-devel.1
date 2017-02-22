Received: from eggs.gnu.org ([2001:4830:134:3::10]:50012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgUr5-0005Xu-JU
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:13:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgUr1-00033u-JX
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:13:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60703
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cgUr1-00033B-Cy
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:13:03 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1MB657i006152
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 06:13:02 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28s9fpr9a4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 06:13:01 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 22 Feb 2017 11:12:59 -0000
Date: Wed, 22 Feb 2017 12:12:54 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <b7b0cb2d-8987-9fe9-e294-a517981453ef@redhat.com>
References: <20170221185901.3256-1-stefanha@redhat.com>
	<20170221185901.3256-3-stefanha@redhat.com>
	<20170222101653.4df25bc4.cornelia.huck@de.ibm.com>
	<b7b0cb2d-8987-9fe9-e294-a517981453ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170222121254.06358542.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio: add missing region cache init
 in virtio_load()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, 22 Feb 2017 11:19:45 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 22/02/2017 10:16, Cornelia Huck wrote:
> >> +
> >> +            /* All ring addresses have been loaded now... */
> >> +            virtio_init_region_cache(vdev, i);
> > It feels a bit weird that the region cache was already initialized when
> > update rings was called. Should the call to init_region_cache be moved
> > from update_rings() to virtio_queue_set_addr()?
> 
> virtio_queue_set_addr isn't called at all, is it?
> 
> The alternative would be to call virtio_init_region_cache from a
> postload callback of vmstate_virtqueue, but Stefan's patch is fine too IMHO.

What I meant was:

We currently have

set_addr -> update_rings -> init_region_cache

and for virtio-1

set_rings -> init_region_cache

The code with Stefan's fix now sets up a region cache via update_rings
and replaces it later via the call introduced above - which is fine,
but adds an extra iteration.

If we move to

set_addr -> update_rings
            init_region_cache

we get the same call pattern for both legacy and virtio-1 layouts and
save the extra iteration. But we can do that in an additional cleanup
patch, and I think the patch is fine as-is, so

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
