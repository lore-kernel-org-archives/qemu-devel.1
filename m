Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC0EC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C702073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXu5YRpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C702073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHT2c-0007BX-C1
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jHT1z-0006Wj-AX
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jHT1y-0000bg-6u
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:58:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:21211)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jHT1y-0000bS-39
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585231125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cH0AC7e8C8k1NZaZqbZc3dHhWglMt6CF/aBq3q1Ef4I=;
 b=XXu5YRppy0P55HpY2ViZROskMgj5KUSsKZB5re62WjXBpUMpSfs97igtgClFo9oYktZzBe
 9xA8n2bPivi8qaWGpCkIxvxeMrvVeZN1YeagI01VJ1+reSPFJaLpP6289wLojm4uxAPWfs
 109Gt3WK+qXUBGE4gcqEwC7WoXaFEkc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-n0Oyj2I2Oju6QLAhxuXP8w-1; Thu, 26 Mar 2020 09:58:43 -0400
X-MC-Unique: n0Oyj2I2Oju6QLAhxuXP8w-1
Received: by mail-wr1-f70.google.com with SMTP id u16so69626wrp.14
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 06:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AmXpObYI0uKImDl65v6TzDhoyRQ8UZUAzBfsq/kcSPk=;
 b=IHuN99SzB+69F1bObImAJ/VOXbkrnpF/ehYIwIE4AMQ9EAG1m/S7VQ2pHEBGVL4Gal
 sRexXa6xMDff6W1bYt2oBcw1+JoeMDYgTj2viEYkeIi+W/eUDLR4LcBqmd8sLovy/f1l
 t3wydPPR3LXtbSPGJhE5rhhN8kKXCGpenC6k7wHKRxYVKnP/d948xqpxog5B5vcB5xgj
 ijclyozeBiM87XbFue93YgnSf7Y3AObpX8StuVJKpkflmw5FzRBqb3cIYnfLLpDmRnrs
 B30r6deyFPkC36R2eTI2lI882RMqMo/9X4Ngw2sewa0pAL1JgcfotOgjayB/7eAYrJbz
 tLUA==
X-Gm-Message-State: ANhLgQ2n2XQYzOf8V2/Mu3K5jMMMzTyghsNxpRJe/PxDb+wPmIE8KdgL
 Umo61F3ceUEs9qdvoKXumYONowX8jPHgEtNwmsBJHb6r4gsRFJlvDQudQrnYFl1xqPT0Knwclwv
 pzIbYmD2gd2CgBOo=
X-Received: by 2002:a5d:4c48:: with SMTP id n8mr9385282wrt.414.1585231122801; 
 Thu, 26 Mar 2020 06:58:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtSPmPYE+EqiGpSokZNdL1AR5drgXrGpPdBMydQhiQeDCRa32Gu1+h3BoGYKZjiFP3iJJ7C3A==
X-Received: by 2002:a5d:4c48:: with SMTP id n8mr9385265wrt.414.1585231122604; 
 Thu, 26 Mar 2020 06:58:42 -0700 (PDT)
Received: from redhat.com (bzq-109-67-62-195.red.bezeqint.net. [109.67.62.195])
 by smtp.gmail.com with ESMTPSA id a14sm3765157wrv.76.2020.03.26.06.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 06:58:42 -0700 (PDT)
Date: Thu, 26 Mar 2020 09:58:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] acpi: pcihp: fix left shift undefined behavior in
 acpi_pcihp_eject_slot()
Message-ID: <20200326095830-mutt-send-email-mst@kernel.org>
References: <20200326135624.32464-1-imammedo@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200326135624.32464-1-imammedo@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 26, 2020 at 09:56:24AM -0400, Igor Mammedov wrote:
> Coverity spots subj in following guest triggered code path
>   pci_write(, data =3D 0) -> acpi_pcihp_eject_slot(,slots =3D 0)
>      uinst32_t slot =3D ctz32(slots)
>      ...
>      ... =3D ~(1U << slot)
> where 'slot' value is 32 in case 'slots' bitmap is empty.
> 'slots' is a bitmap and empty one shouldn't  do anything
> so return early doing nothing if resulted slot value is
> not valid (i.e. not in 0-31 range)
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

tagged, thanks!

> ---
>  hw/acpi/pcihp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 4dcef372bf..0dc963e983 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -154,7 +154,7 @@ static void acpi_pcihp_eject_slot(AcpiPciHpState *s, =
unsigned bsel, unsigned slo
> =20
>      trace_acpi_pci_eject_slot(bsel, slot);
> =20
> -    if (!bus) {
> +    if (!bus || slot > 31) {
>          return;
>      }
> =20
> --=20
> 2.18.1


