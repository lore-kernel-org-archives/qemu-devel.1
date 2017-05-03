Received: from eggs.gnu.org ([2001:4830:134:3::10]:46747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5vic-0007Rp-Ro
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5viY-0007Fn-0s
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:57:30 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1d5viX-0007FO-PS
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:57:25 -0400
Received: by mail-wr0-x243.google.com with SMTP id v42so23295021wrc.3
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 07:57:25 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170503105224.19049-1-xiaoguangrong@tencent.com>
	<e186ce8d-52fc-3eca-1343-1a2f18331a76@redhat.com>
	<ff732c49-de24-eebd-ae8e-2de00281f211@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <878cbc47-316c-d508-a5a3-22029dee2203@redhat.com>
Date: Wed, 3 May 2017 16:57:19 +0200
MIME-Version: 1.0
In-Reply-To: <ff732c49-de24-eebd-ae8e-2de00281f211@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] KVM: MMU: fast write protect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>, mtosatti@redhat.com, avi.kivity@gmail.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong@tencent.com>



On 03/05/2017 16:50, Xiao Guangrong wrote:
> Furthermore, userspace has no knowledge about if PML is enable (it
> can be required from sysfs, but it is a good way in QEMU), so it is
> difficult for the usespace to know when to use write-protect-all.
> Maybe we can make KVM_CAP_X86_WRITE_PROTECT_ALL_MEM return false if
> PML is enabled?

Yes, that's a good idea.  Though it's a pity that, with PML, setting the
dirty bit will still do the massive walk of the rmap.  At least with
reset_dirty_pages it's done a little bit at a time.

>> Also, I wonder how the alternative write protection mechanism would
>> affect performance of the dirty page ring buffer patches.  You would do
>> the write protection of all memory at the end of
>> kvm_vm_ioctl_reset_dirty_pages.  You wouldn't even need a separate
>> ioctl, which is nice.  On the other hand, checkpoints would be more
>> frequent and most pages would be write-protected, so it would be more
>> expensive to rebuild the shadow page tables...
> 
> Yup, write-protect-all can improve reset_dirty_pages indeed, i will
> apply your idea after reset_dirty_pages is merged.
> 
> However, we still prefer to have a separate ioctl for write-protect-all
> which cooperates with KVM_GET_DIRTY_LOG to improve live migration that
> should not always depend on checkpoint. 

Ok, I plan to merge the dirty ring pages early in 4.13 development.

Paolo
