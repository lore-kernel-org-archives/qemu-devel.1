Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB748C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 19:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8104C20720
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 19:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWFW8F4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8104C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwsZW-00037S-Il
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 14:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwsYm-0002hd-24
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 13:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwsYi-0004qw-S2
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 13:59:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26123
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwsYi-0004q5-Ij
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 13:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580324368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4Om27dMMc+MwDJO33ko3fPEMZ8mfK4CNT5yOi9uQV0=;
 b=jWFW8F4YmgJrlmJSsPZnb6DkjUn2xRvlVeiz3nLoaofCEUDiBNEJmctHGth7UE5Ydvzt6u
 vKyRqC+26j4NwauyoIFPpiLGYqby9i4sfEzgaeAk1rL2g2zznAuuMQ81Pj3Yg2kWtdWxsT
 HJkVdLTml5mI9aTvd3ZaPUSfZSQTbDU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-qTBEPwB2M2e-AUB36JNkpg-1; Wed, 29 Jan 2020 13:59:20 -0500
Received: by mail-wr1-f70.google.com with SMTP id w6so351018wrm.16
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 10:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3ZZ+IeHTC4FUkzKLbzuxzj4KT1R3XIan3G+l/tmpPIo=;
 b=MqOOz0kGH/Lk6BCYLjZBNDhvLgqrv15zbxgeXS/iWF+NrBDLF1y8K0PYpIqffEIh59
 nJgmtR2jCe5NmVbmbhMg+YDkM36P9V6mfjPySBaqw8axQpaCraxx7Lu+KTveppLMFR8K
 0/g/Lc2hT4KfiMmsE5h0On5Ct9rynI1q9nCQ+xOnNfFsIGesXb4VPqA+o52r4ctYLc2A
 qy5zPPbnXUNQurWNGL73LeYojooZmSXXRh70++YYGFkgQw9WtDe2LCacHszxDhvoOab9
 t2imFQqzp2tmp5NzeGghz2gh+k4WR7i7IJHaua7GXk70z8YFAKVl2VBaUOkDfQJDgNZA
 srkQ==
X-Gm-Message-State: APjAAAXs3wT4az8UpHIcle1f9aPI7vaEx5/I8quO+FZo0iNJGTqsoXWF
 M/LJN7CqD/W8AFdYg1z1Jq1iiAyVKAAi4dUO1vafQte4cnl0XmdIB7O+uH1MugXqG3uIyKZH+Fy
 OrUp1AXqBPGtPlxk=
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr265657wrp.71.1580324359055;
 Wed, 29 Jan 2020 10:59:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5snWWIuuHvNH4RE31xURvkW/qwtyl790Il40uv9J9jsvY3WMiwOCEBiTXUZ8GHD6H2jKy5w==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr265643wrp.71.1580324358851;
 Wed, 29 Jan 2020 10:59:18 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id c15sm3925182wrt.1.2020.01.29.10.59.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2020 10:59:18 -0800 (PST)
Subject: Re: [PATCH] default-configs: add CONFIG_PARALLEL to hppa-softmmu
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200129182804.19284-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ff7dbd5f-4b38-f53b-f688-1f6841ea7bf3@redhat.com>
Date: Wed, 29 Jan 2020 19:59:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200129182804.19284-1-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: qTBEPwB2M2e-AUB36JNkpg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On 1/29/20 7:28 PM, Alex Benn=C3=A9e wrote:
> The PARISC Lasi chipset emulation requires some of the common parallel
> support and fails to build on a --without-default-devices. I am
> assuming the chipset emulation is non-optional for the HPPA case.
 >

Fixes: 376b851909d

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   default-configs/hppa-softmmu.mak | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-soft=
mmu.mak
> index b64c5eb3ff..9083ce8634 100644
> --- a/default-configs/hppa-softmmu.mak
> +++ b/default-configs/hppa-softmmu.mak
> @@ -3,6 +3,7 @@
>   # Uncomment the following lines to disable these optional devices:
>   #
>   #CONFIG_PCI_DEVICES=3Dn
> +CONFIG_PARALLEL=3Dy

We now use Kconfig :)

CONFIG_DINO=3Dy pulls from hw/hppa/Kconfig:

config DINO
     bool
     imply PCI_DEVICES
     imply E1000_PCI
     imply VIRTIO_VGA
     select PCI
     select SERIAL
     select ISA_BUS
     select I8259
     select IDE_CMD646
     select MC146818RTC
     select LSI_SCSI_PCI
     select LASI_82596
     select LASIPS2
     select ARTIST

The fix is:

-- >8 --
diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index 82178c7dcb..22948db025 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -12,4 +12,5 @@ config DINO
      select LSI_SCSI_PCI
      select LASI_82596
      select LASIPS2
+    select PARALLEL
      select ARTIST
---

Btw I suggested Sven to use a different config for LASI:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg667945.html


