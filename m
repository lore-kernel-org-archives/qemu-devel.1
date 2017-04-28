Received: from eggs.gnu.org ([2001:4830:134:3::10]:54214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d45nm-0001rV-MN
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d45ni-0001OJ-NB
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:19:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40086
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1d45ni-0001Ng-Gf
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:19:10 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3SDDaSo095445
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 09:19:09 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a3jv3v4c4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 09:19:09 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 28 Apr 2017 09:19:08 -0400
References: <20170426183721.7482-1-dgilbert@redhat.com>
	<20170426183721.7482-2-dgilbert@redhat.com>
	<8a107a40-073c-8181-75aa-e5700f2900a7@de.ibm.com>
	<20170426190442.GG2394@work-vm> <20170426193743.GF3508@redhat.com>
	<20170427032037.GE26792@pxdev.xzpeter.org>
	<750be300-6f14-cbef-4b38-f28751e28032@de.ibm.com>
	<20170427134707.GG3508@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 28 Apr 2017 15:19:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170427134707.GG3508@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <cc11d33c-8113-3895-7427-4318af1f3c82@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] Postcopy: Force allocation of all-zero
 precopy pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com, Martin Schwidefsky <schwidefsky@de.ibm.com>

On 04/27/2017 03:47 PM, Andrea Arcangeli wrote:
> On Thu, Apr 27, 2017 at 08:44:03AM +0200, Christian Borntraeger wrote:
>> I have started instrumenting the kernel. I can see a set_pte_at for this address
>> and I see an (to be understood) invalidation shortly after that which explains
>> why I get a fault.
> 
> Sounds great that you can see an invalidation shortly after, that is
> the real source of the problem. Can you get a stack trace of such
> invalidation?
> 
> Thanks!
> Andrea
> 

Finally got it. I had a test module in that guest, which triggered a storage key 
operation. Normally we no longer use the storage keys in Linux. Therefore KVM
disables storage key support and intercepts all storage key instructions to enable
the support for that lazily.This makes paging easier and faster to not worry about those.
When we enable storage keys, we must not use shared pages as the storage key
is a property of the physical page frame (and not of the virtual page).
Therefore, this enablement makes mm_forbids_zeropage return true and removes
all existing zero pages.
(see commit 2faee8ff9dc6f4bfe46f6d2d110add858140fb20
    s390/mm: prevent and break zero page mappings in case of storage keys)
In this case it was called while migrating the storage keys (via kvm ioctl)
resulting in zero page mappings going away. (see qemu hw/s390x/s390-skeys.c)


Apr 28 14:48:43 s38lp08 kernel: ([<000000000011218a>] show_trace+0x62/0x78)
Apr 28 14:48:43 s38lp08 kernel:  [<0000000000112278>] show_stack+0x68/0xe0 
Apr 28 14:48:43 s38lp08 kernel:  [<000000000066f82e>] dump_stack+0x7e/0xb0 
Apr 28 14:48:43 s38lp08 kernel:  [<0000000000123b2c>] ptep_xchg_direct+0x254/0x288 
Apr 28 14:48:43 s38lp08 kernel:  [<0000000000127cfe>] __s390_enable_skey+0x76/0xa0 
Apr 28 14:48:43 s38lp08 kernel:  [<00000000002e5278>] __walk_page_range+0x270/0x500 
Apr 28 14:48:43 s38lp08 kernel:  [<00000000002e5592>] walk_page_range+0x8a/0x148 
Apr 28 14:48:43 s38lp08 kernel:  [<0000000000127bc6>] s390_enable_skey+0x116/0x140 
Apr 28 14:48:43 s38lp08 kernel:  [<000000000013fd92>] kvm_arch_vm_ioctl+0x11ea/0x1c70 
Apr 28 14:48:43 s38lp08 kernel:  [<0000000000131aa2>] kvm_vm_ioctl+0xca/0x710 
Apr 28 14:48:43 s38lp08 kernel:  [<00000000003460e8>] do_vfs_ioctl+0xa8/0x608 
Apr 28 14:48:43 s38lp08 kernel:  [<00000000003466ec>] SyS_ioctl+0xa4/0xb8 
Apr 28 14:48:43 s38lp08 kernel:  [<0000000000923460>] system_call+0xc4/0x23c

As a result a userfault on this virtual address will indeed go back to QEMU
and asks again for that page. And then QEMU "oh I have that page already transferred"
(even if it was detected as zero page and just faulted in by reading from it)
So I will not write it again.

Several options:
- let postcopy not discard a page, even it if must already be there (patch from David)
- change s390-skeys to register_savevm_live and do the skey enablement
very early (but this will be impossible for incoming data from old versions)
- let kernel s390_enable_skey actually fault in (might show big memory consumption)
- let qemu hw/s390x/s390-skeys.c tell the migration code that pages might need
  retransmissions
....
