Received: from eggs.gnu.org ([2001:4830:134:3::10]:36643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqeWA-0000cp-K5
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqeW5-0003QO-NW
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:33:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cqeW5-0003Q0-HW
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:33:25 -0400
References: <CAJy91CY1SOwi7D-kyU0ooe5SyhM414WaBCedXuPfXXhJpbo1fg@mail.gmail.com>
	<CAFEAcA_etsFstPtUzs0AZjWD35MhMLhwru0ibJzS_upgE-nsng@mail.gmail.com>
	<CAJy91CZmqEUXLKjRJ0JdUEf83E3FwE_24qmej-4C8uAGQkTPWA@mail.gmail.com>
	<CAFEAcA-mzO7vniDEaZeueVFQ7+MVBB7pnzHhahv2Yk_f3q0mJw@mail.gmail.com>
	<CAJy91CZ4Ed-HGHLkzEc1dqQbo32d-eTE1S1ovO_ZwkDdTpkQXQ@mail.gmail.com>
	<CAJy91CaCV40FgSP55qWZeZgkQ=2+E8Cr7xdbu9pn5HLEo+6JJQ@mail.gmail.com>
	<CAJy91CYEwOVT7oEdYY=21__c2kcLTyxyjAaq7Zx4VnQdeLdQQQ@mail.gmail.com>
	<CAFEAcA_t9iLude4Vu3Zc=_wcXMTtFb4Q4oJ8O+zLAJ9isAPqHQ@mail.gmail.com>
	<1322109813.6444955.1490172025040.JavaMail.zimbra@redhat.com>
	<CAFEAcA9zd_gXZjY2fnHdK-7XbKFTj-UDtpWq6A9h6ApERysu=Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5917da98-e569-47e8-016d-6cfb6e8c6958@redhat.com>
Date: Wed, 22 Mar 2017 12:33:22 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9zd_gXZjY2fnHdK-7XbKFTj-UDtpWq6A9h6ApERysu=Q@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jiahuan Zhang <jiahuanzhang90@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>



On 22/03/2017 12:07, Peter Maydell wrote:
> That's not the end that's a problem. Here we know we have
> data available from the Windows end to read, we just
> can't feed it to the QEMU UART model yet because the
> UART model is saying "my FIFO is full, try later".
> We should be able to handle that. (I couldn't figure
> out how it works for the socket code either.)

On every iteration of the glib main loop, tcp_chr_read_poll returns zero
and io_watch_poll_prepare removes any previously created QIOChannel
event source for the file descriptor

When hw/char/pl011.c has free space in the FIFO tcp_chr_read_poll
returns nonzero, io_watch_poll_prepare adds again the QIOChannel event
source, the event source calls tcp_chr_read which reads from the socket
and passes the data to the PL011.

qemu_chr_fe_accept_input is only needed to force another call to
tcp_chr_read_poll.

Paolo
