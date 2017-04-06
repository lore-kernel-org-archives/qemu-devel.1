Received: from eggs.gnu.org ([2001:4830:134:3::10]:51504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cwBAu-0000zm-GR
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cwBAt-0000Gx-Kh
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:26:24 -0400
Date: Thu, 6 Apr 2017 19:26:15 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170406172615.ye72dml43z5cme4l@eukaryote>
References: <1491320156-4629-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491320156-4629-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH for-2.9] block: Ignore
 guest dev permissions during incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, armband@enea.com, Ciprian.Barbu@enea.com, qemu-devel@nongnu.org, mreitz@redhat.com, Alexandru.Avadanii@enea.com, pbonzini@redhat.com

On Tue, Apr 04, 2017 at 05:35:56PM +0200, Kevin Wolf wrote:
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
> ---
>  block/block-backend.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  include/block/block.h |  2 ++
>  migration/migration.c |  8 ++++++++
>  qmp.c                 |  6 ++++++
>  4 files changed, 55 insertions(+), 1 deletion(-)

With your fix applied, now I don't see the original error ("error:
internal error: unable to execute QEMU command 'nbd-server-add':
Conflicts with use by drive-virtio-disk0 as 'root', which does not allow
'write' on #block163"), and I can export a disk via `nbd-server-add`
with 'writeable' flag.  

However, with this fix, running `drive-mirror` seg-faults source QEMU.

Reproducer:

(1) On destination QEMU

$ /home/stack/build/build-qemu/x86_64-softmmu/qemu-system-x86_64 \
    -display none -nodefconfig -nodefaults -m 512 \
    -blockdev node-name=bar,driver=qcow2,file.driver=file,file.filename=./dst-disk.qcow2 \
    -serial unix:/tmp/monitor,server,nowait \
    -incoming tcp:localhost:6666 -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 93, "minor": 8, "major": 2}, "package": " (v2.9.0-rc3-3-g3a8624b)"}, "capabilities": []}}
{ "execute": "qmp_capabilities" }
{"return": {}}
{ "execute": "nbd-server-start", "arguments": { "addr": { "type": "inet","data": { "host": "localhost", "port": "3333" } } } }
{"return": {}}
{ "execute": "nbd-server-add", "arguments": { "device": "bar","writable": true } }
{"return": {}}
/home/stack/src/qemu/nbd/server.c:nbd_receive_request():L706: read failed


(2) On source QEMU:

$  /home/stack/build/build-qemu/x86_64-softmmu/qemu-system-x86_64 \
    -display none -nodefconfig -nodefaults -m 512 \
    -device virtio-scsi-pci,id=scsi -device virtio-serial-pci \
    -blockdev node-name=foo,driver=qcow2,file.driver=file,file.filename=./cirros-0.3.5.qcow2
    -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 93, "minor": 8, "major": 2}, "package": " (v2.9.0-rc3-3-g3a8624b)"}, "capabilities": []}}
{ "execute": "qmp_capabilities" }
{"return": {}}
{ "execute": "drive-mirror", "arguments": { "device": "foo", "target": "nbd:localhost:3333:exportname=bar", "sync": "full","format": "raw", "mode": "existing" } }
Segmentation fault (core dumped)


[...]

-- 
/kashyap
