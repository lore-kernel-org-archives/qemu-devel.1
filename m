Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDD9C04AAB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 727F52054F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727F52054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57814 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNf4T-0006bt-O7
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 10:58:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hNf3c-0006Ct-1L
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hNf3b-0004wq-3G
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:57:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>)
	id 1hNf3Y-0004uk-RW; Mon, 06 May 2019 10:57:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1227E300181E;
	Mon,  6 May 2019 14:57:28 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-124-221.rdu2.redhat.com
	[10.10.124.221])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A2FFD63BA1;
	Mon,  6 May 2019 14:57:12 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20190505200602.12412-1-philmd@redhat.com>
	<20190505200602.12412-5-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <05b25819-eaca-3452-5933-437afbe11298@redhat.com>
Date: Mon, 6 May 2019 16:57:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190505200602.12412-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 06 May 2019 14:57:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/5] hw/block/pflash_cfi02: Extract the
 pflash_reset() code
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/05/19 22:06, Philippe Mathieu-Daud=C3=A9 wrote:
> The reset() code is used in various places, refactor it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/block/pflash_cfi02.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index f2c6201f813..f321b74433c 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -120,6 +120,17 @@ static void pflash_register_memory(PFlashCFI02 *pf=
l, int rom_mode)
>      pfl->rom_mode =3D rom_mode;
>  }
> =20
> +static void pflash_reset(PFlashCFI02 *pfl)
> +{
> +    trace_pflash_reset();
> +    timer_del(&pfl->timer);
> +    pfl->bypass =3D 0;
> +    pfl->wcycle =3D 0;
> +    pfl->cmd =3D 0;
> +    pfl->status =3D 0;
> +    pflash_register_memory(pfl, 1);
> +}
> +
>  static void pflash_timer (void *opaque)
>  {
>      PFlashCFI02 *pfl =3D opaque;
> @@ -129,11 +140,10 @@ static void pflash_timer (void *opaque)
>      pfl->status ^=3D 0x80;
>      if (pfl->bypass) {
>          pfl->wcycle =3D 2;
> +        pfl->cmd =3D 0;
>      } else {
> -        pflash_register_memory(pfl, 1);
> -        pfl->wcycle =3D 0;
> +        pflash_reset(pfl);
>      }
> -    pfl->cmd =3D 0;
>  }
> =20
>  static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr offset,
> @@ -481,10 +491,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr =
offset,
> =20
>      /* Reset flash */
>   reset_flash:
> -    trace_pflash_reset();
> -    pfl->bypass =3D 0;
> -    pfl->wcycle =3D 0;
> -    pfl->cmd =3D 0;
> +    pflash_reset(pfl);
>      return;
> =20
>   do_bypass:
> @@ -588,9 +595,7 @@ static void pflash_cfi02_realize(DeviceState *dev, =
Error **errp)
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &pfl->mem);
> =20
>      timer_init_ns(&pfl->timer, QEMU_CLOCK_VIRTUAL, pflash_timer, pfl);
> -    pfl->wcycle =3D 0;
> -    pfl->cmd =3D 0;
> -    pfl->status =3D 0;
> +    pflash_reset(pfl);
>      /* Hardcoded CFI table (mostly from SG29 Spansion flash) */
>      /* Standard "QRY" string */
>      pfl->cfi_table[0x10] =3D 'Q';
>=20

I don't have a vested interest in the pflash_cfi02 device model, but I
guess my earlier (cfi01) comments would apply -- unify first, extract
second. (Or at least document why these changes are unobservable from
the behavior POV.)

Thanks
Laszlo

