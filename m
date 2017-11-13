Received: from eggs.gnu.org ([2001:4830:134:3::10]:43611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eEDmU-0004Zr-BF
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 07:24:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eEDmP-0007g0-Eq
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 07:24:02 -0500
Received: from mail-ua0-f173.google.com ([209.85.217.173]:46350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eEDmP-0007fk-AB
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 07:23:57 -0500
Received: by mail-ua0-f173.google.com with SMTP id w47so7643909uah.3
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 04:23:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3205f50a0ec9089fcaf452911e60637b@ispras.ru>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
	<CABdb736bkcafKPCHsQGEmB6wYOGB4s4S4+sVkuygDe7SjqZDYA@mail.gmail.com>
	<CABdb736w49GjXwNOsj4o8RHQKAfmWnu+jJQgAZjzHwwzOW-+gA@mail.gmail.com>
	<1b94bfaac633fc76c8633bbcec9ff4a9@ispras.ru>
	<CABdb735OHqGVf_0D=zDy9D4HzG4s+w8OjUX5MG2pWrqOrQc=pg@mail.gmail.com>
	<3205f50a0ec9089fcaf452911e60637b@ispras.ru>
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon, 13 Nov 2017 13:23:55 +0100
Message-ID: <CABdb737buNdep007xMsBR2ZxOpmZXiSd_fz_mcQhnrbZGP2kgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/43] Windbg supporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Wed, Nov 8, 2017 at 3:28 PM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Ladi Prosek =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-11-08 16:43:
>
>> On Wed, Nov 8, 2017 at 12:54 PM, Mihail Abakumov
>> <mikhail.abakumov@ispras.ru> wrote:
>>>
>>> Ladi Prosek =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-11-06 18:15:
>>>
>>> In your case windbg does not send packets, more specifically, does not
>>> continue to do it. What is your version of windbg. Also, windbg stub ha=
s
>>> been supported only for windbg x64, yet.
>>
>>
>> Ah, so that's a pretty important piece of information and not very
>> intuitive given the "Only i386 is supported now." sentence in the
>> cover email.
>>
>> Microsoft (R) Windows Debugger Version 10.0.15063.468 X86
>> Microsoft (R) Windows Debugger Version 10.0.15063.468 AMD64
>> Microsoft (R) Windows Debugger Version 10.0.16299.15 X86
>> Microsoft (R) Windows Debugger Version 10.0.16299.15 AMD64
>>
>> are the versions I have tried. I don't see any difference between x86
>> and amd64, all versions never connect and crash after the second
>> break.
>>
>> What guest OS are you running? Can you maybe zip up your QEMU binaries
>> and share them with me?
>>
>> Thanks,
>> Ladi
>
>
> Oh, it looks like a problem in the versions. I use the Windbg from Window=
s
> 7.
> Windbg version: 6.12.0002.633 AMD64. I will try to test with your version=
.

Looks like it's the -b switch making the difference here. It was
removed in later versions of windbg.


Windbg docs (older):

-b
(Kernel mode only) This option has two effects:
1. The debugger will break into the target computer immediately upon connec=
tion.

2. After a reboot, the debugger will break into the target computer
once the kernel is initialized. See Crashing and Rebooting the Target
Computer for details and for other methods of changing this status.


Windbg docs (newer):

-b
This option is no longer supported.


-b makes windbg send a break-in right after connecting. Apparently
there is a short time window when the break-in will work. I can
actually successfully connect with a Win10 windbg (so without -b) if I
hit Ctrl+Break shortly after the initial handshake. This also explains
why I was able to connect once during my initial testing. I was just
lucky and hit Ctrl+Break soon enough after connecting.

By initial handshake I mean this sequence (I have added a simple
logging, should be clear what it means):

Received control PACKET_TYPE_KD_RESET
Sending data 7
Sending control 6

Newer debuggers without -b will stop here. Older debuggers with -b
will continue with:

Received RESULT_BREAKIN_BYTE
Sending data 7
Received RESULT_BREAKIN_BYTE
Sending data 7
Received data PACKET_TYPE_KD_STATE_MANIPULATE (12614)
Sending control 4
Sending data 2
Received data PACKET_TYPE_KD_STATE_MANIPULATE (12592)
Sending control 4
Sending data 2
Received data PACKET_TYPE_KD_STATE_MANIPULATE (12592)
Sending control 4
Sending data 2
...


Next step, when I have time, is to find the differences between
sending the break-in early and sending it later. Also interesting
would be recording the exchange between windbg and the target when
doing regular remote kernel debugging. I would still expect to see the
"Connected to Windows 7 7601 x86 compatible target ..." output always,
even when not breaking in immediately. The handshake is likely still
missing something.

Thanks,
Ladi
