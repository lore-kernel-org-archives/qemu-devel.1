Received: from eggs.gnu.org ([2001:4830:134:3::10]:56604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cj67Y-0001rZ-3L
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cj67W-00034l-Tp
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:24:52 -0500
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:35074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1cj67W-00034f-Mc
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:24:50 -0500
Received: by mail-qk0-x229.google.com with SMTP id u188so75369881qkc.2
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 07:24:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJy91Ca7-f0h6YeGA2+HqeC_ima8oPnTPii26Ryut=JSkEX-EA@mail.gmail.com>
References: <CAJy91CZO+XOyzyhG5yKYcYQsfG_jwRF7W_4sxp6Fen=4gNr+YA@mail.gmail.com>
	<CAJ+F1CL7VPrbwevNXioH5-gSz6DWRMzZN=OK0qnCn--T7sHC0A@mail.gmail.com>
	<CAJy91CYYrj58whBJFKKdo-dkQ=3UcXSvJem1qXas=qPeFtX46w@mail.gmail.com>
	<CAJ+F1CKTWTT2PzGtCCrK_vC7uDGCqmTGXxdYK0LTz-Gwu2Vyuw@mail.gmail.com>
	<CAJy91Ca7-f0h6YeGA2+HqeC_ima8oPnTPii26Ryut=JSkEX-EA@mail.gmail.com>
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Wed, 1 Mar 2017 16:24:49 +0100
Message-ID: <CAJy91CbJnN+yDVgMfYx3p3x-PKKnu7CLMmu26euHeYwpvN7RWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Windows Pipe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

I think the reading failure in 2 is because there is no writing to the pipe
from the frontend (serial port).

So i wonder if the windows pipe implementation is complete. I mean dual-way
pipe.

>From the codes, I sense not. If somebody knows please inform me. =F0=9F=99=
=8F Thanks
a lot!

On 1 March 2017 at 16:12, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:

> What I have done is two things.
>
> 1. I create a NamedPipeClient.exe to open the pipe and write a string int=
o
> it. QEMU indicates the string is recieved from the pipe.
>
> 2. I create another NamedPipeClient.exe to open the pipe and read the dat=
a
> in the pipe. In qemu, I run a test.bin as kernel with versatilepb.
>  test.bin assigns a string to UART0, which is redirected to the pipe.
> (test.bin has been verified by -serial stdio.) The test result is: pipe i=
s
> opened by NamedPipeClient.exe, but nothing on the pipe to read.
>
> the NamedPipeClient.exe is created by visual studio.
>
> On 1 March 2017 at 15:58, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.=
com>
> wrote:
>
>> Hi
>>
>> On Wed, Mar 1, 2017 at 6:42 PM Jiahuan Zhang <jiahuanzhang90@gmail.com>
>> wrote:
>>
>>> Hi,
>>>
>>> I agree with you about win_chr_poll(). But what I wonder is how to writ=
e
>>> data into the pipe for the host to get. I see "writeFile()" in
>>> "win_chr_write()", but have no idea how to use it. Or I have to write
>>> something for this writing. In this case, I don't know what the right
>>> buffer pointer for WriteFile() is.
>>>
>>> Any clue is greatly appreciated!
>>>
>>>
>> According to the documentation, it "creates a single duplex pipe at
>> \\.pipe\path", you'll have to open and write to it from a different
>> application. I don't know if there are console applications that can ope=
n
>> pipe you can use, you'll have to do some research or write one!
>>
>>
>> On 1 March 2017 at 15:25, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail=
.com>
>>> wrote:
>>>
>>> Hi
>>>
>>> On Wed, Mar 1, 2017 at 5:16 PM Jiahuan Zhang <jiahuanzhang90@gmail.com>
>>> wrote:
>>>
>>> Dear QEMU developers,
>>>
>>> I want the host-guest communication for QEMU. I want to achieve
>>> it via serial port redirection to a pipe. My host is windows and guest =
is
>>> Linux. QEMU is in version 2.8.50
>>>
>>> I looked into char-pipe.c and char-win.c, and find that the current QEM=
U
>>> only supports reading data on the pipe from host to guest for Windows.
>>> See *win_chr_pipe_init
>>> () *in char-pipe.c
>>>
>>> Is it true?
>>>
>>>
>>> Not exactly, for some reason, the win-chr-pipe uses a poll,
>>> win_chr_poll() that read from the pipe and write to the frontend (the v=
m
>>> serial).  I haven't tested the windows pipe implementation, only the
>>> console one, but it looks like it should work. Hopefully someone using =
qemu
>>> on windows can help you.
>>>
>>>
>>> I don't know how to use *win_chr_write() *in char-win.c.
>>> Can you please present an example?
>>>
>>> best regards,
>>> Jiahuan
>>>
>>> --
>>> Marc-Andr=C3=A9 Lureau
>>>
>>>
>>> --
>> Marc-Andr=C3=A9 Lureau
>>
>
>
