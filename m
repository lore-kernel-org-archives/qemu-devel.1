Received: from eggs.gnu.org ([2001:4830:134:3::10]:58034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1fa6tB-0000f8-5Y
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 18:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1fa6t6-0005NL-5A
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 18:01:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aarcange@redhat.com>) id 1fa6t5-0005ML-Vg
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 18:01:36 -0400
Date: Mon, 2 Jul 2018 18:01:32 -0400
From: Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <20180702220132.GA8790@redhat.com>
References: <20180331084500.33313-1-jiangshanlai@gmail.com>
	<20180702131054.GE2155@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702131054.GE2155@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Xu Wang <gnawux@gmail.com>, qemu-devel@nongnu.org, "James O . D . Hunt" <james.o.hunt@intel.com>, Peng Tao <bergwolf@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

Hello everyone,

On Mon, Jul 02, 2018 at 02:10:54PM +0100, Stefan Hajnoczi wrote:
> Marcelo, Andrea, Paolo: There was a more complex local migration
> approach in 2013 with fd passing and vmsplice.  They specifically
> avoided the approach proposed in this patch, but I don't remember why.
> 
> The closest to an explanation I've found is this message from Marcelo:
> 
>   Another possibility is to use memory that is not anonymous for guest
>   RAM, such as hugetlbfs or tmpfs.
> 
>   IIRC ksm and thp have limitations wrt tmpfs.
> 
> https://www.spinics.net/lists/linux-mm/msg67437.html
> 
> Have the limitations been been solved since then?

tmpfs supports THP upstream nawadays, but it's not the default.

About KSM on non-anonymous memory it's not happening any time soon,
I'm not aware of anybody working on it and it's major change not
easily staying contained within KSM so it would take time. There have
been multiple requests for this feature (but usually for bare metal
containers).

The higher priority items for KSM are in terms of xxhash and/or
accellerated crc32 and perhaps multithreading the scanner to use more
cores. Those are fully self contained issues and they won't make the
rest of the kernel more complex.

Such kind of setup simply brings some of the limitations that
vhost-user/DPDK also has.

Thanks,
Andrea
