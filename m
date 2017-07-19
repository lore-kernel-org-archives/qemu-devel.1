Received: from eggs.gnu.org ([2001:4830:134:3::10]:50890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dXjzz-0007Be-QU
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dXjzy-0001gS-U1
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:06:23 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dXjzy-0001fF-N3
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:06:22 -0400
Received: by mail-wm0-x242.google.com with SMTP id 15so2421703wmm.3
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 01:06:21 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CABgObfZFzYpHNKZJXxbndgtn_Ya5D5AsrcwXs8E4johNE7VfOQ@mail.gmail.com>
References: <20170717154026.32697-1-stefanha@redhat.com>
	<20170717154026.32697-2-stefanha@redhat.com>
	<CABgObfZFzYpHNKZJXxbndgtn_Ya5D5AsrcwXs8E4johNE7VfOQ@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 19 Jul 2017 10:05:49 +0200
Message-ID: <CAKmqyKM35c_V3AQNKpO2YYHEwdjTxofXTq4Dc8mdayQMiASiqQ@mail.gmail.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

On Mon, Jul 17, 2017 at 7:23 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> +        if (io_read) {
>> +            bitmask |= FD_READ | FD_ACCEPT | FD_CLOSE;
>> +        }
>> +
>> +        if (io_write) {
>> +            bitmask |= FD_WRITE | FD_CONNECT;
>> +        }
>> +
>>          event = event_notifier_get_handle(&ctx->notifier);
>> -        WSAEventSelect(node->pfd.fd, event,
>> -                       FD_READ | FD_ACCEPT | FD_CLOSE |
>> -                       FD_CONNECT | FD_WRITE | FD_OOB);
>> +        WSAEventSelect(node->pfd.fd, event, bitmask);
>>      }
>>
>
> As noticed by Eric, if the same socket is in use via both aio-win32 and
> another GSource, or via multiple AioContexts, this would break because
> there is only one WSAEventSelect mask for each socket handle.
>
> It is probably not going to break anything in the case of aio-win32, but I
> think it is worth at least a comment. And because WSAEventSelect is
> edge-triggered (e.g. an FD_WRITE event doesn't trigger again until the next
> write) it shouldn't be that bad for performance.  If there's time to revert
> this patch, I think it would be preferable.

It looks like this was applied, I'll be back in the office next week
should I try and revert this or just add a comment explaining the
limitation.

Either that or store the current mask and OR then all together.

Thanks,
Alistair

>
> Paolo
