Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C47C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518D22082F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9xHGgtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518D22082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j20Fu-0003Ck-Hx
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 17:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j20F0-0002Jc-CD
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j20Ey-000513-5c
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:12:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49385
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j20Ey-00050C-29
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581545535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OQX3+OQlNGyIK2uBxScP/fIdyTEIe4OqFvcwVb2qhYQ=;
 b=C9xHGgtHYwZNUgMYPlAYG4ZqgbNBa4cw27690W7NPMkw7uoM0q5EEi/ZXDc/IW8YzAhIy0
 P1WbG1lKf50kQ3drFcb6nXdMgLNz5OjQcC1DrzBapyjOZyjrYygMFs1Or7S+YQI0NNJ3YC
 mQq5mXjoVVxMTZtpjYWwXQnoKuvnq58=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-jeOkrhOnP5-V0UryVKK3yA-1; Wed, 12 Feb 2020 17:12:10 -0500
Received: by mail-wr1-f70.google.com with SMTP id t6so1423181wru.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 14:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KbOIkA8SQFrtdw8hwMIaAD/l02PZxmKHkrzKvQ4tpqw=;
 b=c8VIdDv8Tx+SVBNoIS6CY0wotfcREnMRgTeLd1T+xcMH55FAkqce1DCQxf9h5+8f+v
 U6eIhKNoIYpRfLYjQx8GXT1GeE5baUfJf234KekOFzP9O369FOs0WH8za8qxLlCi3TCH
 luMLyzlGgO6yoyz2ueUuu3pFiFqqKzib2bi7JN3kYCyGPrKVgWxITk/ntQfKBGXRvsoL
 XlHqUAUsnziBs6I2dfNz9Apo/7yCyASUGq9GdhMag0EMCwBjp+/+fBMijQfM+HGcilFT
 ed3Iz81/TXvbpI9stTyK2vZjZYqrYJrvwmMl6csbcq2jpDMlL9URdkGO5vVjqy5aQQDZ
 jABg==
X-Gm-Message-State: APjAAAXHpfIF6kU0XrLWbb6jkRfJO+VFAhmwOCDcwomnfIwkUc1M9QtI
 2MKIp5qK1RWSmtBp60u9LjRDQ+PGdvbFEIUiidsKHZ1YzaSoHc0nOy2qe2M+jf6TYOASB9wV4x5
 d3l0QfZdb4aH77T8=
X-Received: by 2002:a5d:6708:: with SMTP id o8mr18147904wru.296.1581545529905; 
 Wed, 12 Feb 2020 14:12:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqwuoNbpZS//CgnUGCV57Yg244HNlXCFn/IpXbC1tGVeNZk680iSgv455x72QYxzJpWvcm0Y+Q==
X-Received: by 2002:a5d:6708:: with SMTP id o8mr18147889wru.296.1581545529664; 
 Wed, 12 Feb 2020 14:12:09 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id y7sm11135958wmd.1.2020.02.12.14.12.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 14:12:09 -0800 (PST)
Subject: Re: [PATCH v4 00/20] Add Allwinner H3 SoC and Orange Pi PC Machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <CAPan3WpV2m9HXLXZDopKUb2EfX2KE9y530m2pJG4-D96==ggCg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ee95179f-c15f-9615-e241-80199e6948b7@redhat.com>
Date: Wed, 12 Feb 2020 23:12:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPan3WpV2m9HXLXZDopKUb2EfX2KE9y530m2pJG4-D96==ggCg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: jeOkrhOnP5-V0UryVKK3yA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jasowang@redhat.com,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 10:47 PM, Niek Linnenbank wrote:
> Hi all,
>=20
> Short status update regarding this series.
>=20
> Currently I am debugging booting NetBSD 9.0-RC2, which is recently=20
> released [1]
> The problem is that, apparently, RC2 can't mount the rootfs properly:
>=20
> [ =C2=A0 3.1871510] vfs_mountroot: can't open root device
> [ =C2=A0 3.2141370] cannot mount root, error =3D 6
>=20
> This only happens using the RC2 filesystem image. However, the RC2=20
> kernel can
> properly load & boot the RC1 filesystem image, and the RC1 kernel gives=
=20
> the same error
> on the RC2 filesystem.=C2=A0 But I dont think its a NetBSD-RC2 issue, bec=
ause=20
> on a real
> Orange Pi PC hardware board, this problem does not show.

Linux shows:
   console: mmc0: Problem switching card into high-speed mode!

QEMU MMC support is not in good shape, and high-speed SD card support is=20
limited. I keep procrastinating at reviewing your SDHCI patch hmmmmm.

So you added:

  * DMA transfers
  * Direct FIFO I/O
  * Short/Long format command responses

I'd start diffing the trace output of the following events:

allwinner_sdhost*
sdcard*

with both kernels.

>=20
> I'm comparing traces and adding more low-level debug output to NetBSD=20
> and QEMU to find the issue.
>=20
> Also I processed the review remarks which were send so far.
>=20
> Kind regards,
> Niek
>=20
> [1] https://www.netbsd.org/releases/formal-9/NetBSD-9.0.html


