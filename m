Received: from eggs.gnu.org ([209.51.188.92]:50140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghk0R-0001WB-Gc
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 18:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghk0Q-0002jI-N9
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 18:44:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ghk0Q-0002iv-HE
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 18:44:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so13280302wrt.11
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 15:44:58 -0800 (PST)
References: <8e67afb3-46b4-9d04-552f-740331165f8f@cisco.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <51071cba-c18f-e491-4d92-6a40130584a7@redhat.com>
Date: Fri, 11 Jan 2019 00:44:54 +0100
MIME-Version: 1.0
In-Reply-To: <8e67afb3-46b4-9d04-552f-740331165f8f@cisco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] KVM serial8250: too much work for irq3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denys Zagorui <dzagorui@cisco.com>, hpa@zytor.com
Cc: qemu-devel@nongnu.org

On 22/09/17 15:28, Denys Zagorui wrote:
> Hello
> 
> This is known issue, it was mentioned at first time about 9 years ago.
> 
> https://lkml.org/lkml/2008/2/5/401
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=986761

The issue is simply that QEMU disregards the baud rate that the guest
programs into the serial port.  H. Peter Anvin's patch, which you
mention, is only a band aid that is geared specifically at avoiding
Linux's error.

It was fixed for real in commit 6936bfe514bbac7af4b24fad9ed9688b78b5be69
by implementing a baud rate timer (May 2008), but then undone in
fcfb4d6aae611d1f804d486d3c998000912c4c81 (March 2013) when the serial
port got flow control support.

Part of the reason may have been laziness, but also there are reasons to
keep it this way.  Basically, the baud rate timer was implemented also
in order to mitigate the problem with losing characters sent by the
guest on the serial console; and thanks to flow control, QEMU will
already slow down the transmit so that the other side never loses
characters.  And because looking at logs on a serial console bps is slow
and mildly annoying even at 115200 bps, it was decided that the "too
much work" error was the lesser evil.

Thanks,

Paolo
