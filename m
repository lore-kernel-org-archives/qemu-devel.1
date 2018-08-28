Received: from eggs.gnu.org ([2001:4830:134:3::10]:43674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fuV3b-0005As-US
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fuV3Y-0006My-E5
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:52:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57784 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fuV3Y-0006Mi-7s
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:52:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B81940241EE
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 03:52:39 +0000 (UTC)
Date: Tue, 28 Aug 2018 11:52:32 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180828035232.GD4446@xz-x1>
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
	<20180827222322.26009-7-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180827222322.26009-7-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/9] terminal3270: do not use backend timer
 sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com

On Tue, Aug 28, 2018 at 12:23:19AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> terminal3270 is uses the front-end side of the chardev. It shouldn't
> create sources from backend side context. Fwiw, send_timing_mark_cb
> calls qemu_chr_fe_write_all() which should be thread safe.
>=20
> This partially reverts changes from commit
> 2c716ba1506769c9be2caa02f0f6d6e7c00f4304.

I don't fully understand too on why "It shouldn't create sources from
backend side context".  Could you explain a bit?

If you don't want the backend gcontext to be exposed to the frontend,
IMHO the simplest thing is just to use the NULL gcontext in
qemu_chr_timeout_add_ms() which is a one-liner change. I don't see
much point on re-using the GSource tags since IMHO GSource pointer is
always superior to the old tag system.

>=20
> CC: Peter Xu <peterx@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/terminal3270.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
> index e9c45e55b1..35b079d5c4 100644
> --- a/hw/char/terminal3270.c
> +++ b/hw/char/terminal3270.c
> @@ -31,7 +31,7 @@ typedef struct Terminal3270 {
>      uint8_t outv[OUTPUT_BUFFER_SIZE];
>      int in_len;
>      bool handshake_done;
> -    GSource *timer_src;
> +    guint timer_tag;
>  } Terminal3270;
> =20
>  #define TYPE_TERMINAL_3270 "x-terminal3270"
> @@ -47,10 +47,9 @@ static int terminal_can_read(void *opaque)
> =20
>  static void terminal_timer_cancel(Terminal3270 *t)
>  {
> -    if (t->timer_src) {
> -        g_source_destroy(t->timer_src);
> -        g_source_unref(t->timer_src);
> -        t->timer_src =3D NULL;
> +    if (t->timer_tag) {
> +        g_source_remove(t->timer_tag);
> +        t->timer_tag =3D 0;
>      }
>  }
> =20
> @@ -100,8 +99,7 @@ static void terminal_read(void *opaque, const uint8_=
t *buf, int size)
>      assert(size <=3D (INPUT_BUFFER_SIZE - t->in_len));
> =20
>      terminal_timer_cancel(t);
> -    t->timer_src =3D qemu_chr_timeout_add_ms(t->chr.chr, 600 * 1000,
> -                                           send_timing_mark_cb, t);
> +    t->timer_tag =3D g_timeout_add_seconds(600, send_timing_mark_cb, t=
);
>      memcpy(&t->inv[t->in_len], buf, size);
>      t->in_len +=3D size;
>      if (t->in_len < 2) {
> @@ -160,8 +158,7 @@ static void chr_event(void *opaque, int event)
>           * char-socket.c. Once qemu receives the terminal-type of the
>           * client, mark handshake done and trigger everything rolling =
again.
>           */
> -        t->timer_src =3D qemu_chr_timeout_add_ms(t->chr.chr, 600 * 100=
0,
> -                                               send_timing_mark_cb, t)=
;
> +        t->timer_tag =3D g_timeout_add_seconds(600, send_timing_mark_c=
b, t);
>          break;
>      case CHR_EVENT_CLOSED:
>          sch->curr_status.scsw.dstat =3D SCSW_DSTAT_DEVICE_END;
> --=20
> 2.18.0.547.g1d89318c48
>=20

Regards,

--=20
Peter Xu
