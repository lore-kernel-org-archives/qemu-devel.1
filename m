Received: from eggs.gnu.org ([2001:4830:134:3::10]:55279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eKRKr-0002WI-13
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eKRKh-0005EX-MP
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:05:13 -0500
References: <20171129144956.11409-1-famz@redhat.com>
	<20171129172546.GG3753@localhost.localdomain>
	<20171130020359.GB16237@lemon>
	<20171130103135.GA4039@localhost.localdomain>
	<20171130143430.GA24067@lemon>
	<20171130151038.GE4039@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02559c3a-0de0-df8c-4324-d326715b1f86@redhat.com>
Date: Thu, 30 Nov 2017 17:04:40 +0100
MIME-Version: 1.0
In-Reply-To: <20171130151038.GE4039@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 0/9] block: Rewrite block drain
 begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jcody@redhat.com, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 30/11/2017 16:10, Kevin Wolf wrote:
>> Yes, I agree, but that (using CoMutex around graph change) requires
>> everything, especially the defer_to_main_loop_bh, runs in a coroutine
>> context, which is exactly what I mean by "introducing 'ubiquitous
>> coroutines'", because currently we don't have them.
> Is it hard to do, though? Instead of using a BH to switch to the main
> loop and outside of coroutine context, you could use aio_co_schedule()
> and yield, which would leave you in the main loop, but still in
> coroutine context.

Not that I think of, but just aio_co_schedule wouldn't work, because
"the coroutine must have yielded unless ctx is the context in which the
coroutine is running (i.e. the value of qemu_get_current_aio_context()
from the coroutine itself)".

So you'd have to use a bottom half that calls aio_co_schedule.  But that
would work.

Paolo

> Would this have any bad side effects I'm not aware of?
