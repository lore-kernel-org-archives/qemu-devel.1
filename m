Received: from eggs.gnu.org ([2001:4830:134:3::10]:40001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eByy2-0000g3-TW
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 03:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eByxz-0000iU-O6
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 03:10:42 -0500
Received: from mail-ua0-f177.google.com ([209.85.217.177]:55933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eByxz-0000iM-KA
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 03:10:39 -0500
Received: by mail-ua0-f177.google.com with SMTP id b11so8229230uae.12
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 00:10:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB0159B2CB632AE8DE6B8DB6F99E500@MWHPR21MB0159.namprd21.prod.outlook.com>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
	<CABdb736bkcafKPCHsQGEmB6wYOGB4s4S4+sVkuygDe7SjqZDYA@mail.gmail.com>
	<CABdb736w49GjXwNOsj4o8RHQKAfmWnu+jJQgAZjzHwwzOW-+gA@mail.gmail.com>
	<MWHPR21MB0159B2CB632AE8DE6B8DB6F99E500@MWHPR21MB0159.namprd21.prod.outlook.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 7 Nov 2017 09:10:38 +0100
Message-ID: <CABdb737aU7U1CsQ0hOVB+6=Nk=Se5EfWrEoUgHQhkKRZbjPheA@mail.gmail.com>
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
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: Mihail Abakumov <mikhail.abakumov@ispras.ru>, "sw@weilnetz.de" <sw@weilnetz.de>, qemu-devel <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Mon, Nov 6, 2017 at 7:41 PM, Andrew Baumann
<Andrew.Baumann@microsoft.com> wrote:
> Hi,
>
> I just noticed this thread, and the problem sounded very familiar...
>
>> From: Ladi Prosek
>> Sent: Monday, 6 November 2017 07:16
> [...]
>> FS base passes all the checks in windbg_on_load() as the guest kernel
>> loads and it returns true. QEMU then sends some data over the pipe.
>> Windbg doesn't print anything, it's still showing:
>>
>>   Opened \\.\pipe\win7_dbg
>>   Waiting to reconnect...
>>
>> Is this expected? In regular remote kernel debugging, windbg produces
>> a bunch of output about the target state when it attaches.
>
> Just a guess, but I suspect the problem you're seeing may be due to the c=
ombination of windbg's tight timing requirements for the serial debug proto=
col and qemu's polling-based implementation of named pipe IO. I ran into th=
is a year or two ago when bringing up raspberry pi... I could never reliabl=
y connect windbg to the emulated serial port using a named pipe. I believe =
the problem is that the named pipe driver relies on receiving input through=
 win_chr_pipe_poll(), which is called too infrequently to satisfy windbg's =
needs (it has a rather short timeout before it gives up and retransmits). T=
he correct fix is to use blocking IO for the named pipes inside qemu, but I=
 know from experience that win32 is awful in this respect -- qemu wants a s=
ingle unified blocking call to wait for IO on any combination of named pipe=
s, sockets, events, etc. and Windows appears to lack this, at least at the =
level of poll/select.

Thanks, I don't usually set up windbg remote debugging over named
pipes so this indeed sounded plausible.

My Windows runs in a QEMU/KVM VM so to eliminate the pipe I have set
up a virtual COM port like so:

-serial tcp:127.0.0.1:8889,server,nowait

and the nested QEMU ran with:

-windbg tcp:10.0.2.2:8889

where 10.0.2.2 is the address assigned to the host with user
networking. Windbg then used the default COM1 to connect to the
target. I routinely use COMx for remote debugging between VMs with a
TCP connection on the host side acting as a null-modem cable and never
had any timing related issues.

However, the symptoms were exactly the same with this set up.

I've also run the original command lines using a pipe on a physical
Windows machine, just in case being in a VM somehow screws it up.
Again, same issue.

At this point I think it would make sense for Mihai to take a look at
the trace in my previous email and maybe compare it with what works
for him.

For completeness, in the unlikely case that it makes a difference, I'm
on Win10 (tried 1511 and 1703) and use windbg that comes with one of
the latest WDK.

Thanks!
Ladi

> My workaround at the time was to kludge up a proxy between sockets and na=
med pipes, so the connection was:
> qemu <-socket-> proxy <-named pipe-> windbg
>
> (The proxy was a fairly flaky python script, but it was good enough to ti=
de me over until I could get kdnet working. I can probably dig it out if yo=
u're interested.)
>
> Cheers,
> Andrew
