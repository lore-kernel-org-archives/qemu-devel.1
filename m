Received: from eggs.gnu.org ([2001:4830:134:3::10]:38112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dXeN2-00087I-6D
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 22:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dXeMw-0003yV-Sd
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 22:05:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dXeMw-0003y5-3j
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 22:05:42 -0400
Date: Wed, 19 Jul 2017 05:05:37 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170719004721-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] host side todo list for virtio rdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: qemu-devel@nongnu.org, linux-rdma@vger.kernel.org, Marcel Apfelbaum <marcel.a@redhat.com>

Here are some thoughts on bits that are still missing to get a working
virtio-rdma, with some suggestions. These are very preliminary but I
feel I kept these in my head (and discussed offline) for too long. All
of the below is just my personal humble opinion.

Feature Requirements:

The basic requirement is to be able to do RDMA to/from
VM memory, with support for VM migration and/or memory
overcommit and/or autonuma and/or THP.
Why are migration/overcommit/autonuma required?
Without these, you can do RDMA with device passthrough,
with likely better performance.

Feature Non-requirements:

It's not a requirement to support RDMA without VM exits,
e.g. like with device passthrough. While avoiding exits improves
performance, it would be handy to more than RDMA,
so there seems no reason to require it from RDMA when we
do not have it for e.g. network.

Assumptions:

It's OK to assume specific hardware capabilities at least initially.

High level architecture:

Follows the same lines as most other virtio devices:

+-----------------------------------
+ 
+ guest kernel
+             ^
+-------------|----------------------
+             v
+ host kernel (kvm, vhost)
+ 
+             ^
+-------------|----------------------
+             v
+ 
+ host userspace (QEMU, vhost-user)
+ 
+-----------------------------------

Each request is forwarded by host kernel to QEMU,
that executes it using the ibverbs library.

Most of this should be implementable host-side using existing
software. However, several issues remain and would need
infrastructure changes, as outlined below.

Host-side todo list for virtio-rdma support:

- Memory registration for guest userspace.

  Register memory region verb accepts a single virtual address,
  which supplies both the on-wire key for access and the
  range of memory to access. Guest kernel turns this into a
  list of pages (e.g. by get_user_pages); when forwarded to host this
  turns into a s/g list of virtual addresses in QEMU address space.

  Suggestion: add a new verb, along the lines of ibv_register_physical,
  which splits these two parameters, accepting the on-wire VA key
  and separately a list of userspace virtual address/size pairs.

- Memory registration for guest kernels.

  Another ability used by some in-kernel users is registering all of memory.
  Ranges not actually present are never accessed - this is OK as
  kernel users are trusted. Memory hotplug changes which ranges
  are present.

  Suggestion: add some throw-away memory and map all
  non-present ranges there. Add ibv_reregister_physical_mr or similar
  API to update mappings on guest memory hotplug/unplug.

- Memory overcommit/autonuma/THP.

  This includes techniques such as swap,KSM,COW, page migration.
  All these rely on ability to move pages around without
  breaking hardware access.

  Suggestion: for hardware that supports it,
  enabling on-demand paging for all registered memory seems
  to address the issue more or less transparently to guests.
  This isn't supported by all hardware but might be
  at least a reasonable first step.

- Migration: memory tracking.

  Migration requires detecting hardware access to pages
  either on write (pre-copy) or any access (post-copy).
  Post copy just requires ODP support to work with
  userfaultfd properly.
  Pre-copy would require a write-tracking API along
  the lines of one exposed by KVM or vhost.
  Each tracked page would be write-protected (causing faults on
  hardware access) on hardware write fault is generated
  and recorded, page is made writeable.

- Migration: moving QP numbers.

  QP numbers are exposed on the wire and so must move together
  with the VM.

  Suggestion: allow specifying QP number when creating a QP.
  To avoid conflicts between multiple users, initial version can limit
  library to a single user per device. Multiple VMs can simply
  attach to distinct VFs.

- Migration: moving QP state.

  When migrating the VM, a QP has to be torn down
  on source and created on destination.
  We have to migrate e.g. the current PSN - but what
  should happen when a new packet arrives on source
  after QP has been torn down?

  Suggestion 1: move QP to a special state "suspended" and ignore
  packets, or cause source to retransmit with e.g. an out of
  resources error. Retransmit counter might need to be
  adjusted compared to what guest requested to account
  for the extra need to retransmit.
  Is there a good existing QP state that does this?

  Suggestion 2: forward packets to destination somehow.
  Might overload the fabric as we are crossing e.g.
  pci bus multiple times.

- Migration: network update

  ROCE v1 and infiniband seem to tie connections to
  hardware specific GIDs which can not be moved by software.

  Suggestion: limit migration to RoCE v2 initially.

- Migration: packet loss recovery.

  As a RoCE address moves across the network, network has
  to be updated which takes time, meanwhile packet loss seems
  to be hard to avoid.

  Suggestion: limit initial support to hardware that is
  able to recover from occasional packet drops, with
  some slowdown.

- Migration: suspend/resume API?
  It might be easier to pack up state of all resources
  such as all QP numbers and state of all QPs etc
  in a single memory buffer, migrate then unpack on destination.

  Removes need for 2 separate APIs for suspended state and
  for specifying QPN on creation.

  This creates a format for serialization that will have to
  be maintained in a compatible way - it is not clear that
  the maintainance overhead is worth the potential
  simplification, if any.


That's it - I hope this helps, feel free to discuss, preferably copying
virtio-dev (subscription required for now, people are looking into
fixing this, sorry about that).

Thanks!

-- 
MST
