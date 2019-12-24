Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857B5C2D0CF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 15:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46AEC206D3
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 15:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsUlDaGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AEC206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijllw-0004Lp-Bf
	for qemu-devel@archiver.kernel.org; Tue, 24 Dec 2019 10:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1ijllK-0003wH-JJ
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 10:06:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1ijllJ-0006ST-LE
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 10:06:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53374
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1ijllJ-0006SJ-HV
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 10:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577199976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nDahgMkkEXOEdyb+xsFiI098GxMIon56DVkT3+C0knk=;
 b=IsUlDaGCorXnWtqw2otQdckJhk6qmiylKYFJZTGgjRWWRFCDWWsqwm/ZjF3jpqKHWQNt44
 fCk8OFnAWM0PhYISlmcLurudxXdxGMeuFI+hxb9kO+4J7e2AGFrXk9nmtkZvei8tGfwcn0
 90ygLvjwPMW+ZxZ0LeG/QF7Cp0gej+w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-1tut3l3fNgOph4ZltoGcug-1; Tue, 24 Dec 2019 10:06:14 -0500
Received: by mail-wr1-f71.google.com with SMTP id t3so8932252wrm.23
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2019 07:06:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=qXkmK7hPkhNADIo3Zo3nsDqLKowFu0wm8G15BeP4kGQ=;
 b=rzpeiijApdZ/pWlId24K5wNxGS6DW+kprwmXk3R+iNEuFdpLiec20fN/tc8jGeWUDk
 FJl8Cptp9bO4HTPAUQ6rmi64rFwOEBOUlbu61prL6l+zBiICXEwkT57FUB15WvNtm/Cd
 r0ykKG2iaQFfV6kHpX1/3dod979E6rIftgbI1/osyvl+gmTgIcjJ59zHytGas50adxNC
 w7vSQZErniAZv5V9OGBac7pgVZVQ33GJfMk+SuiGvdQDX/swadM0uZDo8WHYz+nhyvwi
 WnqzOFB91lz1nzIS2bBRT2J0qrHmsjfGlXUOFkFOv6AiLcFeJAG803Dt3m1a4L8ms+2u
 4PsA==
X-Gm-Message-State: APjAAAXZdfJ3ee2q8S8HELig9JztwyIW5CghNFkNvHWlVNTrZvQEk9/m
 8UGToVV+Fr5uZdtFwbwdORhzO91gxGcURSnYfyhEJQ8G/1YfXMykD9OBtSMSfxun/b1QL4SPQ8+
 C/s4TQzoB72G9stM=
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr38152043wrr.266.1577199973201; 
 Tue, 24 Dec 2019 07:06:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqzRIEFqyNtmG3llJ15OWR7fOrCnbu1wC5UWVv85dkEsCUgV10l+OYNIjE54nEPDeKKAlxP0rg==
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr38152018wrr.266.1577199972982; 
 Tue, 24 Dec 2019 07:06:12 -0800 (PST)
Received: from steredhat ([95.235.120.92])
 by smtp.gmail.com with ESMTPSA id f65sm2982473wmf.2.2019.12.24.07.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2019 07:06:12 -0800 (PST)
Date: Tue, 24 Dec 2019 16:06:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/rtc/mc146818: Add missing dependency on ISA Bus
Message-ID: <20191224150610.gebszlfkskomj2u5@steredhat>
References: <20191224111628.3551-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191224111628.3551-1-philmd@redhat.com>
X-MC-Unique: 1tut3l3fNgOph4ZltoGcug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 24, 2019 at 12:16:28PM +0100, Philippe Mathieu-Daud=E9 wrote:
> The MC146818 sits on an ISA bus. Since it can not be used
> without it, select ISA in the Kconfig.
>=20
> Fixes: 82f5181777e
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  hw/rtc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>=20
> diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> index 45daa8d655..3dc2dd6888 100644
> --- a/hw/rtc/Kconfig
> +++ b/hw/rtc/Kconfig
> @@ -17,6 +17,7 @@ config TWL92230
>      depends on I2C
> =20
>  config MC146818RTC
> +    depends on ISA_BUS
>      bool
> =20
>  config SUN4V_RTC
> --=20
> 2.21.0
>=20
>=20


