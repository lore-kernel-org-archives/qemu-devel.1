Received: from eggs.gnu.org ([2001:4830:134:3::10]:47755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1efsPc-0003GK-8V
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 14:14:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1efsPY-0002Ys-Vq
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 14:14:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1efsPY-0002XQ-Pc
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 14:14:40 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180126155940.26994-1-danielhb@linux.vnet.ibm.com> (Daniel
	Henrique Barboza's message of "Fri, 26 Jan 2018 13:59:40 -0200")
References: <20180126155940.26994-1-danielhb@linux.vnet.ibm.com>
Reply-To: quintela@redhat.com
Date: Sun, 28 Jan 2018 20:14:41 +0100
Message-ID: <87shapre1q.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/1] migration/savevm.c: set
 MAX_VM_CMD_PACKAGED_SIZE to 1ul << 32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> wrote:
> MAX_VM_CMD_PACKAGED_SIZE is a constant used in qemu_savevm_send_packaged
> and loadvm_handle_cmd_packaged to determine whether a package is too
> big to be sent or received. qemu_savevm_send_packaged is called inside
> postcopy_start (migration/migration.c) to send the MigrationState
> in a single blob to the destination, using the MIG_CMD_PACKAGED subcommand,
> which will read it up using loadvm_handle_cmd_packaged. If the blob is
> larger than MAX_VM_CMD_PACKAGED_SIZE, an error is thrown and the postcopy
> migration is aborted. Both MAX_VM_CMD_PACKAGED_SIZE and MIG_CMD_PACKAGED
> were introduced by commit 11cf1d984b ("MIG_CMD_PACKAGED: Send a packaged
> chunk ..."). The constant has its original value of 1ul << 24 (16MB).
>
> The current MAX_VM_CMD_PACKAGED_SIZE value is not enough to support postcopy
> migration of bigger pseries guests. The blob size for a postcopy migration of
> a pseries guest with the following setup:
>
> qemu-system-ppc64 --nographic -vga none -machine pseries,accel=kvm -m 64G \
> -smp 1,maxcpus=32 -device virtio-blk-pci,drive=rootdisk \
> -drive file=f27.qcow2,if=none,cache=none,format=qcow2,id=rootdisk \
> -netdev user,id=u1 -net nic,netdev=u1
>
> Goes around 12MB. Bumping the RAM to 128G makes the blob sizes goes to 20MB.
> With 256G the blob goes to 37MB - more than twice the current maximum size.
> At this moment the pseries machine can handle guests with up to 1TB of RAM,
> making this postcopy blob goes to 128MB of size approximately.
>
> Following the discussions made in [1], there is a need to understand what
> devices are aggressively consuming the blob in that manner and see if that
> can be mitigated. Until then, we can set MAX_VM_CMD_PACKAGED_SIZE to the
> maximum value allowed. Since the size is a 32 bit int variable, we can set
> it as 1ul << 32, giving a maximum blob size of 4G that is enough to support
> postcopy migration of 32TB RAM guests given the above constraints.
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg06313.html
>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
