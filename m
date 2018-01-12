Received: from eggs.gnu.org ([2001:4830:134:3::10]:57906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ea2gg-0005AX-33
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:00:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ea2gf-0003vJ-Cp
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:00:14 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:40461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ea2ge-0003tm-M1
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:00:12 -0500
Received: by mail-wm0-x244.google.com with SMTP id v123so3963938wmd.5
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 09:00:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1512682213-4354-6-git-send-email-minyard@acm.org>
References: <1512682213-4354-1-git-send-email-minyard@acm.org>
	<1512682213-4354-6-git-send-email-minyard@acm.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Jan 2018 18:00:10 +0100
Message-ID: <CAJ+F1CK1XWuxQFAYpXgLFTq+99Cjmn7F1aZoX04uGgNKxVzTUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/8] ipmi: disable IRQ and ATN on an
 external disconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: QEMU <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>

Hi

On Thu, Dec 7, 2017 at 10:30 PM,  <minyard@acm.org> wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> Otherwise there's no way to clear them without an external command,
> and it could lock the OS in the VM if they were stuck.
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

I don't know if anyone knows the specifics better than you. Why aren't
you the maintainer of hw/ipmi? (in MAINTAINERS)

> ---
>  hw/ipmi/ipmi_bmc_extern.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> index abab3bb..58ade79 100644
> --- a/hw/ipmi/ipmi_bmc_extern.c
> +++ b/hw/ipmi/ipmi_bmc_extern.c
> @@ -424,6 +424,11 @@ static void chr_event(void *opaque, int event)
>              return;
>          }
>          ibe->connected =3D false;
> +        /*
> +         * Don't hang the OS trying to handle the ATN bit, other end wil=
l
> +         * resend on a reconnect.
> +         */
> +        k->set_atn(s, 0, 0);
>          if (ibe->waiting_rsp) {
>              ibe->waiting_rsp =3D false;
>              ibe->inbuf[1] =3D ibe->outbuf[1] | 0x04;
> --
> 2.7.4
>
>



--=20
Marc-Andr=C3=A9 Lureau
