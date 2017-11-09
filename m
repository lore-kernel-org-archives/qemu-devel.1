Received: from eggs.gnu.org ([2001:4830:134:3::10]:36162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eCkPo-0007nV-AX
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eCkPn-0005FS-Jh
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:50:32 -0500
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:44883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eCkPn-0005EZ-E1
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:50:31 -0500
Received: by mail-vk0-x242.google.com with SMTP id x65so3674909vkx.1
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 02:50:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171108225340.10194-1-lepton@google.com>
References: <20170508195404.j33kcmqncrb7fziv@var.youpi.perso.aquilenet.fr>
	<20171108225340.10194-1-lepton@google.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 9 Nov 2017 11:50:29 +0100
Message-ID: <CAJ+F1CK53wNxwixP8M4JgbG4kKgpgu_EdJ6-RyNnevNGQsXmJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: don't zero ti_i since we access it
 later.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tao Wu <lepton@google.com>
Cc: QEMU <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@gnu.org>, maethor@subiron.org

Hi

Adding Guillaume in CC, who wrote that line in commit 98c63057d2144

On Wed, Nov 8, 2017 at 11:53 PM, Tao Wu via Qemu-devel
<qemu-devel@nongnu.org> wrote:
> The current code looks buggy, we zero ti_i while we access
> ti_dst/ti_src later.

Could you described the symptoms and why you fixed it that way?

thanks

>
> Signed-off-by: Tao Wu <lepton@google.com>
> ---
>  slirp/tcp_subr.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
> index dc8b4bbb50..da0d53743f 100644
> --- a/slirp/tcp_subr.c
> +++ b/slirp/tcp_subr.c
> @@ -148,7 +148,16 @@ tcp_respond(struct tcpcb *tp, struct tcpiphdr *ti, s=
truct mbuf *m,
>                 m->m_data +=3D IF_MAXLINKHDR;
>                 *mtod(m, struct tcpiphdr *) =3D *ti;
>                 ti =3D mtod(m, struct tcpiphdr *);
> -               memset(&ti->ti, 0, sizeof(ti->ti));
> +               switch (af) {
> +               case AF_INET:
> +                   ti->ti.ti_i4.ih_x1 =3D 0;
> +                   break;
> +               case AF_INET6:
> +                   ti->ti.ti_i6.ih_x1 =3D 0;
> +                   break;
> +               default:
> +                   g_assert_not_reached();
> +               }
>                 flags =3D TH_ACK;
>         } else {
>                 /*
> --
> 2.15.0.448.gf294e3d99a-goog
>
>



--=20
Marc-Andr=C3=A9 Lureau
