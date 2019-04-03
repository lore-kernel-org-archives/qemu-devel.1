Received: from eggs.gnu.org ([209.51.188.92]:52625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hBfwL-00033E-Bf
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 09:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hBfwK-0002wg-63
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 09:28:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1hBfwJ-0002vv-U2
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 09:28:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so21335194wre.7
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 06:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190403121620.5228-1-philmd@redhat.com>
	<20190403122328.GQ25150@redhat.com>
In-Reply-To: <20190403122328.GQ25150@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Wed, 3 Apr 2019 15:28:14 +0200
Message-ID: <CAP+75-UwjDEciweEeAdxYUw_gZFjjSxXkyBX_oq_RCE+Axm4Hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sockets: Fix stringop-truncation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Wed, Apr 3, 2019 at 2:23 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> On Wed, Apr 03, 2019 at 02:16:20PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Compiling with clang-8 fails with:
> >
> >     CC      util/qemu-sockets.o
> >   util/qemu-sockets.c: In function 'unix_connect_saddr':
> >   util/qemu-sockets.c:925:5: error: 'strncpy' specified bound 108 equal=
s destination size [-Werror=3Dstringop-truncation]
> >        strncpy(un.sun_path, saddr->path, sizeof(un.sun_path));
> >        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   util/qemu-sockets.c: In function 'unix_listen_saddr':
> >   util/qemu-sockets.c:880:5: error: 'strncpy' specified bound 108 equal=
s destination size [-Werror=3Dstringop-truncation]
> >        strncpy(un.sun_path, path, sizeof(un.sun_path));
> >        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Per the unix socket manpage:
> >
> >   UNIX(7)
> >
> >   Pathname sockets
> >   When binding a socket to a pathname, a few rules should be observed f=
or maximum portability and ease of coding:
> >   *  The pathname in sun_path should be null-terminated.
> >   *  The length of the pathname, including the terminating null byte, s=
hould not exceed the size of sun_path.
> >
> > Reduce the length of the unix socket path by 1 to hold the NUL byte.
>
> Note it just says "should", not "must" here. IOW, there is no requirement
> to NUL terminate and so we should not artifically require that at QEMU
> level either. If mgmt apps want to have NUL termination then they can
> just pass a shorter path to QEMU to start with.
>
> I've proposed the fix for the warning you mention here:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07759.html

Oh I missed it, thanks for pointing it.

Regards,

Phil.
