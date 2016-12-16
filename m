Received: from eggs.gnu.org ([2001:4830:134:3::10]:44126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1cHuwh-0007LB-4x
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1cHuwe-000862-37
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:01:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aarcange@redhat.com>) id 1cHuwd-00085n-UJ
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:01:16 -0500
Date: Fri, 16 Dec 2016 17:01:12 +0100
From: Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <20161216160112.GC6168@redhat.com>
References: <b58fd9f6-d9dd-dd56-d476-dd342174dac5@intel.com>
	<20161207202824.GH28786@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A14E2AD@SHSMSX104.ccr.corp.intel.com>
	<060287c7-d1af-45d5-70ea-ad35d4bbeb84@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C31D0E6@SHSMSX104.ccr.corp.intel.com>
	<01886693-c73e-3696-860b-086417d695e1@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C32985A@shsmsx102.ccr.corp.intel.com>
	<f517bfbe-18b8-6962-5c57-545f6ef47ad0@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C32A8D6@shsmsx102.ccr.corp.intel.com>
	<84ac9822-880d-b998-52ca-6aa87e0f7a43@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ac9822-880d-b998-52ca-6aa87e0f7a43@intel.com>
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
Cc: "Li, Liang Z" <liang.z.li@intel.com>, David Hildenbrand <david@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mhocko@suse.com" <mhocko@suse.com>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>

On Thu, Dec 15, 2016 at 05:40:45PM -0800, Dave Hansen wrote:
> On 12/15/2016 05:38 PM, Li, Liang Z wrote:
> > 
> > Use 52 bits for 'pfn', 12 bits for 'length', when the 12 bits is not long enough for the 'length'
> > Set the 'length' to a special value to indicate the "actual length in next 8 bytes".
> > 
> > That will be much more simple. Right?
> 
> Sounds fine to me.
> 

Sounds fine to me too indeed.

I'm only wondering what is the major point for compressing gpfn+len in
8 bytes in the common case, you already use sg_init_table to send down
two pages, we could send three as well and avoid all math and bit
shifts and ors, or not?

I agree with the above because from a performance prospective I tend
to think the above proposal will run at least theoretically faster
because the other way is to waste double amount of CPU cache, and bit
mangling in the encoding and the later decoding on qemu side should be
faster than accessing an array of double size, but then I'm not sure
if it's measurable optimization. So I'd be curious to know the exact
motivation and if it is to reduce the CPU cache usage or if there's
some other fundamental reason to compress it.

The header already tells qemu how big is the array payload, couldn't
we just add more pages if one isn't enough?

Thanks,
Andrea
