Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2262BC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8AAB20719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQJCkE0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AAB20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHaR2-0002ax-3r
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaPY-0001DT-KE
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaPX-00021M-Er
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:51:36 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHaPX-00020i-9k
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:51:35 -0400
Received: by mail-oi1-x241.google.com with SMTP id w2so7027251oic.5
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8BMXqbjT3kX//KtodTDd18z0mS/t6iRmsiJbA2ZZ/PQ=;
 b=rQJCkE0qjJlZR0HC6ppwJYHbUAheHiJkesuE9U/Cf37JdnC46ZbJwz6fWf/Ph2uXEW
 JbmZPfGM3AeUKgvazyihtc5hsltwtAdkr8YxkudpVInrZMGK+4jPJyCgPiIig0LzsV6M
 IXJYA2WkYdKzc7PxuMH37zrtzgqAD1ldbZVGi8EoYbe2eL9/5yVmyJDheqhFuMHA37Ro
 zSY9Rqq3dtnErHRW5w14eTusrjE2OqsPIP9bx2Lx4PB98n8mFUBHP4kSzeQWvaauHDbd
 U+b2mQ3+zeiRYnQTKCf53Ga151u/TxNrlgIiJqIXsc4REBb+agKiN7GN48MaYziZwkus
 k7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8BMXqbjT3kX//KtodTDd18z0mS/t6iRmsiJbA2ZZ/PQ=;
 b=twUQFvFse6PzWYT2uLSeuF/TOTQ8cb8Wb+tWb9E8Vdal3a2Z8LR5EtwFShpAdL5hM+
 MYC2M/zkecWOGfrViPIYcLLdmrs3WVPE4VbCFkH1IEykVCTbqOHFoG9lNsjxXGlY3BRR
 H51snPuqPUu30Am9VXCTqvmAq6phJuArw8gSuPYLxXgihegWNYmSTKixvzpUk1XUUcTX
 25rr0ibI+gobgjYmPn5wwI+cdBdL/KEwaUodTDxT7XxYOMIeflf0O871UYcQ2MMtnTTV
 HzWxjYNgYajGFxeeVIP7a5+FQMCLeZ3LIB+ueAnFZsbWvcVWigJeTZ3Mts/8VsWFg3Z9
 icPQ==
X-Gm-Message-State: ANhLgQ1Zewwk1j6bhNkR1htyvly2O26rQ+7pu8bU8DhV442wxKGZQ7//
 tOyQNFuldU0eloK61Xjmhdx704XOchTm9aL1kj/Oaw==
X-Google-Smtp-Source: ADFU+vsfXtyhEgC13An493SR00v2heVfee/q0q5OV+9BLDG877ISClA2BQhtsoYt2Oh8Fz6drxbwuzFzOYvM9WS3uyI=
X-Received: by 2002:a05:6808:8cb:: with SMTP id
 k11mr1784335oij.48.1585259494308; 
 Thu, 26 Mar 2020 14:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200325191830.16553-1-f4bug@amsat.org>
 <20200325191830.16553-12-f4bug@amsat.org>
In-Reply-To: <20200325191830.16553-12-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 21:51:23 +0000
Message-ID: <CAFEAcA-68xvoVRjS8xBrGUsa7AqXRACC0NYK4uE9oy3zgX5-vQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 11/12] hw/net/xilinx_axienet: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Mar 2020 at 19:19, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Running the coccinelle script produced:
>
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/object_property_missing_error_propagate.=
cocci \
>     --keep-comments --smpl-spacing --dir hw
>
>   [[manual check required: error_propagate() might be missing in object_p=
roperty_set_link() hw/net/xilinx_axienet.c:969:4]]
>
> Add the missing error_propagate() after manual review.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/net/xilinx_axienet.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index 704788811a..f11510a71e 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -948,39 +948,42 @@ static NetClientInfo net_xilinx_enet_info =3D {
>  static void xilinx_enet_realize(DeviceState *dev, Error **errp)
>  {
>      XilinxAXIEnet *s =3D XILINX_AXI_ENET(dev);
>      XilinxAXIEnetStreamSlave *ds =3D XILINX_AXI_ENET_DATA_STREAM(&s->rx_=
data_dev);
>      XilinxAXIEnetStreamSlave *cs =3D XILINX_AXI_ENET_CONTROL_STREAM(
>                                                              &s->rx_contr=
ol_dev);
>      Error *local_err =3D NULL;
>
>      object_property_add_link(OBJECT(ds), "enet", "xlnx.axi-ethernet",
>                               (Object **) &ds->enet,
>                               object_property_allow_set_link,
>                               OBJ_PROP_LINK_STRONG,
>                               &local_err);

Again, Coccinelle seems to have not spotted the missing error check here...

>      object_property_add_link(OBJECT(cs), "enet", "xlnx.axi-ethernet",
>                               (Object **) &cs->enet,
>                               object_property_allow_set_link,
>                               OBJ_PROP_LINK_STRONG,
>                               &local_err);
>      if (local_err) {
>          goto xilinx_enet_realize_fail;
>      }
>      object_property_set_link(OBJECT(ds), OBJECT(s), "enet", &local_err);
> +    if (local_err) {
> +        goto xilinx_enet_realize_fail;
> +    }
>      object_property_set_link(OBJECT(cs), OBJECT(s), "enet", &local_err);
>      if (local_err) {
>          goto xilinx_enet_realize_fail;
>      }

thanks
-- PMM

