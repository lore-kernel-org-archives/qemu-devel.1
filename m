Received: from eggs.gnu.org ([2001:4830:134:3::10]:42912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cw5OS-0003pE-Hl
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cw5OP-00017O-E5
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:16:00 -0400
Date: Thu, 6 Apr 2017 13:15:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170406111543.GE4341@noname.redhat.com>
References: <1491320156-4629-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491320156-4629-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH for-2.9] block: Ignore guest dev
 permissions during incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, pbonzini@redhat.com, jcody@redhat.com, Ciprian.Barbu@enea.com, Alexandru.Avadanii@enea.com, armband@enea.com, eblake@redhat.com, qemu-devel@nongnu.org

Am 04.04.2017 um 17:35 hat Kevin Wolf geschrieben:
> Usually guest devices don't like other writers to the same image, so
> they use blk_set_perm() to prevent this from happening. In the migration
> phase before the VM is actually running, though, they don't have a
> problem with writes to the image. On the other hand, storage migration
> needs to be able to write to the image in this phase, so the restrictive
> blk_set_perm() call of qdev devices breaks it.
> 
> This patch flags all BlockBackends with a qdev device as
> blk->disable_perm during incoming migration, which means that the
> requested permissions are stored in the BlockBackend, but not actually
> applied to its root node yet.
> 
> Once migration has finished and the VM should be resumed, the
> permissions are applied. If they cannot be applied (e.g. because the NBD
> server used for block migration hasn't been shut down), resuming the VM
> fails.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Ciprian, can you give this patch a try and report back whether it fixes
the storage migration bug you encountered?

Kevin
