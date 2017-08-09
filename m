Received: from eggs.gnu.org ([2001:4830:134:3::10]:38038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfUbQ-0004HV-Po
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 13:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfUbN-0003G7-JZ
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 13:17:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dfUbN-0003FM-Di
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 13:17:01 -0400
Date: Wed, 9 Aug 2017 20:16:55 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170809201442-mutt-send-email-mst@kernel.org>
References: <743158bc-15e4-46fe-38cb-161397b5b240@linaro.org>
	<3685aed3-735f-ae62-73a9-8f4a5c7cd459@redhat.com>
	<9be585e2-4641-329e-f442-69ae05faadba@redhat.com>
	<ea6acc7c-09a6-70ed-9ff0-865bd45a47f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea6acc7c-09a6-70ed-9ff0-865bd45a47f3@redhat.com>
Subject: Re: [Qemu-devel] Qemu and 32 PCIe devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Drew Jones <drjones@redhat.com>, Christoffer Dall <cdall@linaro.org>, Marc Zygnier <marc.zyngier@arm.com>, Gema Gomez-Solano <gema.gomez-solano@linaro.org>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>

On Wed, Aug 09, 2017 at 09:26:11AM +0200, Paolo Bonzini wrote:
> On 09/08/2017 03:06, Laszlo Ersek wrote:
> >>   20.14%  qemu-system-x86_64                  [.] render_memory_region
> >>   17.14%  qemu-system-x86_64                  [.] subpage_register
> >>   10.31%  qemu-system-x86_64                  [.] int128_add
> >>    7.86%  qemu-system-x86_64                  [.] addrrange_end
> >>    7.30%  qemu-system-x86_64                  [.] int128_ge
> >>    4.89%  qemu-system-x86_64                  [.] int128_nz
> >>    3.94%  qemu-system-x86_64                  [.] phys_page_compact
> >>    2.73%  qemu-system-x86_64                  [.] phys_map_node_alloc
> 
> Yes, this is the O(n^3) thing.  An optimized build should be faster
> because int128 operations will be inlined and become much more efficient.
> 
> > With this patch, I only tested the "93 devices" case, as the slowdown
> > became visible to the naked eye from the trace messages, as the firmware
> > enabled more and more BARs / command registers (and inversely, the
> > speedup was perceivable when the firmware disabled more and more BARs /
> > command registers).
> 
> This is an interesting observation, and it's expected.  Looking at the
> O(n^3) complexity more in detail you have N operations, where the "i"th
> operates on "i" DMA address spaces, all of which have at least "i"
> memory regions (at least 1 BAR per device).
> 
> So the total cost is sum i=1..N i^2 = N(N+1)(2N+1)/6 = O(n^3).
> Expressing it as a sum shows why it gets slower as time progresses.
> 
> The solution is to note that those "i" address spaces are actually all
> the same, so we can get it down to sum i=1..N i = N(N+1)/2 = O(n^2).
> 
> Thanks,
> 
> Paolo

We'll probably run into more issues with the vIOMMU but I guess we
can look into it later.

Resolving addresses lazily somehow might be interesting. And would
the caching work that went in a while ago but got disabled
since we couldn't iron out all the small issues
help go in that direction somehow?

-- 
MST
