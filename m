Received: from eggs.gnu.org ([2001:4830:134:3::10]:42553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdzdo-0007X9-Mf
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 11:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdzdl-0004RY-Dz
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 11:05:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33742 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fdzdl-0004QO-8s
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 11:05:49 -0400
References: <1528185295-14199-1-git-send-email-slp@redhat.com>
	<4e35ea24-147d-1b51-fa1b-0f1cc32966e0@redhat.com>
	<20180710154800.7ea50b73@redhat.com>
	<CAJ+F1CJVQn5zucYgn9dUFOu76MZkqd2Vaep52c89AORWF=sOrA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <05a2f530-3be5-cb18-60c8-ee9f9c7c688a@redhat.com>
Date: Fri, 13 Jul 2018 17:05:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJVQn5zucYgn9dUFOu76MZkqd2Vaep52c89AORWF=sOrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/char/serial: Only retry if
 qemu_chr_fe_write returns 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>

On 13/07/2018 16:55, Marc-Andr=C3=A9 Lureau wrote:
> -                return;
> +        } else {
> +            int rc =3D qemu_chr_fe_write(&s->chr, &s->tsr, 1);
> +
> +            if ((rc =3D=3D 0 ||
> +                 (rc =3D=3D -1 && (errno =3D=3D EAGAIN || errno =3D=3D=
 EINTR))) &&
> +                s->tsr_retry < MAX_XMIT_RETRY) {
> +                assert(s->watch_tag =3D=3D 0);
> +                s->watch_tag =3D
> +                    qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP=
,
> +                                          serial_watch_cb, s);
> +                if (s->watch_tag > 0) {
> +                    s->tsr_retry++;
> +                    return;
> +                }

I think EINTR should be handled by chardev, otherwise yes.

Paolo
