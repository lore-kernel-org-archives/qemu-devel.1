Received: from eggs.gnu.org ([2001:4830:134:3::10]:33386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1cHucy-0007Wa-NU
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1cHucv-0000rV-K9
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:40:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51023)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aarcange@redhat.com>) id 1cHucv-0000qo-ES
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:40:53 -0500
Date: Fri, 16 Dec 2016 16:40:49 +0100
From: Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <20161216154049.GB6168@redhat.com>
References: <d3ff453c-56fa-19de-317c-1c82456f2831@intel.com>
	<20161207183817.GE28786@redhat.com>
	<b58fd9f6-d9dd-dd56-d476-dd342174dac5@intel.com>
	<20161207202824.GH28786@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A14E2AD@SHSMSX104.ccr.corp.intel.com>
	<060287c7-d1af-45d5-70ea-ad35d4bbeb84@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C31D0E6@SHSMSX104.ccr.corp.intel.com>
	<01886693-c73e-3696-860b-086417d695e1@intel.com>
	<20161215173901-mutt-send-email-mst@kernel.org>
	<F2CBF3009FA73547804AE4C663CAB28E3C32A899@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E3C32A899@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH kernel v5 0/5] Extend virtio-balloon for
 fast (de)inflating & fast live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Li, Liang Z" <liang.z.li@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mhocko@suse.com" <mhocko@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>

On Fri, Dec 16, 2016 at 01:12:21AM +0000, Li, Liang Z wrote:
> There still exist the case if the MAX_ORDER is configured to a large value, e.g. 36 for a system
> with huge amount of memory, then there is only 28 bits left for the pfn, which is not enough.

Not related to the balloon but how would it help to set MAX_ORDER to
36?

What the MAX_ORDER affects is that you won't be able to ask the kernel
page allocator for contiguous memory bigger than 1<<(MAX_ORDER-1), but
that's a driver issue not relevant to the amount of RAM. Drivers won't
suddenly start to ask the kernel allocator to allocate compound pages
at orders >= 11 just because more RAM was added.

The higher the MAX_ORDER the slower the kernel runs simply so the
smaller the MAX_ORDER the better.

> Should  we limit the MAX_ORDER? I don't think so.

We shouldn't strictly depend on MAX_ORDER value but it's mostly
limited already even if configurable at build time.

We definitely need it to reach at least the hugepage size, then it's
mostly driver issue, but drivers requiring large contiguous
allocations should rely on CMA only or vmalloc if they only require it
virtually contiguous, and not rely on larger MAX_ORDER that would
slowdown all kernel allocations/freeing.
