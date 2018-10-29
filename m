Received: from eggs.gnu.org ([2001:4830:134:3::10]:57911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gH2Kt-0008C9-AB
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 03:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gH2Ki-0006gO-Il
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 03:51:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52506
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gH2Kh-0006fg-UE
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 03:51:32 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9T7mkhl114089
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 03:51:30 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ndwfrhx7e-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 03:51:30 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 29 Oct 2018 07:51:28 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 29 Oct 2018 08:51:22 +0100
Content-Language: en-US
Message-Id: <38871007-6bbc-f249-2697-daa88d6fc2a1@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] KVM Forum 2018 BoF Meeting minutes - architecture
 common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Janosch Frank <frankja@linux.ibm.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Frediano Ziglio <fziglio@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, kvm list <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, mpe@ellerman.id.au, Paul Mackerras <paulus@ozlabs.org>, James Hogan <jhogan@kernel.org>

Participants:
Christopher Dall, Marc Zyngier, Paolo Bonzini, Suraj Jitindar Singh, Fredia=
no
Ziglio, Sean Christopherson, Radim Krcmar, Janosch Frank, Christian Borntra=
eger
+some more


- Discussion about common code for different architectures - initiated by my
  talk https://schd.ws/hosted_files/kvmforum2018/a0/Christian-Borntraegercr=
ossarch.pdf
- We agreed that we as architecture maintainers should teach people during
  review about making things generic when applicable
- Problem: we do not understand "the other side" at all, e.g. one example in
  x86 code was: does spte means shadow page table or also nested pages (EPT)
- maybe we need a hack-a-thon to sit together and talk about this
- other idea: To see if we can factor out things, just provide a header file
  with "needed" interfaces and the pass that along to the other side

Things to look at:
- dirty log, now 2 common code variante (and arch specific ones)
- ordering of ioctl (e.g. qemu vs native kvm tool) triggered sometimes bugs=
 on
  ARM - can we test this better and maybe also refactor some of the common
  checks
- api tests should be extended to all architectures
- rmap code for nested virtualization -> x86, power and now arm. All private
  copies (s390 uses radix to make it a 4th variant)
- can we avoid compiling virt/kvm/ from arch folders?
- Christopher also wants to look at nested page table faults (stage 2 fault=
s on
  Arm), where on the Arm side we have a lot of code which is not arch-speci=
fic,
  but related to finding a page to back the fault, figuring out if the page=
 is
  hugetlbfs, thp, page size, permission of page, and so on. This could expa=
nd to
  functionality for shadow page tables which we'll use for nested virt on A=
rm as
  well.  Things such as managing caches of shadow page tables for certain g=
uest
  contexts, handling emulated TLB invalidations, etc. should have some
  commonality at least between x86 and Arm.


we agreed to have a meeting of arch maintainers either before or after next
KVM forum or independently. This will be discussed separately.  Christian
Borntraeger will kick of that discussion.
