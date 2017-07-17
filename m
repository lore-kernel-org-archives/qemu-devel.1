Received: from eggs.gnu.org ([2001:4830:134:3::10]:39199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dX9kc-0004GG-6O
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dX9kY-0004CE-T0
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:24:06 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:33892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dX9kY-0004BK-LV
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:24:02 -0400
Received: by mail-lf0-f51.google.com with SMTP id t72so89759377lff.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 10:24:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717154026.32697-2-stefanha@redhat.com>
References: <20170717154026.32697-1-stefanha@redhat.com>
	<20170717154026.32697-2-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 17 Jul 2017 19:23:40 +0200
Message-ID: <CABgObfZFzYpHNKZJXxbndgtn_Ya5D5AsrcwXs8E4johNE7VfOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 1/2] util/aio-win32: Only select on what we
 are actually waiting for
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>

> +        if (io_read) {
> +            bitmask |= FD_READ | FD_ACCEPT | FD_CLOSE;
> +        }
> +
> +        if (io_write) {
> +            bitmask |= FD_WRITE | FD_CONNECT;
> +        }
> +
>          event = event_notifier_get_handle(&ctx->notifier);
> -        WSAEventSelect(node->pfd.fd, event,
> -                       FD_READ | FD_ACCEPT | FD_CLOSE |
> -                       FD_CONNECT | FD_WRITE | FD_OOB);
> +        WSAEventSelect(node->pfd.fd, event, bitmask);
>      }
>

As noticed by Eric, if the same socket is in use via both aio-win32 and
another GSource, or via multiple AioContexts, this would break because
there is only one WSAEventSelect mask for each socket handle.

It is probably not going to break anything in the case of aio-win32, but I
think it is worth at least a comment. And because WSAEventSelect is
edge-triggered (e.g. an FD_WRITE event doesn't trigger again until the next
write) it shouldn't be that bad for performance.  If there's time to revert
this patch, I think it would be preferable.

Paolo
