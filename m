Received: from eggs.gnu.org ([2001:4830:134:3::10]:59166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5tOO-00036T-Fq
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5tOK-00013p-Gx
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:28:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d5tOK-00013K-7p
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:28:24 -0400
References: <20170503105224.19049-1-xiaoguangrong@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e186ce8d-52fc-3eca-1343-1a2f18331a76@redhat.com>
Date: Wed, 3 May 2017 14:28:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170503105224.19049-1-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/7] KVM: MMU: fast write protect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com, mtosatti@redhat.com, avi.kivity@gmail.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong@tencent.com>

So if I understand correctly this relies on userspace doing:

	1) KVM_GET_DIRTY_LOG without write protect
	2) KVM_WRITE_PROTECT_ALL_MEM
	<only look now at the dirty log snapshot>

Writes may happen between 1 and 2; they are not represented in the live
dirty bitmap but it's okay because they are in the snapshot and will
only be used after 2.  This is similar to what the dirty page ring
buffer patches do; in fact, the KVM_WRITE_PROTECT_ALL_MEM ioctl is very
similar to KVM_RESET_DIRTY_PAGES in those patches.

On 03/05/2017 12:52, guangrong.xiao@gmail.com wrote:
> Comparing with the ordinary algorithm which
> write protects last level sptes based on the rmap one by one,
> it just simply updates the generation number to ask all vCPUs
> to reload its root page table, particularly, it can be done out
> of mmu-lock, so that it does not hurt vMMU's parallel.

This is clever.

For processors that have PML, write protecting is only done on large
pages and only for splitting purposes; not for dirty page tracking
process at 4k granularity.  In this case, I think that you should do
nothing in the new write-protect-all ioctl?

Also, I wonder how the alternative write protection mechanism would
affect performance of the dirty page ring buffer patches.  You would do
the write protection of all memory at the end of
kvm_vm_ioctl_reset_dirty_pages.  You wouldn't even need a separate
ioctl, which is nice.  On the other hand, checkpoints would be more
frequent and most pages would be write-protected, so it would be more
expensive to rebuild the shadow page tables...

Thanks,

Paolo

> @@ -490,6 +511,7 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemory=
Listener *kml,
>          memset(d.dirty_bitmap, 0, allocated_size);
> =20
>          d.slot =3D mem->slot | (kml->as_id << 16);
> +        d.flags =3D kvm_write_protect_all ? KVM_DIRTY_LOG_WITHOUT_WRIT=
E_PROTECT : 0;
>          if (kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d) =3D=3D -1) {
>              DPRINTF("ioctl failed %d\n", errno);
>              ret =3D -1;

How would this work when kvm_physical_sync_dirty_bitmap is called from
memory_region_sync_dirty_bitmap rather than
memory_region_global_dirty_log_sync?

Thanks,

Paolo
