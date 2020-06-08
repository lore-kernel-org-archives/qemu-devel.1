Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C272AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 05:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C3522076A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 05:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3qUtf6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3522076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiAkA-000899-Pm
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 01:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiAjI-0007QH-Ff
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 01:53:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59077
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiAjH-0000jN-Nz
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 01:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591595630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SQ9RhGb0hG2NyET5PsfmeFblc+la8bGaecmdU1Mm3Gc=;
 b=E3qUtf6sd+Y9XWQiyQk0AMqT83A417z0YQtk2xWWhZ4gZFfipkcxMwVPKgsvercpG6eLCp
 VhXH6pqigIRejJYjUFVDyI6riVVIHTZYrzxeJ4/J1ui8ii56BBZocVJPYwEVwbHB1FmrBz
 YDrHupXj94D2GOX1AvSqIErgbk9fm0w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-HzHpyvnUM963RsaNZ-MNuA-1; Mon, 08 Jun 2020 01:53:48 -0400
X-MC-Unique: HzHpyvnUM963RsaNZ-MNuA-1
Received: by mail-wr1-f69.google.com with SMTP id e7so6737225wrp.14
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 22:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=SQ9RhGb0hG2NyET5PsfmeFblc+la8bGaecmdU1Mm3Gc=;
 b=p9BOkr1352loeNbFsaJbL7OW/Tnyy+3QbVuFzBtB6EaWgN3PS8xxxPW5JPUqgzFJrI
 Snigp6OCTwkuaoy01+JdsUz9rAM6hynJKm2ynUrjFZMsGrJ9wZA/BNATqKL+5Lsa4Fy7
 9Vhmiag8fNGPI9JwQNdg9ndfhotvVFVZJEvMwXA9EtnS8xGEbzhbqLu4ouaso2mno5xi
 6goB3EOpmz/OcrWtAlWVbAHOK9c0o8wX+MFGmiGV60LjYibhqEjW2lzICFln4nQj8rOH
 jZUjTFC2m3uWZIlzArjUgTn6UsF93rYhf8qOt3pM90EElcln4Ucjudy0Z6hP/hqlsu6K
 Oy/A==
X-Gm-Message-State: AOAM530ndWAze+I3dByvSgg68rQtzv7mXgTgNJ+DYOEmmERA7X1uB795
 +FwSNoRocQnvvoJ12eAXDZT86Gt7Yscty4kGyCazPt9LPfX2MUwDD3AntYP3eC/wU9SPhOXqasy
 yUwMsp4Bk+RXcg2s=
X-Received: by 2002:a1c:f416:: with SMTP id z22mr979233wma.60.1591595627471;
 Sun, 07 Jun 2020 22:53:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxia0m5wXtaauSry5OvI2mcjJ+4Xa8jofEtQhbObWjvhbayq1Gji8orwCb1PCx4rKndw8/2BQ==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr979214wma.60.1591595627259;
 Sun, 07 Jun 2020 22:53:47 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y17sm22964897wrn.12.2020.06.07.22.53.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jun 2020 22:53:46 -0700 (PDT)
Subject: Re: [PATCH 14/16] arm/aspeed: Drop aspeed_board_init_flashes()
 parameter @errp
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200605145625.2920920-1-armbru@redhat.com>
 <20200605145625.2920920-15-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <f4ab0514-4162-2e00-9d53-dcafa457658d@redhat.com>
Date: Mon, 8 Jun 2020 07:53:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200605145625.2920920-15-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 00:45:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001, URIBL_SBL=1.623,
 URIBL_SBL_A=0.1 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>, mreitz@redhat.com, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, pbonzini@redhat.com,
 jsnow@redhat.com, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 4:56 PM, Markus Armbruster wrote:
> We always pass &error_abort.  Drop the parameter, use &error_abort
> directly.
> 
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/arm/aspeed.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 5ffaf86b86..4ce6ca0ef5 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -215,8 +215,8 @@ static void write_boot_rom(DriveInfo *dinfo, hwaddr addr, size_t rom_size,
>      g_free(storage);
>  }
>  
> -static void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
> -                                      Error **errp)
> +static void aspeed_board_init_flashes(AspeedSMCState *s,
> +                                      const char *flashtype)
>  {
>      int i ;
>  
> @@ -227,8 +227,8 @@ static void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
>  
>          fl->flash = qdev_new(flashtype);
>          if (dinfo) {
> -            qdev_prop_set_drive_err(fl->flash, "drive",
> -                                    blk_by_legacy_dinfo(dinfo), errp);
> +            qdev_prop_set_drive(fl->flash, "drive",
> +                                blk_by_legacy_dinfo(dinfo));
>          }
>          qdev_realize_and_unref(fl->flash, BUS(s->spi), &error_fatal);
>  
> @@ -314,8 +314,8 @@ static void aspeed_machine_init(MachineState *machine)
>                            "max_ram", max_ram_size  - ram_size);
>      memory_region_add_subregion(&bmc->ram_container, ram_size, &bmc->max_ram);
>  
> -    aspeed_board_init_flashes(&bmc->soc.fmc, amc->fmc_model, &error_abort);
> -    aspeed_board_init_flashes(&bmc->soc.spi[0], amc->spi_model, &error_abort);
> +    aspeed_board_init_flashes(&bmc->soc.fmc, amc->fmc_model);
> +    aspeed_board_init_flashes(&bmc->soc.spi[0], amc->spi_model);
>  
>      /* Install first FMC flash content as a boot rom. */
>      if (drive0) {
> 


