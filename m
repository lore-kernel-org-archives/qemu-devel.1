Received: from eggs.gnu.org ([2001:4830:134:3::10]:47587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dDts7-0000Jl-TT
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dDts6-00018K-Ru
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:36:15 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dDts6-00017l-Gj
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:36:14 -0400
Received: by mail-lf0-x241.google.com with SMTP id m18so13535185lfj.0
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 07:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <1495198042-124203-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495198042-124203-8-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495198042-124203-8-git-send-email-anton.nefedov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 25 May 2017 14:36:02 +0000
Message-ID: <CAJ+F1C+ku_8AmhY_MfS+0eNLU7UEqqwvJd1_5TezhcGUs_hKCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/9] serial: move TIOCM update to a
 separate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>, den@virtuozzo.com

On Fri, May 19, 2017 at 4:55 PM Anton Nefedov <anton.nefedov@virtuozzo.com>
wrote:

> will be used by the following patch
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/char/serial.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index d8d34d0..1e6bdeb 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -312,6 +312,24 @@ static void serial_write_fcr(SerialState *s, uint8_t
> val)
>      }
>  }
>
> +static void serial_update_tiocm(SerialState *s)
> +{
> +    int flags;
> +
> +    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_GET_TIOCM, &flags);
> +
> +    flags &=3D ~(CHR_TIOCM_RTS | CHR_TIOCM_DTR);
> +
> +    if (s->mcr & UART_MCR_RTS) {
> +        flags |=3D CHR_TIOCM_RTS;
> +    }
> +    if (s->mcr & UART_MCR_DTR) {
> +        flags |=3D CHR_TIOCM_DTR;
> +    }
> +
> +    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_TIOCM, &flags);
> +}
> +
>  static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
>                                  unsigned size)
>  {
> @@ -426,24 +444,13 @@ static void serial_ioport_write(void *opaque, hwadd=
r
> addr, uint64_t val,
>          break;
>      case 4:
>          {
> -            int flags;
>              int old_mcr =3D s->mcr;
>              s->mcr =3D val & 0x1f;
>              if (val & UART_MCR_LOOP)
>                  break;
>
>              if (s->poll_msl >=3D 0 && old_mcr !=3D s->mcr) {
> -
> -                qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_GET_TIOCM,
> &flags);
> -
> -                flags &=3D ~(CHR_TIOCM_RTS | CHR_TIOCM_DTR);
> -
> -                if (val & UART_MCR_RTS)
> -                    flags |=3D CHR_TIOCM_RTS;
> -                if (val & UART_MCR_DTR)
> -                    flags |=3D CHR_TIOCM_DTR;
> -
> -                qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_TIOCM,
> &flags);
> +                serial_update_tiocm(s);
>                  /* Update the modem status after a one-character-send
> wait-time, since there may be a response
>                     from the device/computer at the other end of the
> serial line */
>                  timer_mod(s->modem_status_poll,
> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->char_transmit_time);
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
