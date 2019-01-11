Received: from eggs.gnu.org ([209.51.188.92]:55768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ghshE-0004EB-5u
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ghsXr-0003UG-52
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:52:04 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ghsXq-0003Tq-Uw
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:52:03 -0500
Received: by mail-wm1-x343.google.com with SMTP id m22so1540695wml.3
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 00:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20190111081909.11896-1-ppandit@redhat.com>
In-Reply-To: <20190111081909.11896-1-ppandit@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 11 Jan 2019 12:51:50 +0400
Message-ID: <CAJ+F1C+VM8KCw3uqphK3PrJ386jABmHDJLe0dySg6T1RVMuZiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: check data length while emulating
 ident function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, Kira <864786842@qq.com>, Prasad J Pandit <pjp@fedoraproject.org>

Hi

On Fri, Jan 11, 2019 at 12:31 PM P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While emulating identification protocol, tcp_emu() does not check
> available space in the 'sc_rcv->sb_data' buffer. It could lead to
> heap buffer overflow issue. Add check to avoid it.
>
> Reported-by: Kira <864786842@qq.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  slirp/tcp_subr.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
> index fa61349cbb..4415801fbb 100644
> --- a/slirp/tcp_subr.c
> +++ b/slirp/tcp_subr.c
> @@ -635,6 +635,11 @@ tcp_emu(struct socket *so, struct mbuf *m)
>                         socklen_t addrlen =3D sizeof(struct sockaddr_in);
>                         struct sbuf *so_rcv =3D &so->so_rcv;
>
> +            if (m->m_len > so_rcv->sb_datalen
> +                            - (so_rcv->sb_wptr - so_rcv->sb_data)) {
> +                m_free(m);
> +                return 0;
> +            }

Check looks correct, it should probably return 1.

Is there a reproducer?

>                         memcpy(so_rcv->sb_wptr, m->m_data, m->m_len);
>                         so_rcv->sb_wptr +=3D m->m_len;
>                         so_rcv->sb_rptr +=3D m->m_len;
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
