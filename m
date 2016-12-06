Received: from eggs.gnu.org ([2001:4830:134:3::10]:46448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cEK4e-0004yT-4b
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:02:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cEK4a-0004iW-Uv
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:02:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39470
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cEK4a-0004iJ-P5
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:02:36 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB6HwYXS112281
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 13:02:35 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 275xs6p9nu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 13:02:35 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 6 Dec 2016 18:02:34 -0000
Date: Tue, 6 Dec 2016 19:02:30 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <148104617887.7699.984921868108236415.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <148104617887.7699.984921868108236415.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161206190230.2c9b46b8.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: fix HW_COMPAT_2_6 macro for
 virtio-*-pci drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 06 Dec 2016 18:50:47 +0100
Greg Kurz <groug@kaod.org> wrote:

> Since commit "9a4c0e220d8a hw/virtio-pci: fix virtio behaviour", passing
> -device virtio-blk-pci.disable-modern=off has no effect on 2.6 machine
> types because the internal virtio-pci.disable-modern=on compat property
> always prevail.

s/prevail/prevails/

> 
> This should ideally be fixed in the qdev properties core code, but it is
> too late in the QEMU 2.8 schedule. So this patch fixes the issue by setting
> the compat properties for every virtio-*-pci subtypes instead of the base

s/subtypes/subtype/

> virtio-pci type.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> 
> This fix is for both QEMU 2.8 and 2.7.1.
> 
> Generated with:
> 
> for i in $(git grep 'define TYPE_VIRTIO_.*_PCI' hw/virtio/virtio-pci.h | \
>            awk '{print $3 }'); do 
>     printf '{\\'"\n        .driver   = %s,"'\\'"\n        .property = \"disable-modern\","'\\'"\n        .value    = \"on\","'\\'"\n    },{"'\\'"\n        .driver   = %s,"'\\'"\n        .property = \"disable-legacy\","'\\'"\n        .value    = \"off\","'\\'"\n    }," $i $i
> done

Don't we want vhost-scsi-pci as well?

> 
>  include/hw/compat.h |  116 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 114 insertions(+), 2 deletions(-)
