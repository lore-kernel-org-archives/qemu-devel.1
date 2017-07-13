Received: from eggs.gnu.org ([2001:4830:134:3::10]:41954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dVdPt-0007m7-25
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dVdPm-0003Bu-RB
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:40:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dVdPm-0003A2-Kc
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:40:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id j85so4835374wmj.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 05:40:18 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <1c00858e-2425-ecf5-af6e-ba1030715f16@redhat.com>
References: <468425bd8090e3a9fd7fc791db42e24d6c75315c.1499940552.git.alistair.francis@xilinx.com>
	<20170713102359.GH4011@redhat.com>
	<1c00858e-2425-ecf5-af6e-ba1030715f16@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 13 Jul 2017 14:38:46 +0200
Message-ID: <CAKmqyKN1a1N3y39K-u2tZecjERoLAOOJKCQ29H=mp0KiT7Fixw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/1] io/channel-watch.c: Only select on
 what we are actually waiting for
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

On Thu, Jul 13, 2017 at 1:09 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 13/07/2017 12:23, Daniel P. Berrange wrote:
>> On Thu, Jul 13, 2017 at 03:15:49AM -0700, Alistair Francis wrote:
>>> diff --git a/io/channel-watch.c b/io/channel-watch.c
>>> index 8640d1c464..d80722f496 100644
>>> --- a/io/channel-watch.c
>>> +++ b/io/channel-watch.c
>>> @@ -286,9 +286,21 @@ GSource *qio_channel_create_socket_watch(QIOChannel *ioc,
>>>      QIOChannelSocketSource *ssource;
>>>
>>>  #ifdef WIN32
>>> -    WSAEventSelect(socket, ioc->event,
>>> -                   FD_READ | FD_ACCEPT | FD_CLOSE |
>>> -                   FD_CONNECT | FD_WRITE | FD_OOB);
>>> +    long bitmask = 0;
>>> +
>>> +    if (condition & (G_IO_IN | G_IO_PRI)) {
>>> +        bitmask |= FD_READ | FD_ACCEPT;
>>> +    }
>>> +
>>> +    if (condition & G_IO_HUP) {
>>> +        bitmask |= FD_CLOSE;
>>> +    }
>>> +
>>> +    if (condition & G_IO_OUT) {
>>> +        bitmask |= FD_WRITE | FD_CONNECT;
>>> +    }
>>> +
>>> +    WSAEventSelect(socket, ioc->event, bitmask);
>>>  #endif
>>
>> I think the problem with doing this is that WSAEventSelect is a global
>> setting that applies to the socket handle. If you use qio_channel_create_watch
>> twice on the same socket with different events, the second watch will break
>> the first watch by potentially discarding events that it requested.
>
> This makes sense, and it means the corresponding aio-win32 patch is
> wrong too.

Ah, I see that.

>
> WSAEventSelect events are edge-triggered, so they shouldn't be too bad.
> In particular, they won't cause a busy wait.

The problem I have seen is that threads get kicked at incorrect times
for events that you aren't waiting for. It isn't a horrific issue, but
it does contribute to extra resource usage.

I don't see any nice way to get the value of lNetworkEvents back from
Windows, so unless we keep track of it for a socket we can't just add
to it.

Is it even possible to assign two different events to a single socket?
Every call seems to overwrite whatever was previously set. Are there
cases where we call this two for different events on the same socket?

Thanks,
Alistair

>
> Paolo
