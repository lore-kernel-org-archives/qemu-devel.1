Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3BEC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E47132053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47132053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57703 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNexB-0001PS-3Q
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 10:50:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hNew4-0000j9-ST
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hNew3-0007jZ-Gp
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:49:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>)
	id 1hNew1-0007hj-5H; Mon, 06 May 2019 10:49:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2451D30833A1;
	Mon,  6 May 2019 14:49:40 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-124-221.rdu2.redhat.com
	[10.10.124.221])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 165D819749;
	Mon,  6 May 2019 14:49:35 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20190505200602.12412-1-philmd@redhat.com>
	<20190505200602.12412-3-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <109c9023-0b23-56e0-1c78-2dd3b44374de@redhat.com>
Date: Mon, 6 May 2019 16:49:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190505200602.12412-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Mon, 06 May 2019 14:49:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/5] hw/block/pflash_cfi01: Extract the
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

On 05/05/19 22:05, Philippe Mathieu-Daud=C3=A9 wrote:
> The reset() code is used in various places, refactor it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/block/pflash_cfi01.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 6dc04f156a7..073cd14978f 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -108,6 +108,15 @@ static const VMStateDescription vmstate_pflash =3D=
 {
>      }
>  };
> =20
> +static void pflash_reset(PFlashCFI01 *pfl)
> +{
> +    trace_pflash_reset();
> +    pfl->wcycle =3D 0;
> +    pfl->cmd =3D 0;
> +    pfl->status =3D 0;
> +    memory_region_rom_device_set_romd(&pfl->mem, true);
> +}
> +
>  /* Perform a CFI query based on the bank width of the flash.
>   * If this code is called we know we have a device_width set for
>   * this flash.
> @@ -275,8 +284,7 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwadd=
r offset,
>      default:
>          /* This should never happen : reset state & treat it as a read=
 */
>          DPRINTF("%s: unknown command state: %x\n", __func__, pfl->cmd)=
;
> -        pfl->wcycle =3D 0;
> -        pfl->cmd =3D 0;
> +        pflash_reset(pfl);
>          /* fall through to read code */
>      case 0x00:
>          /* Flash area read */

This change introduces two new actions:
- zeroing "status"
- flipping the chip to romd mode (unless it's already in romd mode)

> @@ -639,10 +647,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr =
offset,
>                    "\n", __func__, offset, pfl->wcycle, pfl->cmd, value=
);
> =20
>   reset_flash:
> -    trace_pflash_reset();
> -    memory_region_rom_device_set_romd(&pfl->mem, true);
> -    pfl->wcycle =3D 0;
> -    pfl->cmd =3D 0;
> +    pflash_reset(pfl);
>  }

This change introduces a new action:
- zeroing "status"

> =20
> =20
> @@ -757,9 +762,7 @@ static void pflash_cfi01_realize(DeviceState *dev, =
Error **errp)
>          pfl->max_device_width =3D pfl->device_width;
>      }
> =20
> -    pfl->wcycle =3D 0;
> -    pfl->cmd =3D 0;
> -    pfl->status =3D 0;
> +    pflash_reset(pfl);

This change introduces a new action:
- flipping the chip to romd mode (unless it's already in romd mode)

>      /* Hardcoded CFI table */
>      /* Standard "QRY" string */
>      pfl->cfi_table[0x10] =3D 'Q';
>=20

Therefore, this patch is not *obviously* a refactoring patch. (IOW, it
may be a pure refactoring patch, but it's not very easy to see.) I sugges=
t:

- either documenting the new actions in the commit message (and why they
are justified),

- or prepending a separate patch that first unifies the behavior in all
the separate reset locations, and then this patch could indeed become an
"obvious" refactoring / code exctraction.

(Clearly, I'm asking for this with an eye towards git-bisect.)

Thanks
Laszlo

