Received: from eggs.gnu.org ([2001:4830:134:3::10]:35327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eWeS3-000168-87
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eWeS0-0000YL-6h
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:31:07 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eWeS0-0000WP-03
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:31:04 -0500
Received: by mail-wm0-f67.google.com with SMTP id g130so19252402wme.0
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 00:31:03 -0800 (PST)
References: <20171228072945.9573-1-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cd7d1d86-331f-1a0e-2a39-bee1d536157b@redhat.com>
Date: Wed, 3 Jan 2018 08:10:58 +0100
MIME-Version: 1.0
In-Reply-To: <20171228072945.9573-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] chardev: convert leftover glib APIs to
 use dedicate gcontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 28/12/2017 08:29, Peter Xu wrote:
> There were existing work that tried to allow chardev to be run in a
> dedicated gcontext rather than the default main context/thread.
> Basically that work passed in the correct gcontext during
> g_source_attach().  However, I found something missing along the way,
> that some legacy glib APIs are used by chardev code which take the
> main context as default:
> 
>    g_timeout_add_seconds
>    g_timeout_add
>    g_idle_add
> 
> To fully allow the chardevs to be run in dedicated gcontext, we need
> to convert all these legacy APIs into g_source_attach() calls as well,
> with the correct gcontext passed in.
> 
> This series tries to clean the rest of things up.
> 
> I picked up patch 1 from monitor-oob series into this series (which is
> a missing of chardev frontend call fix for g_source_attach()), so that
> this series can be a complete fix.
> 
> Please review.  Thanks,
> 
> Peter Xu (3):
>   chardev: use backend chr context when watch for fe
>   chardev: let g_idle_add() be with chardev gcontext
>   chardev: introduce qemu_chr_timeout_add() and use
> 
>  chardev/char-fe.c      |  2 +-
>  chardev/char-pty.c     | 16 ++++++++--------
>  chardev/char-socket.c  |  4 ++--
>  chardev/char.c         | 20 ++++++++++++++++++++
>  hw/char/terminal3270.c |  7 ++++---
>  include/chardev/char.h |  2 ++
>  6 files changed, 37 insertions(+), 14 deletions(-)
> 

All queued, thanks!

Paolo
