Received: from eggs.gnu.org ([2001:4830:134:3::10]:35316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBRYm-0000um-Re
	for qemu-devel@nongnu.org; Thu, 18 May 2017 15:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBRYi-0000UT-VB
	for qemu-devel@nongnu.org; Thu, 18 May 2017 15:58:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dBRYi-0000Si-Oz
	for qemu-devel@nongnu.org; Thu, 18 May 2017 15:58:04 -0400
References: <f0c4de76-77a7-90c4-6a99-10ddda953b19@landley.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c07840b7-29ce-1866-d739-ebe2646a040d@redhat.com>
Date: Thu, 18 May 2017 21:57:59 +0200
MIME-Version: 1.0
In-Reply-To: <f0c4de76-77a7-90c4-6a99-10ddda953b19@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-system-sh4 -M r2d serial is broken.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rob Landley <rob@landley.net>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>



On 18/05/2017 18:08, Rob Landley wrote:
> Serial input hangs after the first character in the 4.11 kernel:
>=20
>   http://www.spinics.net/lists/linux-sh/msg51183.html
>=20
> Because they enabled support for a buffer size thing QEMU doesn't
> emulate right:
>=20
>   http://www.spinics.net/lists/linux-sh/msg51189.html

Hey,

regarding this:

> The really _fun_ thing about this is qemu broke it a couple years back
> and now if you hit ctrl-c it kills the _emulator_ rather than passing i=
t
> through to the Linux console. (Just sh4, the rest do it right.)

Try replacing "-serial stdio" with "-serial mon:stdio".  You'll also be
able to use the QEMU monitor with "Ctrl-a c", so you can quit with
"Ctrl-a c quit <enter>".

> Very likely given how crappy the rest of its serial emulation is for
> this architecture, but ever since qemu added glib support I've stopped
> trying to understand their developers' thought processes.

I'm sure this is going to help you get support, right?

Anyway, Uli Hecht is saying SCIF "asserts DR even if the FIFO threshold
has not been reached if no data is received for 1.5 frames".  If that's
just a register and doesn't trigger an interrupt, you can compute the
bit's value dynamically based on the current clock.

This is for example how the x86 RTC chip computes the "update in
progress" bit, which is set for 220 us before the RC updates.  Doing
that with a timer would be really imprecise.

Paolo
