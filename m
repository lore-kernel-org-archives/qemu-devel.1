Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926A3C5518C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603BF2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzMzyi3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603BF2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRGce-000817-IS
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 10:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRGbp-0007UC-Ab
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRGbo-0002ce-2t
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:44:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36089
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRGbn-0002TW-D3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587566653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CYUa3LXM6cIVAcfLd0BGIUJR1BkVgy2vHedng3FxcUo=;
 b=dzMzyi3JNA/Pkjl0Gt83PEH0dj9afo93lwbPaWbHeVBeuGOZ6d470G4fAPGQjKTBrxd8iW
 F5hfpsb5JuPHIeNDpQbGXGgHimDEva9/wrTB+40dgQ23FIo3FbX4gKtwZyJwMGQDrk8g/k
 h7iXWf9Aq3bVNVEbLaFj/zlOFfBd1Wk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-ppVxyQUQMzOGL672YAyViQ-1; Wed, 22 Apr 2020 10:44:11 -0400
X-MC-Unique: ppVxyQUQMzOGL672YAyViQ-1
Received: by mail-wm1-f71.google.com with SMTP id q5so895056wmc.9
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 07:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pwiQrI2cAlvCh/zBkA+FAN4jwA3IFZSqJ/4C/JMgIvI=;
 b=TSOqI13nnfFnKir6PTFpdEa3weVzFjU5SOSRb1892M2vok1e2fk8IR1NRA0jiOZTBk
 by36zfUbgR6lqQE633qrofi7wzgEpqqkLFPzsHDe6YCsOBBZ+D6P3iSvaeSwZ1vN5+N+
 A6nzea5f9QR95QfCg2DWn0DBg9IBk31e4BDyaureUs1DBXhU6eNJ8HA2czecDkjYGauR
 2Iz1rGnanA+NZvxVuvOeLF999jBa1I5SB1ByFEmFKFmvSLlOy1IHo9FgVeQlOacoB7b+
 Tjl4sau0tWh+D8IsLPSS9Uy3b8kKhGexvaxxo6Zon3T6K7ank6In2EKsbElQhd8cylQG
 AnXg==
X-Gm-Message-State: AGi0PuYyej0waUZorESHID4FFHfYo277XZVE5WB/807Hb+U//qJ/iW8N
 zkYmSBmH1aDT4JIyBDt98dUp/pPsVJzGj6SMJpKuajNsyaCaNrIYLqrKin+lkhX7amNopzYAuuE
 xf/nfT66I8bVzH8o=
X-Received: by 2002:a1c:e087:: with SMTP id
 x129mr11291875wmg.127.1587566650746; 
 Wed, 22 Apr 2020 07:44:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypI1xPmp0oeB4p6UQdHuhKJa+Ma7W33mvDd1MK66hk/NdfEl0u8Chiz9Si4kMo1AaVx+W99USg==
X-Received: by 2002:a1c:e087:: with SMTP id
 x129mr11291861wmg.127.1587566650535; 
 Wed, 22 Apr 2020 07:44:10 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id q10sm8902831wrv.95.2020.04.22.07.44.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 07:44:09 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] sam460ex: Suppress useless warning on -m 32 and -m
 64
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200422134815.1584-1-armbru@redhat.com>
 <20200422134815.1584-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <007f94c0-3907-07f8-1c46-78a468a3af8a@redhat.com>
Date: Wed, 22 Apr 2020 16:44:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200422134815.1584-2-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 09:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 3:48 PM, Markus Armbruster wrote:
> Requesting 32 or 64 MiB of RAM with the sam460ex machine type produces
> a useless warning:
>=20
>      qemu-system-ppc: warning: Memory size is too small for SDRAM type, a=
djusting type
>=20
> This is because sam460ex_init() asks spd_data_generate() for DDR2,
> which is impossible, so spd_data_generate() corrects it to DDR.
>=20
> The warning goes back to commit 08fd99179a "sam460ex: Clean up SPD
> EEPROM creation".
>=20
> Make sam460ex_init() pass the correct SDRAM type to get rid of the
> warning.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/ppc/sam460ex.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 898453cf30..1e3eaac0db 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -335,7 +335,8 @@ static void sam460ex_init(MachineState *machine)
>       dev =3D sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600700, uic[0][2=
]);
>       i2c =3D PPC4xx_I2C(dev)->bus;
>       /* SPD EEPROM on RAM module */
> -    spd_data =3D spd_data_generate(DDR2, ram_sizes[0], &err);
> +    spd_data =3D spd_data_generate(ram_sizes[0] < 128 * MiB ? DDR : DDR2=
,
> +                                 ram_sizes[0], &err);

Previous to this patch question, don't we need one for each module? We=20
have 4 banks... Ah, there is a comment earlier "/* put all RAM on first=20
bank because board has one slot". OK...

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>       if (err) {
>           warn_report_err(err);
>       }
>=20


