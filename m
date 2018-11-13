Received: from eggs.gnu.org ([2001:4830:134:3::10]:36864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gMddn-0004wU-7c
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gMdPA-0002pG-QJ
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:27:17 -0500
References: <1541121763-3277-1-git-send-email-liq3ea@gmail.com>
	<20181102154019.GB26292@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <104e542e-4678-13bf-4378-e378dede71ba@redhat.com>
Date: Tue, 13 Nov 2018 19:26:58 +0100
MIME-Version: 1.0
In-Reply-To: <20181102154019.GB26292@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nvme: fix oob access issue(CVE-2018-16847)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keith Busch <keith.busch@intel.com>, Li Qiang <liq3ea@gmail.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, ppandit@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

On 02/11/2018 16:40, Keith Busch wrote:
> Hey, so why is this memory region access even considered valid if the
> request is out of range from what NVMe had registered for its
> MemoryRegion? Wouldn't it be better to not call the mr->ops->read/write
> if it's out of bounds? Otherwise every MemoryRegion needs to duplicate
> the same check, right?

Because some crazy devices have misaligned registers.

But actually this is not a problem because NVMe doesn't set
ops->impl.unaligned to true, so indeed no change is needed.

Paolo

> Would something like the following work (minimally tested)?
