Received: from eggs.gnu.org ([2001:4830:134:3::10]:45139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzON0-0000uX-Ul
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzOMw-0007N4-Me
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:44:58 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59523)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzOMp-0007KB-V2
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:44:50 -0400
Date: Mon, 10 Sep 2018 11:44:42 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180910154442.GD19941@flamenco>
References: <20180903171831.15446-1-cota@braap.org>
	<20180903171831.15446-2-cota@braap.org>
	<e0055fc2-778d-c9cd-c157-29032085e2e7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0055fc2-778d-c9cd-c157-29032085e2e7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] qsp: drop atomics when using the
 seqlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Mon, Sep 10, 2018 at 01:32:15 +0200, Paolo Bonzini wrote:
> On 03/09/2018 19:18, Emilio G. Cota wrote:
> > Using atomics here is a mistake since they're not guaranteed
> > to compile.
> 
> But isn't it technically a C11 data race if you don't use atomics?

Yes, it's undefined behaviour.

> Could we make nocheck read/set degrade to just a volatile access when
> used on a variable that is bigger than pointers, or perhaps always
> except when using tsan?

But volatile wouldn't save you from undefined behaviour, would it?

A simpler and definitely correct alternative is to just use a
spinlock instead of the seqlock also for reads when !CONFIG_ATOMIC64.
We don't care about scalability on those rare hosts anyway, so
I'd go with that.

Thanks,

		Emilio
