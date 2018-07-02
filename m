Received: from eggs.gnu.org ([2001:4830:134:3::10]:36418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1fa76Q-0003z2-6I
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 18:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1fa76M-0006xM-6u
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 18:15:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36154 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aarcange@redhat.com>) id 1fa76M-0006x2-1O
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 18:15:18 -0400
Date: Mon, 2 Jul 2018 18:15:16 -0400
From: Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <20180702221516.GB8790@redhat.com>
References: <20180331084500.33313-1-jiangshanlai@gmail.com>
	<20180702131054.GE2155@stefanha-x1.localdomain>
	<CA+a=Yy72YN1DAczTnb47b4ZW_vummOVuK3M=F2CF5KF3mRD2Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+a=Yy72YN1DAczTnb47b4ZW_vummOVuK3M=F2CF5KF3mRD2Zw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] migration: add capability to bypass the
 shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Tao <bergwolf@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Xu Wang <gnawux@gmail.com>, "James O . D . Hunt" <james.o.hunt@intel.com>, Juan Quintela <quintela@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

Hello,

On Mon, Jul 02, 2018 at 09:52:08PM +0800, Peng Tao wrote:
> I think we can write some host generated random seeds to guest's
> urandom device, when cloning VMs from the same template before handing
> it to users. Is it enough or do you think there are more to do w/
> re-randomizing?

That may be enough, but it's critically important to get
right. Reusing the same /dev/urandom number just twice on two
different operations, can lead to leak of the entire private key even
if the reused random number itself is not predictable.

You may want to look into the upstream random number generator that
can be configured at build time to printk() a warning if it's being
used at boot before it had its "shutdown" state restored. It would
sound safer if you could re-trigger such warning post vmrestore of a
cloned image if userland uses random number before the random number
has been re-seeded post vmrestore. With a full loaded userland running
immediately post vmrestore, an userland race condition would otherwise
risk to go unnoticed.

Thanks,
Andrea
