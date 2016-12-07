Received: from eggs.gnu.org ([2001:4830:134:3::10]:55340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1cEh6o-0006wq-1F
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1cEh6k-0005cd-3q
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:38:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aarcange@redhat.com>) id 1cEh6j-0005cT-Rq
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:38:22 -0500
Date: Wed, 7 Dec 2016 19:38:17 +0100
From: Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <20161207183817.GE28786@redhat.com>
References: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
	<f67ca79c-ad34-59dd-835f-e7bc9dcaef58@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A130C01@shsmsx102.ccr.corp.intel.com>
	<0b18c636-ee67-cbb4-1ba3-81a06150db76@redhat.com>
	<0b83db29-ebad-2a70-8d61-756d33e33a48@intel.com>
	<2171e091-46ee-decd-7348-772555d3a5e3@redhat.com>
	<d3ff453c-56fa-19de-317c-1c82456f2831@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3ff453c-56fa-19de-317c-1c82456f2831@intel.com>
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
To: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>, "Li, Liang Z" <liang.z.li@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mhocko@suse.com" <mhocko@suse.com>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>

Hello,

On Wed, Dec 07, 2016 at 08:57:01AM -0800, Dave Hansen wrote:
> It is more space-efficient.  We're fitting the order into 6 bits, which
> would allows the full 2^64 address space to be represented in one entry,

Very large order is the same as very large len, 6 bits of order or 8
bytes of len won't really move the needle here, simpler code is
preferable.

The main benefit of "len" is that it can be more granular, plus it's
simpler than the bitmap too. Eventually all this stuff has to end up
into a madvisev (not yet upstream but somebody posted it for jemalloc
and should get merged eventually).

So the bitmap shall be demuxed to a addr,len array anyway, the bitmap
won't ever be sent to the madvise syscall, which makes the
intermediate representation with the bitmap a complication with
basically no benefits compared to a (N, [addr1,len1], .., [addrN,
lenN]) representation.

If you prefer 1 byte of order (not just 6 bits) instead 8bytes of len
that's possible too, I wouldn't be against that, the conversion before
calling madvise would be pretty efficient too.

> and leaves room for the bitmap size to be encoded as well, if we decide
> we need a bitmap in the future.

How would a bitmap ever be useful with very large page-order?

> If that was purely a length, we'd be limited to 64*4k pages per entry,
> which isn't even a full large page.

I don't follow here.

What we suggest is to send the data down represented as (N,
[addr1,len1], ..., [addrN, lenN]) which allows infinite ranges each
one of maximum length 2^64, so 2^64 multiplied infinite times if you
wish. Simplifying the code and not having any bitmap at all and no :6
:6 bits either.

The high order to low order loop of allocations is the interesting part
here, not the bitmap, and the fact of doing a single vmexit to send
the large ranges.

Once we pull out the largest order regions, we just add them to the
array as [addr,1UL<<order], when the array reaches a maximum N number
of entries or we fail a order 0 allocation, we flush all those entries
down to qemu. Qemu then builds the iov for madvisev and it's pretty
much a 1:1 conversion, not a decoding operation converting the bitmap
in the (N, [addr1,len1], ..., [addrN, lenN]) for madvisev (or a flood
of madvise MADV_DONTNEED with current kernels).

Considering the loop that allocates starting from MAX_ORDER..1, the
chance the bitmap is actually getting filled with more than one bit at
page_shift of PAGE_SHIFT should be very low after some uptime.

By the very nature of this loop, if we already exacerbates all high
order buddies, the page-order 0 pages obtained are going to be fairly
fragmented reducing the usefulness of the bitmap and potentially only
wasting CPU/memory.
