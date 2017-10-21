Received: from eggs.gnu.org ([2001:4830:134:3::10]:39671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e5jc9-0001gG-6L
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 22:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e5jc6-0000sR-3O
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 22:34:17 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38881)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e5jc5-0000pl-Pd
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 22:34:14 -0400
Date: Fri, 20 Oct 2017 22:34:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171021023410.GA27478@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171018224518.GA28532@flamenco>
	<5381cf3d-00c9-1c05-c973-5934311d654d@redhat.com>
	<20171019201149.GA15218@flamenco>
	<64241d68-b526-3dc1-a264-fa9e6d634527@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64241d68-b526-3dc1-a264-fa9e6d634527@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 00/50] tcg tb_lock removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On Fri, Oct 20, 2017 at 09:10:38 +0200, Paolo Bonzini wrote:
> >> 2) in tb_for_each_tagged_safe, could the "prev" argument instead be
> >> "next", like
> > 
> > Is this just to make them closer to the macros in queue.h?
> > 
> > In this case tracking *prev in the loop (rather than next) is
> > useful because it makes removing the "current" element very simple:
> 
> This actually makes a lot of sense.  Maybe we should change queue.h the
> other way. ;)

Turns out this works here but it isn't as general-purpose as it
might look. In this case it works because we don't free the tb. If
we did, then we'd either need a branch in the iterator or a third
*next pointer.

In fact, the macro wouldn't be safe even if it tracked *next, since
on a removal *pprev must not be updated to the removed item.
IOW, the caller must be the one keeping track of *pprev, for otherwise
things break after the first removal. (Again, this doesn't affect this
particular instance, because its only caller stops iterating after
a removal.)

I have therefore given up on the macro and changed its only caller to
update *pprev. IMO it's less pretty, but more robust.

The updated branch with the changes you suggested (plus the above) is
available at:
  https://github.com/cota/qemu/tree/multi-tcg-v6-plus2

Thanks,

		Emilio
