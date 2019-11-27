Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA02C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D0620678
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDfl95lU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D0620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZyjY-0004aB-D0
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 09:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrampazz@redhat.com>) id 1iZyhi-0003DT-B7
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrampazz@redhat.com>) id 1iZyhh-0002Bc-81
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:54:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21385
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrampazz@redhat.com>) id 1iZyhg-0002A6-04
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574866442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6kYWMe1rJc09kdtq8tEJIRQBNh6lklS7tZNLVGsx0Yg=;
 b=WDfl95lUEsCiI5kqqtlKyLW0UqHnwGygrWymy0dIY4WTMnPn1Xj34AqJ09ZGjSHJrqbOaE
 ZaZj9OgFPLd7JD5R1g5Z33v6byfTs/AcxhDyjze8LX8wXdOVRISUXSIhcYnlZ4cZ6demh5
 XVEF5F9Do9XdIaVnl4gGRdBYxiE65Jo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-xz2Veo-aNPuSkwdvyywI2w-1; Wed, 27 Nov 2019 09:54:01 -0500
Received: by mail-wr1-f71.google.com with SMTP id w6so526607wrm.16
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 06:54:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6kYWMe1rJc09kdtq8tEJIRQBNh6lklS7tZNLVGsx0Yg=;
 b=coC15HuQS8rgAld0fs8i34GUW1JtiyKMNKjeboh8MSRApH+HmBQxS9+6GoEZEv1csx
 6ea68bmjqesQKHAlm4HN4J5Q4m1Gn5qtruqiv8WdJIV5WK8tkN487yIHwyd73lLiphrw
 TWPL1gbBfDeDo82WP4Bh1COLwonLy/AdnSFoD9dReVxvOaXYwBOCz2oS4OLanIOs7VaH
 8APcHdyYSbDbG2/viqJ8yo72MgOhB3F9E1/+Jd2QbZCWQaC3zLFMHYnpyNKTipIbt1rH
 HXmFF847YrORcMqB1yEoJGUEjGTiPg7Jxr6tOTVFdyBOGiqvD/IiInmKSGDTtdLDMfIr
 EfqA==
X-Gm-Message-State: APjAAAXXXQXVljPworilnx6e/blvi3ZIovtc49wtI0HNANqcv55Fhb2x
 kJrLaDoboUD6Z9/rKGxrDh4Xo9O3zJcCS+swXPT5f49uHLI48f7qXQeAKNsHdQhDundZDk9Tuw/
 L7zQpNNjZjhX3RMrd3MFnvxybFJVsyGI=
X-Received: by 2002:adf:dc06:: with SMTP id t6mr44135372wri.378.1574866440342; 
 Wed, 27 Nov 2019 06:54:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqwOUch3BMU+M5tjzHj5Nds9CQHsID0E/qG4BTrY9Q0iDKpEl21SQoOCBRy0tg17InfPrtKA+G4gXlPaSE89gT0=
X-Received: by 2002:adf:dc06:: with SMTP id t6mr44135353wri.378.1574866440166; 
 Wed, 27 Nov 2019 06:54:00 -0800 (PST)
MIME-Version: 1.0
References: <20191126223810.20180-1-philmd@redhat.com>
 <20191126223810.20180-3-philmd@redhat.com>
In-Reply-To: <20191126223810.20180-3-philmd@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Wed, 27 Nov 2019 11:53:49 -0300
Message-ID: <CAKJDGDY21sjoQ9rvDWvRnwMobgg37ARM3Nj6Ajo6XQaLv4GFtA@mail.gmail.com>
Subject: Re: [PATCH-for-5.0? v2 2/2] Revert "Acceptance test: cancel test if
 m68k kernel packages goes missing"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-MC-Unique: xz2Veo-aNPuSkwdvyywI2w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 26, 2019 at 7:38 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Now than we use the stable snapshot archive, we can remove this check.
>
> This reverts commit d2499aca4bac613d837e2720e7bbe3378bc91245.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 752f776f68..ab4c8a5e5a 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -483,10 +483,7 @@ class BootLinuxConsole(Test):
>                     '/20191021T083923Z/pool-m68k/main'
>                     '/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.u=
deb')
>          deb_hash =3D '044954bb9be4160a3ce81f8bc1b5e856b75cccd1'
> -        try:
> -            deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash=
)
> -        except OSError as exp:
> -            self.cancel(exp)
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
>          kernel_path =3D self.extract_from_deb(deb_path,
>                                              '/boot/vmlinux-5.3.0-1-m68k'=
)
>

Tested-by: Willian Rampazzo <wrampazz@redhat.com>

Although I prefer to be on the safe side and keep the verification,
the code works as expected.

---
Willian


