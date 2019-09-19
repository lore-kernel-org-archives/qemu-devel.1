Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E52C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D63E21907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1Arg1Pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D63E21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAsE8-0002AL-9u
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 04:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iArxC-0006y4-PS
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iArx9-0000kS-T5
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:38:18 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51873)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iArx9-0000k8-ID
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:38:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id 7so3360015wme.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 01:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hbpjwhBdtoVU8SA9mwOe74dD4BOakH8+YJre8ZxtMJU=;
 b=r1Arg1PainBx+6b2KNFfxRAoVaxx4gfoyrLOG3Gdi4erkfM4BAX+UedrrN+Nd28s2H
 PSY/rAG6aQSbCqEsV/l94H613d3O2ODMJ2USrtgj21wXSzJ+mvh7OYD+QQ3o4Y/fP9Md
 1Wln48oepD0gDPI2ePOMxUckDFxJB0VrPugANS9qpS+jZ0BZX3ui12bnylBjl66sEbvB
 zwPpgZj56ZEOccbVZaR7Jt/ghavhvBg1KCeAPrMdNNJJM6LvKZlqIylXe6+6u8U5DSYt
 ILjkzQlUwk3TqOw3yNigfIjUPDjzdCWwObp+JmabxKMDBY/RVHs/5AC1ocJZU4daL2bH
 shwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hbpjwhBdtoVU8SA9mwOe74dD4BOakH8+YJre8ZxtMJU=;
 b=YTAirRCke1uj9xU+D9bFb2dOAFI0q+Vla8tKxlnTTKq+TI7F5NM6IrNWfflYCVd6Vr
 95VjF8gsIvTCbHX/V0fX0wT3EtP8aaska9EUj7eGrSe47D59QFFlJjDElgQLh/C3dFNq
 TTQaoVdsyR0gYFsFeiLOKpZMZMwsso1Pw0aPoBIJi7PXrSnG/5OXRgbje8vtiIK3RUHR
 6UsFYQUpSvS5mRqb/7sAcHy+edshy9pdh8t16hU0PO8UEFvprthPLMIo1qS3vc4dtkoS
 a4aDR1FVw/vBo45B5LHwI+N9ug5Tc1sm6zsP6/QthRq4hgeebF1p1jZskRUKHeOMeBb6
 vk4A==
X-Gm-Message-State: APjAAAW4IGw/oIKBgdD39GQ+XcoBdYHnp7eILD9IL3yT3HF/scRt7jtl
 rtkV7pFE4HyIcWmUweWPFrfwACNllhJ7RTc/I6U=
X-Google-Smtp-Source: APXvYqxNgfIcMBiHR3ujDalUlaKFKocrllskvgaeZEk0CVHVa6c7zLt6dpOzpD0JT/ktB950r77yxQtA/nWkxXFU7eI=
X-Received: by 2002:a1c:9615:: with SMTP id y21mr1784359wmd.5.1568882293703;
 Thu, 19 Sep 2019 01:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190917213241.2276-1-tnt@246tNt.com>
In-Reply-To: <20190917213241.2276-1-tnt@246tNt.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 19 Sep 2019 12:38:00 +0400
Message-ID: <CAJ+F1CJvstUeS21L9fxKxRe5d+1FPGNznGynwZP9P7t-WrwPNg@mail.gmail.com>
To: Sylvain Munaut <tnt@246tnt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] chardev: Add RFC2217 support for telnet
 client mode
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sylvain

On Wed, Sep 18, 2019 at 5:05 AM Sylvain Munaut <tnt@246tnt.com> wrote:
>
> This allow remote control of the baudrate and other comms
> parameters.
>
> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
> ---
>  chardev/char-socket.c | 232 ++++++++++++++++++++++++++++++++++--------
>  chardev/char.c        |   6 ++
>  qapi/char.json        |   3 +
>  3 files changed, 201 insertions(+), 40 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 185fe38dda..47e04357a0 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -36,6 +36,7 @@
>  #include "qapi/qapi-visit-sockets.h"
>
>  #include "chardev/char-io.h"
> +#include "chardev/char-serial.h"
>
>  /***********************************************************/
>  /* TCP Net console */
> @@ -74,6 +75,7 @@ typedef struct {
>      bool is_listen;
>      bool is_telnet;
>      bool is_tn3270;
> +    bool is_rfc2217;
>      GSource *telnet_source;
>      TCPChardevTelnetInit *telnet_init;
>
> @@ -152,8 +154,8 @@ static void tcp_chr_accept(QIONetListener *listener,
>  static int tcp_chr_read_poll(void *opaque);
>  static void tcp_chr_disconnect_locked(Chardev *chr);
>
> -/* Called with chr_write_lock held.  */
> -static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
> +/* Must be called with chr_write_lock held.  */
> +static int tcp_chr_write_raw(Chardev *chr, const uint8_t *buf, int len)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
>
> @@ -186,6 +188,45 @@ static int tcp_chr_write(Chardev *chr, const uint8_t=
 *buf, int len)
>      }
>  }
>
> +/* Must be called with chr_write_lock held.  */
> +static int tcp_chr_write_telnet(Chardev *chr, const uint8_t *buf, int le=
n)
> +{
> +    const uint8_t buf_esc[] =3D { IAC, IAC };
> +    int wlen =3D 0;
> +
> +    /* Send chunks between IAC bytes */
> +    while (len) {
> +        uint8_t *end =3D memchr(buf, IAC, len);
> +        int clen =3D end ? (end - buf) : len;
> +
> +        if (clen) {
> +            wlen +=3D tcp_chr_write_raw(chr, buf, clen);
> +            buf +=3D clen;
> +            len -=3D clen;
> +        }
> +
> +        if (end) {
> +            wlen +=3D tcp_chr_write_raw(chr, buf_esc, 2);

Can you enlight me, why do you need to double the IAC bytes?

> +            buf +=3D 1;
> +            len -=3D 1;
> +        }
> +    }
> +
> +    return wlen;
> +}
> +
> +/* Called with chr_write_lock held.  */
> +static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
> +{
> +    SocketChardev *s =3D SOCKET_CHARDEV(chr);
> +
> +    if (s->do_telnetopt) {
> +        return tcp_chr_write_telnet(chr, buf, len);
> +    } else {
> +        return tcp_chr_write_raw(chr, buf, len);
> +    }
> +}
> +
>  static int tcp_chr_read_poll(void *opaque)
>  {
>      Chardev *chr =3D CHARDEV(opaque);
> @@ -222,37 +263,74 @@ static void tcp_chr_process_IAC_bytes(Chardev *chr,
>      int j =3D 0;
>
>      for (i =3D 0; i < *size; i++) {
> -        if (s->do_telnetopt > 1) {
> -            if ((unsigned char)buf[i] =3D=3D IAC && s->do_telnetopt =3D=
=3D 2) {
> +        if (s->do_telnetopt =3D=3D 2) {
> +            /* Generic options */
> +            if ((unsigned char)buf[i] =3D=3D IAC) {
>                  /* Double IAC means send an IAC */
>                  if (j !=3D i) {
>                      buf[j] =3D buf[i];
>                  }
>                  j++;
>                  s->do_telnetopt =3D 1;
> -            } else {
> -                if ((unsigned char)buf[i] =3D=3D IAC_BREAK
> -                    && s->do_telnetopt =3D=3D 2) {
> -                    /* Handle IAC break commands by sending a serial bre=
ak */
> -                    qemu_chr_be_event(chr, CHR_EVENT_BREAK);
> -                    s->do_telnetopt++;
> -                } else if (s->is_tn3270 && ((unsigned char)buf[i] =3D=3D=
 IAC_EOR
> -                           || (unsigned char)buf[i] =3D=3D IAC_SB
> -                           || (unsigned char)buf[i] =3D=3D IAC_SE)
> -                           && s->do_telnetopt =3D=3D 2) {
> +            } else if ((unsigned char)buf[i] =3D=3D IAC_BREAK) {
> +                /* Handle IAC break commands by sending a serial break *=
/
> +                qemu_chr_be_event(chr, CHR_EVENT_BREAK);
> +                s->do_telnetopt =3D 1;
> +            } else if (s->is_tn3270) {
> +                /* TN3270 specific */
> +                if ((unsigned char)buf[i] =3D=3D IAC_EOR
> +                 || (unsigned char)buf[i] =3D=3D IAC_SB
> +                 || (unsigned char)buf[i] =3D=3D IAC_SE) {
>                      buf[j++] =3D IAC;
>                      buf[j++] =3D buf[i];
> -                    s->do_telnetopt++;
> -                } else if (s->is_tn3270 && ((unsigned char)buf[i] =3D=3D=
 IAC_IP
> -                           || (unsigned char)buf[i] =3D=3D IAC_NOP)
> -                           && s->do_telnetopt =3D=3D 2) {
> +                    s->do_telnetopt =3D 1;
> +                } else if ((unsigned char)buf[i] =3D=3D IAC_IP
> +                        || (unsigned char)buf[i] =3D=3D IAC_NOP) {
>                      /* TODO: IP and NOP need to be implemented later. */
> -                    s->do_telnetopt++;
> +                    s->do_telnetopt =3D 1;
> +                }
> +            } else if (s->is_rfc2217) {
> +                /* RFC2217 specific */
> +                if ((unsigned char)buf[i] =3D=3D IAC_SE) {
> +                    /* Shouldn't happen but ... */
> +                    s->do_telnetopt =3D 1;
> +                } else if ((unsigned char)buf[i] =3D=3D IAC_SB) {
> +                    s->do_telnetopt =3D 50;
>                  }
> -                s->do_telnetopt++;
>              }
> -            if (s->do_telnetopt >=3D 4) {
> -                s->do_telnetopt =3D 1;

You changed quite fundamentally the logic of the function. Before,
after IAC byte (do_telnet =3D 2), if not other branch handle the
following byte, 2 bytes were dropped. Why that change? Could you try
to make this a seperate patch?

> +        } else if (s->do_telnetopt > 2) {
> +            if (s->is_rfc2217) {
> +                if (s->do_telnetopt > 100) { /* Skip mode */
> +                    s->do_telnetopt--;
> +                } else if (s->do_telnetopt =3D=3D 50) { /* Post-SB */
> +                    if ((unsigned char)buf[i] =3D=3D 0x2c) {
> +                        /* This is a COM-Port-Option, look at next byte =
*/
> +                        s->do_telnetopt =3D 51;
> +                    } else {
> +                        /*
> +                         * Unknown option, just skip 1 and wait for IAC =
SE and
> +                         * hope it doesn't happen in the option stream
> +                         */
> +                        s->do_telnetopt =3D 101;
> +                    }
> +                } else if (s->do_telnetopt =3D=3D 51) { /* SB Options */
> +                    /*
> +                     * Skip 4 next bytes if this is baudrate option,
> +                     * else skip 1 byte
> +                     */
> +                    s->do_telnetopt =3D (buf[i] =3D=3D 0x65) ? 104 : 101=
;
> +                } else if (s->do_telnetopt =3D=3D 100) { /* Wait for IAC=
 */
> +                    if ((unsigned char)buf[i] =3D=3D IAC) {
> +                        s->do_telnetopt =3D 99;
> +                    }
> +                } else if (s->do_telnetopt =3D=3D 99) { /* Wait for SE *=
/
> +                    if ((unsigned char)buf[i] =3D=3D IAC_SE)
> +                        s->do_telnetopt =3D 1;
> +                    else if ((unsigned char)buf[i] =3D=3D IAC)
> +                        s->do_telnetopt =3D 99;
> +                    else
> +                        s->do_telnetopt =3D 100;

Must be braced to conform to qemu coding style.

Overall, looks ok to me, but the lack of test is annoying. Could you
write some in tests/test-char.c?


> +                }
>              }
>          } else {
>              if ((unsigned char)buf[i] =3D=3D IAC) {
> @@ -558,6 +636,57 @@ static int tcp_chr_sync_read(Chardev *chr, const uin=
t8_t *buf, int len)
>      return size;
>  }
>
> +static int tcp_chr_ioctl(Chardev *chr, int cmd, void *arg)
> +{
> +    SocketChardev *s =3D SOCKET_CHARDEV(chr);
> +
> +    if (s->is_rfc2217 =3D=3D 0) {
> +        return -ENOTSUP;
> +

I have a preference for "if (!s->is_rfc2217)"

> +    if (s->state !=3D TCP_CHARDEV_STATE_CONNECTED) {
> +        return 0;
> +    }

You could drop that check, since tcp_chr_write_raw() handles it too.

> +
> +    switch (cmd) {
> +    case CHR_IOCTL_SERIAL_SET_PARAMS:
> +        {
> +            QEMUSerialSetParams *ssp =3D arg;
> +            const uint8_t buf[] =3D {
> +                /* IAC SB COM-PORT-OPTION SET-BAUD <value(4)> IAC SE */
> +                0xff, 0xfa, 0x2c, 0x01,
> +                (ssp->speed >> 24) & 0xff,
> +                (ssp->speed >> 16) & 0xff,
> +                (ssp->speed >>  8) & 0xff,
> +                (ssp->speed >>  0) & 0xff,
> +                0xff, 0xf0,
> +
> +                /* IAC SB COM-PORT-OPTION SET-DATASIZE <value> IAC SE */
> +                0xff, 0xfa, 0x2c, 0x02,
> +                ssp->data_bits,
> +                0xff, 0xf0,
> +
> +                /* IAC SB COM-PORT-OPTION SET-PARITY <value> IAC SE */
> +                0xff, 0xfa, 0x2c, 0x03,
> +                (ssp->parity =3D=3D 'O') ? 2 : (ssp->parity =3D=3D 'E' ?=
 3 : 1),
> +                0xff, 0xf0,
> +
> +                /* IAC SB COM-PORT-OPTION SET-STOPSIZE <value> IAC SE */
> +                0xff, 0xfa, 0x2c, 0x04,
> +                ssp->stop_bits,
> +                0xff, 0xf0,
> +            };
> +
> +            qemu_mutex_lock(&chr->chr_write_lock);
> +            tcp_chr_write_raw(chr, buf, sizeof(buf));
> +            qemu_mutex_unlock(&chr->chr_write_lock);
> +        }
> +        break;
> +    default:
> +        return -ENOTSUP;
> +    }
> +    return 0;
> +}
> +
>  static char *qemu_chr_compute_filename(SocketChardev *s)
>  {
>      struct sockaddr_storage *ss =3D &s->sioc->localAddr;
> @@ -722,16 +851,7 @@ static void tcp_chr_telnet_init(Chardev *chr)
>          x[n++] =3D c;                             \
>      } while (0)
>
> -    if (!s->is_tn3270) {
> -        init->buflen =3D 12;
> -        /* Prep the telnet negotion to put telnet in binary,
> -         * no echo, single char mode */
> -        IACSET(init->buf, 0xff, 0xfb, 0x01);  /* IAC WILL ECHO */
> -        IACSET(init->buf, 0xff, 0xfb, 0x03);  /* IAC WILL Suppress go ah=
ead */
> -        IACSET(init->buf, 0xff, 0xfb, 0x00);  /* IAC WILL Binary */
> -        IACSET(init->buf, 0xff, 0xfd, 0x00);  /* IAC DO Binary */
> -    } else {
> -        init->buflen =3D 21;
> +    if (s->is_tn3270) {
>          /* Prep the TN3270 negotion based on RFC1576 */
>          IACSET(init->buf, 0xff, 0xfd, 0x19);  /* IAC DO EOR */
>          IACSET(init->buf, 0xff, 0xfb, 0x19);  /* IAC WILL EOR */
> @@ -740,6 +860,30 @@ static void tcp_chr_telnet_init(Chardev *chr)
>          IACSET(init->buf, 0xff, 0xfd, 0x18);  /* IAC DO TERMINAL TYPE */
>          IACSET(init->buf, 0xff, 0xfa, 0x18);  /* IAC SB TERMINAL TYPE */
>          IACSET(init->buf, 0x01, 0xff, 0xf0);  /* SEND IAC SE */
> +        init->buflen =3D n;
> +    } else if (s->is_rfc2217) {
> +        /*
> +         * Prep the telnet negotion to put telnet in binary,
> +         * no echo, single char mode with COM port options
> +         */
> +        IACSET(init->buf, 0xff, 0xfb, 0x00);  /* IAC WILL Binary */
> +        IACSET(init->buf, 0xff, 0xfd, 0x00);  /* IAC DO Binary */
> +        IACSET(init->buf, 0xff, 0xfc, 0x01);  /* IAC WON'T ECHO */
> +        IACSET(init->buf, 0xff, 0xfe, 0x01);  /* IAC DON'T ECHO */
> +        IACSET(init->buf, 0xff, 0xfb, 0x03);  /* IAC WILL Suppress go ah=
ead */
> +        IACSET(init->buf, 0xff, 0xfd, 0x03);  /* IAC DO Suppress go ahea=
d */
> +        IACSET(init->buf, 0xff, 0xfb, 0x2c);  /* IAC WILL COM-Port-Optio=
n */
> +        init->buflen =3D n;
> +    } else {
> +        /*
> +         * Prep the telnet negotion to put telnet in binary,
> +         * no echo, single char mode
> +         */
> +        IACSET(init->buf, 0xff, 0xfb, 0x01);  /* IAC WILL ECHO */
> +        IACSET(init->buf, 0xff, 0xfb, 0x03);  /* IAC WILL Suppress go ah=
ead */
> +        IACSET(init->buf, 0xff, 0xfb, 0x00);  /* IAC WILL Binary */
> +        IACSET(init->buf, 0xff, 0xfd, 0x00);  /* IAC DO Binary */
> +        init->buflen =3D n;
>      }

Preliminary code move with buflen code change, could be done in a
seperate patch.

>
>  #undef IACSET
> @@ -964,8 +1108,12 @@ static void tcp_chr_accept_server_sync(Chardev *chr=
)
>  static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
> -    const char *opts[] =3D { "telnet", "tn3270", "websock", "tls-creds" =
};
> -    bool optset[] =3D { s->is_telnet, s->is_tn3270, s->is_websock, s->tl=
s_creds };
> +    const char *opts[] =3D {
> +        "telnet", "tn3270", "rfc2217", "websock", "tls-creds"
> +    };
> +    bool optset[] =3D {
> +        s->is_telnet, s->is_tn3270, s->is_rfc2217, s->is_websock, s->tls=
_creds
> +    };
>      size_t i;
>
>      QEMU_BUILD_BUG_ON(G_N_ELEMENTS(opts) !=3D G_N_ELEMENTS(optset));
> @@ -1155,15 +1303,11 @@ static gboolean socket_reconnect_timeout(gpointer=
 opaque)
>
>
>  static int qmp_chardev_open_socket_server(Chardev *chr,
> -                                          bool is_telnet,
>                                            bool is_waitconnect,
>                                            Error **errp)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
>      char *name;
> -    if (is_telnet) {
> -        s->do_telnetopt =3D 1;
> -    }
>      s->listener =3D qio_net_listener_new();
>
>      name =3D g_strdup_printf("chardev-tcp-listener-%s", chr->label);
> @@ -1300,6 +1444,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>      bool is_listen      =3D sock->has_server  ? sock->server  : true;
>      bool is_telnet      =3D sock->has_telnet  ? sock->telnet  : false;
>      bool is_tn3270      =3D sock->has_tn3270  ? sock->tn3270  : false;
> +    bool is_rfc2217     =3D sock->has_rfc2217 ? sock->rfc2217 : false;
>      bool is_waitconnect =3D sock->has_wait    ? sock->wait    : false;
>      bool is_websock     =3D sock->has_websocket ? sock->websocket : fals=
e;
>      int64_t reconnect   =3D sock->has_reconnect ? sock->reconnect : 0;
> @@ -1308,6 +1453,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>      s->is_listen =3D is_listen;
>      s->is_telnet =3D is_telnet;
>      s->is_tn3270 =3D is_tn3270;
> +    s->is_rfc2217 =3D is_rfc2217;
>      s->is_websock =3D is_websock;
>      s->do_nodelay =3D do_nodelay;
>      if (sock->tls_creds) {

I think this deserves some checks in qmp_chardev_validate_socket().

It seems we are lacking them for telnet/tn3270, it's probably not too
late to add them.

Feel free to do that in a separate patch too.


> @@ -1361,9 +1507,12 @@ static void qmp_chardev_open_socket(Chardev *chr,
>
>      update_disconnected_filename(s);
>
> +    if (s->is_listen ? (is_telnet || is_tn3270) : is_rfc2217) {
> +        s->do_telnetopt =3D 1;
> +    }
> +
>      if (s->is_listen) {
> -        if (qmp_chardev_open_socket_server(chr, is_telnet || is_tn3270,
> -                                           is_waitconnect, errp) < 0) {
> +        if (qmp_chardev_open_socket_server(chr, is_waitconnect, errp) < =
0) {
>              return;
>          }
>      } else {
> @@ -1410,6 +1559,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,
>      sock->telnet =3D qemu_opt_get_bool(opts, "telnet", false);
>      sock->has_tn3270 =3D qemu_opt_get(opts, "tn3270");
>      sock->tn3270 =3D qemu_opt_get_bool(opts, "tn3270", false);
> +    sock->has_rfc2217 =3D qemu_opt_get(opts, "rfc2217");
> +    sock->rfc2217 =3D qemu_opt_get_bool(opts, "rfc2217", false);
>      sock->has_websocket =3D qemu_opt_get(opts, "websocket");
>      sock->websocket =3D qemu_opt_get_bool(opts, "websocket", false);
>      /*
> @@ -1480,6 +1631,7 @@ static void char_socket_class_init(ObjectClass *oc,=
 void *data)
>      cc->chr_wait_connected =3D tcp_chr_wait_connected;
>      cc->chr_write =3D tcp_chr_write;
>      cc->chr_sync_read =3D tcp_chr_sync_read;
> +    cc->chr_ioctl =3D tcp_chr_ioctl;
>      cc->chr_disconnect =3D tcp_chr_disconnect;
>      cc->get_msgfds =3D tcp_get_msgfds;
>      cc->set_msgfds =3D tcp_set_msgfds;
> diff --git a/chardev/char.c b/chardev/char.c
> index 7b6b2cb123..b101641784 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -423,6 +423,7 @@ QemuOpts *qemu_chr_parse_compat(const char *label, co=
nst char *filename,
>      if (strstart(filename, "tcp:", &p) ||
>          strstart(filename, "telnet:", &p) ||
>          strstart(filename, "tn3270:", &p) ||
> +        strstart(filename, "rfc2217:", &p) ||
>          strstart(filename, "websocket:", &p)) {
>          if (sscanf(p, "%64[^:]:%32[^,]%n", host, port, &pos) < 2) {
>              host[0] =3D 0;
> @@ -443,6 +444,8 @@ QemuOpts *qemu_chr_parse_compat(const char *label, co=
nst char *filename,
>              qemu_opt_set(opts, "telnet", "on", &error_abort);
>          } else if (strstart(filename, "tn3270:", &p)) {
>              qemu_opt_set(opts, "tn3270", "on", &error_abort);
> +        } else if (strstart(filename, "rfc2217:", &p)) {
> +            qemu_opt_set(opts, "rfc2217", "on", &error_abort);
>          } else if (strstart(filename, "websocket:", &p)) {
>              qemu_opt_set(opts, "websocket", "on", &error_abort);
>          }
> @@ -879,6 +882,9 @@ QemuOptsList qemu_chardev_opts =3D {
>          },{
>              .name =3D "tn3270",
>              .type =3D QEMU_OPT_BOOL,
> +        },{
> +            .name =3D "rfc2217",
> +            .type =3D QEMU_OPT_BOOL,
>          },{
>              .name =3D "tls-creds",
>              .type =3D QEMU_OPT_STRING,
> diff --git a/qapi/char.json b/qapi/char.json
> index a6e81ac7bc..4a6b50bc3e 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -261,6 +261,8 @@
>  #          sockets (default: false)
>  # @tn3270: enable tn3270 protocol on server
>  #          sockets (default: false) (Since: 2.10)
> +# @rfc2217: enable RFC2217 protocol on client
> +#          sockets (default: false) (Since: ???)
>  # @websocket: enable websocket protocol on server
>  #           sockets (default: false) (Since: 3.1)
>  # @reconnect: For a client socket, if a socket is disconnected,
> @@ -279,6 +281,7 @@
>              '*nodelay': 'bool',
>              '*telnet': 'bool',
>              '*tn3270': 'bool',
> +            '*rfc2217': 'bool',
>              '*websocket': 'bool',
>              '*reconnect': 'int' },
>    'base': 'ChardevCommon' }
> --
> 2.21.0
>
>

thanks

--=20
Marc-Andr=C3=A9 Lureau

