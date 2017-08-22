Received: from eggs.gnu.org ([2001:4830:134:3::10]:51078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk99i-0007sT-RU
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk99i-0000JZ-3c
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:23:42 -0400
References: <20170822125113.5025-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8b6f5029-44e8-c14b-6730-6db69ce73f7e@redhat.com>
Date: Tue, 22 Aug 2017 15:23:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170822125113.5025-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd-client: avoid spurious
 qio_channel_yield() re-entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

On 22/08/2017 14:51, Stefan Hajnoczi wrote:
> This should fix the issue that Dave is seeing but I'm concerned that
> there are more problems in nbd-client.c.  We don't have good
> abstractions for writing coroutine socket I/O code.  Something like Go's
> channels would avoid manual low-level coroutine calls.  There is
> currently no way to cancel qio_channel_yield() so requests doing I/O may
> remain in-flight indefinitely and nbd-client.c doesn't join them...

The idea was that shutdown(2) would force them to reenter...

Paolo
