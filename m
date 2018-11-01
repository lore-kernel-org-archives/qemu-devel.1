Received: from eggs.gnu.org ([2001:4830:134:3::10]:37725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gI6FV-0000hd-TM
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gI6FU-0006UH-QZ
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:14:33 -0400
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:50457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gI6FU-0006Tm-IK
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:14:32 -0400
Received: by mail-it1-x144.google.com with SMTP id k206-v6so718713ite.0
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 23:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <1540365080-6844-1-git-send-email-liq3ea@gmail.com>
	<4d64d42a-8727-81aa-6015-a9db92abca76@redhat.com>
	<b8e3151d-b453-67a7-89ef-cdf2ff257a6b@redhat.com>
In-Reply-To: <b8e3151d-b453-67a7-89ef-cdf2ff257a6b@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 1 Nov 2018 14:13:55 +0800
Message-ID: <CAKXe6S+veJq2JRn2eY9SCqqbOJ-KDPokgfbh33A=4Ph983=dPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fw_cfg_reboot: ensure reboot_time is
 nonegative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Thanks Eric and Markus's review,

I have sent out another patch.

I'm not sure what's the effect when the etc/reboot-timeout and
etc/splash-time is 0
in seabios, so CC'd Gerd. Maybe it can be more simplicity.


Thanks,
Li Qiang

Eric Blake <eblake@redhat.com> =E4=BA=8E2018=E5=B9=B410=E6=9C=8831=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:55=E5=86=99=E9=81=93=EF=BC=9A

> On 10/24/18 6:35 AM, Laszlo Ersek wrote:
> > On 10/24/18 09:11, Li Qiang wrote:
> >> This can avoid setting a negative value to
> >> etc/boot-fail-wait.
> >>
> >> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> >> ---
> >>   hw/nvram/fw_cfg.c | 15 ++++++++++-----
> >>   1 file changed, 10 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> >> index f4a52d8..276dcb1 100644
> >> --- a/hw/nvram/fw_cfg.c
> >> +++ b/hw/nvram/fw_cfg.c
> >> @@ -199,12 +199,17 @@ static void fw_cfg_reboot(FWCfgState *s)
> >>               reboot_timeout =3D strtol(p, &p, 10);
>
> Looks like Markus handled the question about replacing strtol(), so I'll
> just point out one additional nit:
>
> >>           }
> >>       }
> >> -    /* validate the input */
> >> -    if (reboot_timeout > 0xffff) {
> >> -        error_report("reboot timeout is larger than 65535, force it t=
o
> 65535.");
>
> Pre-existing, but now's as good a time as any to improve it:
>
> >> -        reboot_timeout =3D 0xffff;
> >> +
> >> +    if (reboot_timeout >=3D 0) {
> >> +        /* validate the input */
> >> +        if (reboot_timeout > 0xffff) {
> >> +            error_report("reboot timeout is larger than 65535,"
> >> +                         "force it to 65535.");
>
> error_report() callers generally do not end with trailing '.'
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
