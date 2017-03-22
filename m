Received: from eggs.gnu.org ([2001:4830:134:3::10]:56569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqciM-0007MH-S7
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqciH-0006Kh-Si
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:37:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cqciH-0006Ka-M4
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:37:53 -0400
References: <CAJy91CY1SOwi7D-kyU0ooe5SyhM414WaBCedXuPfXXhJpbo1fg@mail.gmail.com>
	<CAFEAcA_etsFstPtUzs0AZjWD35MhMLhwru0ibJzS_upgE-nsng@mail.gmail.com>
	<CAJy91CZmqEUXLKjRJ0JdUEf83E3FwE_24qmej-4C8uAGQkTPWA@mail.gmail.com>
	<CAFEAcA-mzO7vniDEaZeueVFQ7+MVBB7pnzHhahv2Yk_f3q0mJw@mail.gmail.com>
	<CAJy91CZ4Ed-HGHLkzEc1dqQbo32d-eTE1S1ovO_ZwkDdTpkQXQ@mail.gmail.com>
	<CAJy91CaCV40FgSP55qWZeZgkQ=2+E8Cr7xdbu9pn5HLEo+6JJQ@mail.gmail.com>
	<CAJy91CYEwOVT7oEdYY=21__c2kcLTyxyjAaq7Zx4VnQdeLdQQQ@mail.gmail.com>
	<CAFEAcA_t9iLude4Vu3Zc=_wcXMTtFb4Q4oJ8O+zLAJ9isAPqHQ@mail.gmail.com>
	<1322109813.6444955.1490172025040.JavaMail.zimbra@redhat.com>
	<CAJy91CaUxFHJeGLLW4DqK6sBwx2qDnE9s20ZbdT86JDn8yQoHg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <218df442-1a31-e969-32ef-01184fae84c0@redhat.com>
Date: Wed, 22 Mar 2017 10:37:50 +0100
MIME-Version: 1.0
In-Reply-To: <CAJy91CaUxFHJeGLLW4DqK6sBwx2qDnE9s20ZbdT86JDn8yQoHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Guest application reading from pl011 without
 device driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 22/03/2017 09:48, Jiahuan Zhang wrote:
>=20
>=20
> On 22 March 2017 at 09:40, Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> wrote:
>=20
>=20
>     > > I am using a windows named pipe to get the data from a window
>     > > host program, which uses ReadFile () in char_win.c
>     >
>     > OK, bugs in the windows-specific char backend would be
>     > unsurprising.
>     >
>     > I'm not entirely sure how the chardev layer works, but
>     > at the pl011 end if we return 0 from our can_receive
>     > function then the chardev layer should decide it has
>     > nothing to do until the pl011 later calls
>     > qemu_chr_fe_accept_input(), I think.
>     >
>     > I've cc'd Paolo and Marc-Andr=C3=A9 Lureau as the chardev
>     > maintainers.
>=20
>     Windows named pipes do not support the equivalent of "select",
>     so it's possible that they cause a busy wait.  Try using a
>     TCP socket instead and see if the bug goes away.
>=20
>=20
> Hi, I am trying to use a Windows socket for serial redirection instead
> of Windows named pipe.
> What do you mean "the equivalent of 'select'"?

A function that lets a process sleep until data is available on the
socket.  The solution is to rewrite Windows chardev handling in QEMU to
use threads or overlapped I/O.

Paolo
