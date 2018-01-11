Received: from eggs.gnu.org ([2001:4830:134:3::10]:55109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZbP3-0004E1-Qp
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 06:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZbP2-0004Qq-Ng
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 06:52:13 -0500
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:44692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZbP2-0004QR-H4
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 06:52:12 -0500
Received: by mail-ot0-x22e.google.com with SMTP id g59so1851961otg.11
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 03:52:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180103093834.20879-1-quintela@redhat.com>
References: <20180103093834.20879-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 11:51:51 +0000
Message-ID: <CAFEAcA9bET+RJrAXk+Gko8Fvkx791XcGSMREf9GhXTxYeitgTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 3 January 2018 at 09:38, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> This are the changes for migration that are already reviewed.
>
> Please, apply.
>
> Later, Juan.
>
>
> The following changes since commit 281f327487c9c9b1599f93c589a408bbf4a651b8:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-request' into staging (2017-12-22 00:11:36 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20180103
>
> for you to fetch changes up to 8a18afdcd8d2d6ab31f9de89d2f20fdadb89beb8:
>
>   migration: finalize current_migration object (2018-01-03 09:28:56 +0100)
>
> ----------------------------------------------------------------
> migration/next for 20180103
>

This fails to build on 32-bit systems:

/home/peter.maydell/qemu/migration/postcopy-ram.c: In function
'mark_postcopy_blocktime_begin':
/home/peter.maydell/qemu/migration/postcopy-ram.c:658:54: error: cast
to pointer from integer of different size
[-Werror=int-to-pointer-cast]
     already_received = ramblock_recv_bitmap_test(rb, (void *)addr);
                                                      ^

Keeping pointers in uint64_t and casting all over the place
looks like the wrong thing -- using the uintptr_t type will
likely make things cleaner.

This also looks suspicious:

    atomic_xchg__nocheck(&dc->last_begin, now_ms);
    atomic_xchg__nocheck(&dc->page_fault_vcpu_time[cpu], now_ms);
    atomic_xchg__nocheck(&dc->vcpu_addr[cpu], addr);

because atomic operations on types larger than the host pointer
size are not portable to all architectures. This should probably
use the atomic_cmpxchg(), not __nocheck, because the latter
bypasses the build time assert for this problem and turns a
"fails on any 32-bit host" into "fails obscurely on some
architectures only".

thanks
-- PMM
