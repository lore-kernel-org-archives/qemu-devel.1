Received: from eggs.gnu.org ([2001:4830:134:3::10]:51562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eAV2H-0004sL-Nh
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 02:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eAV2G-0006Gn-Up
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 02:00:57 -0400
Date: Fri, 3 Nov 2017 14:00:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171103060046.GB18539@lemon>
References: <20171102120223.GI32533@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171102120223.GI32533@redhat.com>
Subject: Re: [Qemu-devel] RFC: use case for adding QMP,
 block jobs & multiple exports to qemu-nbd ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, pbonzini@redhat.com, stefanha@redhat.com

On Thu, 11/02 12:02, Daniel P. Berrange wrote:
> One alternative approach to doing this would be to suggest that we should
> instead just spawn qemu-system-x86_64 with '--machine none' and use that
> as a replacement for qemu-nbd, since it already has a built-in NBD server
> which can do many exports at once and arbitrary block jobs.

Here is a crazy idea from KVM Forum discussions that may relate, so mention it
here: we could move the QEMU block layer to a separate program and guest can use
vhost-user-{blk,scsi} for I/O. It is something like this:


   master-disk1.qcow2  (qemu-nbd)
          ^
          |  backing
          |
   cache-disk1.qcow2   (qemu-vhost)     <-------------.
          ^                                           |
          |  backing                                  |  backing
          |                                           |
          +-  vm-a-disk1.qcow2   (qemu-vhost)         +-  vm-a-disk2.qcow2   (qemu-vhost)
                    ^                                             ^
                    |  vhost-user-blk                             |  vhost-user-blk
                    |                                             |
                    +- VM-1 (qemu-system-XXX)                     +- VM-2 (qemu-system-XXX)


So on the compute node, there will be N qemu-system-XXX processes (where N is
the number of VMs) and 1 qemu-vhost process.

The hypothetical qemu-vhost program needs to support QMP as well and it runs the
COR/mirroring jobs from master disk to cache disk, just like what you propose to
do with the extended qemu-nbd. The only difference is replacing the local NBD
with vhost-user, which is more efficient.

Fam
