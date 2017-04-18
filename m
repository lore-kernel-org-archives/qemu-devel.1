Received: from eggs.gnu.org ([2001:4830:134:3::10]:55927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0Ocn-0008Ai-Lv
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 04:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0Ocm-0003Uc-QV
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 04:36:37 -0400
Date: Tue, 18 Apr 2017 16:36:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170418083625.GA22853@lemon.lan>
References: <20170414080206.2301-1-famz@redhat.com>
	<CAJSP0QVbYRW0VD_1zUqU0T6V48wr_g3co8Dxs_ndpfA70d4TkQ@mail.gmail.com>
	<20170417082719.GC13582@lemon.lan>
	<7ee25e94-d8c1-cc29-7d39-5ecce08ecd90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ee25e94-d8c1-cc29-7d39-5ecce08ecd90@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9-rc5 v2] block: Drain BH in
 bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Tue, 04/18 10:18, Paolo Bonzini wrote:
> 
> 
> On 17/04/2017 10:27, Fam Zheng wrote:
> > At this point it's even unclear to me what should be the plan for 2.9.  v1 IMO
> > was the least intrusive, but didn't cover bdrv_drain_all_begin. v2 has this
> > controversial "aio_poll(ctx_, false)",
> 
> v1 has it too:
> 
> -    bdrv_drain_recurse(bs);
> +    while (true) {
> +        if (!bdrv_drain_recurse(bs) &&
> +            !aio_poll(bdrv_get_aio_context(bs), false)) {
> +                break;
> +            }
> +    }

Yes you are right.

On the other hand, the fact that in v2 I had to add bdrv_ref/bdrv_unref around
the recursive bdrv_drain_recurse() call makes me worry a little - I assume the
same problem exists in v1 and is just latent. So maybe merging v2 is better.

> 
> I don't have any particular preference.  Both patches are self contained
> and easy to revert when the underlying root cause is fixed.
> 

Fam
