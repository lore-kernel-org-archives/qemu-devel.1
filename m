Received: from eggs.gnu.org ([209.51.188.92]:58921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gkGKQ-00060H-P2
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 17:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gkGKP-0000Ud-Fc
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 17:40:02 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gkGKP-0000U3-Bn
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 17:40:01 -0500
Received: by mail-qk1-f194.google.com with SMTP id d15so7059319qkj.0
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 14:40:01 -0800 (PST)
MIME-Version: 1.0
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
	<20190117114359.5164-10-marcandre.lureau@redhat.com>
	<c0a4639f-eaf8-868e-f731-6863c480c785@redhat.com>
In-Reply-To: <c0a4639f-eaf8-868e-f731-6863c480c785@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 18 Jan 2019 02:39:49 +0400
Message-ID: <CAMxuvay3-sCeyrn-FJOo4_mtvxPmAh=ACp6rwVnvNpTBTJnTpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/27] slirp: replace qemu_set_nonblock()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, "Bonzini, Paolo" <pbonzini@redhat.com>

Hi

On Thu, Jan 17, 2019 at 9:55 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 1/17/19 5:43 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Replace qemu_set_nonblock() with slirp_set_nonblock()
> >
> > qemu_set_nonblock() does some event registration with the main
> > loop. Add a new callback register_poll_fd() for that reason.
> >
> > Always build the fd-register stub, to avoid #if WIN32.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
>
> > +++ b/slirp/util.c
> > @@ -43,6 +43,18 @@ int inet_aton(const char *cp, struct in_addr *ia)
> >  }
> >  #endif
> >
> > +void slirp_set_nonblock(int fd)
> > +{
> > +#ifndef _WIN32
> > +    int f;
> > +    f =3D fcntl(fd, F_GETFL);
> > +    fcntl(fd, F_SETFL, f | O_NONBLOCK);
>
> No error checking?  Is that wise?

I did a simple c&p from util/oslib-win32.c & util/oslib-posix.c.

Should I add some g_critical() ?

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
