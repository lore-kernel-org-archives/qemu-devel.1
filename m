Received: from eggs.gnu.org ([2001:4830:134:3::10]:42728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dR7i1-0006kH-5Q
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 22:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dR7hy-0003Zg-3d
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 22:00:29 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47177)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dR7hx-0003Yl-QW
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 22:00:26 -0400
Date: Fri, 30 Jun 2017 22:00:24 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170701020024.GB1320@flamenco>
References: <1498768109-4092-1-git-send-email-cota@braap.org>
	<4e66d79b-6455-58f6-83ce-0ada25d1cec4@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e66d79b-6455-58f6-83ce-0ada25d1cec4@twiddle.net>
Subject: Re: [Qemu-devel] [RFC 0/7] tcg: parallel code generation (Work in
 Progress)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Fri, Jun 30, 2017 at 01:25:54 -0700, Richard Henderson wrote:
> On 06/29/2017 01:28 PM, Emilio G. Cota wrote:
> >- Patches 2-3 remove *tbs[] to use a binary search tree instead.
> >   This removes the assumption in tb_find_pc that *tbs[] are ordered
> >   by tc_ptr, thereby allowing us to generate code regardless of
> >   its location on the host (as we do after patch 6).
> 
> Have you considered a scheme by which the front end translation and tcg
> optimization are done outside the lock, but final code generation is done
> inside the lock?
> 
> It would put at least half of the translation time in the parallel space
> without requiring changes to code_buffer allocation.

I don't think that would save much, because the performance issue comes
from the fact that we have to grab the lock, regardless of how long we hold
it. So even if we did nothing inside the lock, scalability when
translating a lot of code (e.g. booting) would still be quite bad.

So we either get rid of the lock altogether, or use a more scalable lock.

		E.
