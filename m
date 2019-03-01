Received: from eggs.gnu.org ([209.51.188.92]:48667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <llyzs.vic@gmail.com>) id 1gzZlw-0004xl-M3
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 23:27:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <llyzs.vic@gmail.com>) id 1gzZlv-00025p-RO
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 23:27:44 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:44206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <llyzs.vic@gmail.com>) id 1gzZlv-00025S-M4
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 23:27:43 -0500
Received: by mail-io1-xd41.google.com with SMTP id y13so18535011iop.11
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 20:27:43 -0800 (PST)
MIME-Version: 1.0
References: <CACxphuFGAODB_=X1fVFqJa=U14E_YSJMreWJcOgzdsooke1wxg@mail.gmail.com>
	<20190228205109.hmldtldbnlw3pnqq@function>
In-Reply-To: <20190228205109.hmldtldbnlw3pnqq@function>
From: llyzs <llyzs.vic@gmail.com>
Date: Fri, 1 Mar 2019 12:27:31 +0800
Message-ID: <CACxphuHr-Eo6JoPzZWvaZ_29GjxRzP=saWUKCKQxTuBa8qC9mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] socket: fix blocking udp recvfrom.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>

Hi,

I believe this is because UDP packet can have 0 length payload. I
quote some resources here:
https://stackoverflow.com/questions/12505892/under-linux-can-recv-ever-retu=
rn-0-on-udp
https://stackoverflow.com/questions/5307031/how-to-detect-receipt-of-a-0-le=
ngth-udp-datagram

I also found out that sometimes ioctlsocket() call can return error
(probably caused by my unstable wifi linux driver), in which case we
can also return immediately.

I will submit a new version of the patch according to your suggestions.

On Fri, 1 Mar 2019 at 04:51, Samuel Thibault <samuel.thibault@gnu.org> wrot=
e:
>
> Hello,
>
> llyzs, le jeu. 28 f=C3=A9vr. 2019 19:59:12 +0800, a ecrit:
> > Sometimes sorecvfrom() is called from slirp.c because revents =3D=3D G_=
IO_IN,
> > however inside sorecvfrom() function, ioctlsocket() returns 0 bytes ava=
ilable
> > and recvfrom could be blocking indefinitely. This adds a non-blocking f=
lag to
> > recvfrom and checks data availability.
>
> When ioctlsocket() returns 0 bytes available, we could as well just
> immediately return, without even calling recvfrom. We could just move
> that ioctlsocket call above the m_get() call, so we can just return
> without having to clean up anything.
>
> This however still looks weird. AFAIK, G_IO_IN means that we can make
> one recv call and be sure that it won't block. Do you have an idea why
> it wouldn't necessarily be the case?
>
> Samuel
