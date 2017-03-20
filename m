Received: from eggs.gnu.org ([2001:4830:134:3::10]:46457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cq5H3-0005s1-3e
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 17:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cq5H2-0007hl-6Q
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 17:55:33 -0400
Received: from mail-vk0-x230.google.com ([2607:f8b0:400c:c05::230]:35592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1cq5H2-0007hb-0w
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 17:55:32 -0400
Received: by mail-vk0-x230.google.com with SMTP id x75so77765145vke.2
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 14:55:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a98bb8fd-c087-5cb2-92bc-76f255330e3d@redhat.com>
References: <CAO_EM_kn4QEw=+j23F7e+LzLW2_TPwNENoopqyBb-hdKYAow9w@mail.gmail.com>
	<f8f478b3-70a0-b67b-c4df-3f68ac66308a@redhat.com>
	<d54e7c6e-d261-dff0-9038-8f62283c91a4@redhat.com>
	<CAO_EM_=8-nnrz+BygPUnhkgrrRzYiPwE=ji7ncUXyHwZxVkAkw@mail.gmail.com>
	<a98bb8fd-c087-5cb2-92bc-76f255330e3d@redhat.com>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Mon, 20 Mar 2017 14:54:50 -0700
Message-ID: <CAO_EM_myxdGi62-4f69tP57UzUK49n_+NC8nQ-4tjJvhsnsP9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Assertion failure taking external snapshot with
 virtio drive + iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Fri, Mar 17, 2017 at 12:27 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> And this is a fix, but I have no idea why/how it works and what else it
> may break.
>
> Patches 1 and 2 are pretty obvious and would be the first step towards
> eliminating aio_disable/enable_external altogether.
>
> However I got patch 3 more or less by trial and error, and when I
> thought I had the reasoning right I noticed this:
>
>         bdrv_drained_end(state->old_bs);
>
> in external_snapshot_clean which makes no sense given the
>
>         bdrv_drained_begin(bs_new);
>
> that I added to bdrv_append.  So take this with a ton of salt.
>
> The basic idea is that calling child->role->drained_begin and
> child->role->drained_end is not necessary and in fact actively wrong
> when both the old and the new child should be in a drained section.
> But maybe instead it should be asserted that they are, except for the
> special case of adding or removing a child.  i.e. after
>
>     int drain = !!(old_bs && old_bs->quiesce_counter) - !!(new_bs && new_bs->quiesce_counter);
>
> add
>
>     assert(!(drain && old_bs && new_bs));
>
> Throwing this out because it's Friday evening... Maybe Fam can pick
> it up on Monday.

OK, thanks. It would be good to figure this out for 2.9, since the
workaround of disabling iothreads will affect performance. Let me know
if there's anything I can do to help.

Meanwhile I'm also looking into an intermittent crash running
block-commit on an external snapshot. This is with an earlier QEMU
snapshot (from around 20 Jan):

  /x/qemu/deb/debuild/block.c:2433: bdrv_append: Assertion
`!bdrv_requests_pending(bs_top)' failed.

That assertion no longer exists in the current master, but I'm trying
to reproduce it reliably and see whether the bug itself has
disappeared.

--Ed
