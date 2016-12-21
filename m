Received: from eggs.gnu.org ([2001:4830:134:3::10]:57939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cJkHq-0000d5-GO
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 12:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cJkHn-0005oA-EQ
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 12:02:42 -0500
References: <20161220163139.12016-1-famz@redhat.com>
	<20161220163139.12016-4-famz@redhat.com>
	<405aa216-ab28-51e3-c81c-78a841605c01@redhat.com>
	<20161221161934.GA18068@lemon>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5fe9b125-3acf-b63c-36e3-8a19f041c56d@redhat.com>
Date: Wed, 21 Dec 2016 18:02:24 +0100
MIME-Version: 1.0
In-Reply-To: <20161221161934.GA18068@lemon>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] util: Add VFIO helper library
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Karl Rister <krister@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, borntraeger@de.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>



On 21/12/2016 17:19, Fam Zheng wrote:
> It's clever! It'd be a bit more complicated than that, though. Things l=
ike
> queues etc in block/nvme.c have to be preserved, and if we already ensu=
re that,
> ram blocks can be preserved similarly, but indeed bounce buffers can be=
 handled
> that way. I still need to think about how to make sure none of the inva=
lidated
> IOVA addresses are in use by other requests.

Hmm, that's true.  As you said, we'll probably want to split the IOVA
space in two, with a relatively small part for "volatile" addresses.

You can add two counters that track how many requests are using volatile
space.  When it's time to do the VFIO_IOMMU_UNMAP_DMA, you do something
like:

    if (vfio->next_phase =3D=3D vfio->current_phase) {
        vfio->next_phase =3D !vfio->current_phase;
        while (vfio->request_counter[vfio->current_phase] !=3D 0) {
            wait on CoQueue
        }
        ioctl(VFIO_IOMMU_UNMAP_DMA)
        vfio->current_phase =3D vfio->next_phase;
        wake up everyone on CoQueue
    } else {
        /* wait for the unmap to happen */
        while (vfio->next_phase !=3D vfio->current_phase) {
            wait on CoQueue
        }
    }

As an optimization, incrementing/decrementing request_counter can be
delayed until you find an item of the QEMUIOVector that needs a volatile
IOVA.  Then it should never be incremented in practice during guest
execution.

Paolo

> Also I wonder how expensive the huge VFIO_IOMMU_UNMAP_DMA is. In the wo=
rst case
> the "throwaway" IOVAs can be limited to a small range.
