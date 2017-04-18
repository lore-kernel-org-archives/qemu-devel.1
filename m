Received: from eggs.gnu.org ([2001:4830:134:3::10]:45158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d0NrR-0007MH-RH
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 03:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d0NrN-0003qV-0D
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 03:47:41 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d0NrM-0003qJ-PT
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 03:47:36 -0400
Received: by mail-wm0-x241.google.com with SMTP id o81so12985117wmb.0
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 00:47:36 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
	<575d21dff52df4fa53d17e77728018453f82e8e5.1492384862.git.shorne@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <382ab324-39c0-5549-ff01-3fe7cc1319de@twiddle.net>
Date: Tue, 18 Apr 2017 00:47:30 -0700
MIME-Version: 1.0
In-Reply-To: <575d21dff52df4fa53d17e77728018453f82e8e5.1492384862.git.shorne@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] target/openrisc: Fixes for memory
 debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>, qemu-devel@nongnu.org
Cc: openrisc@lists.librecores.org

On 04/16/2017 04:23 PM, Stafford Horne wrote:
> When debugging in gdb you might want to inspect instructions in mapped
> pages or in exception vectors like 0x800 etc.  This was previously not
> possible in qemu since the *get_phys_page_debug() routine only looked
> into the data tlb.
>
> Change to fall back to look into instruction tlb and plain physical
> pages.
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Oh the horrors of a software managed TLB.

You might do well to architecturally define an SPR that holds the page table 
base, even if for real hardware that's only used by the software refill to load 
up the address.

That would give qemu the option of performing a real page table walk.  This 
would fix this debug hook properly (so that you can examine pages that aren't 
in the TLB at all).  It would also optionally allow QEMU to skip the software 
refill, which *significantly* speeds up emulation.

That said,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
