Received: from eggs.gnu.org ([2001:4830:134:3::10]:41274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cfoIT-0008KO-7g
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cfoIQ-0006KB-3j
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:46:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cfoIP-0006Jk-Tq
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:46:30 -0500
References: <0f8f3bd3-04d2-7213-2afb-ea75507eced6@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <04c71d8f-a923-0d66-1c4e-9a24eaf1971c@redhat.com>
Date: Mon, 20 Feb 2017 14:46:25 +0100
MIME-Version: 1.0
In-Reply-To: <0f8f3bd3-04d2-7213-2afb-ea75507eced6@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Error handling for KVM_GET_DIRTY_LOG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 16/02/2017 15:51, Janosch Frank wrote:
> While trying to fix a bug in the s390 migration code, I noticed that
> QEMU ignores practically all errors returned from that VM ioctl. QEMU
> behaves as specified in the KVM api and only processes -1 (-EPERM) as an
> error.
> 
> Unfortunately the documentation is wrong/old and KVM may return -EFAULT,
> -EINVAL, -ENOTSUPP (BookE) and -ENOENT. This bugs me, as I found a case
> where I want to return -EFAULT because of guest memory problems and QEMU
> will still happily migrate the VM.

Guest memory problems should not return EFAULT, which corresponds to a
wrong address passed to KVM_GET_DIRTY_LOG.  In fact, EFAULT is probably
the only case where an assertion is warranted---just like you passed a
wrong pointer to KVM_GET_DIRTY_LOG, who knows who else is going to get
that pointer.

ENOENT and EINVAL should not kill the source guest, though they should
terminate migration.  But then I would like to know more about this
case, because they should never happen unless KVMMemoryListener is buggy.

Paolo

> I currently don't see a reason why we continue to migrate on EFAULT and
> EINVAL. But returning -error from kvm_physical_sync_dirty_bitmap might
> also a bit hard, as it kills QEMU.
> 
> Do we want to fix this and if, how do we want it done?
> If not we at least have a definitive mail to point to when the next one
> comes around. I also have a KVM patch to update the api documentation if
> wanted (maybe we should dust that off a bit anyhow).
> 
> 
> This has been brought up in 2009 [1] the first time and was more or less
> fixed and then reverted in 2014 [2].
> 
> The reason in [1] was that PPC hadn't settled yet on a valid return code.
> 
> In [2] it was too close to the v2 to handle it properly.
> 
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2009-07/msg01772.html
> 
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2014-04/msg01993.html
> 
> 
> Cheers,
> Janosch
> 
