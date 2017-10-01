Received: from eggs.gnu.org ([2001:4830:134:3::10]:48066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damian.tometzki@icloud.com>) id 1dye7T-0005Jp-CR
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 09:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damian.tometzki@icloud.com>) id 1dye7P-0004w3-Ui
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 09:17:19 -0400
Received: from st11p00im-asmtp003.me.com ([17.172.80.97]:55951)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <damian.tometzki@icloud.com>)
	id 1dye7P-0004v4-Pf
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 09:17:15 -0400
Received: from process-dkim-sign-daemon.st11p00im-asmtp003.me.com by
	st11p00im-asmtp003.me.com
	(Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built
	Jun 7 2017)) id <0OX500J00ASW2000@st11p00im-asmtp003.me.com> for
	qemu-devel@nongnu.org; Sun, 01 Oct 2017 13:17:01 +0000 (GMT)
Date: Sun, 01 Oct 2017 15:16:51 +0200
From: Damian Tometzki <damian.tometzki@icloud.com>
In-reply-to: <1506744354-20979-1-git-send-email-wei.w.wang@intel.com>
Message-id: <1506863811.1916.1.camel@icloud.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: QUOTED-PRINTABLE
References: <1506744354-20979-1-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v16 0/5] Virtio-balloon Enhancement
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com
List-ID: <qemu-devel.nongnu.org>

Hello,

where i can found the patch in git.kernel.org ?


Am Samstag, den 30.09.2017, 12:05 +0800 schrieb Wei Wang:
> This patch series enhances the existing virtio-balloon with the
> following
> new features:
> 1) fast ballooning: transfer ballooned pages between the guest and
> host in
> chunks using sgs, instead of one array each time; and
> 2) free page block reporting: a new virtqueue to report guest free
> pages
> to the host.
>=20
> The second feature can be used to accelerate live migration of VMs.
> Here
> are some details:
>=20
> Live migration needs to transfer the VM's memory from the source
> machine
> to the destination round by round. For the 1st round, all the VM's
> memory
> is transferred. From the 2nd round, only the pieces of memory that
> were
> written by the guest (after the 1st round) are transferred. One
> method
> that is popularly used by the hypervisor to track which part of
> memory is
> written is to write-protect all the guest memory.
>=20
> The second feature enables the optimization of the 1st round memory
> transfer - the hypervisor can skip the transfer of guest free pages
> in the
> 1st round. It is not concerned that the memory pages are used after
> they
> are given to the hypervisor as a hint of the free pages, because th=
ey
> will
> be tracked by the hypervisor and transferred in the next round if
> they are
> used and written.
>=20
> Change Log:
> v15->v16:
> 1) mm: stop reporting the free pfn range if the callback returns
> false;
> 2) mm: move some implementaion of walk_free_mem_block into a functi=
on
> to
> make the code layout looks better;
> 3) xbitmap: added some optimizations suggested by Matthew, please
> refer to
> the ChangLog in the xbitmap patch for details.
> 4) xbitmap: added a test suite
> 5) virtio-balloon: bail out with a warning when virtqueue_add_inbuf
> returns
> an error
> 6) virtio-balloon: some small code re-arrangement, e.g. detachinf
> used buf
> from the vq before adding a new buf
>=20
> v14->v15:
> 1) mm: make the report callback return a bool value - returning 1 t=
o
> stop
> walking through the free page list.
> 2) virtio-balloon: batching sgs of balloon pages till the vq is ful=
l
> 3) virtio-balloon: create a new workqueue, rather than using the
> default
> system_wq, to queue the free page reporting work item.
> 4) virtio-balloon: add a ctrl_vq to be a central control plane whic=
h
> will
> handle all the future control related commands between the host and
> guest.
> Add free page report as the first feature controlled under ctrl_vq,
> and
> the free_page_vq is a data plane vq dedicated to the transmission o=
f
> free
> page blocks.
>=20
> v13->v14:
> 1) xbitmap: move the code from lib/radix-tree.c to lib/xbitmap.c.
> 2) xbitmap: consolidate the implementation of xb_bit_set/clear/test
> into
> one xb_bit_ops.
> 3) xbitmap: add documents for the exported APIs.
> 4) mm: rewrite the function to walk through free page blocks.
> 5) virtio-balloon: when reporting a free page blcok to the device, =
if
> the
> vq is full (less likey to happen in practice), just skip reporting
> this
> block, instead of busywaiting till an entry gets released.
> 6) virtio-balloon: fail the probe function if adding the signal buf
> in
> init_vqs fails.
>=20
> v12->v13:
> 1) mm: use a callback function to handle the the free page blocks
> from the
> report function. This avoids exposing the zone internal to a kernel
> module.
> 2) virtio-balloon: send balloon pages or a free page block using a
> single
> sg each time. This has the benefits of simpler implementation with =
no
> new
> APIs.
> 3) virtio-balloon: the free_page_vq is used to report free pages on=
ly
> (no
> multiple usages interleaving)
> 4) virtio-balloon: Balloon pages and free page blocks are sent via
> input
> sgs, and the completion signal to the host is sent via an output sg=
.
>=20
> v11->v12:
> 1) xbitmap: use the xbitmap from Matthew Wilcox to record ballooned
> pages.
> 2) virtio-ring: enable the driver to build up a desc chain using
> vring
> desc.
> 3) virtio-ring: Add locking to the existing START_USE() and END_USE=
()
> macro to lock/unlock the vq when a vq operation starts/ends.
> 4) virtio-ring: add virtqueue_kick_sync() and virtqueue_kick_async(=
)
> 5) virtio-balloon: describe chunks of ballooned pages and free page=
s
> blocks directly using one or more chains of desc from the vq.
>=20
> v10->v11:
> 1) virtio_balloon: use vring_desc to describe a chunk;
> 2) virtio_ring: support to add an indirect desc table to virtqueue;
> 3)=C2=A0=C2=A0virtio_balloon: use cmdq to report guest memory stati=
stics.
>=20
> v9->v10:
> 1) mm: put report_unused_page_block() under CONFIG_VIRTIO_BALLOON;
> 2) virtio-balloon: add virtballoon_validate();
> 3) virtio-balloon: msg format change;
> 4) virtio-balloon: move miscq handling to a task on
> system_freezable_wq;
> 5) virtio-balloon: code cleanup.
>=20
> v8->v9:
> 1) Split the two new features, VIRTIO_BALLOON_F_BALLOON_CHUNKS and
> VIRTIO_BALLOON_F_MISC_VQ, which were mixed together in the previous
> implementation;
> 2) Simpler function to get the free page block.
>=20
> v7->v8:
> 1) Use only one chunk format, instead of two.
> 2) re-write the virtio-balloon implementation patch.
> 3) commit changes
> 4) patch re-org
>=20
> Matthew Wilcox (2):
> =C2=A0 lib/xbitmap: Introduce xbitmap
> =C2=A0 radix tree test suite: add tests for xbitmap
>=20
> Wei Wang (3):
> =C2=A0 virtio-balloon: VIRTIO_BALLOON_F_SG
> =C2=A0 mm: support reporting free page blocks
> =C2=A0 virtio-balloon: VIRTIO_BALLOON_F_CTRL_VQ
>=20
> =C2=A0drivers/virtio/virtio_balloon.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0| 437
> +++++++++++++++++++++++++++++---
> =C2=A0include/linux/mm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A06 +
> =C2=A0include/linux/radix-tree.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=
=A02 +
> =C2=A0include/linux/xbitmap.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=
=C2=A0=C2=A066 +++++
> =C2=A0include/uapi/linux/virtio_balloon.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A016 ++
> =C2=A0lib/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A0=C2=A02 +-
> =C2=A0lib/radix-tree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A042 ++-
> =C2=A0lib/xbitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 264 ++++++++++++=
+++++++
> =C2=A0mm/page_alloc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A091 +++++++
> =C2=A0tools/include/linux/bitmap.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A034 +++
> =C2=A0tools/include/linux/kernel.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A02 +
> =C2=A0tools/testing/radix-tree/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A07 +-
> =C2=A0tools/testing/radix-tree/linux/kernel.h |=C2=A0=C2=A0=C2=A02 =
-
> =C2=A0tools/testing/radix-tree/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A05 +
> =C2=A0tools/testing/radix-tree/test.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A01 +
> =C2=A0tools/testing/radix-tree/xbitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0| 269 ++++++++++++++++++++
> =C2=A016 files changed, 1203 insertions(+), 43 deletions(-)
> =C2=A0create mode 100644 include/linux/xbitmap.h
> =C2=A0create mode 100644 lib/xbitmap.c
> =C2=A0create mode 100644 tools/testing/radix-tree/xbitmap.c
>=20
