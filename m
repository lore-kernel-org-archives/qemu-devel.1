Received: from eggs.gnu.org ([2001:4830:134:3::10]:44067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cjQUW-0000Hv-Th
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 08:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cjQUS-0005kI-WE
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 08:09:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cjQUS-0005j4-Pl
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 08:09:52 -0500
References: <41cc9d11-2e28-5b5e-4772-81a118d79111@redhat.com>
	<20170227101817.11748-1-mmarek@suse.com>
	<41e6edc0-204b-62b7-93b8-b376a40542d6@twiddle.net>
	<bf246870-6e7c-f540-7cd4-3a20d5912162@redhat.com>
	<ea3392d8-cd07-64e0-134a-4f111fe853db@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fea39dac-e9da-c466-a7a2-d55a726272b0@redhat.com>
Date: Thu, 2 Mar 2017 14:09:48 +0100
MIME-Version: 1.0
In-Reply-To: <ea3392d8-cd07-64e0-134a-4f111fe853db@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] target-s390x: Implement stfl and stfle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Michal Marek <mmarek@suse.com>, Alexander Graf <agraf@suse.de>
Cc: Eric Bischoff <ebischoff@suse.com>, Miroslav Benes <mbenes@suse.cz>, qemu-devel@nongnu.org

>>> Of course, in practice we could reduce this to just one cpu_stl_data for
>>> STFL and one or two cpu_stq_data for STFLE.
>>
>> I think STFLE can store more than two 64-bit words, can't it?
> 
> Technically, yes.  But there are less than 128 bits defined.  Certainly much 
> less than the 4k bits that Michal prepares for.
> 

The architectural limit is 2k bytes (yes I said bytes).

Check out "struct kvm_s390_vm_cpu_machine - fac_list" /
KVM_S390_VM_CPU_MACHINE in
arch/s390/include/uapi/asm/kvm.h. Here we prepared for that.

Also note preparations for new stfl bits for future HW:

cd1836f583d7 (KVM: s390: instruction-execution-protection support)
-> bit 130
a679c547d19d (KVM: s390: gaccess: add ESOP2 handling)
-> bit 131

However, for now 128 bit should be more then enough, as TCG still misses
loads of features. CPU model still isn't properly wired up for TCG yet.

-- 
Thanks,

David
