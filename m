Received: from eggs.gnu.org ([2001:4830:134:3::10]:46132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJiac-0007hW-1B
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:18:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJiaW-0005P7-Dt
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:18:30 -0500
References: <20171128154350.21504-1-kwolf@redhat.com>
	<20171128154350.21504-2-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <00b2dbda-e7a1-2fc4-b7ca-e60c0ef08a95@redhat.com>
Date: Tue, 28 Nov 2017 17:18:05 +0100
MIME-Version: 1.0
In-Reply-To: <20171128154350.21504-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 1/4] Revert "coroutine: abort if
 we try to schedule or enter a pending coroutine"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, stefanha@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On 28/11/2017 16:43, Kevin Wolf wrote:
> This reverts commit 6133b39f3c36623425a6ede9e89d93175fde15cd.
> 
> The commit checked conditions that would expose a bug, but there is no
> real reason to forbid them apart from the bug, which we'll fix in a
> minute.
> 
> In particular, reentering a coroutine during co_aio_sleep_ns() is fine;
> the function is explicitly written to allow this.

This is true.

> aio_co_schedule() can indeed conflict with direct coroutine invocations,
> but this is exactky what we want to fix, so remove that check again,
> too.

I'm not sure this is a good idea, as I answered in patch 3.

It can also conflict badly with another aio_co_schedule().  Your patch
here removes the assertion in this case, and patch 3 makes it easier to
get into the situation where two aio_co_schedule()s conflict with each
other.

For example, say you have a coroutine that calls aio_co_schedule on
itself, like

	while (true) {
		aio_co_schedule(qemu_get_current_aio_context(),
				qemu_coroutine_self());
	}

If somebody else calls qemu_coroutine_enter on this coroutine, *that* is
the bug.  These patches would just cause some random corruption or
(perhaps worse) hang.

Paolo
