Received: from eggs.gnu.org ([209.51.188.92]:55116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkXn0-0003nw-Pc
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkXmy-000635-OK
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:18:42 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:42761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkXmu-0005zT-TG
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:18:38 -0500
Received: by mail-oi1-x22d.google.com with SMTP id w13so9508227oiw.9
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:18:35 -0800 (PST)
MIME-Version: 1.0
References: <153994006052.15678.15962440455123359491.malonedeb@gac.canonical.com>
In-Reply-To: <153994006052.15678.15962440455123359491.malonedeb@gac.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 17:18:23 +0000
Message-ID: <CAFEAcA9vczSpf+xd+3so1YKAW-d4RKY7iVEtMvJrgSNbRjQ+Zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1798780] [NEW] hw/usb/dev-mtp.c:1616: bad
 test ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1798780 <1798780@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Fri, 19 Oct 2018 at 10:22, dcb <1798780@bugs.launchpad.net> wrote:
> hw/usb/dev-mtp.c:1616:52: warning: logical =E2=80=98or=E2=80=99 of collec=
tively
> exhaustive tests is always true [-Wlogical-op]
>
> Source code is
>
>                 if ((ret =3D=3D -1) && (errno !=3D EINTR || errno !=3D EA=
GAIN ||
>                                     errno !=3D EWOULDBLOCK)) {
>
> Maybe better code
>
>                 if ((ret =3D=3D -1) && (errno !=3D EINTR && errno !=3D EA=
GAIN &&
>                                     errno !=3D EWOULDBLOCK)) {

Hi Gerd, Bandan -- I was going through older launchpad bugs and
noticed that this one about a dubious conditional in dev-mtp.c is
still unfixed.

Is the file descriptor being used here one that's in non-blocking
mode? If so, then busy-waiting in a loop while the write() returns
EWOULDBLOCK is probably not what you wanted. If it's not then
there's no need to check for EAGAIN or EWOULDBLOCK, I think.
Consider using qemu_write_full() instead of open-coding
the retry loop ?

thanks
-- PMM
